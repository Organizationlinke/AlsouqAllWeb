import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:installed_apps/installed_apps.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';


class ReceverHandler extends StatefulWidget {
  @override
  _ReceverHandlerState createState() => _ReceverHandlerState();
}

class _ReceverHandlerState extends State<ReceverHandler> {
 
  final supabas = Supabase.instance.client;

  @override
  void initState() {
    super.initState();
    handleReferral();
  }

  Future<void> handleReferral() async {
    final url = Uri.base; 

    final reseverId =
        url.queryParameters['resever_id']; // الحصول على referral_id
   
    try {
      // if (html.window.localStorage['referr_uuid'] != null) {
        if (reseverId != null) {
          final respos = await supabas
              .from('referr')
              .insert({
                'user_id': reseverId,
                'resever_id': html.window.localStorage['referr_uuid'],
                'type': 2,
              })
              .select()
              .single();
        }
      // }
    } catch (e) {
      print(e);
    }
    
  }
Future<void> _launchURL() async {
  final String packageName = 'com.Alsouq365.Alsouq'; // معرّف الحزمة
  final String playStoreUrl =
      'https://play.google.com/store/apps/details?id=$packageName';

  try {
    // تحقق مما إذا كان التطبيق مثبتًا
    var app = await InstalledApps.getAppInfo(packageName);

    if (app != null) {
      // إذا كان التطبيق مثبتًا، افتحه
      await InstalledApps.startApp(packageName);
    } else {
      // إذا لم يكن التطبيق مثبتًا، افتح متجر Google Play
      final Uri uri = Uri.parse(playStoreUrl);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch $playStoreUrl';
      }
    }
  } catch (e) {
    // إذا حدث خطأ (التطبيق غير مثبت)
    final Uri uri = Uri.parse(playStoreUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $playStoreUrl';
    }
  }
}
  // Future<void> _launchURL() async {
  //   final String url =
  //       'https://play.google.com/store/apps/details?id=com.Alsouq365.Alsouq';
  //   final Uri uri = Uri.parse(url);
  //   if (await canLaunchUrl(uri)) {
  //     await launchUrl(uri, mode: LaunchMode.externalApplication);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('السوق',style: TextStyle(fontSize: 22),),
        ),
        body:  Center(
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      color: const Color.fromARGB(255, 4, 140, 8),
                      child: TextButton(onPressed: () async{
                        await _launchURL();
                      }, child: Text('متابعه الي التطبيق',style: TextStyle(color: Colors.white,fontSize: 20),)),
                    ),
                  ),
                ],
              ),
             
            ],
          ),
        ),
      ),
    );
  }
}
