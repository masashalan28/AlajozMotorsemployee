import 'package:AlajozMotorsemployee/core/widgets/CustomButton.dart';
import 'package:flutter/material.dart';
import '../login_screen.dart';
import 'getStarted_Title.dart';
import 'getStarted_Subtitle.dart';
import 'getstarted_image.dart';

class GetStartedContent extends StatelessWidget {
  const GetStartedContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
       const SizedBox(height: 40),
        const GetStartedImage(),
        const SizedBox(height: 50),
        const GetStartedTitle(),
        const SizedBox(height: 10),
        const GetStartedSubtitle(),
        const Spacer(),
        CustomButton(
          text: 'Get Started',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          },
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
