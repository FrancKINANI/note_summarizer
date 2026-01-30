import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import '../data/models/note.dart';

class StorageService {
  static const String _fileName = 'my_notes.json';

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/$_fileName');
  }

  // Save the list of notes to the file
  Future<void> saveNotes(List<Note> notes) async {
    final file = await _localFile;
    // Convert List<Note> to List<Map>
    final List<Map<String, dynamic>> jsonList = 
        notes.map((note) => note.toJson()).toList();
    // Convert List<Map> to JSON string
    final String jsonString = jsonEncode(jsonList);
    
    // Write the file
    await file.writeAsString(jsonString);
  }

  // Load the list of notes from the file
  Future<List<Note>> loadNotes() async {
    try {
      final file = await _localFile;
      if (!await file.exists()) {
        return []; // Return empty list if file doesn't exist yet
      }

      // Read the file
      final String contents = await file.readAsString();
      // Decode JSON string to List<dynamic>
      final List<dynamic> jsonList = jsonDecode(contents);

      // Convert List<dynamic> to List<Note>
      return jsonList.map((json) => Note.fromJson(json)).toList();
    } catch (e) {
      // If encountering an error (e.g. corrupted file), return empty list for now
      debugPrint('Error loading notes: $e');
      return [];
    }
  }
}
