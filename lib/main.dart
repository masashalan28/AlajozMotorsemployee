import 'package:AlajozMotorsemployee/features/auth/presentation/manager/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/di/dependency_injection.dart';

import 'features/auth/presentation/views/getstarted_screen.dart';

void main() {
 
  di.init();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => UserCubit(di.userRepo)),
      ],
      child: AlajozMotorsemployee(),
    ),
  );
}

class AlajozMotorsemployee extends StatelessWidget {
  const AlajozMotorsemployee({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xFFFFC107),
          selectionColor: Color(0xFFFFF176),
          selectionHandleColor: Color(0xFFFFC107),
        ),
      ),
      title: 'Employee Login',
      debugShowCheckedModeBanner: false,
      home: GetStartedScreen(),
    );
  }
}
