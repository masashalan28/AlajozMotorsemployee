import 'package:AlajozMotorsemployee/core/utils/assets.dart';
import 'package:flutter/material.dart';


class GetStartedImage extends StatelessWidget {
  const GetStartedImage({super.key});

  @override
  Widget build(BuildContext context) {
    return 
    Image.asset(
     AssetsData.getStarted,
     height: 250,
    );
  }
}

//AssetImage(AssetsData.logo),