

import 'package:barber_booking/cloud_firestroe/all_salon_ref.dart';
import 'package:barber_booking/models/barber_model.dart';
import 'package:barber_booking/models/city_model.dart';
import 'package:barber_booking/models/salon_model.dart';
import 'package:barber_booking/state/state_mangement.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:im_stepper/stepper.dart';

class BookingScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, watch) {
    var step = watch(currentStep).state;
    var cityWatch = watch(selectedCity).state;
    var salonWatch = watch(selectedSalon).state;
    var barberWatch = watch(selectedBarber).state;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Color(0xFFFDF9EE),
        body: Column(
          children: [
            // Step
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

            // Screen
            Expanded(
              child: step == 1
                  ? displayCityList()
                  : step == 2
                      ? displaySalon(cityWatch.name)
                  : step == 2
                      ? displayBarber(salonWatch)
                      : Container(),
            ),

            // Button
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: ElevatedButton(
                              onPressed: step == 1
                                  ? null
                                  : () => context.read(currentStep).state--,
                              child: Text("Previous"))),
                      SizedBox(
                        width: 30,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: (step == 1 &&
                                      context.read(selectedCity).state.name == '') ||
                                  (step == 2 &&
                                      context.read(selectedSalon).state.docId == '')   ||
                                  (step == 3 &&
                                      context.read(selectedBarber).state.docId == '')
                              ? null
                              : step == 5
                                  ? null
                                  : () => context.read(currentStep).state++,
                          child: Text("Next"),
                        ),
                      ),
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

  displayCityList() {
    return FutureBuilder(
      future: getCities(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return Center(
            child: CircularProgressIndicator(),
          );
        else {
          var cities = snapshot.data as List<CityModels>;
          if (cities == null || cities.length == 0)
            return Center(
              child: Text("Cannot Load city List"),
            );
          else
            return ListView.builder(
              itemCount: cities.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () =>
                      context.read(selectedCity).state = cities[index],
                  child: Card(
                    child: ListTile(
                      leading: Icon(Icons.home_work, color: Colors.black),
                      trailing:
                          context.read(selectedCity).state.name == cities[index].name
                              ? Icon(Icons.check)
                              : null,
                      title: Text(
                        '${cities[index].name}',
                        style: GoogleFonts.robotoMono(),
                      ),
                    ),
                  ),
                );
              },
            );
        }
      },
    );
  }

  displaySalon(String cityName) {
    return FutureBuilder(
      future: getSalonByCity(cityName),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return Center(
            child: CircularProgressIndicator(),
          );
        else {
          var salons = snapshot.data as List<SalonModel>;
          if (salons == null || salons.length == 0)
            return Center(
              child: Text("Cannot Load salons List"),
            );
          else
            return ListView.builder(
              itemCount: salons.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () =>
                      context.read(selectedSalon).state = salons[index],
                  child: Card(
                    child: ListTile(
                      leading: Icon(Icons.home_outlined, color: Colors.black),
                      trailing: context.read(selectedSalon).state.docId ==
                              salons[index].docId
                          ? Icon(Icons.check)
                          : null,
                      title: Text(
                        '${salons[index].name}',
                        style: GoogleFonts.robotoMono(),
                      ),
                      subtitle: Text(
                        '${salons[index].address}',
                        style:
                            GoogleFonts.robotoMono(fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                );
              },
            );
        }
      },
    );
  }

  displayBarber(SalonModel salonModel) {
    return FutureBuilder(
      future: getBarberBySalon(salonModel),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return Center(
            child: CircularProgressIndicator(),
          );
        else {
          var barbers = snapshot.data as List<BarberModel>;
          if (barbers == null || barbers.length == 0)
            return Center(
              child: Text("Barber List is empty"),
            );
          else
            return ListView.builder(
              itemCount: barbers.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () =>
                      context.read(selectedBarber).state = barbers[index],
                  child: Card(
                    child: ListTile(
                      leading: Icon(Icons.person, color: Colors.black),
                      trailing: context.read(selectedBarber).state.docId ==
                              barbers[index].docId
                          ? Icon(Icons.check)
                          : null,
                      title: Text(
                        '${barbers[index].name}',
                        style: GoogleFonts.robotoMono(),
                      ),
                      subtitle: Text(
                        '${barbers[index].address}',
                        style:
                            GoogleFonts.robotoMono(fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                );
              },
            );
        }
      },
    );
  }
}
