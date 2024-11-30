import 'package:flutter/material.dart';

class Budget extends StatelessWidget{
  const Budget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.wallet, size: 25,),
        Text("Budget"),
      ],
    );
  }
}