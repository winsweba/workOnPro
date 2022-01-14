import 'package:decider_app/models/question.dart';
import 'package:flutter/material.dart';

class QuestionCard extends StatelessWidget {
  final Question _question;
  const QuestionCard({ Key? key, required this._question }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Row (
                children: [
                  Padding (
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text('Should I ${_question.query}')
                  )
                ]
              ),
              
            ],
          ) ,
        ),
      ),
    );
  }
}