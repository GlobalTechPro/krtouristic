import 'package:cached_network_image/cached_network_image.dart';
import 'package:krtouristic/conf/responsive_app_config.dart';
import 'package:krtouristic/model/core/location.dart';
import 'package:krtouristic/model/core/schedule.dart';
import 'package:flutter/material.dart';
import 'package:krtouristic/conf/font_styles.dart' as font_styles;
import 'package:galleryimage/galleryimage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:krtouristic/views/common/map/map_helper.dart';
import 'package:krtouristic/views/common/map/map_widget.dart';
import 'package:krtouristic/views/common/youtube_player_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:readmore/readmore.dart';

const double paddingPercentage = 1;

class SightDetailsTile extends StatefulWidget {
  final Location sight;
  const SightDetailsTile({Key? key, required this.sight}) : super(key: key);

  @override
  State<SightDetailsTile> createState() => _SightDetailsTileState();
}

class _SightDetailsTileState extends State<SightDetailsTile> {
  Map<MarkerId, Marker> markers = {};
  Widget mapWidget = Container();

  Future<void> processData(context) async {
    markers = await MapHelper.createMarkers([widget.sight], context);
    setState(() {
      mapWidget = Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: MapWidget(
          height: 200,
          markers: markers,
          cameraPosition: CameraPosition(
            target: LatLng(widget.sight.lat, widget.sight.lng),
            zoom: 13.0,
          ),
        ),
      );
    });

  }

  @override
  Widget build(BuildContext context) {
    processData(context);
    final responsiveAppConfig = ResponsiveAppConfig(context);
    List<Widget> scheduleRows = [];
    List<Schedule> schedule = widget.sight.schedule ?? [];

    for (Schedule scheduleItem in schedule) {
      scheduleRows.add(Row(
        children: [
          SizedBox(
            width: responsiveAppConfig.rWidthPadding(35),
            child: Text(
              "${scheduleItem.weekDay}:",
              style: font_styles.sightDetailsInfoRow,
            ),
          ),
          SizedBox(
            width: responsiveAppConfig.rWidthPadding(30),
            child: Text(
              "${scheduleItem.fromHour.toString().padLeft(2, '0')}:${scheduleItem.fromMinute.toString().padLeft(2, '0')}"
              " - "
              "${scheduleItem.toHour.toString().padLeft(2, '0')}:${scheduleItem.toMinute.toString().padLeft(2, '0')}",
              style: font_styles.sightDetailsInfoRow,
            ),
          ),
        ],
      ));
    }

    Widget videoSection = YoutubePlayerWidget(youtubeUrl: widget.sight.youtubeUrl);

    return Padding(
      padding: EdgeInsets.only(
          bottom: responsiveAppConfig.rHeight(paddingPercentage)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Column(
          children: [
            CachedNetworkImage(
              imageUrl: widget.sight.headImage.url,
              imageBuilder: (context, imageProvider) {
                return Container(
                  height: 200.0,
                  width: responsiveAppConfig.rWidthPadding(100),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                    color: Colors.grey.withOpacity(0.4),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 15,
                        bottom: 15,
                        right: 15,
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(7.0)),
                          ),
                          constraints: const BoxConstraints(
                            minHeight: 40.0,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.sight.title,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: font_styles.sightDetailsTitle,
                              ),
                              const SizedBox(height: 5.0),
                              Text(
                                widget.sight.subtitle ?? '',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: font_styles.sightDetailsSubtitle,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CircularProgressIndicator(
                value: downloadProgress.progress,
                color: Colors.blueAccent,
                backgroundColor: Colors.yellowAccent,
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),

            // -----------------------------------------------------------
            // info section
            Column(
              children: [
                InkWell(
                  child: Row(
                    children: [
                      if (widget.sight.address != null) ...[
                        Column(children: [
                          const Divider(
                            height: 20.0,
                            indent: 17.0,
                            endIndent: 17.0,
                          ),
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 12.0),
                                child: Icon(
                                  Icons.location_pin,
                                  color: Colors.white,
                                  size: 20.0,
                                ),
                              ),
                              Text(
                                widget.sight.address!,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: font_styles.sightDetailsInfoRow,
                              ),
                            ],
                          ),
                        ]),
                      ],
                    ],
                  ),
                  onTap: () {
                    MapHelper.openMapApp(widget.sight.lat, widget.sight.lng);
                  },
                ),
                if (widget.sight.phone != null && widget.sight.phone != '') ...[
                  const SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 3.0),
                    child: InkWell(
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.0),
                            child: Icon(
                              Icons.phone_sharp,
                              color: Colors.white,
                              size: 20.0,
                            ),
                          ),
                          Text(
                            widget.sight.phone ?? '',
                            style: font_styles.sightDetailsInfoRow,
                          ),
                        ],
                      ),
                      onTap: () {
                        final call = Uri.parse("tel:${widget.sight.phone}");
                        launchUrl(call);
                      },
                    ),
                  ),
                ],
                if (widget.sight.email != null && widget.sight.email != '') ...[
                  const SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 3.0),
                    child: InkWell(
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.0),
                            child: Icon(
                              Icons.email_sharp,
                              color: Colors.white,
                              size: 20.0,
                            ),
                          ),
                          Text(
                            widget.sight.email!,
                            style: font_styles.sightDetailsInfoRow,
                          ),
                        ],
                      ),
                      onTap: () {
                        final email = Uri.parse("mailto:${widget.sight.email}");
                        launchUrl(email);
                      },
                    ),
                  ),
                ],
                if (widget.sight.schedule != null) ...[
                  const SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 3.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.0),
                          child: Icon(
                            Icons.watch_later_sharp,
                            color: Colors.white,
                            size: 20.0,
                          ),
                        ),
                        Column(
                          children: scheduleRows,
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
            // -----------------------------------------------------------

            // description section
            if (widget.sight.description != null && widget.sight.description != '') ...[
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    children: [
                      const Divider(
                        height: 20.0,
                        indent: 17.0,
                        endIndent: 17.0,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Опис',
                          style: font_styles.screenSectionTitle,
                        ),
                      ),
                      ReadMoreText(
                        widget.sight.description ?? '',
                        trimLines: 3,
                        colorClickableText:
                            const Color.fromRGBO(255, 213, 0, 1.0),
                        trimMode: TrimMode.Line,
                        trimCollapsedText: 'Читати далі',
                        trimExpandedText: 'Приховати',
                        textAlign: TextAlign.justify,
                        style: font_styles.locationDescription,
                      ),
                    ],
                  )),
            ],
            // -----------------------------------------------------------

            // -----------------------------------------------------------
            // map section
            const Divider(
              height: 20.0,
              indent: 17.0,
              endIndent: 17.0,
            ),

            // map section
            mapWidget,
            // end of map section
            // -----------------------------------------------------------

            // gallery section
            if (widget.sight.galleryImages != null) ...[
              const Divider(
                height: 20.0,
                indent: 17.0,
                endIndent: 17.0,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: Column(
                    children: [
                      Row(children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            'Галерея',
                            style: font_styles.screenSectionTitle,
                          ),
                        ),
                      ]),

                      // YouTube video section
                      videoSection,

                      GalleryImage(
                        numOfShowImages:
                          widget.sight.galleryImages!.length > 5 ? 6 : 3,
                        titleGallery: widget.sight.title,
                        imageUrls: widget.sight.galleryImages ?? [],
                      ),
                    ],
                  ))
            ],
          ],
        ),
      ]),
    );
  }
}
