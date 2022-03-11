import 'package:flutter/material.dart';
import 'package:movie_app_fteam/app/modules/search/presenter/widgets/components/custom_app_bar_widget.dart';
import 'package:movie_app_fteam/app/modules/search/presenter/widgets/components/custom_card_component_widget.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  final Color defaultBackgroundColor = const Color(0xff1E2440);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: const CustomAppBar(),
          backgroundColor: defaultBackgroundColor,
          body: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return const CardComponentWidget(cardHeight: 180);
                  },
                  childCount: 2,
                ),
              )
            ],
          )),
    );
  }
}
