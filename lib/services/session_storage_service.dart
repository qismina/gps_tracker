import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/walk_session.dart';

class SessionStorageService {
  static const String _sessionsFileName = 'walk_sessions.json';

  Future<String> get _sessionsFilePath async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/$_sessionsFileName';
  }

  Future<void> saveSession(WalkSession session) async {
    final sessions = await getAllSessions();
    sessions.add(session);
    
    final filePath = await _sessionsFilePath;
    final file = File(filePath);
    final jsonList = sessions.map((s) => s.toJson()).toList();
    await file.writeAsString(json.encode(jsonList));
  }

  Future<List<WalkSession>> getAllSessions() async {
    try {
      final filePath = await _sessionsFilePath;
      final file = File(filePath);
      
      if (!await file.exists()) {
        return [];
      }
      
      final contents = await file.readAsString();
      final List<dynamic> jsonList = json.decode(contents);
      return jsonList.map((json) => WalkSession.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<WalkSession?> getSessionByRecording(String recordingPath) async {
    final sessions = await getAllSessions();
    try {
      return sessions.firstWhere((s) => s.recordingPath == recordingPath);
    } catch (e) {
      return null;
    }
  }

  Future<WalkSession?> getSessionByScreenshot(String screenshotPath) async {
    final sessions = await getAllSessions();
    try {
      return sessions.firstWhere((s) => s.screenshotPath == screenshotPath);
    } catch (e) {
      return null;
    }
  }

  Future<void> deleteSession(String sessionId) async {
    final sessions = await getAllSessions();
    sessions.removeWhere((s) => s.id == sessionId);
    
    final filePath = await _sessionsFilePath;
    final file = File(filePath);
    final jsonList = sessions.map((s) => s.toJson()).toList();
    await file.writeAsString(json.encode(jsonList));
  }
}