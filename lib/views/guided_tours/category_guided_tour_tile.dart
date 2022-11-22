import 'package:cached_network_image/cached_network_image.dart';
import 'package:krtouristic/conf/responsive_app_config.dart';
import 'package:krtouristic/model/core/guided_tour.dart';
import 'package:flutter/material.dart';
import 'package:krtouristic/conf/font_styles.dart' as font_styles;

class CategoryGuidedTourTile extends StatelessWidget {
  final GuidedTour tour;
  const CategoryGuidedTourTile({Key? key, required this.tour})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsiveAppConfig = ResponsiveAppConfig(context);

    return Card(
      child: ListTile(
        textColor: Colors.white,
        tileColor: const Color.fromRGBO(2, 51, 103, 1.0),
        leading: CachedNetworkImage(
          imageUrl: tour.headImage.url,
          imageBuilder: (context, imageProvider) {
            return Image(
              image: imageProvider,
              width: responsiveAppConfig.rWidth(12.0),
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
        title: Padding(
          padding: const EdgeInsets.only(left: 3.0),
          child: Text(
            tour.title,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: font_styles.categoryTourTitle,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios_outlined,
          color: Color.fromRGBO(255, 213, 0, 1.0),
          size: 18.0,
        ),
      ),
    );
  }
}
