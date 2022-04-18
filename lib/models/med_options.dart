import 'dart:ui';

abstract class MedForm {
  static const List = [
    'Tablet',
    'Capsule',
    'Solution',
    'Inhaler',
    'Powder',
    'Drops',
    'Injection',
    'Topical',
    'Other'
  ];
}

abstract class MedStrength {
  static const List = [
    "mg",
    "mcg",
    "IU",
    "mL",
    "g",
    "mcg/ml",
    "mEq",
    "mg/ml",
    "%",
  ];
}

abstract class MedColor {
  static const List = [
    Color(0xffd5d8dc),
    Color(0xffabb2b9),
    Color(0xff566573),
    Color(0xff2c3e50),
    Color(0xffEE45B8),
    Color(0xff45b8ee),
    Color(0xffFFD34D),
    Color(0xffC0392B),
    Color(0xff8E44AD),
    Color(0xff2471A3),
    Color(0xff16A085),
    Color(0xff229954),
    Color(0xffF39C12),
    Color(0xffD35400),
    Color(0xffF5B7B1),
    Color(0xffD7BDE2),
    Color(0xffAED6F1),
    Color(0xffA2D9CE),
    Color(0xff7DCEA0),
    Color(0xffF9E79F),
    Color(0xffF5CBA7),
  ];
}
