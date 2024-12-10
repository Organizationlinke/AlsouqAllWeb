import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:web_app/ReceverHandler.dart';
import 'package:web_app/ReferralHandler.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main()async {
final uri = Uri.base;
  final referralId = uri.queryParameters['referral_id'];
  final reseverId = uri.queryParameters['resever_id'];
    // استخدم القيم التي تم تمريرها من dart-define
  const supabaseUrl = String.fromEnvironment('SUPABASE_URL');
  const supabaseAnonKey = String.fromEnvironment('SUPABASE_ANON_KEY');
  // تحقق من القيم
  if (supabaseUrl.isEmpty || supabaseAnonKey.isEmpty) {
    throw Exception('Supabase URL or Anon Key is missing');
  }
  await dotenv.load(isOptional: true); // تحميل ملف .env  
  await Supabase.initialize(
    url: supabaseUrl, // قراءة URL
    anonKey: supabaseAnonKey, // قراءة المفتاح
  );

  
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
