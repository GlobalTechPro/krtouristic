import 'package:krtouristic/conf/responsive_app_config.dart';
import 'package:krtouristic/model/core/location.dart';
import 'package:flutter/material.dart';
import 'package:krtouristic/conf/font_styles.dart' as font_styles;

class TopSightTile extends StatelessWidget {
  final Location location;

  const TopSightTile({Key? key, required this.location}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsiveAppConfig = ResponsiveAppConfig(context);

    return Card(
      child: ListTile(
        textColor: Colors.white,
        tileColor: const Color.fromRGBO(2, 51, 103, 1.0),
        leading: Image(
          image: location.locationType?.icon ??
              const AssetImage('assets/img_placeholder.png'),
          width: responsiveAppConfig.rWidth(12.0),
        ),
        title: Padding(
          padding: const EdgeInsets.only(left: 3.0),
          child: Text(
            location.title,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: font_styles.topSightTitle,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(left: 3.0),
          child: Row(
            children: [
              if (location.address != null) ...[
                const Icon(
                  Icons.location_pin,
                  size: 14.0,
                  color: Colors.white,
                ),
                const SizedBox(width: 3.0),
              ],
              Container(
                constraints: BoxConstraints(
                  maxWidth: responsiveAppConfig.rWidth(50.0),
                ),
                child: Text(
                  location.address ?? location.locationType!.title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: font_styles.topSightSubtitle,
                ),
              ),
            ],
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
