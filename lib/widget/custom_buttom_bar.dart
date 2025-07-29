import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_browser/utils/text_style.dart';

class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar({
    super.key,
    required this.onTap,
    required this.selectedIndex,
    required this.image,
    required this.index,
    required this.text,
    required this.length,
  });

  final void Function()? onTap;
  final int selectedIndex;
  final Widget image;
  final int index;
  final String text;
  final int length;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: const ButtonStyle(
        splashFactory: NoSplash.splashFactory,
        surfaceTintColor: WidgetStatePropertyAll(Colors.transparent),
        backgroundColor: WidgetStatePropertyAll(Colors.transparent),
        padding: WidgetStatePropertyAll(EdgeInsets.zero),
      ),
      onPressed: onTap,
      child: SizedBox(
        width: ScreenUtil().screenWidth / length,
        child: Column(
          children: [
            ColorFiltered(
              colorFilter: ColorFilter.mode(
                selectedIndex == index ? Colors.green : Colors.grey,
                BlendMode.srcIn,
              ),
              child: image,
            ),
            Padding(
              padding: EdgeInsets.only(top: 5.sp, bottom: 7.sp),
              child: Text(
                text,
                style: selectedIndex == index
                    ? CommonTextStyle.f14px400c35
                    : CommonTextStyle.f14px400gry,
              ),
            ),
          ],
        ),
      ),
    );
  }
}