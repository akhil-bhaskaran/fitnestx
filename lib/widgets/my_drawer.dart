import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDrawer extends StatefulWidget {
  final Function(int) onItemTap;
  const MyDrawer({super.key, required this.onItemTap});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  String name = '';

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    final pref = await SharedPreferences.getInstance();
    setState(() {
      name = pref.getString("name") ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Column(
          children: [
            DrawerHeader(
              child: Column(
                children: [
                  Text("Hey", style: Theme.of(context).textTheme.bodyMedium),
                  Text(name),
                ],
              ),
            ),
            drawerItem(context, Icons.home, "Home", 0),
            drawerItem(context, Icons.boy_rounded, "Workout", 1),
            drawerItem(context, Icons.food_bank, "Diet Planner", 2),
            drawerItem(context, Icons.settings, "Profile", 3),
          ],
        ),
      ),
    );
  }

  Widget drawerItem(
    BuildContext context,
    IconData icon,
    String title,
    int index,
  ) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      titleTextStyle: Theme.of(
        context,
      ).textTheme.bodyLarge?.copyWith(fontSize: 18),
      onTap: () {
        widget.onItemTap(index);
        Navigator.pop(context);
      },
    );
  }
}
