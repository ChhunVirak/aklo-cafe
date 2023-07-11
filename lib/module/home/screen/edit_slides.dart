import 'dart:io' show File;

import 'package:aklo_cafe/generated/l10n.dart';
import 'package:aklo_cafe/module/home/model/slide_model.dart';
import 'package:aklo_cafe/util/alerts/app_dialog.dart';
import 'package:aklo_cafe/util/alerts/app_modal_bottomsheet.dart';
import 'package:aklo_cafe/util/alerts/app_snackbar.dart';
import 'package:aklo_cafe/util/extensions/widget_extension.dart';
import 'package:aklo_cafe/util/widgets/custom_textfield.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../constant/resources.dart';
import '../../../util/widgets/custom_button.dart';
import '../controller/edit_slide_controller.dart';

class EditSlide extends StatefulWidget {
  const EditSlide({super.key});

  @override
  State<EditSlide> createState() => _EditSlideState();
}

class _EditSlideState extends State<EditSlide> {
  final ImagePicker _imagePicker = ImagePicker();

  ///Set image quality here
  final _imgQuality = 50;

  Future<XFile?> _onSelectImage() async {
    return await _imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: _imgQuality,
    );
  }

  Future<XFile?> _onOpenCamera() async {
    return await _imagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: _imgQuality,
    );
  }

  void _showAndroidPopUp({String? id, String? oldUrl}) {
    showModalBottomSheet(
      context: context,
      builder: (popContext) => SafeArea(
        minimum: const EdgeInsets.only(bottom: 30, top: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        _onSelectImage().then((xFile) {
                          // Navigator.pop(popContext);
                          _showImage(
                              url: null,
                              file: File(xFile!.path),
                              id: id,
                              oldUrl: oldUrl);
                        });
                      },
                      icon: const Icon(Icons.image),
                    ),
                    Text(
                      S.current.gallery,
                      style: AppStyle.medium,
                    ),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        _onOpenCamera().then((xFile) {
                          // Navigator.pop(popContext);
                          _showImage(
                              url: null,
                              file: File(xFile!.path),
                              id: id,
                              oldUrl: oldUrl);
                        });
                      },
                      icon: const Icon(Icons.camera),
                    ),
                    Text(
                      S.current.camera,
                      style: AppStyle.medium,
                    ),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        _showUrlInput(id: id, oldUrl: oldUrl);
                      },
                      icon: const Icon(PhosphorIcons.link_bold),
                    ),
                    Text(
                      S.current.link,
                      style: AppStyle.medium,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showUrlInput({String? id, String? oldUrl}) {
    final txtController = TextEditingController();
    showCustomModalBottomSheetNoLimit(
      Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, bottom: 25, top: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextField(
              controller: txtController,
              label: S.current.link,
            ),
            CustomButton(
              onPressed: () {
                _showImage(url: txtController.text, file: null, id: id);
              },
              name: S.current.check_out,
            )
          ],
        ),
      ),
    );
  }

  void _showImage(
      {String? url, File? file, required String? id, String? oldUrl}) {
    showDialog(
      context: context,
      barrierColor: Colors.black87,
      barrierDismissible: false,
      builder: (context) => Column(
        children: [
          AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_rounded,
                color: AppColors.txtLightColor,
              ),
            ),
            // title: Text(S.current.image),
            actions: [
              IconButton(
                onPressed: () async {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  if (id != null) {
                    Navigator.pop(context);
                  }

                  //TODO: Submit Image
                  if (id == null) {
                    await controller.submitNewSlide(
                      url: url,
                      file: file,
                    );
                  } else {
                    controller.updateSlide(
                        id: id, url: url, file: file, oldUrl: oldUrl);
                  }
                },
                icon: Icon(
                  Icons.done_rounded,
                  color: AppColors.txtLightColor,
                ),
              ),
              10.sw,
            ],
          ),
          Expanded(
            child: Center(
              child: file != null ? Image.file(file) : Image.network(url!),
            ),
          ),
          60.sh
        ],
      ),
    );
  }

  final controller = Get.put(EditSlideController());

  @override
  void initState() {
    controller.currentIndex(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.edit_slide),
      ),
      body: StreamBuilder<List<SlideModel>>(
        stream: controller.sliderSnapShot,
        builder: (context, snapshot) {
          final imgs = snapshot.data;
          if (snapshot.hasData && imgs != null) {
            return Obx(
              () => Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: Sizes.defaultPadding),
                child: Column(
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                        initialPage: controller.currentIndex.value,
                        aspectRatio: 2 / 1,
                        viewportFraction: 0.9,
                        enlargeFactor: 0.2,
                        enlargeCenterPage: true,
                        autoPlay: false,
                        enableInfiniteScroll: false,
                        onPageChanged: (index, reason) {
                          debugPrint('Current Index = $index');
                          controller.currentIndex(index);
                        },
                      ),
                      items: [
                        ...imgs
                            .map(
                              (e) => e.image != null
                                  ? SizedBox(
                                      width: double.infinity,
                                      child: ClipRRect(
                                        borderRadius: Sizes.boxBorderRadius,
                                        child: Image.network(
                                          e.image!,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    )
                                  : Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.backgroundColor,
                                        borderRadius: Sizes.boxBorderRadius,
                                      ),
                                      child: Center(
                                        child: Text(S.current.noImage),
                                      ),
                                    ),
                            )
                            .toList(),
                        InkWell(
                          onTap: () {
                            _showAndroidPopUp();
                          },
                          borderRadius: Sizes.boxBorderRadius,
                          child: Ink(
                            decoration: BoxDecoration(
                              color: AppColors.backgroundColor,
                              borderRadius: Sizes.boxBorderRadius,
                            ),
                            child: Center(
                              child: Icon(
                                PhosphorIcons.plus_circle_thin,
                                size: 80,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    20.sh,
                    if (controller.currentIndex.value < imgs.length)
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: Column(
                          children: [
                            CustomButton(
                              onPressed: () {
                                _showAndroidPopUp(
                                    id: imgs[controller.currentIndex.value].id);
                              },
                              backgroundColor: Colors.green,
                              name: S.current.edit,
                            ),
                            20.sh,
                            CustomButton(
                              onPressed: () {
                                showCustomDialog(
                                  title: S.current.confirm,
                                  description: S.current.delete_img_message,
                                  actions: [
                                    TextButton(
                                      onPressed: () async {
                                        removeDialog();
                                        await controller.deleteImage(imgs[
                                            controller.currentIndex.value]);

                                        showErrorSnackBar(
                                            title: S.current.success,
                                            description:
                                                S.current.delete_success);
                                      },
                                      child: Text(S.current.yes),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(S.current.cancel),
                                    ),
                                  ],
                                );
                              },
                              backgroundColor: Colors.red,
                              name: S.current.delete,
                            ),
                          ],
                        ),
                      )
                  ],
                ),
              ),
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
