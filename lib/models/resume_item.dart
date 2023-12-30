class ResumeItem {
  String title;
  String content;

  ResumeItem({required this.title, required this.content});

  factory ResumeItem.fromJson(Map<String, dynamic> json) {
    return ResumeItem(
      title: json['title'] as String,
      content: json['content'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
    };
  }
}
