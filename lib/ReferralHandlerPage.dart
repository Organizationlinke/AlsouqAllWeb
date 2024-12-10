import 'dart:convert'; // For jsonEncode
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';

class ReferralHandlerPage extends StatefulWidget {
  @override
  _ReferralHandlerPageState createState() => _ReferralHandlerPageState();
}

class _ReferralHandlerPageState extends State<ReferralHandlerPage> {
  String userUUID = '';
  String referralId='';
  String device_info2 = '';
  var User_UUID = "0";
  final supabas = Supabase.instance.client;

  @override
  void initState() {
    super.initState();
    handleReferral();
  }

  Future<void> handleReferral() async {
    // final url = Uri.base; // URL الحالي
    String url =
        'https://ahmegabr2010.github.io/Linkes/LinkPage.html?referral_id=eca438c7-f462-4eff-bc60-f7fba75a331a'; // URL الحالي

    // // final referralId = url.queryParameters['referral_id']; // الحصول على referral_id
    String referralId = 'eca438c7-f462-4eff-bc60-f7fba75a331a';
    // String? userUUID = html.window.localStorage['referr_uuid'];
    try {
      if (referralId != null) {
      final respos = await supabas
          .from('referr')
          .insert({
            'sender_id': referralId,
            'url': url.toString(),
            'resever_id': userUUID, // سيُستخدم لاحقًا بعد استرجاعه
            'type': 1,
          })
          .select()
          .single();

      if (respos.isNotEmpty) {
        html.window.localStorage['referr_uuid'] = respos['UU_ID'];
        print(respos['UU_ID']);
      }
    }

    } catch (e) {
      print(e);
    }
    // html.window.location.href =
    //     'https://play.google.com/store/apps/details?id=com.Alsouq365.Alsouq';
  }

  // Future<void> handleReferral3() async {
  //   // الحصول على الـ referral_id من الـ URL
  //   // final url = Uri.base; // URL الحالي
  //   const url =
  //       'https://ahmegabr2010.github.io/Linkes/LinkPage.html?referral_id=eca438c7-f462-4eff-bc60-f7fba75a331a'; // URL الحالي

  //   // final referralId = url.queryParameters['referral_id']; // الحصول على referral_id
  //   const referralId = 'eca438c7-f462-4eff-bc60-f7fba75a331a';
  //   String? userUUID = html.window.localStorage['referr_uuid'];

  //   final respos = await supabas
  //       .from('referr')
  //       .insert({
  //         'sender_id': referralId,
  //         'url': url.toString(),
  //         'resever_id': userUUID, // سيُستخدم لاحقًا بعد استرجاعه
  //         'type': 1,
  //       })
  //       .select()
  //       .single();

  //   if (respos.isNotEmpty) {}
  //   if (referralId != null) {
  //     try {
  //       // التحقق مما إذا كان User_UUID مخزن بالفعل في localStorage

  //       if (userUUID == null) {
  //         // إذا لم يكن موجودًا، احصل عليه من Supabase
  //         const supabaseUrl =
  //             'https://zhhnxvbajczmvqrxwcul.supabase.co/rest/v1/referr';
  //         const apiKey =
  //             'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InpoaG54dmJhamN6bXZxcnh3Y3VsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzI1NTM0MDcsImV4cCI6MjA0ODEyOTQwN30.sh7x-k-k3C4vNSgT9q8GJR_ZrKrfoz2MGsRG6Rr0ybI';

  //         final headers = {
  //           'Content-Type': 'application/json',
  //           'apikey': apiKey,
  //           'Authorization': 'Bearer $apiKey',
  //         };

  //         final body = jsonEncode({
  //           'sender_id': referralId,
  //           'url': url.toString(),
  //           'resever_id': userUUID, // سيُستخدم لاحقًا بعد استرجاعه
  //           'type': 1,
  //         });

  //         final response = await http.post(
  //           Uri.parse('$supabaseUrl'),
  //           headers: headers,
  //           body: body,
  //         );
  //         final aa = await supabas
  //             .from('referr')
  //             .select()
  //             .eq('url', url.toString())
  //             .eq('sender_id', referralId);

  //         print(aa);
  //         if (response.statusCode == 200) {
  //           final data = jsonDecode(response.body);
  //           print('Data inserted: $data');

  //           if (data != null && data.isNotEmpty) {
  //             userUUID = data[0]['UU_ID'];
  //             print('Generated ID: $userUUID');

  //             // تخزين User_UUID في localStorage
  //             html.window.localStorage['referr_uuid'] = userUUID!;
  //           }
  //         } else {
  //           print('Response status code: ${response.statusCode}');
  //           print('Response body: ${response.body}');

  //           print('Error inserting data: ${response.body}');
  //         }
  //       }

  //       // // الانتقال إلى متجر التطبيقات بعد الانتهاء
  //       //  html.window.location.href =
  //       //     'https://play.google.com/store/apps/details?id=com.Alsouq365.Alsouq';
  //     } catch (error) {
  //       print('Error: $error');
  //       // // الانتقال في حالة الخطأ
  //       //  html.window.location.href =
  //       //     'https://play.google.com/store/apps/details?id=com.Alsouq365.Alsouq';
  //     }
  //   } else {
  //     print('No referral_id found in URL');
  //     // // في حالة عدم وجود referral_id
  //     //  html.window.location.href =
  //     //     'https://play.google.com/store/apps/details?id=com.Alsouq365.Alsouq';
  //   }
  // }
// Future<String> getOrCreateDeviceId() async {
//   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   String? deviceId = prefs.getString('device_id');

//   if (deviceId == null) {
//     var uuid = Uuid();
//     deviceId = uuid.v4(); // يولد UUID فريد
//     await prefs.setString('device_id', deviceId);
//   }
// deviceId.isNotEmpty? User_UUID = deviceId:"0";
//   print('User_UUID3:$User_UUID');
//  handleReferral();

//   return deviceId;
// }

  // /// Handle referral logic
  // Future<void> handleReferral2() async {
  //   // Retrieve referral ID from the URL
  //   final url = html.window.location.href;
  //   final uri = Uri.parse(url);
  //   referralId = uri.queryParameters['referral_id'];

  //   // Generate or retrieve user UUID
  //   final localStorage = html.window.localStorage;
  //   userUUID = localStorage['user_uuid'] ??await getOrCreateDeviceId();
  //   localStorage['user_uuid'] = userUUID;
  //   localStorage['sender_uuid'] = referralId??'';

  //   print('User UUID: $userUUID');
  //   print('Referral ID: $referralId');

  //   if (referralId != null) {
  //     await sendDataToSupabase();
  //   } else {
  //     print('No referral_id found.');
  //     navigateToApp();
  //   }
  // }

  // /// Send data to Supabase
  // Future<void> sendDataToSupabase() async {
  //   await dotenv.load(isOptional: true); // تحميل ملف .env
  //  String  supabaseUrl = dotenv.env['SUPABASE_URL']!;
  //   String apiKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InpoaG54dmJhamN6bXZxcnh3Y3VsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzI1NTM0MDcsImV4cCI6MjA0ODEyOTQwN30.sh7x-k-k3C4vNSgT9q8GJR_ZrKrfoz2MGsRG6Rr0ybI';

  //   final headers = {
  //     'Content-Type': 'application/json',
  //     'apikey': apiKey,
  //     'Authorization': 'Bearer $apiKey',
  //   };

  //   final deviceId = html.window.navigator.userAgent ?? 'unknown_device';
  //   final body = {
  //     'sender_id': referralId,
  //     'url': html.window.location.href,
  //     'resever_id': userUUID,
  //     'device_info': deviceId,
  //     'device_info2': 'additional_device_info',
  //   };

  //   try {
  //     final response = await http.post(
  //       Uri.parse(supabaseUrl),
  //       headers: headers,
  //       body: jsonEncode(body),
  //     );

  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       print('Data sent successfully!');
  //       navigateToApp();
  //     } else {
  //       print('Failed to send data: ${response.body}');
  //     }
  //   } catch (e) {
  //     print('Error sending data: $e');
  //   }
  // }

  // /// Navigate to the app on success or no referral
  // void navigateToApp() {
  //   html.window.location.href = 'https://play.google.com/store/apps/details?id=com.Alsouq365.Alsouq';
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Referral Handler'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Handling Referral...'),
            if (referralId != null) Text('Referral ID: $referralId'),
          ],
        ),
      ),
    );
  }
}
