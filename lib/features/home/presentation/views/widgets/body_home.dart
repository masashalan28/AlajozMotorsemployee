import 'dart:async';
import 'package:flutter/material.dart';


import 'checkCard_home.dart';

class HomeBody extends StatefulWidget {
  final String employeeName;

  const HomeBody({
    super.key,
    required this.employeeName,
  });

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  DateTime? checkInTime;
  Timer? timer;
  Duration? timeElapsed;

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void startCheckInTimer() {
    setState(() {
      checkInTime = DateTime.now();
      timeElapsed = Duration.zero;
    });

    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        timeElapsed = DateTime.now().difference(checkInTime!);
      });
    });
  }

  void stopCheckInTimer() {
    timer?.cancel();
    setState(() {
      checkInTime = null;
      timeElapsed = null;
    });
  }

  String formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    final seconds = duration.inSeconds % 60;
    return '$hours h : $minutes m : $seconds s';
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome, ${widget.employeeName} ',
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          if (timeElapsed != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                '⏱ Checked in since: ${formatDuration(timeElapsed!)}',
                style: TextStyle(fontSize: 16, color: Colors.green[700]),
              ),
            ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: CheckCard(
                  title: 'Check In',
                  icon: Icons.fingerprint,
                  color: Colors.green,
                  onTap: startCheckInTimer,
                ),
              ),
              Expanded(
                child: CheckCard(
                  title: 'Check Out',
                  icon: Icons.fingerprint,
                  color: Colors.red,
                  onTap: stopCheckInTimer,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }


  }

