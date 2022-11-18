import 'package:flutter/material.dart';
import 'package:xedu/themes/color.dart';

class ErrorDialog extends StatelessWidget {
  final String errorValue;

  const ErrorDialog({Key? key, required this.errorValue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        errorValue,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
      ),
      actions: [
        TextButton(
          onPressed: ()=> Navigator.pop(context), 
          child: Text('kembali')
        )
      ],
    );
  }
}

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(kPrimaryColor),
            backgroundColor: Colors.white,
          ),
          SizedBox(height: 16),
          Text(
            'Loading . . .',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}