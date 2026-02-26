import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late VideoPlayerController _controller;
  bool _initialized = false;

  final String _videoUrl =
      'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4';

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(_videoUrl))
      ..initialize().then((_) {
        setState(() => _initialized = true);
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Center(
        child: _initialized
            ? SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Video display area
              AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
              SizedBox(height: screenHeight * 0.02),

              // Progress bar
              VideoProgressIndicator(_controller, allowScrubbing: true),
              SizedBox(height: screenHeight * 0.01),

              // Controls row
              Wrap(
                alignment: WrapAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.replay_5),
                    iconSize: screenWidth * 0.08,
                    constraints: const BoxConstraints(
                      minWidth: 48,
                      minHeight: 48,
                    ),
                    onPressed: () {
                      final pos = _controller.value.position;
                      _controller.seekTo(pos - const Duration(seconds: 5));
                    },
                  ),
                  IconButton(
                    iconSize: screenWidth * 0.15,
                    constraints: const BoxConstraints(
                      minWidth: 56,
                      minHeight: 56,
                    ),
                    icon: Icon(
                      _controller.value.isPlaying
                          ? Icons.pause_circle
                          : Icons.play_circle,
                      color: Colors.indigo,
                    ),
                    onPressed: () {
                      setState(() {
                        _controller.value.isPlaying
                            ? _controller.pause()
                            : _controller.play();
                      });
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.forward_5),
                    iconSize: screenWidth * 0.08,
                    constraints: const BoxConstraints(
                      minWidth: 48,
                      minHeight: 48,
                    ),
                    onPressed: () {
                      final pos = _controller.value.position;
                      _controller.seekTo(pos + const Duration(seconds: 5));
                    },
                  ),
                ],
              ),

              // Volume slider
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     const Icon(Icons.volume_down),
              //     Expanded(
              //       child: Slider(
              //         value: _controller.value.volume,
              //         onChanged: (val) {
              //           setState(() => _controller.setVolume(val));
              //         },
              //       ),
              //     ),
              //     const Icon(Icons.volume_up),
              //   ],
              // ),
              SizedBox(height: screenHeight * 0.02),
            ],
          ),
        )
            : const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Loading video...'),
          ],
        ),
      ),
    );
  }
}