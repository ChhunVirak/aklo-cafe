import 'package:aklo_cafe/constant/resources.dart';
import 'package:aklo_cafe/generated/l10n.dart';
import 'package:aklo_cafe/util/extensions/widget_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileDetail extends StatelessWidget {
  const ProfileDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.about_us),
      ),
      body: StreamBuilder(
        builder: (context, snapshot) {
          final name = 'Chorn Kihong';
          final email = 'ChornKihong@gmail.com';
          final department = 'BBU University';
          final bio =
              "I'm Chorn Kihong, a computer science student at BBU University. Passionate about technology and programming, I'm eager to contribute my skills to practical projects and stay up-to-date with the latest industry trends.";
          return Container(
            width: double.infinity,
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                left: Sizes.defaultPadding,
                right: Sizes.defaultPadding,
                top: Sizes.defaultPadding,
                bottom: 80,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: context.width * .3,
                    backgroundImage: NetworkImage(
                      'https://scontent.fpnh16-1.fna.fbcdn.net/v/t39.30808-6/242123158_558942111890998_5464427153061642308_n.jpg?_nc_cat=102&ccb=1-7&_nc_sid=174925&_nc_eui2=AeFb51uTdk374cd8X1ZhGfOg_tOwpYbPbBj-07Clhs9sGE_g8O2vMvNRlugO0mSiXbB6E9smLLBwD7xAFWDQG_HH&_nc_ohc=678KOGvdVCoAX_66EMI&_nc_ht=scontent.fpnh16-1.fna&oh=00_AfDwlDoe-36Lv8RvCRk0vFhY7roDvPE-8GiBzYR6qsHlTg&oe=649B6302',
                    ),
                  ),
                  10.sh,
                  NameBox(des: 'Name', name: name),
                  5.sh,
                  NameBox(des: 'Email', name: email),
                  5.sh,
                  NameBox(des: 'Department', name: department),
                  5.sh,
                  NameBox(des: 'Bio', name: bio),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.edit),
      ),
    );
  }
}

class NameBox extends StatelessWidget {
  const NameBox({
    super.key,
    required this.des,
    required this.name,
  });

  final String des;
  final String name;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                des,
                style: AppStyle.small.copyWith(fontSize: 12),
              ),
              Text(
                name,
                style: AppStyle.medium
                    .copyWith(fontSize: 14, color: AppColors.mainColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
