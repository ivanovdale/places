import 'package:places/domain/coordinate_point.dart';
import 'package:places/domain/sight.dart';

final List<Sight> sights = [
  Sight(
    id: 1,
    name: 'Кофейня Sibaristica',
    coordinatePoint: CoordinatePoint(
      lat: 30.283861,
      lon: 59.910208,
    ),
    photoUrlList: [
      'https://avatars.mds.yandex.net/get-altay/4538345/2a000001787fa76c069d4eb7050786867628/XXXL',
      'https://www.restoclub.ru/uploads/place_thumbnail_big/6/e/c/8/6ec8ab9d6342b6af1063682566485561.jpg',
      'https://www.restoclub.ru/uploads/place_thumbnail_big/5/c/1/3/5c13e63892ccf8c0e75f50e29e79ca72.jpg',
      'https://fastly.4sqi.net/img/general/600x600/535754786__KJypBcrDvKFoDcogp4bLM7ZLhrKRvYtFtnUOTuNkJw.jpg',
      'https://spb.restoran.ru/upload/resize_cache/editor/378/414_500_1/apmrdpwjni136.jpg',
    ],
    details:
        'Это кофейня, которая затерялась среди кирпичных заводов. Это место, где свежеобжаренный спешелти кофе сразу наливают в чашку. Место, где все еще ощущается дух фабричного прошлого. Мы сохранили индустриальную атмосферу, добавили немного лоска и еды, которая насытит после сложного рабочего дня.',
    type: SightTypes.coffeeShop,
    workTimeFrom: '09:00',
    visitDate: DateTime(2022, 9),
  ),
  Sight(
    id: 2,
    name: 'Остров Новая Голландия',
    coordinatePoint: CoordinatePoint(
      lat: 30.287104,
      lon: 59.92961,
    ),
    photoUrlList: [
      'https://avatars.mds.yandex.net/get-altay/1344805/2a00000164516084f410c679146540fde647/XXXL',
    ],
    details:
        'Остров в Адмиралтейском районе Санкт-Петербурга, ограниченный рекой Мойкой, Крюковым и Адмиралтейским каналами. Кроме того, Новая Голландия - единственный в своём роде памятник промышленной архитектуры раннего классицизма. Площадь острова - 7,8 га.',
    type: SightTypes.park,
    workTimeFrom: '06:00',
    visitDate: DateTime(2022, 9, 5),
  ),
  Sight(
    id: 3,
    name: 'Bolshecoffee roasters',
    coordinatePoint: CoordinatePoint(
      lat: 30.353768,
      lon: 59.927996,
    ),
    photoUrlList: [
      'https://avatars.mds.yandex.net/get-altay/4341149/2a0000017b3b0e09e6fa8c0b9125918cc40d/XXXL',
    ],
    details:
        'Хорошая кофейня с гигантским окном и берлинским интерьером. По выходным тут проходят каппинги и воркшопы.',
    type: SightTypes.coffeeShop,
    workTimeFrom: '08:00',
    visitDate: DateTime(2022, 8, 10),
    visited: true,
  ),
  Sight(
    id: 4,
    name: 'Государственный Эрмитаж',
    coordinatePoint: CoordinatePoint(
      lat: 30.314566,
      lon: 59.939864,
    ),
    photoUrlList: [
      'https://avatars.mds.yandex.net/get-altay/986332/2a000001653f7ed2792b7f067aec94f23f58/XXXL',
    ],
    details:
        'Музей изобразительного и декоративно-прикладного искусства, расположенный в городе Санкт-Петербурге Российской Федерации. Основан 7 декабря 1764 года. Является одним из крупнейших художественных музеев в мире.',
    type: SightTypes.museum,
    workTimeFrom: '10:00',
    visitDate: DateTime(2022, 8, 21),
    visited: true,
  ),
  Sight(
    id: 5,
    name: 'Исаакиевский собор',
    coordinatePoint: CoordinatePoint(
      lat: 30.306274,
      lon: 59.934073,
    ),
    photoUrlList: [
      'https://avatars.mds.yandex.net/get-altay/492546/2a0000015e53320283200bf5224667d93b33/XXXL',
    ],
    details:
        'Крупнейший православный храм Санкт-Петербурга. Расположен на Исаакиевской площади. Кафедральный собор Санкт-Петербургской епархии с 1858 по 1929 год. С 1928 года имеет статус музея.',
    type: SightTypes.museum,
    workTimeFrom: '10:00',
  ),
  Sight(
    id: 6,
    name: 'Эрарта',
    coordinatePoint: CoordinatePoint(
      lat: 30.251621,
      lon: 59.931901,
    ),
    photoUrlList: [
      'https://avatars.mds.yandex.net/get-altay/1525683/2a0000016ae318432cb1a7d265f75f224b7d/XXXL',
    ],
    details:
        'Открытые в трёх странах мира, продвигают современное искусство России в самой стране и за её пределами. Продажа произведений современных авторов в международной сети галерей Эрарты - неотъемлемая часть механизма продвижения искусства, позволяющего расширить географию популяризации художников современной России.',
    type: SightTypes.museum,
    workTimeFrom: '11:00',
    visitDate: DateTime(2022, 8, 14),
    visited: true,
  ),
  Sight(
    id: 7,
    name: 'Парк 300-летия Санкт-Петербурга',
    coordinatePoint: CoordinatePoint(
      lat: 30.230737,
      lon: 59.98431,
    ),
    photoUrlList: [
      'https://avatars.mds.yandex.net/get-altay/406255/2a00000164515ae4f0d433719b80f9cf01bc/XXXL',
    ],
    details:
        'Парк, расположенный в северо-западной части Санкт-Петербурга на границе Приневской низменности в северной части Невской губы. С севера парк ограничен Приморским проспектом и Приморским шоссе, а с востока - Яхтенной улицей. Общая площадь - 38,58 га.',
    type: SightTypes.park,
    workTimeFrom: '05:00',
    visitDate: DateTime(2022, 9, 7),
  ),
];

// Координаты пользователя.
final CoordinatePoint userCoordinates =
    CoordinatePoint(lat: 30.304772, lon: 59.909876);

// Список добавляемых изображений места.
final List<String> photoCarouselOnAddSightScreen = [
  'https://cdn-irec.r-99.com/sites/default/files/imagecache/copyright1/user-images/771233/euxApskGZrOgQ6Wpmwrxww.jpg',
  'https://visit-primorye.ru/upload/resize_cache/webp/upload/medialibrary/92f/image_30_06_21_11_59.webp',
  'https://visit-primorye.ru/upload/resize_cache/webp/iblock/1b6/image_30_06_21_11_59_5.webp',
  'https://visit-primorye.ru/upload/resize_cache/webp/iblock/56b/image_30_06_21_11_59_3.webp',
];

// Новое изображение места.
const String newPhotoOnAddSightScreen =
    'https://visit-primorye.ru/upload/resize_cache/webp/iblock/3c6/1_2.webp';
