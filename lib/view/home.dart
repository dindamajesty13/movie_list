import 'package:flutter/material.dart';
import 'package:movie_list/app/app_values.dart';
import 'package:movie_list/utils/rive_utils.dart';
import 'package:movie_list/view/movie_popular_page.dart';
import 'package:movie_list/view/movie_slider_view.dart';
import 'package:movie_list/view/movie_upcoming_page.dart';
import 'package:rive/rive.dart';
import '../components/animated_bar.dart';
import '../models/rive_assets.dart';
import 'now_playing_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  RiveAsset selectedBottomNav = bottomNav.first;
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    MoviePopularPage(),
    MovieUpcomingPage(),
    MovieSliderView(),
    NowPlayingPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(AppPadding.p12),
          margin: const EdgeInsets.symmetric(horizontal: AppSize.s24),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(AppSize.s24)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ...List.generate(bottomNav.length,
                    (index) => GestureDetector(
                onTap: () {
                  bottomNav[index].input!.change(true);
                  if (bottomNav[index] != selectedBottomNav) {
                    setState(() {
                      selectedBottomNav = bottomNav[index];
                      _selectedIndex = index;
                    });
                  }
                  Future.delayed(const Duration(seconds: 1), () {
                    bottomNav[index].input!.change(false);
                  });
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedBar(isActive: bottomNav[index] == selectedBottomNav),
                    SizedBox(
                        height: AppSize.s36,
                        width: AppSize.s36,
                        child: Opacity(
                            opacity: bottomNav[index] == selectedBottomNav ? 1 : 0.5,
                            child: RiveAnimation.asset(
                              bottomNav.first.src,
                              artboard: bottomNav[index].artboard,
                              onInit: (artboard) {
                                StateMachineController controller = RiveUtils.getRiveController(
                                    artboard,
                                    stateMachineName: bottomNav[index].stateMachineName
                                );
                                bottomNav[index].input = controller.findSMI('active') as SMIBool;
                                },
                            )
                        )
                    ),
                  ],
                ),
              ),
              )
            ],
          ),
        ),
      ),
    );
  }
}