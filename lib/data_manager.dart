import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/resume_item.dart';

class ResumeDataManager {
  static const String resumeKey = 'resume';

  static Future<List<ResumeItem>> getResume() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? resumeJson = prefs.getString(resumeKey);

    if (resumeJson != null) {
      List<dynamic> decodedList = jsonDecode(resumeJson);
      List<ResumeItem> resume = decodedList.map((item) => ResumeItem.fromJson(item)).toList();
      return resume;
    } else {
      return [];
    }
  }

  static Future<void> saveResume(List<ResumeItem> resume) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> encodedList = resume.map((item) => jsonEncode(item.toJson())).toList();
    prefs.setStringList(resumeKey, encodedList);
  }
}
