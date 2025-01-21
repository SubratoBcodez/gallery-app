import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gallery_app/app/controllers/my_controller.dart';
import 'package:gallery_app/app/views/full_image_view.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../constants/color.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: MyController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: AppColor.white,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              centerTitle: true,
              backgroundColor: AppColor.purple,
              title: Text(
                'Gallery App',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColor.white),
              ),
            ),
            body: Obx(() => controller.isLoaded.value
                ? NotificationListener<ScrollNotification>(
                    onNotification: (ScrollNotification scrollInfo) {
                      if (!controller.isLoading.value &&
                          scrollInfo.metrics.pixels ==
                              scrollInfo.metrics.maxScrollExtent) {
                        controller.getApiData();
                      }
                      return false;
                    },
                    child: MasonryGridView.builder(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 10),
                      gridDelegate:
                          const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      itemCount: controller.listOfUnSplashModelView.length,
                      itemBuilder: (BuildContext context, int index) {
                        var photos = controller.listOfUnSplashModelView[index];
                        var user =
                            controller.listOfUnSplashModelView[index].user!;
                        return InkWell(
                          onTap: () {
                            Get.to(FullImageView(
                              image: '${photos.regular}',
                              name: '${user.name}',
                              likes: '${photos.likes}', description: '${photos.altDescription}',
                            ));
                          },
                          borderRadius: BorderRadius.circular(12.0),
                          child: Stack(
                            children: [
                              Container(
                                margin: const EdgeInsets.all(5),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12.0),
                                  child: CachedNetworkImage(
                                    imageUrl: '${photos.small}',
                                    placeholder: (context, url) => const Icon(
                                      Icons.image_outlined,
                                      size: 30,
                                      color: Colors.grey,
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error,
                                            size: 30, color: Colors.red),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                  bottom: 16,
                                  left: 16,
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 15,
                                        backgroundColor: AppColor.white,
                                        backgroundImage: NetworkImage(
                                            '${user.profileImage!.small}'),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        '${user.firstName}',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: AppColor.white),
                                      ),
                                    ],
                                  ))
                            ],
                          ),
                        );
                      },
                    ))
                : const Center(
                    child: SizedBox(
                        child: CircularProgressIndicator(
                    color: Colors.purple,
                  )))),
          );
        });
  }
}
