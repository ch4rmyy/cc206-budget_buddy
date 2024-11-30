import 'package:flutter/material.dart';

class Expenses extends StatelessWidget{
  const Expenses({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.receipt_long, size: 25,),
        Text("Expenses"),
      ],
    );
  }
}