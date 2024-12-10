import 'dart:convert'; // For jsonEncode
import 'dart:html' as html;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:uuid/uuid.dart';
import 'package:shared_preferences/shared_preferences.dart';

var User_UUID = "0";
Future<String> getOrCreateDeviceId() async {
  String deviceId = "";
  try {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    final androidInfo = await deviceInfo.androidInfo;
    deviceId = androidInfo.id;
   deviceId.isNotEmpty? User_UUID = deviceId:"0";
    print('User_UUID1:$User_UUID');
  } catch (e) {
    try {
      final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      final windowsInfo = await deviceInfo.windowsInfo;
      deviceId = windowsInfo.deviceId;
      print('deviceId:$deviceId');
      deviceId.isNotEmpty? User_UUID = deviceId:"0";
       print('User_UUID2:$User_UUID');
    } catch (e) {
      await getOrCreateDeviceId_2();
      print(e);
    }
  }
 
  
  return deviceId;
}

Future<String> getOrCreateDeviceId_2() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String? deviceId = prefs.getString('device_id');

  if (deviceId == null) {
    var uuid = Uuid();
    deviceId = uuid.v4(); // يولد UUID فريد
    await prefs.setString('device_id', deviceId);
  }
deviceId.isNotEmpty? User_UUID = deviceId:"0";
  print('User_UUID3:$User_UUID');
 handleReferral();

  return deviceId;
}

void handleReferral() {
  final url = html.window.location.href;
  final uri = Uri.parse(url);
  final referralId = uri.queryParameters['referral_id'];

  if (referralId != null) {
    final supabaseUrl =
        'https://zhhnxvbajczmvqrxwcul.supabase.co/rest/v1/referr';
    final apiKey =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InpoaG54dmJhamN6bXZxcnh3Y3VsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzI1NTM0MDcsImV4cCI6MjA0ODEyOTQwN30.sh7x-k-k3C4vNSgT9q8GJR_ZrKrfoz2MGsRG6Rr0ybI';
    final headers = {
      'Content-Type': 'application/json',
      'apikey': apiKey,
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InpoaG54dmJhamN6bXZxcnh3Y3VsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzI1NTM0MDcsImV4cCI6MjA0ODEyOTQwN30.sh7x-k-k3C4vNSgT9q8GJR_ZrKrfoz2MGsRG6Rr0ybI',
    };

    final body = {
      'sender_id': referralId,
      'url': url,
      'resever_id': User_UUID,
    };

    html.HttpRequest.request(
      supabaseUrl,
      method: 'POST',
      requestHeaders: headers,
      sendData: jsonEncode(body), // jsonEncode is sufficient here
    ).then((_) {
      html.window.location.href =
          'https://play.google.com/store/apps/details?id=com.example.app';
    }).catchError((error) {
      print('Error saving referral: $error');
    });
  } else {
    html.window.location.href =
        'https://play.google.com/store/apps/details?id=com.example.app';
  }
}
