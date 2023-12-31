import 'dart:io';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import '../data_manager.dart';
import '../models/resume_item.dart';
import '../widgets/resume_list_item.dart';
import 'add_item_screen.dart';
import 'edit_item_screen.dart';

class ResumeScreen extends StatefulWidget {
  const ResumeScreen({super.key});

  @override
  _ResumeScreenState createState() => _ResumeScreenState();
}

class _ResumeScreenState extends State<ResumeScreen> {
  List<ResumeItem>? resume = [];

  @override
  void initState() {
    super.initState();
    _loadResume();
  }
  _loadResume() async {
    List<ResumeItem> loadedResume = await ResumeDataManager.getResume();
    setState(() {
      resume = loadedResume;
    });
  }
   _editItem(int index) async {
     if (resume != null && resume!.isNotEmpty && index < resume!.length) {
       final result = await Navigator.push(
         context,
         MaterialPageRoute(
           builder: (context) => EditItemScreen(item: resume![index]),
         ),
       );

       if (result != null) {
         setState(() {
           resume![index] = result as ResumeItem;
         });

         _saveResume();
       }
     }
   }

   _saveResume() async {
    await ResumeDataManager.saveResume(resume!);
  }
   _deleteItem(int index) {
     if (resume != null && resume!.isNotEmpty && index < resume!.length) {
       setState(() {
         resume!.removeAt(index);
       });
       _saveResume();
     }
   }
   _addItem() async {
     // Navigate to AddItemScreen and wait for result
     final result = await Navigator.push(
       context,
       MaterialPageRoute(builder: (context) => const AddItemScreen()),
     );

     if (result != null) {
       setState(() {
         if (resume == null) {
           resume = [];
         }
         resume!.add(result as ResumeItem);
       });

       _saveResume();
     }
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Resume'),
       centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent.shade100,
      ),
      body: Container(
        color: Colors.grey[200],
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (resume!.isEmpty)
              const Center(
                child: Text(
                  'Your resume is empty. Start by adding items.',
                  style: TextStyle(fontSize: 18.0),
                ),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: resume!.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 3.0,
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ResumeListItem(
                        item: resume![index],
                        onDelete: () => _deleteItem(index),
                        onEdit: () => _editItem(index),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _addItem,
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 16.0),
          FloatingActionButton(
            onPressed: _generatePDF,
            child: const Icon(Icons.picture_as_pdf),
          ),
        ],
      ),
    );
  }
   _generatePDF() async {
     if (resume != null && resume!.isNotEmpty) {
       final pdf = pw.Document();

       // Custom fonts
       final boldFont = pw.Font.ttf(await rootBundle.load("assets/fonts/OpenSans-Bold.ttf"));
       final regularFont = pw.Font.ttf(await rootBundle.load("assets/fonts/OpenSans-Regular.ttf"));

       // Styling
       final titleStyle = pw.TextStyle(font: boldFont, fontSize: 16, color: PdfColors.blue900);
       final contentStyle = pw.TextStyle(font: regularFont, fontSize: 14, color: PdfColors.black);

       // Add content to the PDF
       pdf.addPage(
         pw.Page(
           margin: const pw.EdgeInsets.all(20.0),
           build: (context) => pw.Column(
             crossAxisAlignment: pw.CrossAxisAlignment.start,
             children: [
               pw.Header(
                 level: 1,
                 text: 'Resume',
                 textStyle: pw.TextStyle(font: boldFont, fontSize: 24, color: PdfColors.blue900),
               ),
               pw.SizedBox(height: 20),
               for (var item in resume!)
                 pw.Column(
                   crossAxisAlignment: pw.CrossAxisAlignment.start,
                   children: [
                     pw.Text(item.title, style: titleStyle),
                     pw.Text(item.content, style: contentStyle),
                     pw.SizedBox(height: 10),
                   ],
                 ),
             ],
           ),
         ),
       );

       // Save the PDF to a file
       final Directory tempDir = await getTemporaryDirectory();
       final String tempPath = tempDir.path;
       final String pdfPath = '$tempPath/resume.pdf';
       final File file = File(pdfPath);
       await file.writeAsBytes(await pdf.save());

       // Open the PDF using a PDF viewer
       OpenFile.open(pdfPath);
     }
   }
}
