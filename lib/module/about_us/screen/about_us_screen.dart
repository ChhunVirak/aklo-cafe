import 'package:aklo_cafe/config/router/app_pages.dart';
import 'package:aklo_cafe/constant/resources.dart';
import 'package:aklo_cafe/generated/l10n.dart';
import 'package:aklo_cafe/module/about_us/screen/add_profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.about_us),
      ),
      body: StreamBuilder(
        builder: (context, snapshot) {
          return GridView.builder(
            padding: EdgeInsets.all(Sizes.defaultPadding),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1,
              mainAxisSpacing: Sizes.defaultPadding,
              crossAxisSpacing: Sizes.defaultPadding,
            ),
            itemCount: 20,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  ///TODO: Handle Detail Route
                  pushSubRoute('123');
                },
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.deepBackgroundColor,
                        image: DecorationImage(
                          image: NetworkImage(
                              'https://scontent.fpnh16-1.fna.fbcdn.net/v/t39.30808-6/242123158_558942111890998_5464427153061642308_n.jpg?_nc_cat=102&ccb=1-7&_nc_sid=174925&_nc_eui2=AeFb51uTdk374cd8X1ZhGfOg_tOwpYbPbBj-07Clhs9sGE_g8O2vMvNRlugO0mSiXbB6E9smLLBwD7xAFWDQG_HH&_nc_ohc=678KOGvdVCoAX_66EMI&_nc_ht=scontent.fpnh16-1.fna&oh=00_AfDwlDoe-36Lv8RvCRk0vFhY7roDvPE-8GiBzYR6qsHlTg&oe=649B6302'),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black87,
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Chorn Kihong',
                        style: AppStyle.small.copyWith(
                          color: AppColors.txtLightColor,
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(AddProfile());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
