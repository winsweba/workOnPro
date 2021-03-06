import 'package:barber_booking/models/barber_model.dart';
import 'package:barber_booking/models/city_model.dart';
import 'package:barber_booking/models/salon_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userLogged = StateProvider((ref) =>  FirebaseAuth.instance.currentUser );
final userToken = StateProvider((ref) => '' );
final forceReload = StateProvider((ref) => false );

// Booking state
final currentStep = StateProvider((ref) =>  1);
final selectedCity = StateProvider((ref) => CityModels() );
final selectedSalon = StateProvider((ref) => SalonModel() );
final selectedBarber = StateProvider((ref) => BarberModel() );