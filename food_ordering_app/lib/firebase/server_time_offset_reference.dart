/* 
this contain server time
 */

import 'package:firebase_database/firebase_database.dart';

Future<int> getServerTimeOffset() async {
  int offset = 0;
  var source = await FirebaseDatabase.instance
  .ref()
  .child(".info/serverTimeOffset")
  .once();
  var  snapshot = source.snapshot;
  offset = snapshot.value as int;
  int estimatedServerTimeInMs = DateTime.now().millisecondsSinceEpoch+offset;
  return estimatedServerTimeInMs;
}