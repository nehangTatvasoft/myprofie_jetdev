import 'dart:developer';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:my_profile_task/utils/permission_dialog.dart';
import 'package:permission_handler/permission_handler.dart';

import '../values/app_strings.dart';
import 'Navigations/app_routes.dart';

class PickImage {
  Future<String?> takePicture(ImageSource source) async {
    if (Platform.isIOS) {
      var status = await getPermission(
          source == ImageSource.camera ? Permission.camera : Permission.photos);
      if (status == ImagePermissionStatus.isGranted) {
        return await _getImage(source);
      } else {
        showPermissionDialog(navigationKey.currentContext!, () {
          openAppSettings().then((permission) async {
            if (await Permission.camera.isGranted) {
              return await _getImage(source);
            }
          });
        }, AppStrings.labelPleaseAllowAccessToYourCamera,
            AppStrings.labelThisAllowsYuMeToCapturePhotosFromYourCamera);
      }
    } else {
      return await _getImage(source);
    }
    return null;
  }

  Future<ImagePermissionStatus> getPermission(Permission permission) async {
    if (await permission.isGranted || await permission.isLimited) {
      return ImagePermissionStatus.isGranted;
    } else if (await permission.isDenied) {
      PermissionStatus permission1 = await permission.request();
      if (permission1.isGranted) {
        return ImagePermissionStatus.isGranted;
      }
      return ImagePermissionStatus.isDenied;
    } else {
      return ImagePermissionStatus.isDenied;
    }
  }

  Future<String?> _getImage(
    ImageSource source,
  ) async {
    await Future.delayed(const Duration(milliseconds: 400));
    try {
      var pickedFile = await ImagePicker().pickImage(
        source: source,
        preferredCameraDevice: CameraDevice.rear,
      );

      if (pickedFile != null) {
        return pickedFile.path;
      }
    } on Exception catch (e) {
      log(e.toString());
    }
    return null;
  }
}
