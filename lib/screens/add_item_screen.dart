import 'package:flutter/material.dart';
import '../models/resume_item.dart';
import '../widgets/text_widget.dart';

class AddItemScreen extends StatefulWidget {
  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Resume Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(labelText: 'Content'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _addItem,
              child: Text('Add Item'),
            ),
          ],
        ),
      ),
    );
  }

  _addItem() {
    String title = _titleController.text.trim();
    String content = _contentController.text.trim();

    if (title.isNotEmpty && content.isNotEmpty) {
      ResumeItem newItem = ResumeItem(title: title, content: content);
      Navigator.pop(context, newItem);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: TextWidget(label: "Field is Empty"),
            backgroundColor: Colors.red,)
      );
    }
  }}
