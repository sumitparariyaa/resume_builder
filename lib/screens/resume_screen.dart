import 'package:flutter/material.dart';
import '../data_manager.dart';
import '../models/resume_item.dart';
import '../widgets/resume_list_item.dart';
import 'add_item_screen.dart';
import 'edit_item_screen.dart';

class ResumeScreen extends StatefulWidget {
  @override
  _ResumeScreenState createState() => _ResumeScreenState();
}

class _ResumeScreenState extends State<ResumeScreen> {
  late List<ResumeItem> resume;

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
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditItemScreen(item: resume[index]),
      ),
    );

    if (result != null) {
      setState(() {
        resume[index] = result as ResumeItem;
      });

      _saveResume(); // Ensure _saveResume is declared before calling it
    }
  }
  _saveResume() async {
    await ResumeDataManager.saveResume(resume);
  }
  _deleteItem(int index) {
    setState(() {
      resume.removeAt(index);
    });
    _saveResume();
  }
  _addItem() async {
    // Navigate to AddItemScreen and wait for result
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddItemScreen()),
    );

    if (result != null) {
      setState(() {
        resume.add(result as ResumeItem);
      });

      _saveResume(); // Ensure _saveResume is declared before calling it
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Resume'),
       centerTitle: true,
      ),
      body: Container(
        color: Colors.grey[200],
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (resume.isEmpty)
              Center(
                child: Text(
                  'Your resume is empty. Start by adding items.',
                  style: TextStyle(fontSize: 18.0),
                ),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: resume.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 3.0,
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      child: ResumeListItem(
                        item: resume[index],
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
      // body: ListView.builder(
      //   itemCount: resume.length,
      //   itemBuilder: (context, index) {
      //     return ResumeListItem(
      //       item: resume[index],
      //       onDelete: () => _deleteItem(index),
      //       onEdit: () => _editItem(index),
      //     );
      //   },
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addItem,
        child: Icon(Icons.add),
      ),
    );
  }




}
