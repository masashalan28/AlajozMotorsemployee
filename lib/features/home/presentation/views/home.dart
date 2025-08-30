import 'package:flutter/material.dart';
import 'widgets/body_home.dart';
import 'widgets/drawer_home.dart';

class EmployeeHomeScreen extends StatelessWidget{
  final String employeeName;
  final DateTime loginTime;

  const EmployeeHomeScreen({
    super.key,
    this.employeeName = 'Employee',
    required this.loginTime,
  });




  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar( backgroundColor: Colors.yellow, ),
      drawer: HomeDrawer(employeeName: employeeName),

      body: HomeBody(employeeName: employeeName),
    );
  }

  

  
}
