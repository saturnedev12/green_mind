import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greenmind/data/bloc/weather_cubit.dart';
import 'package:greenmind/tests/weather_small_box.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BlocBuilder<WeatherCubit, RequestState>(
              builder: (context, state) {
                if (state is LoadeState) {
                  return WeatherSmallBox(
                    weatherDataAgregationModel: state.data[0],
                  );
                } else {
                  return Container(
                    width: 330,
                    height: 220,
                    color: CupertinoColors.systemFill,
                    child: const Center(
                      child: CupertinoActivityIndicator(),
                    ),
                  );
                }
              },
            ),
            ElevatedButton(
                onPressed: () async {
                  context.read<WeatherCubit>().fetchWeatherData();
                },
                child: Text('Hello')),
          ],
        ),
      ),
    );
  }
}
