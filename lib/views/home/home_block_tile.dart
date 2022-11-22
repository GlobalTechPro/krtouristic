import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:krtouristic/conf/font_styles.dart' as font_styles;

class HomeBlockTile extends StatelessWidget {
  const HomeBlockTile({Key? key, required this.homeBlock}) : super(key: key);
  final dynamic homeBlock;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: homeBlock['imageUrl'],
      imageBuilder: (context, imageProvider) {
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
              // colorFilter: const ColorFilter.mode(Color.fromRGBO(0, 91, 187, 1.0), BlendMode.softLight),
            ),
            borderRadius: BorderRadius.circular(2),
            // border: Border.all(
            //   color: const Color.fromRGBO(40, 9, 0, 1.0),
            //   width: 2.0,
            // ),
            color: const Color.fromRGBO(255, 255, 255, 1.0),
            // boxShadow: const [BoxShadow(
            //   color: Color.fromRGBO(0, 91, 187, 1.0),
            //   blurRadius: 2,
            //   spreadRadius: 1,
            //   offset: Offset(2, 2),
            // )]
          ),
          margin: const EdgeInsets.only(bottom: 10.0),
          // color: const Color.fromRGBO(218, 255, 207, 1.0),
          height: 150,
          child: ListTile(
            title: Center(
                child: Text(
              homeBlock["title"],
              textAlign: TextAlign.center,
              style: font_styles.homeBlockTitle,
            )),
          ),
        );
      },
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          CircularProgressIndicator(
        value: downloadProgress.progress,
        color: const Color.fromRGBO(1, 25, 51, 1.0),
        backgroundColor: const Color.fromRGBO(255, 213, 0, 1.0),
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
