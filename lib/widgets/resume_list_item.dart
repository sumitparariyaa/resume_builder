import 'package:flutter/material.dart';
import '../models/resume_item.dart';

class ResumeListItem extends StatelessWidget {
  final ResumeItem item;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  ResumeListItem({required this.item, required this.onDelete, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item.title),
      subtitle: Text(item.content),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: onEdit,
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}
