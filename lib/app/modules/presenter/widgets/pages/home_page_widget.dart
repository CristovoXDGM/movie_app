import 'package:flutter/material.dart';
import 'package:movie_app_fteam/app/modules/presenter/widgets/components/card_component_widget.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff1E2440),
        appBar: AppBar(
          title: const Icon(Icons.menu),
          backgroundColor: Colors.transparent,
          actions: const [
            Icon(Icons.search),
            SizedBox(width: 10),
            Icon(Icons.filter_alt_sharp),
            SizedBox(width: 10),
          ],
          elevation: 0,
        ),
        body: ListView.builder(
          itemCount: 1,
          itemBuilder: ((context, index) {
            return const CardComponentWidget(
              cardHeight: 200,
              cardWidth: 326,
            );
          }),
        ),
      ),
    );
  }
}
