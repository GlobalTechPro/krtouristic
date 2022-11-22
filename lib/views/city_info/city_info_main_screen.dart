import 'package:cached_network_image/cached_network_image.dart';
import 'package:krtouristic/conf/responsive_app_config.dart';
import 'package:krtouristic/views/common/app_bar_main.dart';
import 'package:krtouristic/conf/globals.dart' as globals;
import 'package:flutter/material.dart';
import 'package:krtouristic/conf/font_styles.dart' as font_styles;

class CityInfoMainScreen extends StatefulWidget {
  const CityInfoMainScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<CityInfoMainScreen> createState() => _CityInfoMainScreenState();
}

class _CityInfoMainScreenState extends State<CityInfoMainScreen> {
  @override
  Widget build(BuildContext context) {
    final responsiveAppConfig = ResponsiveAppConfig(context);

    return Scaffold(
      appBar: etsAppBar(context, globals.cityData['title_main'],
          globals.cityData['title_city_info']),
      backgroundColor: const Color.fromRGBO(1, 25, 51, 1.0),
      body: ListView(
        children: [
          // general info
          ListTile(
            title: Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 15.0),
              child: Text(
                'Загальні відомості',
                style: font_styles.cityInfoTitle,
                textAlign: TextAlign.center,
              ),
            ),
            subtitle: CachedNetworkImage(
              imageUrl:
                  'https://firebasestorage.googleapis.com/v0/b/ets-com.appspot.com/o/images%2Fcity_pics%2FKryvyi_Rih_9.jpeg?alt=media&token=461bdd7e-00f9-4356-a712-6fcf3ff03233',
              imageBuilder: (context, imageProvider) {
                return Container(
                  height: 250.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                      colorFilter: const ColorFilter.mode(
                          Color.fromRGBO(1, 25, 51, 1.0), BlendMode.softLight),
                    ),
                    borderRadius: BorderRadius.circular(2),
                    color: const Color.fromRGBO(255, 255, 255, 1.0),
                  ),
                );
              },
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CircularProgressIndicator(
                value: downloadProgress.progress,
                color: const Color.fromRGBO(255, 213, 0, 1.0),
                backgroundColor: const Color.fromRGBO(1, 25, 51, 1.0),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),

          ListTile(
            title: Container(
              margin: const EdgeInsets.only(top: 10.0, bottom: 5.0),
              child: Text(
                'Географічне розташування',
                style: font_styles.cityInfoParagraphTitle,
              ),
            ),
            subtitle: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Text(
                    'Кривий Ріг – місто, розташоване у степовій зоні України, в центральній частині Українського кристалічного масиву, на злитті річок Інгулець і Саксагань, що входять до басейну р. Дніпро. ',
                    style: font_styles.cityInfoParagraph,
                    textAlign: TextAlign.justify,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Text(
                    'Місто розташоване у помірних широтах. Від екватора – у північній півкулі, від Гринвіцького (нульового) меридіану – у східній півкулі. Точні координати відсутні, оскільки місто витягнуте у майже субмеридіональному напрямі на кілька десятків кілометрів.',
                    style: font_styles.cityInfoParagraph,
                    textAlign: TextAlign.justify,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Text(
                    'Площа міста – 430 кв. км, протяжність з півночі на південь – 126 км, ширина – до 20 км.',
                    style: font_styles.cityInfoParagraph,
                    textAlign: TextAlign.justify,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Text(
                    'Відстань від Кривого Рогу по прямій до Дніпропетровська 137 км, до Києва – 345 км, до Лондона – 2 160 км, Парижа – 2741 км, Берліна – 1 777 км, Брюсселя – 2 531 км, Москви – 962 км, Вашингтона – 8 650 км.',
                    style: font_styles.cityInfoParagraph,
                    textAlign: TextAlign.justify,
                  ),
                ),
                CachedNetworkImage(
                  imageUrl:
                      'https://firebasestorage.googleapis.com/v0/b/ets-com.appspot.com/o/images%2Fcity_pics%2FKryvyi_Rih_3.jpg?alt=media&token=8d47ae61-6674-4c60-b0f3-67b7fa1585c7',
                  imageBuilder: (context, imageProvider) {
                    return Image(
                      image: imageProvider,
                      width: responsiveAppConfig.rWidthPadding(100),
                    );
                  },
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                    value: downloadProgress.progress,
                    color: const Color.fromRGBO(255, 213, 0, 1.0),
                    backgroundColor: const Color.fromRGBO(1, 25, 51, 1.0),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ],
            ),
          ),

          ListTile(
            title: Container(
              margin: const EdgeInsets.only(top: 10.0, bottom: 5.0),
              child: Text(
                "Кліматичні умови. Корисні копалини",
                style: font_styles.cityInfoParagraphTitle,
              ),
            ),
            subtitle: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Text(
                    "Місто Кривий Ріг розташоване в центральній частині Українського кристалічного масиву. В геологічній побудові міста та його околиць беруть участь четвертинні суглинки, товщиною 3-25 м, що підстилаються неогеновими глинами, пісками або тріщинуватими вапняками, товщиною 5-11 м. Над неогеновими відкладеннями залягають докембрійські кристалічні породи (граніти), що виходять на поверхню в долинах річок.",
                    style: font_styles.cityInfoParagraph,
                    textAlign: TextAlign.justify,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Text(
                    "Чорноземи звичайні — головна генетична група ґрунтів у приміській зоні. Також представлені лучно-чорноземні та лучно-солонцюваті ґрунти.",
                    style: font_styles.cityInfoParagraph,
                    textAlign: TextAlign.justify,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Text(
                    "Місто розташоване у степовій зоні України, на злитті річок Інгулець і Саксагань, які входять до басейну Дніпра. Територія околиць розчленована численними балками (Зелена, Березнеговата, Червона, Макортова, Галахова, Лозуватка, Грушевата, Петрикова, Красна, Роковата, Суха, Гливата, Дубова, Вовча, Суслова, Кобальска, Калетіна, Крутий Яр, Приворотна та інші). У місцях виходу корінних порід схили річкових долин круті.",
                    style: font_styles.cityInfoParagraph,
                    textAlign: TextAlign.justify,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Text(
                    "Клімат — помірно-континентальний, характеризується спекотним посушливим літом і помірно м'якою з частими відлигами зимою.",
                    style: font_styles.cityInfoParagraph,
                    textAlign: TextAlign.justify,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Text(
                    "Більша частина опадів випадає під час теплої половини року (квітень—жовтень) — 268 мм. Добовий максимум опадів (90 мм) спостерігався у червні 1913 року. Упродовж року сумарна тривалість випадіння опадів 730 годин. За останні 60 років посушливими є кожні 3-4 роки на одне десятиліття. Сильні посухи на Криворіжжі бувають раз на 5-10 років. Зливові дощі супроводжуються грозами та градом. Найчастіше грози трапляються в період з травня по серпень.",
                    style: font_styles.cityInfoParagraph,
                    textAlign: TextAlign.justify,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Text(
                    "Над територією міста сформувався своєрідний мікроклімат «острова тепла». В місті тепліше на 1,8°С. Особливо це помітно в холодний період року. Також більше опадів, туманів, часто з низьких хмар і пило-газових викидів підприємств та автомобілів взимку утворюються смоги, знижені дози сонячної радіації.",
                    style: font_styles.cityInfoParagraph,
                    textAlign: TextAlign.justify,
                  ),
                ),
                CachedNetworkImage(
                  imageUrl:
                      'https://firebasestorage.googleapis.com/v0/b/ets-com.appspot.com/o/images%2Fcity_pics%2FKryvyi_Rih_1.jpg?alt=media&token=b6752ef9-4ae2-4999-9f08-e6fcb3e45fd5',
                  imageBuilder: (context, imageProvider) {
                    return Image(
                      image: imageProvider,
                      width: responsiveAppConfig.rWidthPadding(100),
                    );
                  },
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                    value: downloadProgress.progress,
                    color: const Color.fromRGBO(255, 213, 0, 1.0),
                    backgroundColor: const Color.fromRGBO(1, 25, 51, 1.0),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ],
            ),
          ),

          ListTile(
            title: Container(
              margin: const EdgeInsets.only(top: 10.0, bottom: 5.0),
              child: Text(
                'Адміністративно-територіальний устрій',
                style: font_styles.cityInfoParagraphTitle,
              ),
            ),
            subtitle: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Text(
                    'До складу Кривого Рогу входять 7 районів: Металургійний, Довгинцівський, Покровський, Інгулецький, Саксаганський, Тернівський та Центрально-Міський. У підпорядкуванні Криворізької міської ради також перебувають селища Авангард, Гірницьке, Коломійцеве, Степне, а також село Новоіванівка та Тернуватий Кут.',
                    style: font_styles.cityInfoParagraph,
                    textAlign: TextAlign.justify,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Text(
                    'Кривий Ріг — місто в Дніпропетровській області; найбільше місто України, яке не є обласним центром. Населення близько 648 тис. мешканців, а разом із Криворізькою агломерацією ця позначка сягає мільйону осіб. Відстань до обласного центру становить 146 км. Довжина міста становить 126 км. відстань між крайніми точками по прямій — 66 км.',
                    style: font_styles.cityInfoParagraph,
                    textAlign: TextAlign.justify,
                  ),
                ),
                CachedNetworkImage(
                  imageUrl:
                      'https://firebasestorage.googleapis.com/v0/b/ets-com.appspot.com/o/images%2Fcity_pics%2FKryvyi_Rih_4.jpg?alt=media&token=dfe424c4-25e5-47d9-a17a-90a111e4b2a1',
                  imageBuilder: (context, imageProvider) {
                    return Image(
                      image: imageProvider,
                      width: responsiveAppConfig.rWidthPadding(100),
                    );
                  },
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                    value: downloadProgress.progress,
                    color: const Color.fromRGBO(255, 213, 0, 1.0),
                    backgroundColor: const Color.fromRGBO(1, 25, 51, 1.0),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ],
            ),
          ),

          ListTile(
            title: Container(
              margin: const EdgeInsets.only(top: 10.0, bottom: 5.0),
              child: Text(
                'Атрибутика міста',
                style: font_styles.cityInfoParagraphTitle,
              ),
            ),
            subtitle: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Column(children: [
                    CachedNetworkImage(
                      imageUrl:
                          'https://firebasestorage.googleapis.com/v0/b/ets-com.appspot.com/o/images%2Fcity_pics%2FCoat_of_Arms_of_Kryvyy_Rih.png?alt=media&token=1891d3cd-779e-4303-aa91-d17d3bcdfa8d',
                      imageBuilder: (context, imageProvider) {
                        return Image(
                          image: imageProvider,
                          width: responsiveAppConfig.rWidth(50),
                        );
                      },
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                              CircularProgressIndicator(
                        value: downloadProgress.progress,
                        color: const Color.fromRGBO(255, 213, 0, 1.0),
                        backgroundColor: const Color.fromRGBO(1, 25, 51, 1.0),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                    Text(
                      'Герб',
                      style: font_styles.cityInfoParagraph,
                    ),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Column(children: [
                    CachedNetworkImage(
                      imageUrl:
                          'https://firebasestorage.googleapis.com/v0/b/ets-com.appspot.com/o/images%2Fcity_pics%2FKryvyi_Rih_stamp.png?alt=media&token=a0b88497-66a3-412e-ab72-2597c9d16dc7',
                      imageBuilder: (context, imageProvider) {
                        return Image(
                          image: imageProvider,
                          width: responsiveAppConfig.rWidth(50),
                        );
                      },
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                              CircularProgressIndicator(
                        value: downloadProgress.progress,
                        color: const Color.fromRGBO(255, 213, 0, 1.0),
                        backgroundColor: const Color.fromRGBO(1, 25, 51, 1.0),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                    Text(
                      'Печатка',
                      style: font_styles.cityInfoParagraph,
                    ),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Column(children: [
                    CachedNetworkImage(
                      imageUrl:
                          'https://firebasestorage.googleapis.com/v0/b/ets-com.appspot.com/o/images%2Fcity_pics%2FKryvyi_Rih_flag.png?alt=media&token=92a7498c-4fb4-4778-b3bb-1438d2ece611',
                      imageBuilder: (context, imageProvider) {
                        return Image(
                          image: imageProvider,
                          width: responsiveAppConfig.rWidth(50),
                        );
                      },
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                              CircularProgressIndicator(
                        value: downloadProgress.progress,
                        color: const Color.fromRGBO(255, 213, 0, 1.0),
                        backgroundColor: const Color.fromRGBO(1, 25, 51, 1.0),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                    Text(
                      'Прапор',
                      style: font_styles.cityInfoParagraph,
                    ),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Text(
                    'Сучасний герб, печатка та прапор Кривого Рогу затверджені 28 лютого 2007 року. В основу герба покладена козацька порохівниця, виготовлена з рогу, що передусім вказує на назву міста і його минуле як територію Запорізької січі, легенду про засновника міста козака Кривого Рога та іншу версію про походження назви міста — утворення кривого мису (рогу) при злитті річок Інгулець та Саксагань.',
                    style: font_styles.cityInfoParagraph,
                    textAlign: TextAlign.justify,
                  ),
                ),
                const SizedBox(height: 5.0),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Column(children: [
                    CachedNetworkImage(
                      imageUrl:
                          'https://firebasestorage.googleapis.com/v0/b/ets-com.appspot.com/o/images%2Fcity_pics%2FKryvyi_Rih_badge.png?alt=media&token=94af8cd6-d1f5-4536-bf8b-58cc6935f288',
                      imageBuilder: (context, imageProvider) {
                        return Image(
                          image: imageProvider,
                          width: responsiveAppConfig.rWidth(50),
                        );
                      },
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                              CircularProgressIndicator(
                        value: downloadProgress.progress,
                        color: const Color.fromRGBO(255, 213, 0, 1.0),
                        backgroundColor: const Color.fromRGBO(1, 25, 51, 1.0),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                    Text(
                      'Нагрудний знак',
                      style: font_styles.cityInfoParagraph,
                    ),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Text(
                    'Головна нагорода міста — нагрудний знак «За заслуги перед містом». 40 діячів міста мають звання його почесних громадян.',
                    style: font_styles.cityInfoParagraph,
                    textAlign: TextAlign.justify,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Text(
                    'У 2002 році гімном Кривого Рогу визнана пісня «Кривий Ріг — моє місто».',
                    style: font_styles.cityInfoParagraph,
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10.0),

          // historical reference
          ListTile(
            title: Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 15.0),
              child: Text(
                'Історична довідка',
                style: font_styles.cityInfoTitle,
                textAlign: TextAlign.center,
              ),
            ),
            subtitle: CachedNetworkImage(
              imageUrl:
                  'https://firebasestorage.googleapis.com/v0/b/ets-com.appspot.com/o/images%2Fcity_pics%2FKryvyi_Rih_10.jpg?alt=media&token=d70d6adc-e6f0-44c4-a8e1-09ed291d818d',
              imageBuilder: (context, imageProvider) {
                return Image(
                  image: imageProvider,
                  width: responsiveAppConfig.rWidthPadding(100),
                );
              },
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CircularProgressIndicator(
                value: downloadProgress.progress,
                color: const Color.fromRGBO(255, 213, 0, 1.0),
                backgroundColor: const Color.fromRGBO(1, 25, 51, 1.0),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),

          ListTile(
            subtitle: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                  child: Text(
                    "Перша офіційна письмова згадка про Кривий Ріг знайдена у “Розписі заснованих поштових станцій по річці Інгулець від Кременчука до Херсона”, датованому 1775 роком.",
                    style: font_styles.cityInfoParagraph,
                    textAlign: TextAlign.justify,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Text(
                    "Свою назву місто отримало від форми кривого мису (рогу) на злитті річок Інгулець і Саксагань, де було перше поселення. За іншою версією, згадана назва походить від імені запорізького козака Рога на прізвисько “Кривий”, який оселився у цьому мальовничому місці і заснував перше поселення.",
                    style: font_styles.cityInfoParagraph,
                    textAlign: TextAlign.justify,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Text(
                    "У XVIII ст. Кривий Ріг був запорізьким поселенням у складі Інгулецької паланки Запорізької Січі: у переліку сіл і зимівників Інгульської паланки, створеної у 1734 році, згадується Кривий Ріг. 1775 року в урочищі Кривий Ріг засновано одну зі станцій поштового тракту, на якій для обслуговування пошти в тимчасових землянках оселилися п’ять козаків. Від селища, що утворилося біля цієї поштової станції, і веде свій початок сучасне місто. З першої третини XIX ст. Кривий Ріг перетворено на військове поселення. У 1860 році це місто набуло статусу містечка у складі Херсонської губернії, а з 1919 року – повітового міста у складі Катеринославської губернії.",
                    style: font_styles.cityInfoParagraph,
                    textAlign: TextAlign.justify,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Text(
                    "У кінці XIX ст. у місті та на його околицях виявлено поклади залізної руди. Після підтвердження значних запасів залізної руди у 1881 році засновано перший на Криворіжжі Саксаганський рудник, а у 1882 році розпочато будівництво криворізької залізниці, яка відіграла величезну роль у прискоренні розвитку промисловості регіону.",
                    style: font_styles.cityInfoParagraph,
                    textAlign: TextAlign.justify,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Text(
                    "Під час громадянської війни у 1919–1920 роках не припиняється розвиток металургії, формується система адміністративного управління добувною промисловістю. У 1924 році розпочинається будівництво Криворізької електростанції. Радянська індустріалізація стала потужним поштовхом до більш сучасного видобутку та переробки руди. Місто розширюється за рахунок малих населених пунктів, що виникають навколо рудників. Розростаючись в умовах складного природного рельєфу, місто поглинає рудники і підприємства. Це стало причиною відсутності у межах міста чіткого розмежування промислових зон і житлових масивів.",
                    style: font_styles.cityInfoParagraph,
                    textAlign: TextAlign.justify,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Text(
                    "Під час Другої світової війни місто з серпня 1941 року до лютого 1944 року було окуповане військами фашистської Німеччини. Робота найбільшого заводу міста – “Криворіжсталі” – була призупинена перед окупацією.",
                    style: font_styles.cityInfoParagraph,
                    textAlign: TextAlign.justify,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Text(
                    "Після Другої світової війни місто та його економіка, насамперед промисловість, відроджуються. Першочергово увага приділяється відновленню промислових потужностей. Упродовж 1952–1956 років для використання запасів бідних залізних руд та залізистих кварцитів будується перший в СРСР гірничо-збагачувальний комбінат – Південний ГЗК, а у 1959 році відбувається запуск Новокриворізького ГЗК. Тільки з середини 70-х років економіка міста доповнюється підприємствами легкої промисловості. І сьогодні Кривий Ріг є найбільшим гірничодобувним та металургійним центром України.",
                    style: font_styles.cityInfoParagraph,
                    textAlign: TextAlign.justify,
                  ),
                ),
                CachedNetworkImage(
                  imageUrl:
                      'https://firebasestorage.googleapis.com/v0/b/ets-com.appspot.com/o/images%2Fcity_pics%2FOleksandr_Pol_2.jpeg?alt=media&token=044ed368-f28c-4a7e-86b1-e5b783a22c07',
                  imageBuilder: (context, imageProvider) {
                    return Image(
                      image: imageProvider,
                      width: responsiveAppConfig.rWidthPadding(100),
                    );
                  },
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                    value: downloadProgress.progress,
                    color: const Color.fromRGBO(255, 213, 0, 1.0),
                    backgroundColor: const Color.fromRGBO(1, 25, 51, 1.0),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ],
            ),
          ),

          const SizedBox(height: 15.0),
        ],
      ),
    );
  }
}
