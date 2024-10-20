import 'package:flutter/material.dart';
import 'weather_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fabulous Weather App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 18, color: Colors.white),
          bodyMedium: TextStyle(fontSize: 16, color: Colors.black54),
        ),
      ),
      home: WeatherHomePage(),
    );
  }
}

class WeatherHomePage extends StatefulWidget {
  @override
  _WeatherHomePageState createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage> {
  final WeatherService _weatherService = WeatherService();
  String _city = 'London'; // Default city
  Map<String, dynamic>? _weatherData;
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _fetchWeather() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null; // Reset error message
    });
    try {
      final data = await _weatherService.fetchWeather(_city);
      setState(() {
        _weatherData = data;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to fetch weather data. Please try again.';
      });
      print(e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white12, Colors.teal[600]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Enter city',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal, width: 2.0),
                ),
              ),
              onSubmitted: (value) {
                setState(() {
                  _city = value;
                  _fetchWeather();
                });
              },
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _errorMessage != null
                ? Text(_errorMessage!, style: TextStyle(color: Colors.red, fontSize: 18))
                : _weatherData != null
                ? WeatherCard(weatherData: _weatherData!)
                : Container(),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _fetchWeather,
              child: const Text('Refresh Weather'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white12,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WeatherCard extends StatelessWidget {
  final Map<String, dynamic> weatherData;

  const WeatherCard({Key? key, required this.weatherData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Colors.white.withOpacity(0.9), // Slightly transparent background
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'City: ${weatherData['name']}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Temperature: ${weatherData['main']['temp']}°C',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 10),
            Text(
              'Weather: ${weatherData['weather'][0]['description']}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 10),
            Text(
              'Cloud Coverage: ${weatherData['clouds']['all']}%',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 10),
            Image.network(
              'http://openweathermap.org/img/wn/${weatherData['weather'][0]['icon']}@2x.png',
              height: 100,
            ),
            const SizedBox(height: 10),

          ],
        ),
      ),
    );
  }
}
