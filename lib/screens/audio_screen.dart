import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioScreen extends StatefulWidget {
  const AudioScreen({super.key});

  @override
  State<AudioScreen> createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  PlayerState _playerState = PlayerState.stopped;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  bool _isLoading = false;
  String? _errorMessage;

  // Free sample audio URL
  final String _audioUrl =
      'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3';

  @override
  void initState() {
    super.initState();

    // Set audio context (platform-neutral)
    _audioPlayer.setAudioContext(const AudioContext());

    _audioPlayer.onPlayerStateChanged.listen((state) {
      if (mounted) {
        setState(() {
          _playerState = state;
          if (state == PlayerState.playing || state == PlayerState.paused) {
            _isLoading = false;
          }
        });
      }
    });

    _audioPlayer.onDurationChanged.listen((duration) {
      if (mounted) setState(() => _duration = duration);
    });

    _audioPlayer.onPositionChanged.listen((position) {
      if (mounted) setState(() => _position = position);
    });

    _audioPlayer.onLog.listen((message) {
      debugPrint('AudioPlayer Log: $message');
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  String _formatTime(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return '${twoDigits(d.inMinutes)}:${twoDigits(d.inSeconds.remainder(60))}';
  }

  Future<void> _handlePlay() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      if (_playerState == PlayerState.playing) {
        await _audioPlayer.pause();
      } else {
        // Using setSource + resume for more reliable loading
        await _audioPlayer.setSource(UrlSource(_audioUrl));
        await _audioPlayer.resume();
      }
    } catch (e) {
      debugPrint('Error playing audio: $e');
      if (mounted) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Failed to load audio. Please check your connection.';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Album
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.indigo.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : const Icon(Icons.music_note, size: 100, color: Colors.indigo),
            ),
            const SizedBox(height: 24),

            const Text(
              'SoundHelix Song 1',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const Text('Sample Audio', style: TextStyle(color: Colors.grey)),
            
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              
            const SizedBox(height: 20),

            // Seek bar
            Slider(
              min: 0,
              max: _duration.inSeconds.toDouble(),
              value: _position.inSeconds.toDouble().clamp(
                  0, _duration.inSeconds.toDouble()),
              activeColor: Colors.indigo,
              onChanged: (value) {
                _audioPlayer.seek(Duration(seconds: value.toInt()));
              },
            ),

            // Time display
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_formatTime(_position)),
                  Text(_formatTime(_duration)),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Controls
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Stop button
                // IconButton(
                //   icon: const Icon(Icons.stop_circle_outlined),
                //   iconSize: 44,
                //   color: Colors.red,
                //   onPressed: () {
                //     _audioPlayer.stop();
                //     setState(() => _isLoading = false);
                //   },
                // ),

                // Play/Pause button
                const SizedBox(width: 16),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    if (_isLoading)
                      const SizedBox(
                        width: 72,
                        height: 72,
                        child: CircularProgressIndicator(strokeWidth: 4),
                      ),
                    IconButton(
                      iconSize: 72,
                      icon: Icon(
                        _playerState == PlayerState.playing
                            ? Icons.pause_circle
                            : Icons.play_circle,
                        color: Colors.indigo,
                      ),
                      onPressed: _isLoading ? null : _handlePlay,
                    ),
                  ],
                ),
                const SizedBox(width: 16),

                // Replay button
                IconButton(
                  icon: const Icon(Icons.replay),
                  iconSize: 44,
                  color: Colors.indigo,
                  onPressed: () async {
                    await _audioPlayer.seek(Duration.zero);
                    _handlePlay();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
