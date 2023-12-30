import 'package:flutter/material.dart';
import '../data_manager.dart';
import '../models/resume_item.dart';
import '../widgets/resume_list_item.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Resume'),
      ),
      body: ListView.builder(
        itemCount: resume.length,
        itemBuilder: (context, index) {
          return ResumeListItem(
            item: resume[index],
            onDelete: () => _deleteItem(index),
            onEdit: () => _editItem(index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addItem,
        child: Icon(Icons.add),
      ),
    );
  }

  _addItem() async {
  }

  _deleteItem(int index) {
    setState(() {
      resume.removeAt(index);
    });
    _saveResume();
  }

  _editItem(int index) async {

  }

  _saveResume() async {
    await ResumeDataManager.saveResume(resume);
  }
}
