import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubePlayerWidget extends StatefulWidget {
  const YoutubePlayerWidget({Key? key, this.youtubeUrl})
      : super(key: key);

  final String? youtubeUrl;

  @override
  State<YoutubePlayerWidget> createState() => _YoutubePlayerWidgetState();
}

class _YoutubePlayerWidgetState extends State<YoutubePlayerWidget> {
  late YoutubePlayerController _youtubeController;

  @override
  initState() {
    super.initState();
    final String videoId =
        YoutubePlayer.convertUrlToId(widget.youtubeUrl ?? '') ?? '';
    _youtubeController = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        disableDragSeek: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.youtubeUrl == null) {
      return Container();
    } else {
      return YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: _youtubeController,
          showVideoProgressIndicator: true,
          bottomActions: [
            const SizedBox(width: 8.0),
            CurrentPosition(),
            const SizedBox(width: 8.0),
            ProgressBar(isExpanded: true),
            const SizedBox(width: 8.0),
            RemainingDuration(),
            const SizedBox(width: 8.0),
          ],
        ),
        builder: (context, player) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            margin: const EdgeInsets.only(top: 15.0),
            child: player,
          );
        },
      );
    }
  }

  @override
  void dispose() {
    _youtubeController.dispose();
    super.dispose();
  }
}