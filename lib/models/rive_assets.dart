import 'package:rive/rive.dart';

class RiveAsset {
  final String src, artboard, stateMachineName, title;
  late SMIBool? input;

  RiveAsset({
    required this.src,
    required this.artboard,
    required this.stateMachineName,
    required this.title, this.input
  });

  set setInput (SMIBool status) {
    input = status;
  }
}

List<RiveAsset> bottomNav = [
  RiveAsset(artboard: 'LIKE/STAR', stateMachineName: 'STAR_Interactivity', title: 'Favorite', src: 'assets/RiveAssets/icons.riv'),
  RiveAsset(artboard: 'TIMER', stateMachineName: 'TIMER_Interactivity', title: 'Movie', src: 'assets/RiveAssets/icons.riv'),
  RiveAsset(artboard: 'USER', stateMachineName: 'USER_Interactivity', title: 'Profile', src: 'assets/RiveAssets/icons.riv'),
  RiveAsset(artboard: 'SEARCH', stateMachineName: 'SEARCH_Interactivity', title: 'Search', src: 'assets/RiveAssets/icons.riv'),
];