import 'package:krtouristic/utils/injection/injection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


void insertData() async {
  // getIt<FirebaseFirestore>().useFirestoreEmulator('localhost', 8080);

  final batch = getIt<FirebaseFirestore>().batch();

/*
  final cityKryvyiRihUk = <String, dynamic>{
    "id": 1,
    "lang": "uk",
    "name": "Кривий Ріг",
    "lat": 47.910573076933524,
    "lng": 33.391669323403704,
    "title_main": "Кривий Ріг Туристичний",
    "title_sights": "Пам'ятки Кривого Рогу",
    "title_guided_tours": "Екскурсії Кривого Рогу",
    "title_guides": "Гіди Кривого Рогу",
    "title_gallery": "Галерея",
    "title_city_info": "Про місто",
    "title_top5sights": "ТОП 5 Пам‘яток",
    "title_top5guided_tours": "ТОП 5 Екскурсій",
    "menu_item_main": "Головна",
    "menu_item_sights": "Пам'ятки",
    "menu_item_guided_tours": "Екскурсії",
    "menu_item_guides": "Гіди",
    "menu_item_gallery": "Галерея",
    "menu_item_city_info": "Довідка",
    "fb_group_url": "https://www.facebook.com/kr.tour",
    "insta_group_url": "https://www.instagram.com/tour.kr/",
  };
  final cityKryvyiRihEn = <String, dynamic>{
    "id": 1,
    "lang": "en",
    "name": "Kryvyi Rih",
    "lat": 47.910573076933524,
    "lng": 33.391669323403704,
    "title_main": "Kryvyi Rih Unknown",
    "title_sights": "Kryvyi Rih Sights",
    "title_guided_tours": "Kryvyi Rih view.guided_tours",
    "title_guides": "Kryvyi Rih Guides",
    "title_gallery": "Gallery",
    "title_city_info": "About the city",
    "title_top5sights": "TOP 5 Sights",
    "title_top5guided_tours": "TOP 5 Guided Tours",
    "menu_item_main": "Main",
    "menu_item_sights": "Sights",
    "menu_item_guided_tours": "Guided Tours",
    "menu_item_guides": "Guides",
    "menu_item_gallery": "Gallery",
    "menu_item_city_info": "City Info",
    "fb_group_url": "https://www.facebook.com/kr.tour",
    "insta_group_url": "https://www.instagram.com/tour.kr/",
  };
  final cityKryvyiRihRu = <String, dynamic>{
    "id": 1,
    "lang": "ru",
    "name": "Кривой Рог",
    "lat": 47.910573076933524,
    "lng": 33.391669323403704,
    "title_main": "Кривой Рог Туристический",
    "title_sights": "Места Кривого Рога",
    "title_guided_tours": "Экскурсии Кривого Рога",
    "title_guides": "Гиды Кривого Рога",
    "title_gallery": "Галерея",
    "title_city_info": "Информация о городе",
    "title_top5sights": "ТОП 5 Мест",
    "title_top5guided_tours": "ТОП 5 Экскурсий",
    "menu_item_main": "Главная",
    "menu_item_sights": "Места",
    "menu_item_guided_tours": "Экскурсии",
    "menu_item_guides": "Гиды",
    "menu_item_gallery": "Галерея",
    "menu_item_city_info": "Справка",
    "fb_group_url": "https://www.facebook.com/kr.tour",
    "insta_group_url": "https://www.instagram.com/tour.kr/",
  };

  batch.set(
      getIt<FirebaseFirestore>().collection("City").doc('kryvyi-rih-uk'),
      cityKryvyiRihUk);
  batch.set(
      getIt<FirebaseFirestore>().collection("City").doc('kryvyi-rih-en'),
      cityKryvyiRihEn);
  batch.set(
      getIt<FirebaseFirestore>().collection("City").doc('kryvyi-rih-ru'),
      cityKryvyiRihRu);

  final homePageBlock1 = <String, dynamic>{
    "lang": "uk",
    "name": "home_guided_tours",
    "sort_order": 1,
    "title": "Екскурсії",
    "imageUrl":
    "https://firebasestorage.googleapis.com/v0/b/ets-com.appspot.com/o/images%2Fhome_page_blocks%2Fguided_tours.png?alt=media&token=d6c64751-1f61-4181-aa00-894612198f69",
  };
  final homePageBlock2 = <String, dynamic>{
    "lang": "uk",
    "name": "home_industrial_heritage",
    "sort_order": 2,
    "title": "Індустріальна спадщина",
    "imageUrl":
    "https://firebasestorage.googleapis.com/v0/b/ets-com.appspot.com/o/images%2Fhome_page_blocks%2Findustrial_heritage.png?alt=media&token=14a5081f-b8f5-49a7-96e0-352be6cdfbd7",
  };
  final homePageBlock3 = <String, dynamic>{
    "lang": "uk",
    "name": "home_monumental_arts",
    "sort_order": 3,
    "title": "Обʼєкти монументального мистецтва",
    "imageUrl":
    "https://firebasestorage.googleapis.com/v0/b/ets-com.appspot.com/o/images%2Fhome_page_blocks%2Fmonumental_arts.png?alt=media&token=c0209c4f-0f32-4416-9710-c73ae02c7687",
  };
  final homePageBlock4 = <String, dynamic>{
    "lang": "uk",
    "name": "home_history_architecture",
    "sort_order": 4,
    "title": "Обʼєкти історії та архітектури",
    "imageUrl":
    "https://firebasestorage.googleapis.com/v0/b/ets-com.appspot.com/o/images%2Fhome_page_blocks%2Fhistory_architecture.png?alt=media&token=ec3c8fd4-d332-4dc5-9f36-27a385084999",
  };
  batch.set(getIt<FirebaseFirestore>().collection("HomePageBlock").doc(),
      homePageBlock1);
  batch.set(getIt<FirebaseFirestore>().collection("HomePageBlock").doc(),
      homePageBlock2);
  batch.set(getIt<FirebaseFirestore>().collection("HomePageBlock").doc(),
      homePageBlock3);
  batch.set(getIt<FirebaseFirestore>().collection("HomePageBlock").doc(),
      homePageBlock4);

  final guideGlibKozlov = <String, dynamic>{
    "city_id": 1,
    "lang": "uk",
    "name": {
      "first": "Гліб",
      "last": "Козлов",
      "patronymic": "Юрійович",
    },
    "subtitle": "Гід Кривого Рогу",
    "description":
    "Випускник 2013 року Дніпропетровського Національного Університету ім. Олеся Гончара. За спеціальністю - філолог (англійська мова та література). Працював вчителем англійської мови, до цього - вантажником залізорудного концентрату на ЦГЗК. На сьогодні приватний підприємець. В екскурсійній діяльності з 2014 року. Проводить екскурсії англійською і німецькою мовами. Зараз отримує другу вищу освіту у Львівському Національному Університеті імені Івана Франка за спеціальністю-туризм.",
    "phone": "+380689446462",
    "email": "",
    "spoken_languages": ["uk", "ru"],
    "avatar":
    "https://firebasestorage.googleapis.com/v0/b/ets-com.appspot.com/o/images%2Fguides%2Fglib_kozlov.jpeg?alt=media&token=b304faa5-470f-47de-a7f1-00f3f76c006b",
    "youtube_url": "https://youtu.be/09o88HopvC8",
  };
  final guideAnnaKaverina = <String, dynamic>{
    "city_id": 1,
    "lang": "uk",
    "name": {
      "first": "Ганна",
      "last": "Каверіна",
      "patronymic": "Ігорівна",
    },
    "subtitle": "Гід Кривого Рогу",
    "description":
    "Закінчила Донбаську державну академію будівництва та архітектури за спеціальністю «Теплогазопостачання, опалення та вентиляція». Працювала в будівельних компаніях м.Донецьк. З 2014 р. проживає в м.Кривий Ріг. У 2015 році закінчила курси екскурсоводів при Криворізькому педагогічному інституті.",
    "phone": "+380951592909",
    "email": "kaverina_anna@ukr.net",
    "spoken_languages": ["uk", "ru"],
    "avatar":
    "https://firebasestorage.googleapis.com/v0/b/ets-com.appspot.com/o/images%2Fguides%2Fanna_kaverina.png?alt=media",
  };
  final guideIrinaOstapchuk = <String, dynamic>{
    "city_id": 1,
    "lang": "uk",
    "name": {
      "first": "Ірина",
      "last": "Остапчук",
    },
    "subtitle": "Гід Кривого Рогу",
    "description":
    "За освітою я вчитель географії та біології, кандидат географічних наук, екскурсовод по Кривому Рогу. Займаюсь організацією і проведенням екскурсій по Кривому Рогу: є чотири наукові екологічні екскурсії по місту, які поєднують природні та індустріальні, постіндустріальні ландшафти; є декілька варіантів одноденних турів по Кривому Рогу тривалістю від 4-х до 12 годин.",
    "phone": "+380677633354",
    "email": "ostapmanaen@gmail.com",
    "spoken_languages": ["uk", "ru"],
    "avatar":
    "https://firebasestorage.googleapis.com/v0/b/ets-com.appspot.com/o/images%2Fguides%2Firina_ostapchuk.png?alt=media&token=52fa38d7-f507-493e-ad66-970fbab48c07",
  };
  final guideAnnaLitvinchuk = <String, dynamic>{
    "city_id": 1,
    "lang": "uk",
    "name": {
      "first": "Анна",
      "last": "Литвинчук",
    },
    "subtitle": "Гід Кривого Рогу",
    "description": "Текст опису професійного шляху і діяльності",
    "phone": "+380979404748",
    "email": "",
    "spoken_languages": ["uk", "ru"],
    "avatar":
    "https://firebasestorage.googleapis.com/v0/b/ets-com.appspot.com/o/images%2Fguides%2Fanna_litvinchuk.png?alt=media",
    "youtube_url": "https://youtu.be/TIZ53ssZHKg",
  };
  final guideDenisDubov = <String, dynamic>{
    "city_id": 1,
    "lang": "uk",
    "name": {
      "first": "Денис",
      "last": "Дубов",
      "patronymic": "Альбертович",
    },
    "subtitle": "Гід Кривого Рогу",
    "description":
    "Випускник металургійного інституту Криворізького національного університету 2014 року. За спеціальністю інженер автоматизованого управління технологічними процесами. На сьогодні працює на ПАТ «АрселоМіттал Кривий Ріг». В екскурсійній справі з 2014 року. Екскурсійну діяльність розпочав у Кривому Розі.",
    "phone": "+380977162801",
    "email": "",
    "spoken_languages": ["uk", "ru"],
    "avatar":
    "https://firebasestorage.googleapis.com/v0/b/ets-com.appspot.com/o/images%2Fguides%2Fdenis_dubov.png?alt=media",
    "youtube_url": "https://youtu.be/-F2O4rQZmnE",
  };
  final guideEduardDvorchuk = <String, dynamic>{
    "city_id": 1,
    "lang": "uk",
    "name": {
      "first": "Едуард",
      "last": "Дворчук",
      "patronymic": "Володимирович",
    },
    "subtitle": "Гід Кривого Рогу",
    "description":
    "Закінчив географічний факультет Криворізький державний педагогічний інститут у 2012 році. За спеціальністю вчитель географії та основ економіки, організатор краєзнавчо-туристичної роботи. Наразі навчається в аспірантурі при кафедрі географії Вінницькому педагогічному університеті. Досліджує антропогенну спадщину, природу та історію Криворіжжя. Екскурсовод з 2013 року.",
    "phone": "+380961632007",
    "email": "",
    "spoken_languages": ["uk", "ru", "en"],
    "avatar":
    "https://firebasestorage.googleapis.com/v0/b/ets-com.appspot.com/o/images%2Fguides%2Feduard_dvorchuk.png?alt=media",
    "youtube_url": "https://youtu.be/4xGwM6uvl5Q",
  };
  final guideIvanNaidenko = <String, dynamic>{
    "city_id": 1,
    "lang": "uk",
    "name": {
      "first": "Іван",
      "last": "Найденко",
      "patronymic": "Володимирович",
    },
    "subtitle": "Гід Кривого Рогу",
    "description":
    "За спеціальністю журналіст, засновник і керівник туристичної агенції «Криворізький меридіан». Стаж діяльності за фахом екскурсійного супроводу 14 років. Самостійно були розроблені і впроваджені у життя екскурсійні маршрути: «Чигиринщина – земля героїв», «Дніпропетровськ вчора і завтра», «Легендарна Хортиця», «Степові Карпати», «Придніпровські гори», «На просторах Таврії», «Таємниці землі криворізької», «Славетні імена», «Степове диво», «Єлисаветград культурно-духовний», «Криворіжжя – край козацький», «Підземні скарби Кривбасу», «Неповторний Приінгульський степ», «Чаруюча Полтава», «Зелене Криворіжжя». Ведуться розробки ще кількох екскурсійних маршрутів – «Гранітно-степове Побужжя», «Міфи і реалії Жовтої Річки», «Загадкове Поділля».",
    "phone": "+380678374683",
    "email": "",
    "spoken_languages": ["uk", "ru"],
    "avatar":
    "https://firebasestorage.googleapis.com/v0/b/ets-com.appspot.com/o/images%2Fguides%2Fivan_naidenko.png?alt=media",
    "youtube_url": "https://youtu.be/RrvxBx7295g",
  };
  final guideViktoriiaGricenko = <String, dynamic>{
    "city_id": 1,
    "lang": "uk",
    "name": {
      "first": "Вікторія",
      "last": "Грисенко",
      "patronymic": "Павлівна",
    },
    "subtitle": "Гід Кривого Рогу",
    "description":
    "Закінчила Криворізький державний педагогічний інститут у 1988 році. За освітою вчитель географії та біології. З 1993 року працює в КЗШ № 75 вчителем географії. Має вищу категорію та звання \"вчитель-методист\". Разом з учнями досліджує природу Криворіжжя та України. Організовує екскурсії для учнів в різні куточки нашої Батьківщини. В 2014 році закінчила курси екскурсоводів при Криворізькому педагогічному інституті.",
    "phone": "+380679070996",
    "email": "grisenko.viktoriya@gmail.com",
    "spoken_languages": ["uk", "ru"],
    "avatar":
    "https://firebasestorage.googleapis.com/v0/b/ets-com.appspot.com/o/images%2Fguides%2Fviktoriia_grisenko.png?alt=media",
  };
  final guideVladimirKazakov = <String, dynamic>{
    "city_id": 1,
    "lang": "uk",
    "name": {
      "first": "Володимир",
      "last": "Казаков",
      "patronymic": "Леонідович",
    },
    "subtitle": "Найкращий гід України 2021 року - Ukraine Tourism Awards",
    "description":
    "Випускник географічного факультету Криворізького педагогічного інституту 1993 року. За спеціальністю вчитель географії та біології. Навчався в аспірантурі Сімферопольського державного університету. Кандидат географічних наук, доцент. З 2003 року завідуючий кафедрою фізичної географії, краєзнавства та туризму Криворізького національного університету. В екскурсійній справі з 1991 року. Екскурсійну діяльність розпочав в карстових печерах Кримських гір – Мармуровій і Тигровий Хід, по горі Чатирдаг. Дослідник індустріальної спадщини, природи та історії Криворіжжя. Автор понад 150 наукових публікацій. Організатор і керівник курсів екскурсоводів при Криворізькому педагогічному інституті.",
    "phone": "+380672918621",
    "email": "",
    "spoken_languages": ["uk", "ru"],
    "avatar":
    "https://firebasestorage.googleapis.com/v0/b/ets-com.appspot.com/o/images%2Fguides%2Fvladimir_kazakov.png?alt=media",
    "youtube_url": "https://youtu.be/XdPLHKUUOdM",
  };
  final guideMariyaGolovan = <String, dynamic>{
    "city_id": 1,
    "lang": "uk",
    "name": {
      "first": "Марія",
      "last": "Головань",
    },
    "subtitle": "Начвідділу пром. туризму інституту розвитку міста",
    "description": "Текст опису професійного шляху і діяльності",
    "phone": "+380969276160",
    "email": "",
    "spoken_languages": ["uk", "ru"],
    "avatar":
    "https://firebasestorage.googleapis.com/v0/b/ets-com.appspot.com/o/images%2Fguides%2Fmariya_golovan.png?alt=media&token=ffaa1765-be2a-4ce3-8613-4e93cce45ec7",
    "youtube_url": "https://youtu.be/Q_Ex83nglF8",
  };
  final guideGrygoryiKurochkin = <String, dynamic>{
    "city_id": 1,
    "lang": "uk",
    "name": {
      "first": "Григорій",
      "last": "Курочкін",
    },
    "subtitle": "Керівник туристичного центру Командор",
    "description": "Текст опису професійного шляху і діяльності",
    "phone": "+380676342224",
    "email": "",
    "spoken_languages": ["uk", "ru"],
    "avatar":
    "https://firebasestorage.googleapis.com/v0/b/ets-com.appspot.com/o/images%2Fguides%2Fgrygoryi_kurochkin.png?alt=media&token=46406c98-b758-4b62-a7a8-4ec44ac8e459",
    "youtube_url": "https://youtu.be/nTSHEo3XXW8",
  };
  final guideVolodymyrMurashkin = <String, dynamic>{
    "city_id": 1,
    "lang": "uk",
    "name": {
      "first": "Володимир",
      "last": "Мурашкін",
    },
    "subtitle": "Гід Кривого Рогу",
    "description":
    "Організовую промислові тури, екскурсії, а також приватні тури у місті Кривий Ріг.",
    "phone": "+380989753082",
    "email": "ukrmvs@gmail.com",
    "spoken_languages": [
      "uk",
      "ru",
      "en",
    ],
    "avatar":
    "https://firebasestorage.googleapis.com/v0/b/ets-com.appspot.com/o/images%2Fguides%2Fvolodymyr_murashkin.png?alt=media&token=16dce820-fad1-4ec4-890e-22c77e2ccb68",
  };
  // final guideVolodymyrOgur = <String, dynamic>{
  //   "city_id": 1,
  //   "lang": "uk",
  //   "name": {
  //     "first": "Володимир",
  //     "last": "Огур",
  //   },
  //   "subtitle": "Гід Кривого Рогу",
  //   "description": "Текст опису професійного шляху і діяльності",
  //   "phone": "+380999999999",
  //   "email": "",
  //   "spoken_languages": [
  //     "uk",
  //     "ru"
  //   ],
  //   "avatar": "https://firebasestorage.googleapis.com/v0/b/ets-com.appspot.com/o/images%2Fguides%2Fvolodymyr_ogur.png?alt=media&token=2ef59c2f-10b6-45b5-98fb-11085587a1da",
  //   "youtube_url": "https://youtu.be/Q_Ex83nglF8",
  // };
  // final guideViktoriyaTrotner = <String, dynamic>{
  //   "city_id": 1,
  //   "lang": "uk",
  //   "name": {
  //     "first": "Вікторія",
  //     "last": "Тротнер",
  //   },
  //   "subtitle": "Експерт із заповідних територій",
  //   "description": "Текст опису професійного шляху і діяльності",
  //   "phone": "+380999999999",
  //   "email": "",
  //   "spoken_languages": [
  //     "uk",
  //     "ru"
  //   ],
  //   "avatar": "https://firebasestorage.googleapis.com/v0/b/ets-com.appspot.com/o/images%2Fguides%2Fviktoriya_trotner.png?alt=media&token=55b36538-959c-4274-bcb1-0964cebf1416",
  //   "youtube_url": "https://youtu.be/cLZ8Ephn0kE",
  // };
  // final guideOlenaGalych = <String, dynamic>{
  //   "city_id": 1,
  //   "lang": "uk",
  //   "name": {
  //     "first": "Олена",
  //     "last": "Галич",
  //   },
  //   "subtitle": "Гід Кривого Рогу",
  //   "description": "Текст опису професійного шляху і діяльності",
  //   "phone": "+380999999999",
  //   "email": "",
  //   "spoken_languages": [
  //     "uk",
  //     "ru"
  //   ],
  //   "avatar": "https://firebasestorage.googleapis.com/v0/b/ets-com.appspot.com/o/images%2Fguides%2Folena_galych.png?alt=media&token=2c00e324-1555-405d-8d4a-b6ff7a392224",
  //   "youtube_url": "https://youtu.be/6QPahJrts4A",
  // };

  batch.set(
      getIt<FirebaseFirestore>().collection("Guide").doc(), guideGlibKozlov);
  batch.set(getIt<FirebaseFirestore>().collection("Guide").doc(),
      guideAnnaKaverina);
  batch.set(getIt<FirebaseFirestore>().collection("Guide").doc(),
      guideIrinaOstapchuk);
  batch.set(getIt<FirebaseFirestore>().collection("Guide").doc(),
      guideAnnaLitvinchuk);
  batch.set(
      getIt<FirebaseFirestore>().collection("Guide").doc(), guideDenisDubov);
  batch.set(getIt<FirebaseFirestore>().collection("Guide").doc(),
      guideEduardDvorchuk);
  batch.set(getIt<FirebaseFirestore>().collection("Guide").doc(),
      guideIvanNaidenko);
  batch.set(getIt<FirebaseFirestore>().collection("Guide").doc(),
      guideViktoriiaGricenko);
  batch.set(getIt<FirebaseFirestore>().collection("Guide").doc(),
      guideVladimirKazakov);
  batch.set(getIt<FirebaseFirestore>().collection("Guide").doc(),
      guideMariyaGolovan);
  batch.set(getIt<FirebaseFirestore>().collection("Guide").doc(),
      guideGrygoryiKurochkin);
  batch.set(getIt<FirebaseFirestore>().collection("Guide").doc(),
      guideVolodymyrMurashkin);
  // batch.set(getIt<FirebaseFirestore>().collection("Guide").doc(), guideVolodymyrOgur);
  // batch.set(getIt<FirebaseFirestore>().collection("Guide").doc(), guideViktoriyaTrotner);
  // batch.set(getIt<FirebaseFirestore>().collection("Guide").doc(), guideOlenaGalych);

  final sightGroup1 = <String, dynamic>{
    "name": "industrial",
    "lang": "uk",
    "title": "Індустріальні",
    "subtitle": "Індустріальна спадщина",
    "icon": "assets/icons/sight_groups/industrial.png",
  };
  final sightGroup2 = <String, dynamic>{
    "name": "art",
    "lang": "uk",
    "title": "Мистецькі",
    "subtitle": "Обʼєкти монументального мистецтва",
    "icon": "assets/icons/sight_groups/art.png",
  };
  final sightGroup3 = <String, dynamic>{
    "name": "historical",
    "lang": "uk",
    "title": "Історичні",
    "subtitle": "Обʼєкти історії та архітектури",
    "icon": "assets/icons/sight_groups/historical.png",
  };
  final sightGroup4 = <String, dynamic>{
    "name": "featured",
    "lang": "uk",
    "title": "Візитівки міста",
    "icon": "assets/icons/Coat_of_Arms_of_Kryvyy_Rih.png",
  };
  batch.set(
      getIt<FirebaseFirestore>().collection("SightGroup").doc(), sightGroup1);
  batch.set(
      getIt<FirebaseFirestore>().collection("SightGroup").doc(), sightGroup2);
  batch.set(
      getIt<FirebaseFirestore>().collection("SightGroup").doc(), sightGroup3);
  batch.set(
      getIt<FirebaseFirestore>().collection("SightGroup").doc(), sightGroup4);

  final locationType1 = <String, dynamic>{
    "lang": "uk",
    "title": "Міська забудова",
    "name": "city_building",
  };
  final locationType2 = <String, dynamic>{
    "lang": "uk",
    "title": "Карʼєр",
    "name": "quarry",
    "icon": "assets/icons/location_types/quarry_mine_pit.png",
  };
  final locationType3 = <String, dynamic>{
    "lang": "uk",
    "title": "Провалля шахти",
    "name": "mine_pit",
    "icon": "assets/icons/location_types/quarry_mine_pit.png",
  };
  final locationType4 = <String, dynamic>{
    "lang": "uk",
    "title": "Відвал",
    "name": "dump",
    "icon": "assets/icons/location_types/dump.png",
  };
  final locationType5 = <String, dynamic>{
    "lang": "uk",
    "title": "Шахта",
    "name": "mine",
    "icon": "assets/icons/location_types/mine.png",
  };
  final locationType6 = <String, dynamic>{
    "lang": "uk",
    "title": "Завод",
    "name": "factory",
    "icon": "assets/icons/location_types/factory.png",
  };
  final locationType7 = <String, dynamic>{
    "lang": "uk",
    "title": "Залізничний вокзал",
    "name": "railway_station",
    "icon": "assets/icons/location_types/railway_station.png",
  };
  final locationType8 = <String, dynamic>{
    "lang": "uk",
    "title": "Автовокзал",
    "name": "bus_station",
    "icon": "assets/icons/location_types/bus_station.png",
  };
  final locationType9 = <String, dynamic>{
    "lang": "uk",
    "title": "Аеропорт",
    "name": "airport",
    "icon": "assets/icons/location_types/airport.png",
  };
  final locationType10 = <String, dynamic>{
    "lang": "uk",
    "title": "Громадська вбиральня",
    "name": "public_toilet",
    "subtitle": "WC",
    "icon": "assets/icons/location_types/public_toilet.png",
  };
  final locationType11 = <String, dynamic>{
    "lang": "uk",
    "title": "Станція швидкісного трамваю",
    "name": "subway_station",
    "icon": "assets/icons/location_types/subway_station.png",
  };
  final locationType12 = <String, dynamic>{
    "lang": "uk",
    "title": "Муніципальний орган управління",
    "name": "municipal_government",
    "icon": "assets/icons/location_types/municipal_government.png",
  };
  final locationType13 = <String, dynamic>{
    "lang": "uk",
    "title": "Заклад культури",
    "name": "cultural_institution",
    "subtitle": "театри, кінотеатри, палаци культури",
    "icon": "assets/icons/location_types/cultural_institution.png",
  };
  final locationType14 = <String, dynamic>{
    "lang": "uk",
    "title": "Музей",
    "name": "museum",
    "icon": "assets/icons/location_types/museum.png",
  };
  final locationType15 = <String, dynamic>{
    "lang": "uk",
    "title": "Заклад харчування",
    "name": "dining",
    "icon": "assets/icons/location_types/dining.png",
  };
  final locationType16 = <String, dynamic>{
    "lang": "uk",
    "title": "Торгівельний заклад, супермаркет",
    "name": "mall",
    "icon": "assets/icons/location_types/mall.png",
  };
  final locationType17 = <String, dynamic>{
    "lang": "uk",
    "title": "Місце відпочинку",
    "name": "relax_place",
    "icon": "assets/icons/location_types/relax_place.png",
  };
  final locationType18 = <String, dynamic>{
    "lang": "uk",
    "title": "Обʼєкт природи",
    "name": "nature_place",
    "icon": "assets/icons/location_types/nature_place.png",
  };
  final locationType19 = <String, dynamic>{
    "lang": "uk",
    "title": "Місце для дайвінгу",
    "name": "diving_place",
    "icon": "assets/icons/location_types/diving_place.png",
  };
  final locationType20 = <String, dynamic>{
    "lang": "uk",
    "title": "Цирк",
    "name": "circus",
    "icon": "assets/icons/location_types/circus.png",
  };
  final locationType21 = <String, dynamic>{
    "lang": "uk",
    "title": "Культова споруда",
    "subtitle": "православні храми, костели, синагоги",
    "name": "cult_building",
    "icon": "assets/icons/location_types/cult_building.png",
  };
  batch.set(getIt<FirebaseFirestore>().collection("LocationType").doc(),
      locationType1);
  batch.set(getIt<FirebaseFirestore>().collection("LocationType").doc(),
      locationType2);
  batch.set(getIt<FirebaseFirestore>().collection("LocationType").doc(),
      locationType3);
  batch.set(getIt<FirebaseFirestore>().collection("LocationType").doc(),
      locationType4);
  batch.set(getIt<FirebaseFirestore>().collection("LocationType").doc(),
      locationType5);
  batch.set(getIt<FirebaseFirestore>().collection("LocationType").doc(),
      locationType6);
  batch.set(getIt<FirebaseFirestore>().collection("LocationType").doc(),
      locationType7);
  batch.set(getIt<FirebaseFirestore>().collection("LocationType").doc(),
      locationType8);
  batch.set(getIt<FirebaseFirestore>().collection("LocationType").doc(),
      locationType9);
  batch.set(getIt<FirebaseFirestore>().collection("LocationType").doc(),
      locationType10);
  batch.set(getIt<FirebaseFirestore>().collection("LocationType").doc(),
      locationType11);
  batch.set(getIt<FirebaseFirestore>().collection("LocationType").doc(),
      locationType12);
  batch.set(getIt<FirebaseFirestore>().collection("LocationType").doc(),
      locationType13);
  batch.set(getIt<FirebaseFirestore>().collection("LocationType").doc(),
      locationType14);
  batch.set(getIt<FirebaseFirestore>().collection("LocationType").doc(),
      locationType15);
  batch.set(getIt<FirebaseFirestore>().collection("LocationType").doc(),
      locationType16);
  batch.set(getIt<FirebaseFirestore>().collection("LocationType").doc(),
      locationType17);
  batch.set(getIt<FirebaseFirestore>().collection("LocationType").doc(),
      locationType18);
  batch.set(getIt<FirebaseFirestore>().collection("LocationType").doc(),
      locationType19);
  batch.set(getIt<FirebaseFirestore>().collection("LocationType").doc(),
      locationType20);
  batch.set(getIt<FirebaseFirestore>().collection("LocationType").doc(),
      locationType21);

  final guidedTourType1 = <String, dynamic>{
    "lang": "uk",
    "title": "Оглядові",
    "name": "observe_tour",
  };
  final guidedTourType2 = <String, dynamic>{
    "lang": "uk",
    "title": "Екологічні",
    "name": "eco_tour",
  };
  final guidedTourType3 = <String, dynamic>{
    "lang": "uk",
    "title": "Індустріальні",
    "name": "industrial_tour",
  };
  final guidedTourType4 = <String, dynamic>{
    "lang": "uk",
    "title": "Історичні",
    "name": "historical_tour",
  };
  final guidedTourType5 = <String, dynamic>{
    "lang": "uk",
    "title": "Природничі",
    "name": "nature_tour",
  };
  final guidedTourType6 = <String, dynamic>{
    "lang": "uk",
    "title": "Екстремальні",
    "name": "extreme_tour",
  };
  batch.set(getIt<FirebaseFirestore>().collection("GuidedTourType").doc(),
      guidedTourType1);
  batch.set(getIt<FirebaseFirestore>().collection("GuidedTourType").doc(),
      guidedTourType2);
  batch.set(getIt<FirebaseFirestore>().collection("GuidedTourType").doc(),
      guidedTourType3);
  batch.set(getIt<FirebaseFirestore>().collection("GuidedTourType").doc(),
      guidedTourType4);
  batch.set(getIt<FirebaseFirestore>().collection("GuidedTourType").doc(),
      guidedTourType5);
  batch.set(getIt<FirebaseFirestore>().collection("GuidedTourType").doc(),
      guidedTourType6);

  final location1 = <String, dynamic>{
    "city_id": 1,
    "lang": "uk",
    "lat": 47.89535955990847,
    "lng": 33.31045461054179,
    "title": "Геологічна памʼятка природи \"Скелі МОДРу\"",
    "subtitle": "Памʼятка природи загальнодержавного значення",
    "description":
    "Утворена у 1985 році. Площа - 62 га. Охороняються природні відслонення залізистих кварцитів на правому і високому лівому берегах ріки Інгулець, ділянки природних степових ландшафтів.",
    "sort_order": 3,
    "location_type": {
      "title": "Обʼєкт природи",
      "name": "nature_place",
      "icon": "assets/icons/location_types/nature_place.png",
    },
    "top": true,
    "head_image":
    "https://firebasestorage.googleapis.com/v0/b/ets-com.appspot.com/o/images%2Flocations%2Fskeli_modru.png?alt=media",
    "gallery_images": [
      "https://firebasestorage.googleapis.com/v0/b/ets-com.appspot.com/o/images%2Flocations%2Fskeli_modru%2F21_big.jpeg?alt=media&token=764af230-76e9-4d0b-96ae-226e6b3ec93e",
      "https://firebasestorage.googleapis.com/v0/b/ets-com.appspot.com/o/images%2Flocations%2Fskeli_modru%2FCRW_7565-8.jpeg?alt=media&token=c4a5fece-cec2-4bc3-9f2a-b5ef18ef59eb",
      "https://firebasestorage.googleapis.com/v0/b/ets-com.appspot.com/o/images%2Flocations%2Fskeli_modru%2FMODR_Skeli8.jpeg?alt=media&token=84a74ff9-117d-4ae4-8b7d-6d9ecc8b254c",
    ]
  };
  final location2 = <String, dynamic>{
    "city_id": 1,
    "lang": "uk",
    "lat": 48.14765298552269,
    "lng": 33.58091574031731,
    "title": "Криворізький ботанічний сад НАН України",
    "subtitle": "Обʼєкт природно-заповідного фонду",
    "description":
    "Заснований у 1981 році. Розташований на схилі балки Приворотної. Площа 52,4 га. Має дендрарій, розарій, сад бузку та садового жасмину, оренжереї, ставок, упорядковані алеї. Унікальна колекція рідкісних і зникаючих рослин з понад 180 видів.",
    "sort_order": 2,
    "location_type": {
      "title": "Місце відпочинку",
      "name": "relax_place",
      "icon": "assets/icons/location_types/relax_place.png",
    },
    "sight_group": {
      "title": "Візитівки міста",
      "name": "featured",
      "icon": "assets/icons/Coat_of_Arms_of_Kryvyy_Rih.png",
    },
    "address": "вулиця Маршака, 50",
    "phone": "+38 (063) 262 5572",
    "schedule": [
      {
        "week_day": "Щодня",
        "from_hour": 8,
        "from_minute": 0,
        "to_hour": 20,
        "to_minute": 0,
      },
    ],
    "top": true,
    "head_image":
    "https://firebasestorage.googleapis.com/v0/b/ets-com.appspot.com/o/images%2Flocations%2Fbotsad.png?alt=media",
    "gallery_images": [
      "https://firebasestorage.googleapis.com/v0/b/ets-com.appspot.com/o/images%2Flocations%2Fbotsad%2F1936049_800x600_10182_800x600_IMG_20140927_175555.jpeg?alt=media&token=4b528329-ae36-42b1-a9fe-d67b277a4237",
      "https://firebasestorage.googleapis.com/v0/b/ets-com.appspot.com/o/images%2Flocations%2Fbotsad%2F2215604_800x600_IMG_20140927_175436.jpeg?alt=media&token=368684bc-ac37-4b4b-89f0-22e4f6183618",
      "https://firebasestorage.googleapis.com/v0/b/ets-com.appspot.com/o/images%2Flocations%2Fbotsad%2F2705857_800x600_IMG_3472.jpeg?alt=media&token=0562c3e2-86db-435b-920c-f840934786c6",
      "https://firebasestorage.googleapis.com/v0/b/ets-com.appspot.com/o/images%2Flocations%2Fbotsad%2FMG_6848.jpeg?alt=media&token=f58b713e-be52-4619-925c-429016cccab1",
      "https://firebasestorage.googleapis.com/v0/b/ets-com.appspot.com/o/images%2Flocations%2Fbotsad%2F_1_15153956094480-AD8.jpeg?alt=media&token=c79196f5-2dfa-4015-b464-e501c14b9fc3",
      "https://firebasestorage.googleapis.com/v0/b/ets-com.appspot.com/o/images%2Flocations%2Fbotsad%2Fimage_5aa57a23d36b00.15089642.jpg?alt=media&token=71c85cad-7c01-488a-89db-755e9b43e693",
    ]
  };
  final location3 = <String, dynamic>{
    "city_id": 1,
    "lang": "uk",
    "lat": 47.897939711088895,
    "lng": 33.33299116239597,
    "title": "Човнова станція",
    "subtitle": "Візитівка Кривого Рогу",
    "description":
    "Човнова станція побудована в середині ХХ століття на лівому березі річки в парку імені Федора Мершавцева і була відкрита в травні 1957 року. Над павільйоном самої станції працювали архітектор Василь Суманеєв і скульптор Леонід Пержа. Ліпленням займалися Анатолій Ярошенко та В'ячеслав Чиж. Станція стала головним об'єктом відвідування для молодят. Не один десяток весіль пройшов через цей куточок Кривого Рогу, а листівки, марки і фотографії із зображенням пам'ятки можна було купити в будь-якому поштовому відділенні. Влітку на станції функціонує прокат човнів і катамаранів. На даний момент, завдяки міській владі, човнова станція зарахована до списку пам'яток архітектури на рівні міста.",
    "sort_order": 1,
    "location_type": {
      "title": "Місце відпочинку",
      "name": "relax_place",
      "icon": "assets/icons/location_types/relax_place.png",
    },
    "sight_group": {
      "title": "Візитівки міста",
      "name": "featured",
      "icon": "assets/icons/Coat_of_Arms_of_Kryvyy_Rih.png",
    },
    "address": "7A, вулиця Грабовського, 7А",
    "top": true,
    "head_image":
    "https://firebasestorage.googleapis.com/v0/b/ets-com.appspot.com/o/images%2Flocations%2Fkrlodochnayastanciya.jpeg?alt=media",
    "gallery_images": [
      "https://firebasestorage.googleapis.com/v0/b/ets-com.appspot.com/o/images%2Flocations%2Fboat_station%2Fboat_station1.jpeg?alt=media&token=d9a716a2-c02c-4af8-8389-20e189821abc",
      "https://firebasestorage.googleapis.com/v0/b/ets-com.appspot.com/o/images%2Flocations%2Fboat_station%2Fboat_station2.jpeg?alt=media&token=d9674eb6-8a99-452e-9c9c-8047ee484e4b",
      "https://firebasestorage.googleapis.com/v0/b/ets-com.appspot.com/o/images%2Flocations%2Fboat_station%2Fboat_station3.jpeg?alt=media&token=b2e1d445-3fb1-4337-8fc8-15df0250e8f2",
      "https://firebasestorage.googleapis.com/v0/b/ets-com.appspot.com/o/images%2Flocations%2Fboat_station%2Fboat_station4.jpeg?alt=media&token=24c2acb9-f68c-49a4-bbb0-2236bd5d766e",
      "https://firebasestorage.googleapis.com/v0/b/ets-com.appspot.com/o/images%2Flocations%2Fboat_station%2Fboat_station5.jpeg?alt=media&token=399d1ecf-9731-41f6-bea4-5d2bfbcda057",
      "https://firebasestorage.googleapis.com/v0/b/ets-com.appspot.com/o/images%2Flocations%2Fboat_station%2Fboat_station6.jpeg?alt=media&token=8f18522f-a1c0-4490-a7ec-6ebe6c00d9a8",
      "https://firebasestorage.googleapis.com/v0/b/ets-com.appspot.com/o/images%2Flocations%2Fboat_station%2Fboat_station7.jpeg?alt=media&token=a39aff72-d1be-4989-845d-eeb8be5128ad",
    ],
  };
  final location4 = <String, dynamic>{
    "city_id": 1,
    "lang": "uk",
    "lat": 47.910609084554196,
    "lng": 33.39164757973962,
    "title": "95-й квартал",
    "subtitle": "Візитівка Кривого Рогу",
    "description":
    "95-й кварта́л — місцевість в Кривому Розі, розташована на межі Саксаганського та Металургійного районів, на лівому березі річки Саксагань. Центр кварталу — площа Горького, що утворена перехрестям проспектів Гагаріна, Металургів, Миру і вулиці Волгоградської. Площа 95-го кварталу є популярним місцем зустрічей мешканців, що обумовлено вигідним географічним розташуванням та зручною транспортною розв'язкою.",
    "sort_order": 4,
    "location_type": {
      "title": "Місце відпочинку",
      "name": "relax_place",
      "icon": "assets/icons/location_types/relax_place.png",
    },
    "sight_group": {
      "title": "Візитівки міста",
      "name": "featured",
      "icon": "assets/icons/Coat_of_Arms_of_Kryvyy_Rih.png",
    },
    "address": "площа Горького",
    "top": false,
    "head_image":
    "https://firebasestorage.googleapis.com/v0/b/ets-com.appspot.com/o/images%2Flocations%2F95kvartal.jpeg?alt=media&token=0b015827-1ca4-429b-b364-8769e9b97d89",
    "gallery_images": [
      "https://firebasestorage.googleapis.com/v0/b/ets-com.appspot.com/o/images%2Flocations%2F95kvartal%2F85_big.jpeg?alt=media&token=a3c1b7f5-6982-4201-8664-5bb75bd6c835",
      "https://firebasestorage.googleapis.com/v0/b/ets-com.appspot.com/o/images%2Flocations%2F95kvartal%2F87_big.jpeg?alt=media&token=0e60ccab-8ebe-447c-a2bb-ecb4541f66a4",
      "https://firebasestorage.googleapis.com/v0/b/ets-com.appspot.com/o/images%2Flocations%2F95kvartal%2F92_big.jpeg?alt=media&token=c97ff197-2be6-4ee4-bd47-84954144c75c",
    ],
  };
  final location5 = <String, dynamic>{
    "city_id": 1,
    "lang": "uk",
    "lat": 47.90510445959514,
    "lng": 33.392009204485824,
    "title": "Квітковий годинник",
    "subtitle": "Візитівка Кривого Рогу",
    "description":
    "Найбільший квітковий годинник в Європі. Всередині знаходиться інтерактивний історичний музей. Годинник був створений у рамках проекту «Місто без околиць». Шедевральна споруда зайняла місце посеред облаштованого в європейському стилі парку Героїв на проспекті Металургів. Основою композиції годинника став герб міста Кривий Ріг, розташований на темно-зеленому тлі. Малюнок створений за допомогою 22 тисяч квітів шести видів.",
    "sort_order": 5,
    "location_type": {
      "title": "Місце відпочинку",
      "name": "relax_place",
      "icon": "assets/icons/location_types/relax_place.png",
    },
    "sight_group": {
      "title": "Візитівки міста",
      "name": "featured",
      "icon": "assets/icons/Coat_of_Arms_of_Kryvyy_Rih.png",
    },
    "address": "просп. Металургів",
    "top": false,
    "head_image":
    "https://firebasestorage.googleapis.com/v0/b/ets-com.appspot.com/o/images%2Flocations%2Fflower_clock2.jpeg?alt=media&token=53607917-9106-4ba4-83a8-58e54b475cb9",
    "gallery_images": [
      "https://firebasestorage.googleapis.com/v0/b/ets-com.appspot.com/o/images%2Flocations%2Fflower_clock%2Fflower_clock1.jpeg?alt=media&token=a7ef03d7-b657-4a16-bb4a-fefa5ca81124",
      "https://firebasestorage.googleapis.com/v0/b/ets-com.appspot.com/o/images%2Flocations%2Fflower_clock%2Fflower_clock3.jpeg?alt=media&token=b346eeda-0589-45b6-bf5d-1721317cff85",
      "https://firebasestorage.googleapis.com/v0/b/ets-com.appspot.com/o/images%2Flocations%2Fflower_clock%2Fflower_clock2.jpeg?alt=media&token=d962c08b-c1da-4a84-a3a7-e1dcdd402a66",
    ],
  };
  final location6 = <String, dynamic>{
    "city_id": 1,
    "lang": "uk",
    "lat": 47.91365383445,
    "lng": 33.349154514110765,
    "title": "Проспект Поштовий",
    "subtitle": "Візитівка Кривого Рогу",
    "description":
    "Проспект Поштовий — проспект у Центрально-Міському районі Кривого Рогу. Це одна з найстаріших вулиць міста, що виникла в останній чверті XVIII століття. Проспект розташований в центральній частині історичного ядра Кривого Рогу та починається від вулиці Свято-Миколаївської (раніше вул. Миколаївська), проходить наскрізь через площу Визволення. Далі прямує лівим берегом річки Саксагань, паралельно старому річищу. Загальна довжина проспекту становить 3 км.",
    "sort_order": 6,
    "location_type": {
      "title": "Місце відпочинку",
      "name": "relax_place",
      "icon": "assets/icons/location_types/relax_place.png",
    },
    "sight_group": {
      "title": "Візитівки міста",
      "name": "featured",
      "icon": "assets/icons/Coat_of_Arms_of_Kryvyy_Rih.png",
    },
    "address": "просп. Поштовий",
    "top": false,
    "head_image":
    "https://firebasestorage.googleapis.com/v0/b/ets-com.appspot.com/o/images%2Flocations%2Fprosp_poshtovyi%2Fprosp_poshtovyi3.jpeg?alt=media&token=7e3352f9-cbba-4e2a-a043-832ccdeed8b5",
    "gallery_images": [
      "https://firebasestorage.googleapis.com/v0/b/ets-com.appspot.com/o/images%2Flocations%2Fprosp_poshtovyi%2Fprosp_poshtovyi.jpeg?alt=media&token=dd3ac61c-8a2c-4df5-8e3d-e1ea1b305268",
      "https://firebasestorage.googleapis.com/v0/b/ets-com.appspot.com/o/images%2Flocations%2Fprosp_poshtovyi%2Fprosp_poshtovyi2.jpeg?alt=media&token=57c14197-6ea0-46cf-863b-614ffd3c59c3",
      "https://firebasestorage.googleapis.com/v0/b/ets-com.appspot.com/o/images%2Flocations%2Fprosp_poshtovyi%2Fprosp_poshtovyi4.jpeg?alt=media&token=23d1b0df-f302-42a9-a6f9-50347e09c2a3",
    ],
  };
  final location7 = <String, dynamic>{
    "city_id": 1,
    "lang": "uk",
    "lat": 47.90558488192981,
    "lng": 33.39570252711817,
    "title": "Козак Ріг",
    "subtitle": "Візитівка Кривого Рогу",
    "description":
    "Памʼятник легендарному засновнику міста - козаку Кривому Рогу",
    "sort_order": 7,
    "location_type": {
      "title": "Місце відпочинку",
      "name": "relax_place",
      "icon": "assets/icons/location_types/relax_place.png",
    },
    "sight_group": {
      "title": "Візитівки міста",
      "name": "featured",
      "icon": "assets/icons/Coat_of_Arms_of_Kryvyy_Rih.png",
    },
    "address": "вулиця Героїв АТО",
    "top": true,
    "head_image":
    "https://firebasestorage.googleapis.com/v0/b/ets-com.appspot.com/o/images%2Flocations%2Fkozak_rig%2Fkozak_rig2.jpeg?alt=media&token=46878fbf-a4b3-4915-a484-55a43328e7e6",
    "gallery_images": [
      "https://firebasestorage.googleapis.com/v0/b/ets-com.appspot.com/o/images%2Flocations%2Fkozak_rig%2Fkozak_rig.jpeg?alt=media&token=781f7e97-54f4-4ad3-a49e-077d980e3676",
      "https://firebasestorage.googleapis.com/v0/b/ets-com.appspot.com/o/images%2Flocations%2Fkozak_rig%2Fkozak_rig1.jpeg?alt=media&token=12e0ffe3-58b3-4af2-9fcd-083dd76dcc4e",
      "https://firebasestorage.googleapis.com/v0/b/ets-com.appspot.com/o/images%2Flocations%2Fkozak_rig%2Fkozak_rig4.jpeg?alt=media&token=f050cdf3-e7ef-4244-b8cc-88459302c67d",
    ],
  };
  final location8 = <String, dynamic>{
    "city_id": 1,
    "lang": "uk",
    "lat": 47.83908264782559,
    "lng": 33.308519020023375,
    "title": "Кар’єр Південного ГЗК",
    "subtitle": "Візитівка Кривого Рогу",
    "description":
    "Південний гірничо-збагачувальний кар’єр (ПГЗК) – перший комбінат з видобутку залізної руди який був відкритий в Кривому Розі ще в 1955 році. Це єдине в країні підприємство, що видобуває агломерат. Знаходиться воно в південній частині Дніпропетровської області  – звідси походить і назва цього кар’єру. В цьому регіоні знаходяться найбільші поклади залізної руди. За рік на південному гірничо-збагачувальному кар’єрі видобувається приблизно 9 млн. тон залізорудного концентрату та 5 млн. тон агломерату. Це приблизно 20% від загального об’єму видобутку в країні!",
    "sort_order": 8,
    "location_type": {
      "title": "Карʼєр",
      "name": "quarry",
      "icon": "assets/icons/location_types/quarry_mine_pit.png",
    },
    "sight_group": {
      "title": "Візитівки міста",
      "name": "featured",
      "icon": "assets/icons/Coat_of_Arms_of_Kryvyy_Rih.png",
    },
    "address": "Кривий Ріг",
    "top": true,
    "youtube_url": "https://youtu.be/zHOmJH1-QgM",
    "head_image":
    "https://firebasestorage.googleapis.com/v0/b/ets-com.appspot.com/o/images%2Flocations%2Fquarry_yugok%2Fquarry_yugok.jpeg?alt=media&token=8a9c40fa-5c44-4b34-a2a4-5f663411844a",
    "gallery_images": [
      "https://firebasestorage.googleapis.com/v0/b/ets-com.appspot.com/o/images%2Flocations%2Fquarry_yugok%2Fquarry_yugok1.jpeg?alt=media&token=2d93e17c-721f-4b3c-9776-9d0ef02d158c",
      "https://firebasestorage.googleapis.com/v0/b/ets-com.appspot.com/o/images%2Flocations%2Fquarry_yugok%2Fquarry_yugok2.jpeg?alt=media&token=9c524532-e1f9-4708-9474-569a2583c655",
      "https://firebasestorage.googleapis.com/v0/b/ets-com.appspot.com/o/images%2Flocations%2Fquarry_yugok%2Fquarry_yugok4.jpeg?alt=media&token=81232d04-8e62-4ba4-aaf9-803b130aab05",
      "https://firebasestorage.googleapis.com/v0/b/ets-com.appspot.com/o/images%2Flocations%2Fquarry_yugok%2Fquarry_yugok3.jpeg?alt=media&token=172425d2-ca6b-4b7e-90ef-be1d045d1244",
      "https://firebasestorage.googleapis.com/v0/b/ets-com.appspot.com/o/images%2Flocations%2Fquarry_yugok%2Fquarry_yugok5.jpeg?alt=media&token=ee88e029-1d6c-4711-bd9c-acea8f5e42f7",
    ],
  };
/*
    final location9 = <String, dynamic>{
      "city_id": 1,
      "lang": "uk",
      "lat": 4,
      "lng": 3,
      "title": "",
      "subtitle": "Візитівка Кривого Рогу",
      "description": "",
      "sort_order": 1,
      "location_type": {
        "title": "Місце відпочинку",
        "name": "relax_place",
        "icon": "assets/icons/location_types/relax_place.png",
      },
      "sight_group": {
        "title": "Візитівки міста",
        "name": "featured",
        "icon": "assets/icons/Coat_of_Arms_of_Kryvyy_Rih.png",
      },
      "address": "",
      "top": false,
      "head_image": "",
      "gallery_images": [
        "",
        "",
        "",
      ],
    };
    final location10 = <String, dynamic>{
      "city_id": 1,
      "lang": "uk",
      "lat": 4,
      "lng": 3,
      "title": "",
      "subtitle": "Візитівка Кривого Рогу",
      "description": "",
      "sort_order": 1,
      "location_type": {
        "title": "Місце відпочинку",
        "name": "relax_place",
        "icon": "assets/icons/location_types/relax_place.png",
      },
      "sight_group": {
        "title": "Візитівки міста",
        "name": "featured",
        "icon": "assets/icons/Coat_of_Arms_of_Kryvyy_Rih.png",
      },
      "address": "",
      "top": false,
      "head_image": "",
      "gallery_images": [
        "",
        "",
        "",
      ],
    };
*/
  batch.set(
      getIt<FirebaseFirestore>().collection("Location").doc(), location1);
  batch.set(
      getIt<FirebaseFirestore>().collection("Location").doc(), location2);
  batch.set(
      getIt<FirebaseFirestore>().collection("Location").doc(), location3);
  batch.set(
      getIt<FirebaseFirestore>().collection("Location").doc(), location4);
  batch.set(
      getIt<FirebaseFirestore>().collection("Location").doc(), location5);
  batch.set(
      getIt<FirebaseFirestore>().collection("Location").doc(), location6);
  batch.set(
      getIt<FirebaseFirestore>().collection("Location").doc(), location7);
  batch.set(
      getIt<FirebaseFirestore>().collection("Location").doc(), location8);
  // batch.set(getIt<FirebaseFirestore>().collection("Location").doc(), location9);
  // batch.set(getIt<FirebaseFirestore>().collection("Location").doc(), location10);


    final guidedTour1 = <String, dynamic>{
      "city_id": 1,
      "lang": "uk",
      "guided_tour_type": {
        "title": "Індустріальні",
        "name": "industrial",
      },
      "title": "З висоти Бурщицького відвалу",
      "sort_order": 1,
      "head_image": "https://firebasestorage.googleapis.com/v0/b/ets-com.appspot.com/o/images%2Fguided_tours%2Fbursch_dump%2Fbursch_dump9.jpeg?alt=media",
      "locations": [
        {
          "lat": 47.88065761759897,
          "lng": 33.36024231129748,
          "title": "Зупинка Трампарк",
        },
        {
          "lat": 47.8734607715316,
          "lng": 33.358834864252856,
          "title": "",
        },
        {
          "lat": 47.874500,
          "lng": 33.337505,
          "title": "",
        },
        {
          "lat": 47.875378,
          "lng": 33.333417,
          "title": "",
        },
        {
          "lat": 47.87269174377485,
          "lng": 33.333533838731356,
          "title": "Відвал \"Бурщицький\" НКГОКа",
        },
      ],
      "subtitle": "Бурщицький відвал – одна з трьох оглядових точок міста",
      "description": "Бурщицький відвал – високий насипаний велетень, у підніжжя якого розкинулася центральна і південна частини міста. Це об'єкт індустріальної спадщини, який відсипаний колишнім Новокриворізьким гірничо-збагачувальним комбінатом. Відвал нависає над річкою Інгулець. Щоб дістатися на нього, потрібно здійснити пішу прогулянку довжиною 3 кілометри та піднятися на гору. Панорама і масштаби простору просто приголомшують! Історія міста і реалії його сьогодення постають перед очима туриста в усій красі і неповторності! Особливо захоплюючою є панорама міста з висоти Бурщицького відвалу у нічний час, коли Кривий Ріг перетворюється на сузір'я вогнів, що ваблять і притягують допитливе око спостерігача.",
      "top": true,
      "gallery_images": [
        "https://firebasestorage.googleapis.com/v0/b/ets-com.appspot.com/o/images%2Fguided_tours%2Fbursch_dump%2Fbursch_dump1.jpeg?alt=media&token=f16eb193-3727-4ae2-8944-45262fa2ebee",
        "https://firebasestorage.googleapis.com/v0/b/ets-com.appspot.com/o/images%2Fguided_tours%2Fbursch_dump%2Fbursch_dump10.jpeg?alt=media&token=a889a74a-b695-42a2-8ed8-4c2d3ca5a57d",
        "https://firebasestorage.googleapis.com/v0/b/ets-com.appspot.com/o/images%2Fguided_tours%2Fbursch_dump%2Fbursch_dump12.jpeg?alt=media&token=749c5afd-501e-494f-9b1e-a8176ab5e2f5",
        "https://firebasestorage.googleapis.com/v0/b/ets-com.appspot.com/o/images%2Fguided_tours%2Fbursch_dump%2Fbursch_dump14.jpeg?alt=media&token=14ca0a99-5f0a-4135-be4b-46e6b88347a8",
        "https://firebasestorage.googleapis.com/v0/b/ets-com.appspot.com/o/images%2Fguided_tours%2Fbursch_dump%2Fbursch_dump15.jpeg?alt=media&token=7ba559d4-1066-43ff-975b-d09475de1cea",
        "https://firebasestorage.googleapis.com/v0/b/ets-com.appspot.com/o/images%2Fguided_tours%2Fbursch_dump%2Fbursch_dump2.jpeg?alt=media&token=585cbc89-0492-461b-845e-4c0789088bf3",
        "https://firebasestorage.googleapis.com/v0/b/ets-com.appspot.com/o/images%2Fguided_tours%2Fbursch_dump%2Fbursch_dump3.jpeg?alt=media&token=a1517c56-d510-4e71-a58d-3d461884e741",
        "https://firebasestorage.googleapis.com/v0/b/ets-com.appspot.com/o/images%2Fguided_tours%2Fbursch_dump%2Fbursch_dump5.jpeg?alt=media&token=4a67b72f-f988-4810-8426-daec4be68550",
        "https://firebasestorage.googleapis.com/v0/b/ets-com.appspot.com/o/images%2Fguided_tours%2Fbursch_dump%2Fbursch_dump6.jpeg?alt=media&token=34e79dcb-e71b-41a2-a904-5860e185915e",
        "https://firebasestorage.googleapis.com/v0/b/ets-com.appspot.com/o/images%2Fguided_tours%2Fbursch_dump%2Fbursch_dump7.jpeg?alt=media&token=6c37ce4b-5702-4e9d-b840-f2e2aaf3b55c",
        "https://firebasestorage.googleapis.com/v0/b/ets-com.appspot.com/o/images%2Fguided_tours%2Fbursch_dump%2Fbursch_dump8.jpeg?alt=media&token=1fd34729-a422-4014-8c9f-a9cf6d9e5a3f",
      ],
      "guide": {
        "name": {
          "first": "Володимир",
          "last": "Казаков",
          "patronymic": "Леонідович",
        },
        "phone": "+380672918621",
        "spoken_languages": [
          "uk",
          "ru"
        ],
        "avatar": "https://firebasestorage.googleapis.com/v0/b/ets-com.appspot.com/o/images%2Fguides%2Fvladimir_kazakov.png?alt=media",
      },
      "youtube_url": "https://youtu.be/dmJXdoOySUg",
      "length": 7500,
      "schedule": [
        {
          "week_day": "Saturday",
          "from_hour": 12,
          "from_minute": 0,
          "to_hour": 16,
          "to_minute": 0,
        },
        {
          "week_day": "Sunday",
          "from_hour": 12,
          "from_minute": 0,
          "to_hour": 16,
          "to_minute": 0,
        },
      ],
    };

*/

/*
    final guidedTour2 = <String, dynamic>{
      "city_id": 1,
      "lang": "uk",
      "guided_tour_type": "Індустріальні",
      "title": "",
      "head_image": "",
      "locations": [
        {
          "lat": "",
          "lng": "",
          "title": "",
        },
      ],
      "subtitle": "",
      "description": [
        {
          "p": "",
        },
        {
          "p": "",
        },
      ],
      "pricing": "",
      "top": false,
      "gallery_images": [
        "",
      ],
      "guide": {
        "name": {
          "first": "Володимир",
          "last": "Казаков",
          "patronymic": "Леонідович",
        },
        "phone": "+380672918621",
        "spoken_languages": [
          "uk",
          "ru"
        ],
        "avatar": "https://firebasestorage.googleapis.com/v0/b/ets-com.appspot.com/o/images%2Fguides%2Fvladimir_kazakov.png?alt=media",
      },
      "schedule": [
        {
          "week_day": "Monday",
          "from_hour": 10,
          "from_minute": 0,
          "to_hour": 17,
          "to_minute": 0,
        },
      ],
    };

    batch.set(getIt<FirebaseFirestore>().collection("GuidedTour").doc(), guidedTour1);
*/

  await batch.commit();
}
