import 'package:cached_network_image/cached_network_image.dart';
import 'package:krtouristic/model/core/location.dart';
import 'package:flutter/material.dart';
import 'package:krtouristic/conf/font_styles.dart' as font_styles;

class FeaturedSightTile extends StatelessWidget {
  final Location location;

  const FeaturedSightTile({Key? key, required this.location}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: location.headImage.url,
      imageBuilder: (context, imageProvider) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(7.0)),
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
                  padding: const EdgeInsets.symmetric(
                      horizontal: 5.0, vertical: 3.0),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: const BorderRadius.all(Radius.circular(3.0)),
                  ),
                  constraints: const BoxConstraints(
                    minHeight: 40.0,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      location.title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: font_styles.featuredSightTitle,
                    ),
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
      // placeholder: (context, url) => const CircularProgressIndicator(),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
