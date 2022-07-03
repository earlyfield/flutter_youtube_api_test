import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_youtube_api_test/providers/general_provider.dart';
import 'package:flutter_youtube_api_test/providers/router_provider.dart';
import 'package:flutter_youtube_api_test/utils/youtube_live_streaming_api/model/request_body.dart';
import 'package:flutter_youtube_api_test/utils/youtube_live_streaming_api/youtube_live_sreaming_api.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final baseUrl = "https://www.youtube.com/watch?v=";
  late YoutubeLiveStreamingApi api;
  List<YoutubeVideoInfo> videoInfos = [];

  @override
  void initState() {
    super.initState();
    api = ref.read(youtubeLiveStreamingApiProvider);
    api.initialSetup().then((_) {
      api.getLiveBroadcastsList().then((value) {
        print(value.body);
        Map<String, dynamic> json = jsonDecode(value.body);
        for (var item in json['items']) {
          var videoInfo = YoutubeVideoInfo().fromJson(item);
          videoInfos.add(videoInfo);
        }
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: videoInfos.length,
      itemBuilder: (context, index) {
        return listItem(videoInfos[index]);
      },
    );
  }

  Widget listItem(YoutubeVideoInfo video) {
    return GestureDetector(
      onTap: () {
        ref.watch(routerProvider).go(
            '/video?id=${video.id}&liveChatId=${video.snippet?.liveChatId}&title=${video.snippet?.title}');
      },
      child: Card(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 7.0),
          padding: EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Image.network(
                  video.snippet?.thumbnails?['default']?.url ?? '',
                  width: 120.0,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      video.snippet?.title ?? '',
                      softWrap: true,
                      style: TextStyle(fontSize: 18.0),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 3.0),
                      child: Text(
                        video.snippet?.channelId ?? '',
                        softWrap: true,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      baseUrl + video.id!,
                      softWrap: true,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
