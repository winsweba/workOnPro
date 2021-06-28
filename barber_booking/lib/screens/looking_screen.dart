import 'package:barber_booking/state/state_mangement.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:im_stepper/stepper.dart';

class BookingScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, watch) {
    var step = watch(currentStep).state;
    var cityWatch = watch(selectedCity).state;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Color(0xFFFDF9EE),
        body: Column(
          children: [
            NumberStepper(
              activeStep: step - 1,
              direction: Axis.horizontal,
              enableNextPreviousButtons: false,
              enableStepTapping: false,
              numbers: [1, 2, 3, 4, 5],
              stepColor: Colors.black,
              activeStepColor: Colors.grey,
              numberStyle: TextStyle(color: Colors.white),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: ElevatedButton(onPressed: step == 1 ? null : () => context.read(currentStep).state-- , child: Text("Previous"))),
                      SizedBox(width: 30,),
                       Expanded(child: ElevatedButton(onPressed: step == 5 ? null : () => context.read(currentStep).state++, child: Text("Next"))),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
