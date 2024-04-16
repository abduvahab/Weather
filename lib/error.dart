import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget{
  final String message;
  const ErrorMessage({
    super.key,
    required this.message,
  });
  @override
  Widget build(BuildContext context){
    return Center(
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 40.0,
          color: Colors.red ,
          ),
      ),
    );
  }
}