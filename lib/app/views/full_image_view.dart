

import 'package:flutter/material.dart';
import 'package:gallery_app/app/controllers/my_controller.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:share_plus/share_plus.dart';
import '../constants/color.dart';

class FullImageView extends StatelessWidget {
  const FullImageView(
      {super.key,
      required this.image,
      required this.name,
      required this.likes,
      required this.description});

  final String image;
  final String name;
  final String likes;
  final String description;

 shareImage(String url, String desc) {
     Share.share(url, subject: desc);
  }


  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: MyController(),
        builder: (controller) {
          return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: AppColor.purple,
                leading: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: AppColor.white,
                    )),
                title: Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColor.white),
                ),
                centerTitle: true,
                actions: [
                  InkWell(
                      onTap: () {
                        shareImage(image, description);
                      },
                      child: Icon(
                        Icons.share_outlined,
                        color: AppColor.white,
                      )),
                  const SizedBox(
                    width: 20,
                  )
                ],
              ),
              body: Stack(
                children: [
                  Center(
                      child: PhotoView(
                    imageProvider: NetworkImage(image),
                  )),
                  Positioned(
                      bottom: 40,
                      right: 20,
                      child: InkWell(
                        onTap: () {
                          controller.savePhoto(image, context);
                        },
                        borderRadius: BorderRadius.circular(100),
                        splashColor: AppColor.purple,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: AppColor.white),
                          child: Row(
                            children: [
                              Text(
                                'Download',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: AppColor.purple),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                               Icon(
                                Icons.download_rounded,
                                color: AppColor.purple,
                                size: 18,
                              )
                            ],
                          ),
                        ),
                      )),
                  Positioned(
                      bottom: 160,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.black26),
                        child:  Row(
                          children: [
                            Expanded(
                              child: Text(
                                description == "null" ? 'no description' : description,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: AppColor.white),
                              ),
                            ),

                          ],
                        ),
                      )),
                  Positioned(
                      bottom: 40,
                      left: 20,
                      child: InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(100),
                        splashColor: AppColor.purple,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: AppColor.white),
                          child: Row(
                            children: [
                              Text(
                                'Likes ',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: AppColor.purple),
                              ),
                              Icon(
                                Icons.favorite_outline,
                                color: AppColor.purple,
                                size: 18,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                likes,
                                style:  TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: AppColor.purple),
                              ),
                            ],
                          ),
                        ),
                      )),
                ],
              ));
        });
  }
}
