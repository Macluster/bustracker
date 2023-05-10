import 'dart:io';
import 'dart:typed_data';

import 'package:bustracker/backend/SupaBaseDatabase.dart';
import 'package:file_picker/file_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseStorage {
  final supabase = Supabase.instance.client;

  Future<bool> uploadBirthCertificate() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    var userId = await SupaBaseDatabase().getCurrentUserId();

    if (result != null) {
      File file = File(result.files.single.path.toString());

      final avatarFile = file;

      final String path = await supabase.storage.from('Documents').upload(
            "UID${userId.toString()}/birthCertificate.jpg",
            avatarFile,
            fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
          );

      if (path == "Documents/UID${userId.toString()}/birthCertificate.jpg") {
        return true;
      }
    } else {
      // User canceled the picker
    }

    return false;
  }

  Future<bool> uploadIdCard() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    var userId = await SupaBaseDatabase().getCurrentUserId();

    if (result != null) {
      File file = File(result.files.single.path.toString());

      final avatarFile = file;

      final String path = await supabase.storage.from('Documents').upload(
            "UID${userId.toString()}/IdCard.jpg",
            avatarFile,
            fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
          );
      if (path == "Documents/UID${userId.toString()}/IdCard.jpg") {
        return true;
      }
    } else {
      // User canceled the picker
    }
    return false;
  }



  Future<bool> checkItemExist(String name)async
  {
 var userId = await SupaBaseDatabase().getCurrentUserId();
     final Uint8List file = await supabase
  .storage
  .from('Documents')
  .download("UID$userId/"+name);
        if(file!=null)
        {
          return true;
        }
        else
        {
          return false;
        }
  }
}