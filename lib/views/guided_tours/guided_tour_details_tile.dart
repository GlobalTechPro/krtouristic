import 'package:cached_network_image/cached_network_image.dart';
import 'package:krtouristic/conf/responsive_app_config.dart';
import 'package:krtouristic/model/core/guided_tour.dart';
import 'package:krtouristic/model/core/location.dart';
import 'package:krtouristic/model/core/schedule.dart';
import 'package:krtouristic/providers/google_provider.dart';
import 'package:flutter/material.dart';
import 'package:krtouristic/conf/font_styles.dart' as font_styles;
import 'package:galleryimage/galleryimage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:krtouristic/views/common/youtube_player_widget.dart';
import 'package:readmore/readmore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:krtouristic/conf/globals.dart' as globals;

const double paddingPercentage = 1;

class GuidedTourDetailsTile extends StatefulWidget {
  final GuidedTour tour;
  const GuidedTourDetailsTile({Key? key, required this.tour}) : super(key: key);

  @override
  State<GuidedTourDetailsTile> createState() => _GuidedTourDetailsTileState();
}

class _GuidedTourDetailsTileState extends State<GuidedTourDetailsTile> {
  Map<PolylineId, Polyline> polylines = {};
  Map<MarkerId, Marker> mapMarkers = {};
  MapType dialogMapType = MapType.normal;
  String mapTypeValue = 'normal';

  Polyline createPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = PolylineId(polylineCoordinates.toString());
    return Polyline(
      polylineId: id,
      geodesic: true,
      color: Colors.blue,
      points: polylineCoordinates,
      width: 4,
    );
  }

  Future<void> buildPolylines(
      {required LatLng origin, required LatLng destination}) async {
    PolylinePoints polylinePoints = PolylinePoints();
    List<LatLng> polylineCoordinates = [];

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      globals.googleApiKey,
      PointLatLng(origin.latitude, origin.longitude),
      PointLatLng(destination.latitude, destination.longitude),
      travelMode: TravelMode.walking,
    );
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    } else {
      // print(result.errorMessage);
    }
    final polyline = createPolyLine(polylineCoordinates);
    polylines[polyline.polylineId] = polyline;
    setState(() {});
  }

  void createMarkers(List<Location> locations) async {
    final BitmapDescriptor startMarkerBitmap =
        await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      'assets/icons/start-icon.png',
    );
    final BitmapDescriptor finishMarkerBitmap =
        await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      'assets/icons/finish-icon.png',
    );
    for (final location in locations) {
      BitmapDescriptor iconBitmap =
          BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure);
      if (location == locations[0]) {
        iconBitmap = startMarkerBitmap;
      }
      if (location == locations[locations.length - 1]) {
        iconBitmap = finishMarkerBitmap;
      }
      final markerId =
          MarkerId('${location.lat.toString()}${location.lng.toString()}');
      mapMarkers[markerId] = Marker(
        markerId: markerId,
        position: LatLng(location.lat, location.lng),
        infoWindow: InfoWindow(
          title: location.title,
        ),
        icon: iconBitmap,
      );
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    createMarkers([
      widget.tour.locations[0],
      widget.tour.locations[widget.tour.locations.length - 1]
    ]);

    buildPolylines(
        origin:
            LatLng(widget.tour.locations[0].lat, widget.tour.locations[0].lng),
        destination: LatLng(
            widget.tour.locations[widget.tour.locations.length - 1].lat,
            widget.tour.locations[widget.tour.locations.length - 1].lng));
  }

  @override
  Widget build(BuildContext context) {
    final responsiveAppConfig = ResponsiveAppConfig(context);
    List<Widget> scheduleRows = [];
    List<Schedule> schedule = widget.tour.schedule ?? [];
    var googleServiceProvider = GoogleProvider();
    final CameraPosition initialPosition = CameraPosition(
      target:
          LatLng(widget.tour.locations[0].lat, widget.tour.locations[0].lng),
      zoom: 13.0,
    );

    Future<void> openMapDialog(BuildContext context) async {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return StatefulBuilder(builder: (context, setState) {
              return SimpleDialog(
                backgroundColor: const Color.fromRGBO(2, 51, 103, 1.0),
                contentPadding: const EdgeInsets.all(3.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                children: [
                  Stack(children: [
                    SizedBox(
                      height: responsiveAppConfig.rHeight(50),
                      width: responsiveAppConfig.rWidth(80),
                      child: GoogleMap(
                        mapType: dialogMapType,
                        minMaxZoomPreference: googleServiceProvider.zoomPref,
                        onMapCreated: googleServiceProvider.onMapCreated,
                        initialCameraPosition: initialPosition,
                        zoomGesturesEnabled: true,
                        zoomControlsEnabled: true,
                        tiltGesturesEnabled: true,
                        scrollGesturesEnabled: true,
                        compassEnabled: true,
                        myLocationEnabled: true,
                        myLocationButtonEnabled: true,
                        markers: Set<Marker>.of(mapMarkers.values),
                        polylines: Set<Polyline>.of(polylines.values),
                      ),
                    ),
                    Positioned(
                      left: 15.0,
                      top: 5.0,
                      child: DropdownButton(
                        style: const TextStyle(
                          color: Color.fromRGBO(255, 213, 0, 1.0),
                        ),
                        dropdownColor: const Color.fromRGBO(2, 51, 103, 1.0),
                        value: mapTypeValue,
                        underline: Container(
                          height: 2,
                          color: const Color.fromRGBO(255, 213, 0, 1.0),
                        ),
                        icon: const Icon(
                          Icons.map_outlined,
                          color: Color.fromRGBO(255, 213, 0, 1.0),
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: "normal",
                            child: Text(
                              "Звичайна",
                            ),
                          ),
                          DropdownMenuItem(
                            value: "satellite",
                            child: Text(
                              "Супутник",
                            ),
                          ),
                          DropdownMenuItem(
                            value: "terrain",
                            child: Text(
                              "Ландшафт",
                            ),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            switch (value) {
                              case 'normal':
                                dialogMapType = MapType.normal;
                                mapTypeValue = value.toString();
                                break;
                              case 'satellite':
                                dialogMapType = MapType.satellite;
                                mapTypeValue = value.toString();
                                break;
                              case 'terrain':
                                dialogMapType = MapType.terrain;
                                mapTypeValue = value.toString();
                                break;
                            }
                          });
                        },
                      ),
                    ),
                  ]),
                ],
              );
            });
          });
    }

    Widget divider = const Divider(
      height: 30.0,
      indent: 17.0,
      endIndent: 17.0,
    );

    Widget videoSection = YoutubePlayerWidget(youtubeUrl: widget.tour.youtubeUrl);

    for (Schedule scheduleItem in schedule) {
      scheduleRows.add(Row(
        children: [
          SizedBox(
            width: responsiveAppConfig.rWidthPadding(35),
            child: Text(
              "${scheduleItem.weekDay}:",
              style: font_styles.tourDetailsInfoRow,
            ),
          ),
          SizedBox(
            width: responsiveAppConfig.rWidthPadding(40),
            child: Text(
              "${scheduleItem.fromHour.toString().padLeft(2, '0')}:${scheduleItem.fromMinute.toString().padLeft(2, '0')}"
              " - "
              "${scheduleItem.toHour.toString().padLeft(2, '0')}:${scheduleItem.toMinute.toString().padLeft(2, '0')}"
              " (${scheduleItem.duration?.inHours.toString()} год.)",
              style: font_styles.sightDetailsInfoRow,
            ),
          ),
        ],
      ));
    }

    return Padding(
      padding: EdgeInsets.only(
          bottom: responsiveAppConfig.rHeight(paddingPercentage)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Column(
          children: [
            // -----------------------------------------------------------
            // head image section
            CachedNetworkImage(
              imageUrl: widget.tour.headImage.url,
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
                                widget.tour.title,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: font_styles.sightDetailsTitle,
                              ),
                              const SizedBox(height: 5.0),
                              Text(
                                widget.tour.subtitle ?? '',
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
            // end of head image section
            // -----------------------------------------------------------

            // -----------------------------------------------------------
            // info section
            Column(
              children: [
                // guide info section
                Padding(
                  padding: const EdgeInsets.only(
                      left: 12.0, top: 20.0, bottom: 15.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CachedNetworkImage(
                        imageUrl: widget.tour.guide!.avatar!.url,
                        imageBuilder: (context, imageProvider) {
                          return CircleAvatar(
                            radius: 30.0,
                            foregroundImage: imageProvider,
                            backgroundColor: Colors.lightBlueAccent,
                            child: Text(
                              "${widget.tour.guide!.name['last'][0]}${widget.tour.guide!.name['first'][0]}",
                              style: font_styles.guideNameLetters,
                            ),
                          );
                        },
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                CircularProgressIndicator(
                          value: downloadProgress.progress,
                          color: const Color.fromRGBO(0, 91, 187, 1.0),
                          backgroundColor:
                              const Color.fromRGBO(255, 213, 0, 1.0),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Ваш гід:',
                              style: font_styles.guideLangTitle,
                            ),
                            // const SizedBox(height: 1.0),
                            Text(
                              "${widget.tour.guide!.name['last']} ${widget.tour.guide!.name['first']} ${widget.tour.guide!.name['patronymic']}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: font_styles.guideNameTitle,
                            ),
                            const SizedBox(height: 4.0),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: widget.tour.guide!.spokenLanguages!
                                    .map((lang) {
                                  return Container(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: Image.asset(
                                      "assets/icons/$lang.png",
                                      width: 15.0,
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                            // InkWell(
                            //   child: Text(
                            //     tour.guide!.phone,
                            //     style: font_styles.guideNameLetters,
                            //   ),
                            //   onTap: () async {
                            //     final call = Uri.parse("tel:${tour.guide!.phone}");
                            //     if (await canLaunchUrl(call)) {
                            //       launchUrl(call);
                            //     }
                            //   },
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // phone number section
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 3.0),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                        child: Icon(
                          Icons.phone,
                          color: Colors.white,
                          size: 20.0,
                        ),
                      ),
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: responsiveAppConfig.rWidthPadding(90.0),
                        ),
                        child: InkWell(
                          child: Text(
                            widget.tour.guide!.phone,
                            style: font_styles.sightDetailsInfoRow,
                          ),
                          onTap: () {
                            final call =
                                Uri.parse("tel:${widget.tour.guide!.phone}");
                            launchUrl(call);
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 5.0,
                ),

                // departure point section
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 3.0),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                        child: Icon(
                          Icons.location_pin,
                          color: Colors.white,
                          size: 20.0,
                        ),
                      ),
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: responsiveAppConfig.rWidthPadding(90.0),
                        ),
                        child: Text(
                          "Місце старту: ${widget.tour.locations[0].title}",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: font_styles.sightDetailsInfoRow,
                        ),
                      ),
                    ],
                  ),
                ),

                // route length section
                const SizedBox(
                  height: 5.0,
                ),

                Container(
                  margin: const EdgeInsets.symmetric(vertical: 3.0),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                        child: Icon(
                          Icons.route,
                          color: Colors.white,
                          size: 20.0,
                        ),
                      ),
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: responsiveAppConfig.rWidthPadding(90.0),
                        ),
                        child: Text(
                          "Протяжність маршруту: ${(widget.tour.length / 1000).toStringAsFixed(1)} км",
                          style: font_styles.sightDetailsInfoRow,
                        ),
                      ),
                    ],
                  ),
                ),

                // schedule section
                if (widget.tour.schedule != null) ...[
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Розклад екскурсій:",
                              style: font_styles.sightDetailsInfoRow,
                            ),
                            ...scheduleRows,
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
            // end of info section
            // -----------------------------------------------------------

            // description section
            if (widget.tour.description != null &&
                widget.tour.description != '') ...[
              divider,
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Text(
                          'Опис',
                          style: font_styles.screenSectionTitle,
                        ),
                      ),
                      ReadMoreText(
                        widget.tour.description ?? '',
                        trimLines: 3,
                        colorClickableText:
                            const Color.fromRGBO(255, 213, 0, 1.0),
                        trimMode: TrimMode.Line,
                        trimCollapsedText: 'Читати далі',
                        trimExpandedText: 'Приховати',
                        textAlign: TextAlign.justify,
                        style: font_styles.tourDescription,
                      ),
                    ],
                  )),
            ],
            // end of description section
            // -----------------------------------------------------------
            divider,

            // -----------------------------------------------------------
            // map section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: SizedBox(
                height: 200,
                child: GoogleMap(
                  mapType: MapType.normal,
                  minMaxZoomPreference: googleServiceProvider.zoomPref,
                  onMapCreated: googleServiceProvider.onMapCreated,
                  initialCameraPosition: initialPosition,
                  zoomGesturesEnabled: false,
                  zoomControlsEnabled: false,
                  tiltGesturesEnabled: false,
                  scrollGesturesEnabled: false,
                  compassEnabled: false,
                  myLocationEnabled: false,
                  myLocationButtonEnabled: false,
                  markers: Set<Marker>.of(mapMarkers.values),
                  polylines: Set<Polyline>.of(polylines.values),
                  onTap: (latLng) {
                    openMapDialog(context);
                  },
                ),
              ),
            ),
            // end of map section
            // -----------------------------------------------------------

            divider,

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                textStyle: font_styles.bookTourButtonText,
                backgroundColor: Colors.green,
              ),
              onPressed: () async {
                final call = Uri.parse("tel:${widget.tour.guide!.phone}");
                if (await canLaunchUrl(call)) {
                  launchUrl(call);
                }
              },
              child: Text('Замовити екскурсію'.toUpperCase()),
            ),

            // gallery section
            if (widget.tour.galleryImages != null) ...[
              divider,
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
                            widget.tour.galleryImages!.length > 5 ? 6 : 3,
                        titleGallery: widget.tour.title,
                        imageUrls: widget.tour.galleryImages ?? [],
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
