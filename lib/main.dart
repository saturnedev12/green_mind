import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:greenmind/cubit/login_cubit.dart';
import 'package:greenmind/data/bloc/weather_cubit.dart';
import 'package:greenmind/data/repository/field/field_repository.dart';
import 'package:greenmind/data/repository/weather/weather_repository.dart';
import 'package:greenmind/data/services/LocationService.dart';
import 'package:greenmind/feature/delimitation/handler.dart';
import 'package:greenmind/feature/home/bloc/home_navigation_cubit.dart';
import 'package:greenmind/maplib/maplib.dart';
import 'package:greenmind/routes.dart';

import 'configs/theme_configs.dart';
import 'data/bloc/create_field_bloc.dart';
import 'feature/delimitation/bloc/map_bloc.dart';

class SimpleBlocDelegate extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);

    print(transition);
  }
}

Future<void> _getCurrentLocation() async {
  await Handler.requestLocationPermission();

  bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
  if (isLocationServiceEnabled) {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    ).then(
      (value) {
        MapUtils.currentPosition = value;
        return value;
      },
    );
    //_path.add(LatLng(position.latitude, position.longitude));
  }
}

Future main() async {
  Bloc.observer = SimpleBlocDelegate();
  await dotenv.load(fileName: ".env");
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.landscapeLeft,
  //   DeviceOrientation.landscapeRight,
  // ]);

  if (MapUtils.icon == null) {
    await MapDisplayFunction.getBytesFromAsset('assets/map/pin.png', 50)
        .then((value) => MapUtils.icon = value);
  }
  runApp(MyApp(fieldRepository: FieldRepository()));
}

class MyApp extends StatelessWidget {
  final FieldRepository fieldRepository;

  const MyApp({Key? key, required this.fieldRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<FieldRepository>(create: (_) => FieldRepository()),
        RepositoryProvider<WeatherRepository>(
            create: (_) => WeatherRepository()),
      ],
      child: MultiBlocProvider(
        providers: <BlocProvider>[
          BlocProvider<CreateFieldBloc>(
              create: (_) => CreateFieldBloc(fieldRepository: fieldRepository)),
          BlocProvider<HomeNavigationCubit>(
              create: (_) => HomeNavigationCubit()),
          BlocProvider<WeatherCubit>(
            create: (context) => WeatherCubit(
                weatherRepository: context.read<WeatherRepository>()),
          ),
          BlocProvider<MapBloc>(
            create: (context) => MapBloc(),
          ),
          BlocProvider<LoginCubit>(
            create: (context) => LoginCubit(),
          )
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: ThemeConfig.lightTheme(context: context),
          darkTheme: ThemeConfig.darkTheme(context: context),
          routerConfig: AppRouter(),
        ),
      ),
    );
  }
}
