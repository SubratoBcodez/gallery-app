import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:gallery_app/app/model/unsplash_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import '../../bcodez/app_logger.dart';
import '../constants/api.dart';
import '../constants/color.dart';

class MyController extends GetxController {
  RxList<UnSplashModelView> listOfUnSplashModelView = <UnSplashModelView>[].obs;

  RxBool isLoaded = false.obs;
  RxBool isLoading = false.obs;

  RxInt pages = 1.obs;

  /// get photos from api
  Future<void> getApiData() async {
    if (isLoading.value) return;
    isLoading.value = true;

    try {
      final response = await http.get(
          Uri.parse("${Api.baseUrl}?page=${pages.value}&per_page=15"),
          headers: {'Authorization': "Client-ID ${Api.clientID}"});

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        List<dynamic> masterList = json;
        //  listOfUnSplashModelView.clear();

        for (int i = 0; i < masterList.length; i++) {
          Urls urls = Urls.fromJson(masterList[i]['urls'] ?? {});
          User user = User.fromJson(masterList[i]['user'] ?? {});
          UnSplashModelView unSplashModelView = UnSplashModelView(
            id: masterList[i]['id'],
            small: masterList[i]['urls']['small'],
            regular: masterList[i]['urls']['regular'],
            likes: masterList[i]['likes'],
            description: masterList[i]['description'],
            altDescription: masterList[i]['alt_description'],
            urls: urls,
            user: user,
          );

          if (!listOfUnSplashModelView
              .any((element) => element.id == unSplashModelView.id)) {
            listOfUnSplashModelView.add(unSplashModelView);
            //  AppLogger.instance.debug(unSplashModelView.toJson());
          }

          //  listOfUnSplashModelView.add(unSplashModelView);
          //  AppLogger.instance.debug(unSplashModelView.toJson());
        }

        AppLogger.instance.debug(pages.value);
        pages.value++;
        isLoaded.value = true;
        isLoading.value = false;
      } else {
        AppLogger.instance.debug("something went wrong :)");
      }
    } catch (e) {
      AppLogger.instance.debug(e);
    }
  }

  /// save photo to gallery
  Future<void> savePhoto(String url, BuildContext context) async {
    try {

      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final result = await ImageGallerySaverPlus.saveImage(
            Uint8List.fromList(response.bodyBytes));
        if (result['isSuccess']) {
          Get.snackbar('Success', 'Photo saved to gallery!',
              backgroundColor: AppColor.white,
              snackPosition: SnackPosition.BOTTOM);
        } else {
          throw Exception('Failed to save photo');
        }
      } else {
        throw Exception('Failed to download image');
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to save photo: ${e.toString()}',
        backgroundColor: AppColor.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  void onInit() async {
    await getApiData();
    super.onInit();
  }
}
