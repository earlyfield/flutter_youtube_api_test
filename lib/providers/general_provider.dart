import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_youtube_api_test/utils/youtube_live_streaming_api/model/request_body.dart';
import 'package:flutter_youtube_api_test/utils/youtube_live_streaming_api/youtube_live_sreaming_api.dart';

final bottomNavPageProvider = StateProvider<int>((ref) => 0);

final youtubeLiveStreamingApiProvider =
    Provider<YoutubeLiveStreamingApi>((ref) => YoutubeLiveStreamingApi());

final chatMessagesProvider = StateProvider<List<ChatMessage>>((ref) => []);
