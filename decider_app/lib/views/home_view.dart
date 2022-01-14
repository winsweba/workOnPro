import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decider_app/extensions/string_extension.dart';
import 'package:decider_app/models/question.dart';
import 'package:decider_app/services/auth_service.dart';
import 'package:decider_app/views/history_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TextEditingController _questionControlller = TextEditingController();

  String _answer = "";

  bool _askBtnActive = false;
  Question _question = Question();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Decider"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {},
              child: const Icon(Icons.shopping_bag),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const HistoryView() ));
              },
              child: const Icon(Icons.history),
            ),
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                const Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Decisions Left ##"),
                ),
                const Spacer(),
                _buildQuestionForm(),
                const Spacer(
                  flex: 3,
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Account Type: Free"),
                ),
                Text("${AuthService().currentUser?.uid}"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionForm() {
    return Column(children: [
      Text("Should I", style: Theme.of(context).textTheme.headline4),
      Padding(
        padding: const EdgeInsets.only(bottom: 10.0, left: 30, right: 30),
        child: TextField(
          decoration: const InputDecoration(
            helperText: 'Enter A Qution',
          ),
          maxLines: null,
          keyboardType: TextInputType.multiline,
          controller: _questionControlller,
          textInputAction: TextInputAction.done,
          onChanged: (value) {
            setState(() {
              _askBtnActive = value.length >= 3 ? true : false;
            });
          },
        ),
      ),
      ElevatedButton(
        onPressed: _askBtnActive == true ? _answerQuestion : null,
        child: Text("Ask"),
      ),
      _questionAndAnswer()
    ]);
  }

  String _getAnser() {
    var anserOptions = ['yes', 'no', 'definitely', 'not rigth now'];

    return anserOptions[Random().nextInt(anserOptions.length)];
  }

  Widget _questionAndAnswer() {
    if (_answer != "") {
      return Column( 
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Text('Should I ${_question.query}?'),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              "Answer: ${_answer.capitalize()}",
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        ],
      );
    } else {
      return Container();
    }
  }

  /* 
   preform loggical actions
    */

  void _answerQuestion() async {
    setState(
      () {
        _answer = _getAnser();
      },
    );

    _question.query = _questionControlller.text;
    _question.answer = _answer;
    _question.created = DateTime.now();

    await FirebaseFirestore.instance
        .collection('users')
        .doc(AuthService().currentUser?.uid)
        .collection('questions')
        .add(_question.toJson());

        _questionControlller.text = '';
  }
}
