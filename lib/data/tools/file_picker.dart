import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';

class ToolFilePicker {
  static late FileSystemEntity assetsFolder;

  static createAssetsDirectory() async {
    String pathDocuments = (await getApplicationSupportDirectory()).path;
    assetsFolder = File("$pathDocuments\\user_data");
    Directory(assetsFolder.path).create();
  }

  static Future<String?> choseVideoFile() async {
    PlatformFile? pickedFile;
    try {
      pickedFile = (await FilePicker.platform.pickFiles(
        type: FileType.video,
      ))
          ?.files
          .first;
    } catch (e) {
      print(e);
    }
    return pickedFile?.path;
  }

  static Future<List<String?>?> choseImageFile() async {
    List<PlatformFile>? pickedFile;
    try {
      pickedFile = (await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: true,
      ))
          ?.files;
    } catch (e) {
      print(e);
    }
    List<String?>? pathList = pickedFile?.map((e) => e.path).toList();
    return pathList;
  }

  static String saveVideoFileToUserFolder(String filePath, String name) {
    File file = File(filePath);
    file
        .copy("${assetsFolder.path}\\video_$name.mp4")
        .then((value) => file.delete());
    return "${assetsFolder.path}\\video_$name.mp4"
        "";
  }

  static String saveImgFileToUserFolder(String filePath, String name) {
    File file = File(filePath);
    String newFilePath = "${assetsFolder.path}\\$name.png";
    file.copy(newFilePath).then((value) => file.delete());

    return "${assetsFolder.path}\\$name.png";
  }

  static File changeFileNameOnlySync(File file, String newFileName) {
    var path = file.path;
    var lastSeparator = path.lastIndexOf(Platform.pathSeparator);
    var newPath = path.substring(0, lastSeparator + 1) + newFileName;
    return file.renameSync(newPath);
  }

  static deleteFile(String path) {
    try {
      File(path).delete();
    } catch (e) {
      print(e);
    }
  }
}
