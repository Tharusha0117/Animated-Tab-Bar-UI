import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Enhanced Animated Tabs',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.ralewayTextTheme(),
      ),
      home: AnimatedTabBar(),
    );
  }
}

class AnimatedTabBar extends StatefulWidget {
  @override
  _AnimatedTabBarState createState() => _AnimatedTabBarState();
}

class _AnimatedTabBarState extends State<AnimatedTabBar> with TickerProviderStateMixin {
  int _selectedIndex = 0;

  final List<TabInfo> _tabs = [
    TabInfo(
      title: 'Gadget Guru',
      description: 'Like, Share & Subscribe!',
      icon: Icons.home,
      gradient: LinearGradient(colors: [Colors.blueAccent, Colors.cyan]),
      heroTag: 'home',
    ),
    TabInfo(
      title: 'Search',
      description: 'Find what you need',
      icon: Icons.search,
      gradient: LinearGradient(colors: [Colors.greenAccent, Colors.teal]),
      heroTag: 'search',
    ),
    TabInfo(
      title: 'Profile',
      description: 'View your info',
      icon: Icons.person,
      gradient: LinearGradient(colors: [Colors.purpleAccent, Colors.pinkAccent]),
      heroTag: 'profile',
    ),
  ];

  void _onTap(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final currentTab = _tabs[_selectedIndex];

    return Scaffold(
      extendBody: true,
      body: AnimatedSwitcher(
        duration: 600.ms,
        child: TabScreen(
          key: ValueKey(currentTab.title),
          title: currentTab.title,
          description: currentTab.description,
          icon: currentTab.icon,
          gradient: currentTab.gradient,
          heroTag: currentTab.heroTag,
        )
            .animate()
            .fadeIn(duration: 800.ms)
            .slideY(begin: 0.1),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)],
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          currentIndex: _selectedIndex,
          onTap: _onTap,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: List.generate(_tabs.length, (index) {
            final selected = index == _selectedIndex;
            final tab = _tabs[index];

            return BottomNavigationBarItem(
              icon: AnimatedContainer(
                duration: 300.ms,
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: selected ? tab.gradient.colors.first.withOpacity(0.3) : Colors.transparent,
                  shape: BoxShape.circle,
                  boxShadow: selected
                      ? [BoxShadow(color: tab.gradient.colors.first, blurRadius: 12)]
                      : [],
                ),
                child: Icon(
                  tab.icon,
                  size: selected ? 30 : 24,
                  color: selected ? tab.gradient.colors.first : Colors.grey,
                ),
              ),
              label: '',
            );
          }),
        ),
      ),
    );
  }
}

class TabScreen extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final LinearGradient gradient;
  final String heroTag;

  const TabScreen({
    Key? key,
    required this.title,
    required this.description,
    required this.icon,
    required this.gradient,
    required this.heroTag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: heroTag,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(gradient: gradient),
        child: Stack(
          children: [
            // Frosted Glass Background Layer
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Container(
                color: Colors.black.withOpacity(0.1),
              ),
            ),
            Center(
              child: Container(
                padding: EdgeInsets.all(24),
                margin: EdgeInsets.symmetric(horizontal: 32),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.white30),
                  boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 12)],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(icon, size: 140, color: Colors.white),
                    SizedBox(height: 16),
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        fontSize: 36,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ).animate().fadeIn(duration: 600.ms),
                    SizedBox(height: 10),
                    Text(
                      description,
                      style: GoogleFonts.raleway(
                        fontSize: 18,
                        color: Colors.white70,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ).animate().fadeIn().slideY(begin: 0.2),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TabInfo {
  final String title;
  final String description;
  final IconData icon;
  final LinearGradient gradient;
  final String heroTag;

  TabInfo({
    required this.title,
    required this.description,
    required this.icon,
    required this.gradient,
    required this.heroTag,
  });
}
