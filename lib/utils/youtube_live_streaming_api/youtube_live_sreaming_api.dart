import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_youtube_api_test/auth/secrets.dart';
import 'package:flutter_youtube_api_test/utils/constants.dart';
import 'package:flutter_youtube_api_test/utils/youtube_live_streaming_api/model/request_body.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:googleapis_auth/auth_browser.dart';
import 'package:http/http.dart';

class YoutubeLiveStreamingApi {
  final _baseUrl = "youtube.googleapis.com";
  AuthClient? _authClient;

  final Map<String, String> header = {
    "Authorization": "",
    "Accept": "application/json",
    "Content-Type": "application/json",
  };

  final Map<String, String> options = {
    "part": "snippet,ContentDetails,status",
  };

  YoutubeLiveStreamingApi() {
    // if (kIsWeb) {
    //   obtainAuthenticatedClient().then((value) => _authClient = value);
    // } else {
    //   obtainCredentials().then((value) => _authClient = value);
    // }
  }

  Future<void> initialSetup() async {
    _authClient = await obtainAuthenticatedClient();
  }

  Future<AuthClient> obtainAuthenticatedClient() async {
    final flow = await createImplicitBrowserFlow(
      ClientId(googleOAuthWebClientId, googleOAuthWebClientSecret),
      [googleOAuthScope],
    );

    try {
      return await flow.clientViaUserConsent();
    } finally {
      flow.close();
    }
  }

  Future<AuthClient> obtainCredentials() async => await clientViaUserConsent(
        ClientId(googleOAuthWebClientId, googleOAuthWebClientSecret),
        [googleOAuthScope],
        _prompt,
      );

  void _prompt(String url) {
    print('Please go to the following URL and grant access:');
    print('  => $url');
    print('');
  }

  Future<Response> getLiveBroadcastsList() async {
    options['broadcastStatus'] = 'all';
    options['broadcastType'] = 'all';

    var url = Uri.https(_baseUrl, "youtube/v3/liveBroadcasts", options);

    return await _authClient?.get(url) ?? Response('', 500);
  }

  void postLiveBroadcastsInsert() {
    var url = Uri.https(_baseUrl, "youtube/v3/liveBroadcasts", options);

    var snippet = Snippet(
      title: "",
      scheduledStartTime: DateTime(2022, 8, 1, 10, 0, 0),
    );
    var contentDetails = ContentDetails();
    var status = Status(privacyStatus: "private");

    var body = YoutubeVideoInfo(
      snippet: snippet,
      contentDetails: contentDetails,
      status: status,
    ).toJson();

    _authClient?.post(url, body: body);
  }

  Future<Response> getLiveChatMessagesList(String liveChatId) async {
    options['part'] = 'snippet,authorDetails';
    options['liveChatId'] = liveChatId;

    var url = Uri.https(_baseUrl, "youtube/v3/liveChat/messages", options);

    return await _authClient?.get(url) ?? Response('', 500);
  }

  Future<Response> postLiveChatMessagesInsert(
      String liveChatId, String comment) async {
    options['part'] = 'snippet';

    var url = Uri.https(_baseUrl, "youtube/v3/liveChat/messages", options);

    var snippet = Snippet(
      liveChatId: liveChatId,
      type: "textMessageEvent",
      messageText: comment,
    );

    var body = jsonEncode(
        YoutubeVideoInfo(snippet: snippet).toJsonForPostingComment());

    print(body);

    return await _authClient?.post(url, body: body) ?? Response('', 500);
  }
}
