import 'package:cached_network_image/cached_network_image.dart';
import 'package:dally/resource/values/colors.dart';
import 'package:flutter/material.dart';

import '../../data/model/artwork_model.dart';
import '../../data/model/user_model.dart';
import '../../data/repository/search_repository.dart';
import '../../data/source/remote_data_source.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  final resultUserMap = <User, List<ArtWork>>{};

  @override
  void initState() {
    _getInfo();
    super.initState();
  }

  Future<void> _getInfo() async {
    final userMap = <String, User>{};
    for (int i = 1; i <= 100; i++) {
      try {
        final user = await RemoteDataSource.getUser("$i");
        if (user != null) userMap["$i"] = user;
      } catch (e) {
        print(e);
      }
    }
    userMap.forEach((key, value) async {
      final artworks = await SearchRepository.getUsersArtworks(key);
      if (artworks.isNotEmpty) {
        final str = artworks.map((e) => "${e.title} : ${e.artImageUrl}, ");
        setState(() {
          resultUserMap[value] = artworks;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("테스트 페이지")),
        body: ListView(
          children: resultUserMap.entries
              .map((v) => Container(
                    color: ColorPalette.gray100,
                    margin: const EdgeInsets.only(top: 12),
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 14),
                    child: Column(
                      children: [
                        SelectableText(
                          v.key.name,
                          style: TextStyle(fontSize: 16),
                        ),
                        SelectableText(v.key.phone),
                        Divider(),
                        ...(v.value
                            .map((art) => Row(
                                  children: [
                                    SelectableText(art.title),
                                    CachedNetworkImage(
                                      imageUrl: art.artImageUrl,
                                      height: 128,
                                    )
                                  ],
                                ))
                            .toList())
                      ],
                    ),
                  ))
              .toList(),
        ));
  }
}
