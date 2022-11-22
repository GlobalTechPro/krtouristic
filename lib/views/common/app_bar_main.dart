import 'package:krtouristic/views/common/ui_lists/list_unordered.dart';
import 'package:krtouristic/views/common/social_media.dart';
import 'package:flutter/material.dart';
import 'package:krtouristic/conf/font_styles.dart' as font_styles;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

bool isRootRoute(BuildContext context) =>
    ModalRoute.of(context)?.isFirst ?? true;

Future<void> openAboutDialog(BuildContext context) async {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          backgroundColor: const Color.fromRGBO(2, 51, 103, 1.0),
          contentPadding: const EdgeInsets.all(20.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          title: Center(
            child: Text(
              'Про застосунок',
              style: font_styles.aboutDialogTitle,
            ),
          ),
          children: [
            Column(
              children: [
                Image.asset(
                  'assets/icons/logo_256.png',
                  height: 80.0,
                ),
                Row(
                  children: [
                    Text(
                      '"Кривий РІг Туристичний" - це:',
                      style: font_styles.aboutDialogText,
                    ),
                  ],
                ),
                const SizedBox(height: 5.0),
                const UnorderedList([
                  'памʼятки міста;',
                  'визначні місця;',
                  'екскурсії містом та за його межі;',
                  'інші активності та локації для комфортного, цікавого й пізнавального проведення часу.',
                ]),
                const SizedBox(height: 15.0),
                Text(
                  'Зроблено з ♥️ до рідного',
                  style: font_styles.aboutDialogText,
                ),
                Text(
                  '"Міста довжиною в життя"',
                  style: font_styles.aboutDialogCityText,
                ),
                const SizedBox(height: 20.0),
                const Divider(
                  height: 30.0,
                  thickness: 1.0,
                  indent: 20.0,
                  endIndent: 20.0,
                  color: Colors.white,
                ),
                const SizedBox(height: 3.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocialMedia.buildSocialButton(
                      icon: FontAwesomeIcons.squareFacebook,
                      color: const Color(0xFF0075FC),
                      onClicked: () =>
                          SocialMedia.open(SocialMediaPlatform.facebook),
                    ),
                    SocialMedia.buildSocialButton(
                      icon: FontAwesomeIcons.instagram,
                      color: const Color(0xFF405DE6),
                      onClicked: () =>
                          SocialMedia.open(SocialMediaPlatform.instagram),
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
      });
}

PreferredSizeWidget etsAppBar(context, title, subtitle) {
  bool isRootR = isRootRoute(context);
  Widget leadingChild = IconButton(
    icon: Image.asset('assets/icons/logo_256.png'),
    onPressed: () {
      openAboutDialog(context);
    },
  );
  if (!isRootR) {
    leadingChild = Align(child: BackButton(
      onPressed: () async {
        Navigator.pop(context);
      },
    ));
  }

  return AppBar(
    // shadowColor: const Color.fromRGBO(39, 203, 0, 1.0),
    leading: leadingChild,
    title: RichText(
      textAlign: TextAlign.start,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
          text: title,
          style: font_styles.appBarTitle,
          children: <TextSpan>[
            TextSpan(
              text: "\n$subtitle",
              style: font_styles.appBarSubTitle,
            ),
          ]),
    ),
    centerTitle: false,
    titleSpacing: 0.0,
    // actions: <Widget>[
    //   Container(
    //     padding: const EdgeInsets.only(right: 10),
    //     child: IconButton(
    //       icon: const Icon(
    //         Icons.info_outlined,
    //       ),
    //       tooltip: 'Про додаток',
    //       onPressed: () {
    //         openAboutDialog(context);
    //         // ScaffoldMessenger.of(context).showSnackBar(
    //         //     const SnackBar(content: Text('Пошук'))
    //         // );
    //       },
    //     ),
    //   ),
    // ],
  );
}
