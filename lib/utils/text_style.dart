import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'colors.dart';

class CommonTextStyle {
  static TextStyle f18px600w = TextStyle(
    color: Colors.grey,
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
    fontFamily: 'OpenSans',
  );

  static TextStyle f18pxBoldG = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.bold,
    color: Colors.green,
  );

  static TextStyle f14px400c35 = TextStyle(
    color: Colors.green, // #FDFFFF
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    fontFamily: 'OpenSans',
  );
  static TextStyle f14px400gry = TextStyle(
    color: Colors.grey, // #FDFFFF
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    fontFamily: 'OpenSans',
  );

  static TextStyle f11px500 = TextStyle(
    color: AllColours.error, // #FDFFFF
    fontSize: 11.sp,
    fontWeight: FontWeight.w500,
    fontFamily: 'OpenSans',
  );
}