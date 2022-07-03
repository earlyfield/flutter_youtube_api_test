import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_youtube_api_test/providers/general_provider.dart';
import 'package:flutter_youtube_api_test/utils/youtube_live_streaming_api/model/request_body.dart';
import 'package:flutter_youtube_api_test/utils/youtube_live_streaming_api/youtube_live_sreaming_api.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class VideoScreen extends ConsumerStatefulWidget {
  final String videoId;
  final String liveChatId;
  final String title;

  VideoScreen(
    this.videoId,
    this.liveChatId,
    this.title, {
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends ConsumerState<VideoScreen> {
  final _messageController = TextEditingController();
  late YoutubePlayerController _controller;
  late YoutubeLiveStreamingApi api;
  late Timer timer;
  List<String> authors = [];
  List<String> messages = [];

  @override
  void initState() {
    super.initState();

    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      params: const YoutubePlayerParams(
        autoPlay: true,
        mute: true,
        showFullscreenButton: true,
      ),
    );

    api = ref.read(youtubeLiveStreamingApiProvider);

    timer = Timer.periodic(
      const Duration(seconds: 2),
      (timer) {
        api.getLiveChatMessagesList(widget.liveChatId).then((response) {
          print(response.body);

          if (response.statusCode == 200) {
            Map<String, dynamic> json = jsonDecode(response.body);

            List<ChatMessage> msgs = [];

            for (Map<String, dynamic> item in json['items']) {
              var msg = ChatMessage(
                item['authorDetails']['displayName'],
                item['snippet']['textMessageDetails']['messageText'],
                item['authorDetails']['profileImageUrl'],
              );
              msgs.add(msg);
            }

            ref.watch(chatMessagesProvider.notifier).update((state) => msgs);
          }
        });
      },
    );

    // _controller = YoutubePlayerController(
    //   initialVideoId: widget.videoId,
    //   flags: const YoutubePlayerFlags(
    //     autoPlay: true,
    //     mute: false,
    //     showLiveFullscreenButton: true,
    //   ),
    // );
  }

  @override
  void dispose() {
    super.dispose();

    timer.cancel();
    ref.watch(chatMessagesProvider.notifier).update((state) => []);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 300,
            child: YoutubePlayerIFrame(
              controller: _controller,
              aspectRatio: 16 / 9,
            ),
          ),
          Flexible(
            child: ListView.builder(
              itemCount: ref.watch(chatMessagesProvider).length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(ref
                          .watch(chatMessagesProvider)[index]
                          .profileImageUrl),
                    ),
                    Text(ref.watch(chatMessagesProvider)[index].authorName),
                    Text('：'),
                    Text(ref.watch(chatMessagesProvider)[index].message),
                  ],
                );
              },
            ),
          ),
          Container(
            margin: EdgeInsets.all(25),
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: "",
                suffixIcon: IconButton(
                  onPressed: _messageController.clear,
                  icon: Icon(Icons.clear),
                ),
              ),
              onSubmitted: (text) {
                api
                    .postLiveChatMessagesInsert(widget.liveChatId, text)
                    .then((response) {
                  print(response.body);
                });
                _messageController.clear();
              },
            ),
          )
        ],
      ),
    );

    // return YoutubePlayer(
    //   controller: _controller,
    //   showVideoProgressIndicator: true,
    //   progressIndicatorColor: Colors.amber,
    //   progressColors: const ProgressBarColors(
    //     playedColor: Colors.amber,
    //     handleColor: Colors.amberAccent,
    //   ),
    //   bottomActions: [
    //     CurrentPosition(),
    //     ProgressBar(isExpanded: true),
    //   ],
    // );
  }
}
