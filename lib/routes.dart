import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:greenmind/data/models/weather_data_agregation_model.dart';
import 'package:greenmind/feature/analyse/field/field_component.dart';
import 'package:greenmind/feature/delimitation/delimit_map.dart';
import 'package:greenmind/feature/home/home.dart';
import 'package:greenmind/feature/login_page/login_page.dart';
import 'package:greenmind/feature/login_page/otp_page.dart';
import 'package:greenmind/feature/polygonal_page.dart/polygonal_page.dart';
import 'package:greenmind/feature/vegetation_analyse/vegetation_analyse_page.dart';
import 'package:greenmind/tests/test_page.dart';
import 'package:greenmind/tests/weather_detail_page.dart';

import 'feature/map/map.dart';

class AppRouter extends GoRouter {
  AppRouter()
      : super(
          routes: <RouteBase>[
            GoRoute(
              path: '/',
              builder: (BuildContext context, GoRouterState state) {
                return LoginPage();
              },
              routes: <RouteBase>[
                GoRoute(
                  path: 'otp',
                  builder: (BuildContext context, GoRouterState state) {
                    return OtpPage();
                  },
                ),
                GoRoute(
                  path: 'home',
                  builder: (BuildContext context, GoRouterState state) {
                    return Home();
                  },
                ),

                GoRoute(
                  path: 'polygonal',
                  builder: (BuildContext context, GoRouterState state) {
                    return PolygonalPage(
                      paths: state.extra as List<LatLng>,
                    );
                  },
                ),
                GoRoute(
                  path: 'weatherDetail',
                  builder: (BuildContext context, GoRouterState state) {
                    return WeatherDetailPage(
                      weatherDataAgregationModel:
                          (state.extra as WeatherDataAgregationModel),
                    );
                  },
                ),

                // GoRoute(
                //   path: 'login',
                //   builder: (BuildContext context, GoRouterState state) {
                //     return Login();
                //   },
                // ),
                // GoRoute(
                //   path: 'signin',
                //   builder: (BuildContext context, GoRouterState state) {
                //     return SignIn();
                //   },
                // ),
                // GoRoute(
                //   path: 'singup',
                //   builder: (BuildContext context, GoRouterState state) {
                //     return SignUp();
                //   },
                // ),
                // GoRoute(
                //   path: 'accountSetup',
                //   builder: (BuildContext context, GoRouterState state) {
                //     return AccountSetup();
                //   },
                // ),
                // GoRoute(
                //   path: 'app',
                //   builder: (BuildContext context, GoRouterState state) {
                //     return App();
                //   },
                //   routes: <RouteBase>[
                //     GoRoute(
                //       path: 'profil',
                //       builder: (BuildContext context, GoRouterState state) {
                //         return ProfilPage();
                //       },
                //     ),
                //     GoRoute(
                //       path: 'history',
                //       builder: (BuildContext context, GoRouterState state) {
                //         return HistoryPage();
                //       },
                //     ),
                //     GoRoute(
                //       path: 'track',
                //       builder: (BuildContext context, GoRouterState state) {
                //         return TrackPage();
                //       },
                //     ),
                //     GoRoute(
                //       path: 'notification',
                //       builder: (BuildContext context, GoRouterState state) {
                //         return NotificationPage();
                //       },
                //     ),
                //     GoRoute(
                //       path: 'makeOrder',
                //       builder: (BuildContext context, GoRouterState state) {
                //         return MakeOrderPage();
                //       },
                //     ),
                //   ],
                // ),
                // GoRoute(
                //   path: 'homePage',
                //   builder: (BuildContext context, GoRouterState state) {
                //     return HomePage();
                //   },
                // ),
              ],
            ),
          ],
        );
}



// We use name route
// All our routes will be available here
// final Map<String, WidgetBuilder> routes = {
//    HomeNavigation.routeName: (context) => HomeNavigation(),
//    Home.routeName: (context) => Home(),
//    MapScreen.routeName: (context) => MapScreen(),
   

// };
