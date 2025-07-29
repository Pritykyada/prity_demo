import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:product_browser/providers/main_provider.dart';
import 'package:provider/provider.dart';

import '../providers/home_provider.dart';
import '../screen/main_app_screen.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => HomeProvider()),
            ChangeNotifierProvider(create: (_) => MainProvider()),
          ],
          child: const MainAppScreen(),
        );
      },
    ),
  ],
);