import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:machine_care/constants/constants.dart';
import 'package:permission_handler/permission_handler.dart';

class DialogUploadImage extends StatelessWidget {
  final bool? isNative;

  const DialogUploadImage({Key? key, this.isNative}) : super(key: key);

  changeImage(bool fromGallery, BuildContext context) async {
    try {
      openChooseImage(fromGallery);
    } on Exception catch (_) {}
  }

  Future<void> openChooseImage(bool fromGallery) async {
    final image = await ImagePicker()
        .pickImage(
      source: fromGallery ? ImageSource.gallery : ImageSource.camera,
      imageQuality: 70,
      maxWidth: 720,
    )
        .catchError((Object error) {
      openAppSettings();
    });
    if (image != null) {
      if (isNative != null && isNative!) {
        Get.back(result: File(image.path));
      } else {
        final f = await _cropImage(image.path);
        if (f != null) {
          Get.back(result: File(f.path));
        }
      }
    }
  }

  Future<CroppedFile?> _cropImage(path) async {
    return await ImageCropper().cropImage(
      sourcePath: path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: '',
            toolbarColor: Colors.black,
            toolbarWidgetColor: Colors.white,
            hideBottomControls: true,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: true),
        IOSUiSettings(
          title: '',
          minimumAspectRatio: 1,
          rotateButtonsHidden: true,
          rotateClockwiseButtonHidden: true,
          resetButtonHidden: true,
          aspectRatioPickerButtonHidden: true,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.back(),
      child: Container(
        color: Colors.transparent,
        width: double.maxFinite,
        height: double.maxFinite,
        alignment: Alignment.bottomCenter,
        child: GestureDetector(
          onTap: () {},
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: Get.height * .03 + 5),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(15),
                topLeft: Radius.circular(15),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => changeImage(false, context),
                  child: Text(
                    'take_photo'.tr,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.medium().copyWith(color: const Color(0xFF3F3F3F)),
                  ),
                ),
                const SizedBox(height: 18),
                GestureDetector(
                  onTap: () => changeImage(true, context),
                  child: Text(
                    'photo_from_lib'.tr,
                    style: AppTextStyles.medium().copyWith(color: const Color(0xFF3F3F3F)),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 18),
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Text(
                    'cancel'.tr,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.medium().copyWith(color: const Color(0xFFB7B7B7)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
