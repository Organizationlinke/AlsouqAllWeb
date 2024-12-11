import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ReferralHandler extends StatefulWidget {
  @override
  _ReferralHandlerPageState createState() => _ReferralHandlerPageState();
}

class _ReferralHandlerPageState extends State<ReferralHandler> {
 
  final supabas = Supabase.instance.client;

  @override
  void initState() {
    super.initState();
    handleReferral();
  }

  Future<void> handleReferral() async {
    final url = Uri.base; 

    final referralId =
        url.queryParameters['referral_id']; // الحصول على referral_id
   print('referralId::-$referralId');
    try {
      // if (html.window.localStorage['referr_uuid'] == null) {
        if (referralId != null) {
          final respos = await supabas
              .from('referr')
              .insert({
                'sender_id': referralId,
                'url': url.toString(),
                'Old_UU_ID':html.window.localStorage['referr_uuid'],
                'type': 1,
              })
              .select()
              .single();

          if (respos.isNotEmpty) {
            html.window.localStorage['referr_uuid'] = respos['UU_ID'];
            print(respos['UU_ID']);
          }
        }
      // }
    } catch (e) {
      print(e);
    }

  }

  Future<void> _launchURL() async {
    final String url =
        'https://play.google.com/store/apps/details?id=com.Alsouq365.Alsouq';
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

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
