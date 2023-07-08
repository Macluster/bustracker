import 'dart:io';
import 'dart:typed_data';

import 'package:bustracker/backend/SupaBaseDatabase.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseStorage {
  final supabase = Supabase.instance.client;

  Future<bool> uploadPhoto() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    var userId = await SupaBaseDatabase().getCurrentUserId();

    if (result != null) {
      File file = File(result.files.single.path.toString());

      final avatarFile = file;

      await supabase.storage
          .from('Documents')
          .remove(["UID${userId.toString()}/Photo.jpg"]);

     final String path = await supabase.storage.from('Documents').upload(
            "UID${userId.toString()}/Photo.jpg",
            avatarFile,
            fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
          );
      if (path == "Documents/UID${userId.toString()}/Photo.jpg") {
        var url = await supabase.storage
            .from("Documents")
            .getPublicUrl("UID${userId.toString()}/Photo.jpg");
        SupaBaseDatabase().addProilePhotoUrl(url);
        return true;
      }
    } else {
      // User canceled the picker
    }

    return false;
  }

  Future<bool> uploadForm() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    var userId = await SupaBaseDatabase().getCurrentUserId();

    if (result != null) {
      File file = File(result.files.single.path.toString());

      final avatarFile = file;

      await supabase.storage
          .from('Documents')
          .remove(["UID${userId.toString()}/Form.jpg"]);

      final String path = await supabase.storage.from('Documents').upload(
            "UID${userId.toString()}/Form.jpg",
            avatarFile,
            fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
          );
      if (path == "Documents/UID${userId.toString()}/Form.jpg") {
        var url = await supabase.storage
            .from("Documents")
            .getPublicUrl("UID${userId.toString()}/Form.jpg");
        SupaBaseDatabase().addFormPhotoUrl(url);
        return true;
      }
    } else {
      // User canceled the picker
    }
    return false;
  }

  Future<bool> uploadAdhar() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    var userId = await SupaBaseDatabase().getCurrentUserId();

    if (result != null) {
      File file = File(result.files.single.path.toString());

      final avatarFile = file;

      
      await supabase.storage
          .from('Documents')
          .remove(["UID${userId.toString()}/adhar.jpg"]);

      final String path = await supabase.storage.from('Documents').upload(
            "UID${userId.toString()}/adhar.jpg",
            avatarFile,
            fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
          );
      if (path == "Documents/UID${userId.toString()}/adhar.jpg") {
        return true;
      }
    } else {
      // User canceled the picker
    }
    return false;
  }

  Future<bool> checkItemExist(String name) async {
    var userId = await SupaBaseDatabase().getCurrentUserId();
    final Uint8List file =
        await supabase.storage.from('Documents').download("UID$userId/" + name);
    if (file != null) {
      return true;
    } else {
      return false;
    }
  }
}
