import 'dart:convert';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:women_safety_app/common/constants/env.constants.dart';

import 'permission.service.dart';

class ImageService {
  static Future<String> uploadImage(String filePath) async {
    print('Image Upload URL -> $imageUploadUrl');
    final req = http.MultipartRequest('POST', Uri.parse(imageUploadUrl));
    final http.MultipartFile multipartFile =
        await http.MultipartFile.fromPath('image', filePath);
    req.files.add(multipartFile);
    final res = await req.send();
    final Map<dynamic, dynamic> responseJson =
        jsonDecode(await res.stream.bytesToString());
    print('Image Upload Response Image -> ${responseJson['data']?['image']}');
    return responseJson['data']?['image']?['url'];
  }

  static Future<List<XFile>?> clickPictures(BuildContext context) async {
    if (!(await PermissionService.getCameraPermission())) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Not able to proceed. Please provide sms access'),
        ),
      );

      return null;
    }

    final List<CameraDescription> cameras = await availableCameras();
    final List<XFile> imageFiles = [];
    print('Available Cameras -> ${cameras.length}');
    for (CameraDescription camera in cameras) {
      CameraController controller =
          CameraController(camera, ResolutionPreset.max);
      await controller.initialize();
      if (controller.value.isInitialized) {
        print('Capturing image');
        XFile image = await controller.takePicture();
        print('Image Captured Path -> ${image.path}');
        imageFiles.add(image);
      } else {
        print('Camera controller not initialized');
      }
    }
    ;
    return imageFiles;
  }
}
