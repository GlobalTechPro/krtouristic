import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:krtouristic/conf/globals.dart' as globals;

enum SocialMediaPlatform { facebook, instagram }

class SocialMedia {
  static Future open(SocialMediaPlatform platform) async {
    final urls = {
      SocialMediaPlatform.facebook: Uri.parse(globals.cityData['fb_group_url']),
      SocialMediaPlatform.instagram:
          Uri.parse(globals.cityData['insta_group_url']),
    };
    final url = urls[platform]!;
    await launchUrl(url);
  }

  static Widget buildSocialButton({
    required IconData icon,
    Color? color,
    required Function() onClicked,
  }) =>
      InkWell(
        onTap: onClicked,
        child: SizedBox(
          width: 60.0,
          height: 60.0,
          child: Center(
            child: FaIcon(icon, color: color, size: 40),
          ),
        ),
      );
}
