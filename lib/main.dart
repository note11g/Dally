import 'package:dally/data/enums.dart';
import 'package:dally/data/model/artwork_model.dart';
import 'package:dally/data/model/search_record_model.dart';
import 'package:dally/data/model/user_model.dart';
import 'package:dally/resource/values/colors.dart';
import 'package:dally/routes/pages.dart';
import 'package:dally/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  await Hive.initFlutter();
  Hive
    ..registerAdapter(SearchRecordAdapter())
    ..registerAdapter(ArtWorkAdapter())
    ..registerAdapter(UserAdapter())
    ..registerAdapter(GalleryTypeAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Dally',
      theme: ThemeData(
          fontFamily: 'spoqa',
          scaffoldBackgroundColor: ColorPalette.backGroundGray,
          primaryColor: ColorPalette.mainBlue),
      getPages: ApplicationPages.pages,
      initialRoute: Routes.main,
    );
  }
}
