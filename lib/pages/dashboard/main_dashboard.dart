import 'package:fitness/firebase_services/database_services.dart';
import 'package:fitness/model/user_model.dart';
import 'package:fitness/widgets/my_drawer.dart';
import 'package:flutter/material.dart';
import 'package:fitness/pages/dashboard/diet_palanner.dart';
import 'package:fitness/pages/dashboard/home_page.dart';
import 'package:fitness/pages/dashboard/settings_page.dart';
import 'package:fitness/pages/dashboard/work_out.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainDashboardPage extends StatefulWidget {
  const MainDashboardPage({super.key});

  @override
  State<MainDashboardPage> createState() => _MainDashboardPageState();
}

class _MainDashboardPageState extends State<MainDashboardPage> {
  int _selectedPageIndex = 0;
  final DatabaseService bdservices = DatabaseService();
  final List<Widget> _pages = [
    HomePage(),
    WorkOut(),
    DietPlanner(),
    SettingsPage(),
  ];
  final List<String> _pagesTitle = [
    "Home",
    "WorkOut",
    "Diet Palanner",
    "Profile",
  ];
  void _changePage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void fetchUserInfo() async {
    UserProfile? user = await bdservices.getUserProfile();
    if (user != null) {
      final prefs = await SharedPreferences.getInstance();

      // 2. Write values
      await prefs.setString('id', user.id);
      await prefs.setInt('age', user.age);
      await prefs.setString('name', user.name);
      await prefs.setString('gender', user.gender);
      await prefs.setDouble('height', user.height);
      await prefs.setDouble('weight', user.weight);
      // await prefs.setDouble('gender', user.);
      print('User ID: ${user.id}');
      print('Name: ${user.name}');
      print('Age: ${user.age}');
      print('Age: ${user.weight}');
      print('Age: ${user.height}');
    } else {
      print('No user profile found.');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pagesTitle[_selectedPageIndex]),
        centerTitle: true,
        titleTextStyle: Theme.of(context).textTheme.titleMedium,
      ),
      drawer: MyDrawer(onItemTap: _changePage),
      body: _pages[_selectedPageIndex],
    );
  }
}
