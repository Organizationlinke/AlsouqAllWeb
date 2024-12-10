import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:web_app/ReceverHandler.dart';
import 'package:web_app/ReferralHandler.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main()async {
final uri = Uri.base;
  final referralId = uri.queryParameters['referral_id'];
  final reseverId = uri.queryParameters['resever_id'];
  await dotenv.load(isOptional: true); // تحميل ملف .env  
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!, // قراءة URL
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!, // قراءة المفتاح
  );
  // await Supabase.initialize(
  //    url: 'https://zhhnxvbajczmvqrxwcul.supabase.co', // قراءة URL
  //   anonKey:'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InpoaG54dmJhamN6bXZxcnh3Y3VsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzI1NTM0MDcsImV4cCI6MjA0ODEyOTQwN30.sh7x-k-k3C4vNSgT9q8GJR_ZrKrfoz2MGsRG6Rr0ybI', // قراءة المفتاح
  //    );

  
  runApp(Alsouq_Web(referralId: referralId,reseverId:reseverId));


}


class Alsouq_Web extends StatefulWidget {
final String? referralId;
final String? reseverId;
 Alsouq_Web({this.referralId, this.reseverId});
  @override
  State<Alsouq_Web> createState() => _Alsouq_WebState();
}

class _Alsouq_WebState extends State<Alsouq_Web> {
    @override
  void initState() {
    super.initState();
    print('referralId:${widget.referralId}');
    print('reseverId:${widget.reseverId}');
 
  }
 

  @override
  Widget build(BuildContext context) {
    return Directionality(
     textDirection: TextDirection.rtl,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        
        title: 'السوق',
           home:widget.referralId!=null?ReferralHandler(): widget.reseverId!=null? ReceverHandler():null,
        // initialRoute: '/home',
        // routes: {

        // },
      ),
    );
  }
}
