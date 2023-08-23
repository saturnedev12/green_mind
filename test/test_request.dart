import 'package:greenmind/data/repository/weather/weather_repository.dart';
import 'package:test/test.dart';

void main() {
  test('Test weather request', () async {
    // Make the request
    final actualResponse = await WeatherRepository().getWeatherBetween();

    // Assert that the response is the same as the expected response
    expect(actualResponse, List<Map>);
  });
}
