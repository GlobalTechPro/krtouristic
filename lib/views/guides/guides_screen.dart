import 'package:after_layout/after_layout.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:krtouristic/model/core/guide.dart';
import 'package:krtouristic/model/helpers/guide_helper.dart';
import 'package:krtouristic/views/common/app_bar_main.dart';
import 'package:krtouristic/conf/globals.dart' as globals;
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:krtouristic/conf/font_styles.dart' as font_styles;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class GuidesScreen extends StatefulWidget {
  const GuidesScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<GuidesScreen> createState() => _GuidesScreenState();
}

class _GuidesScreenState extends State<GuidesScreen> with AfterLayoutMixin {
  late var guides = [];

  @override
  void afterFirstLayout(BuildContext context) async {
    final guideHelper = GuideHelper();
    final guideHelperResult =
        await guideHelper.getGuides(cityId: globals.cityId, lang: globals.lang);
    guideHelperResult.fold((l) {}, (r) {
      guides = r;
    });
    setState(() {});
  }

  void _scrollToSelectedContent({required GlobalKey expansionTileKey}) {
    final keyContext = expansionTileKey.currentContext;
    if (keyContext != null) {
      Future.delayed(const Duration(milliseconds: 300)).then((value) {
        Scrollable.ensureVisible(
          keyContext,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOutQuart,
        );
      });
    }
  }

  Widget _buildGuideTile(Guide guide) {
    final GlobalKey expansionTileKey = GlobalKey();
    Widget videoSection = Container();
    if (guide.youtubeUrl != null && guide.youtubeUrl != '') {
      final String videoId =
          YoutubePlayer.convertUrlToId(guide.youtubeUrl!) ?? '';
      YoutubePlayerController videoController = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
        ),
      );

      videoSection = YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: videoController,
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
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            margin: const EdgeInsets.only(top: 15.0),
            child: player,
          );
        },
      );
    }

    return Card(
      child: ExpansionTile(
        key: expansionTileKey,
        textColor: Colors.white,
        backgroundColor: const Color.fromRGBO(2, 51, 103, 1.0),
        collapsedBackgroundColor: const Color.fromRGBO(2, 51, 103, 1.0),
        onExpansionChanged: (opening) async {
          if (opening) {
            _scrollToSelectedContent(expansionTileKey: expansionTileKey);
          } else {
            await Future.delayed(const Duration(milliseconds: 150));
          }
        },
        leading: CachedNetworkImage(
          imageUrl: guide.avatar?.url ?? '',
          imageBuilder: (context, imageProvider) {
            return CircleAvatar(
              foregroundImage: imageProvider,
              backgroundColor: Colors.lightBlueAccent,
              child: Text(
                "${guide.name['last'][0]}${guide.name['first'][0]}",
                style: font_styles.guideNameLetters,
              ),
            );
          },
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              CircularProgressIndicator(
            value: downloadProgress.progress,
            color: const Color.fromRGBO(0, 91, 187, 1.0),
            backgroundColor: const Color.fromRGBO(255, 213, 0, 1.0),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        title: Text(
          "${guide.name['last'] ?? ''} ${guide.name['first'] ?? ''} ${guide.name['patronymic'] ?? ''}",
          style: font_styles.guideNameTitle,
        ),
        subtitle: Text(
          guide.subtitle ?? '',
          style: font_styles.guideNameSubtitle,
        ),
        trailing: IconButton(
          icon: const Icon(
            Icons.phone,
            color: Colors.green,
          ),
          onPressed: () async {
            final call = Uri.parse("tel:${guide.phone}");
            if (await canLaunchUrl(call)) {
              launchUrl(call);
            }
          },
        ),
        children: <Widget>[
          ListTile(
            title: Row(
              children: [
                Text(
                  'Мови:',
                  style: font_styles.guideLangTitle,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: guide.spokenLanguages!.map((lang) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 7.0),
                        child: Image.asset(
                          "assets/icons/$lang.png",
                          width: 15.0,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          if (guide.description != null && guide.description != '') ...[
            ListTile(
              title: Text(
                "${guide.description}",
                textAlign: TextAlign.justify,
                style: font_styles.guideDescription,
              ),
            ),
          ],
          ListTile(
            title: Column(
              children: [
                InkWell(
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 3.0),
                        child: Icon(
                          Icons.phone_sharp,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        guide.phone,
                        style: font_styles.guideData,
                      ),
                    ],
                  ),
                  onTap: () {
                    final call = Uri.parse("tel:${guide.phone}");
                    launchUrl(call);
                  },
                ),
                if (guide.email != null && guide.email != '') ...[
                  const SizedBox(
                    height: 5.0,
                  ),
                  InkWell(
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 3.0),
                          child: Icon(
                            Icons.email_sharp,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          guide.email!,
                          style: font_styles.guideData,
                        ),
                      ],
                    ),
                    onTap: () {
                      final call = Uri.parse("mailto:${guide.email}");
                      launchUrl(call);
                    },
                  ),
                ],
              ],
            ),
          ),
          if (guide.youtubeUrl != null && guide.youtubeUrl != '') ...[
            videoSection,
          ],
          const SizedBox(
            height: 15.0,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(1, 25, 51, 1.0),
      appBar: etsAppBar(context, globals.cityData['title_main'],
          globals.cityData['menu_item_guides']),
      body: ListView.builder(
        padding: const EdgeInsets.only(bottom: 10.0),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        itemCount: guides.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildGuideTile(guides[index]);
        },
      ),
    );
  }
}
