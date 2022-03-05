import 'package:ntp/ntp.dart';

class Ntp{
 late DateTime myTime;
 late DateTime ntpTime;
  Ntp(){
    getTime();
  }

 Future<Map> getTime() async{

   /// Or you could get NTP current (It will call DateTime.now() and add NTP offset to it)
   myTime = await NTP.now();
   /// Or get NTP offset (in milliseconds) and add it yourself
   final int offset = await NTP.getNtpOffset(localTime: DateTime.now());
   ntpTime = myTime.add(Duration(milliseconds: offset));

   print('My time: $myTime');
   print('NTP time: $ntpTime');
   print('Difference: ${myTime.difference(ntpTime).inMilliseconds}ms');

   return {
    'myTime': myTime,
    'ntpTime':ntpTime
   };
 }

}





