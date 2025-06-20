// import 'package:fitness/constants.dart';
import 'package:fitness/pages/dashboard/diet_palanner.dart';
import 'package:fitness/pages/dashboard/work_out.dart';
import 'package:fitness/widgets/cardss.dart';
import 'package:fitness/widgets/my_cards.dart';
// import 'package:fitness/widgets/my_drawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //
      //
      //
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          children: [
            MyCards(),
            Cardss(
              largeTxt: "Workout Plans",
              smallTxt: "Make Workout As Your Routine",
              imgpath: "assets/images/men10.png",
              onpress: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WorkOut()),
                );
              },
            ),
            Cardss(
              largeTxt: "Diet Planner",
              smallTxt: "Make Your Best Diet Plan",
              imgpath: "assets/images/salad.png",
              onpress: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DietPlanner()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
