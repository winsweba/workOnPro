import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:main_todo/app/modules/home/controller.dart';
import 'package:main_todo/app/core/utils/extensions.dart';


class ReportPage extends StatelessWidget {
  final homeCtrl = Get.find<HomeControll>();
  
 ReportPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx ( () {
          var createdTasks = homeCtrl.getTotalTask();
          var completedTask = homeCtrl.getTotalDoneTask();
          var liveTasks = createdTasks - completedTask;
          var precent = (completedTask / createdTasks * 100).toStringAsFixed(0);
        return ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(4.0.wp),
              child: Text("My Report",
              style: TextStyle(
                fontSize: 24.0.sp,
                fontWeight: FontWeight.bold
              ),
              ),
            )
          ],
        );

        }, ),
      )
    );
  }
}