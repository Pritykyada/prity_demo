import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../providers/home_provider.dart';
import '../providers/main_provider.dart';
import '../widget/custom_buttom_bar.dart';

class MainAppScreen extends StatefulWidget {
  const MainAppScreen({super.key});

  @override
  State<MainAppScreen> createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeProvider>().loadProducts();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(
      builder: (context, mainProvider, child) {
        return Scaffold(
          body: mainProvider.screens[mainProvider.currentIndex],
          bottomNavigationBar: SizedBox(
            height: 80.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: List.generate(
                    mainProvider.screens.length,
                        (index) =>  AnimatedContainer(
                      margin: EdgeInsets.only(bottom: 7.h),
                      curve: Curves.easeInOut,
                      height: 2.h,
                      duration: const Duration(milliseconds: 100),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            mainProvider.currentIndex == index?
                            Colors.green : Colors.grey,
                            mainProvider.currentIndex == index?
                            Colors.green : Colors.grey
                          ])),
                      width: ScreenUtil().screenWidth /
                          mainProvider.screens.length,
                    )),
                  ),

                Row(
                  children: List.generate(
                      mainProvider.screens.length,
                        (index) => CustomBottomBar(
                      length:  mainProvider.screens.length,
                      index: index,
                      selectedIndex: mainProvider.currentIndex,
                      onTap: () => mainProvider.setCurrentIndex(index),
                      image: mainProvider.bottomBarItems[index]['image'],
                      text: mainProvider.bottomBarItems[index]['text'],
                    )
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}