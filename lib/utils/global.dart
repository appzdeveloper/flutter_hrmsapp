import 'dart:io';
import 'dart:async';

import 'package:file_picker/file_picker.dart';

class Global {
  String filePath;
  // Will let you pick one file path, from all extensions
  openFilePicker() async {
    List<File> files = await FilePicker.getMultiFile(type: FileType.ANY);
    return files;
  }
}
