import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_youtube_api_test/utils/youtube_api/src/model/youtube_video.dart';
import 'package:flutter_youtube_api_test/views/error_screen.dart';
import 'package:flutter_youtube_api_test/views/main_screen.dart';
import 'package:flutter_youtube_api_test/views/video_screen.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>(
  (ref) => GoRouter(
    initialLocation: '/',
    errorBuilder: (context, state) => const ErrorScreen(),
    routes: [
      GoRoute(
          path: '/',
          name: 'Home',
          builder: (context, state) => const MainScreen(),
          routes: [
            GoRoute(
              path: 'video',
              name: 'Video',
              builder: (context, state) => VideoScreen(
                state.queryParams['id'] ?? "",
                state.queryParams['liveChatId'] ?? "",
                state.queryParams['title'] ?? "",
              ),
            ),
          ]),
    ],
  ),
);
