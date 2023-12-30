import 'package:flutter/material.dart';
import 'package:resume_builder/widgets/text_widget.dart';

import '../models/resume_item.dart';


class EditItemScreen extends StatefulWidget {
  final ResumeItem item;

  EditItemScreen({super.key, required this.item});

  @override
  _EditItemScreenState createState() => _EditItemScreenState();
}

class _EditItemScreenState extends State<EditItemScreen> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.item.title);
    _contentController = TextEditingController(text: widget.item.content);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Resume Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _contentController,
              decoration: const InputDecoration(labelText: 'Content'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _editItem,
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }

  _editItem() {
    String title = _titleController.text.trim();
    String content = _contentController.text.trim();

    if (title.isNotEmpty && content.isNotEmpty) {
      ResumeItem editedItem = ResumeItem(title: title, content: content);

      Navigator.pop(context, editedItem);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: TextWidget(label: "Field is Empty"),
            backgroundColor: Colors.red,)
      );
    }
  }
}
