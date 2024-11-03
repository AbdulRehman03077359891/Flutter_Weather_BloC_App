import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_navigation_bar/responsive_navigation_bar.dart';
import 'package:weather_bloc/screens/setting_screen.dart';
import 'package:weather_bloc/screens/weather_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  void _navigateToWeather() {
    setState(() {
      _currentIndex = 0;
      _pageController.jumpToPage(0); // Directly jump to the weather page
    });
  }

  void changeTab(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut, // Customize the curve of the animation
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
        ),
      ),
      body: PageView(
        physics: const BouncingScrollPhysics(),
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: [
          const WeatherScreen(),
          SettingsScreen(
            onNavigateToWeather: _navigateToWeather,
          ),
        ],
      ),
      bottomNavigationBar: ResponsiveNavigationBar(
        borderRadius: 10,
        backgroundOpacity: .4,
        backgroundColor: Colors.grey.shade900,
        selectedIndex: _currentIndex,
        onTabChange: changeTab,
        textStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        navigationBarButtons: const <NavigationBarButton>[
          NavigationBarButton(
            text: 'Weather',
            icon: Icons.cloud,
            backgroundGradient: LinearGradient(
              colors: [Colors.orange, Colors.red, Colors.deepPurple],
            ),
          ),
          NavigationBarButton(
            text: 'Choose Locaton',
            icon: Icons.location_on,
            backgroundGradient: LinearGradient(
              colors: [Colors.deepPurple, Colors.orange],
            ),
          ),
        ],
      ),
    );
  }
}
