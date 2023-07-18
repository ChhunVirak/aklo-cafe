import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constant/resources.dart';
import '../../../generated/l10n.dart';
import '../controller/edit_slide_controller.dart';
import '../model/slide_model.dart';

class ImageSlider extends StatelessWidget {
  const ImageSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final slideController = Get.put(EditSlideController());
    return StreamBuilder<List<SlideModel>>(
      stream: slideController.sliderSnapShot,
      builder: (context, snapshot) {
        final imgs = snapshot.data;
        if (snapshot.hasData && imgs != null) {
          return CarouselSlider(
            options: CarouselOptions(
              aspectRatio: 2 / 1,
              viewportFraction: 0.8,
              enlargeFactor: 0.2,
              enlargeCenterPage: true,
              autoPlay: true,
              // enableInfiniteScroll: false,
              onPageChanged: (index, reason) {},
            ),
            items: imgs
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
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
