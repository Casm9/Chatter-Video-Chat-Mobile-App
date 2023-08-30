import 'package:chatter/common/routes/routes.dart';
import 'package:chatter/common/style/style.dart';
import 'package:chatter/common/utils/FirebaseMessagingHandler.dart';
import 'package:chatter/global.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';





Future<void> main() async{
  await Global.init();
  runApp(const MyApp());
  firebaseChatInit().whenComplete(() => FirebaseMessagingHandler.config());

}

Future firebaseChatInit() async{
  FirebaseMessaging.onBackgroundMessage(
          FirebaseMessagingHandler.firebaseMessagingBackground
  );
  if(GetPlatform.isAndroid){
    FirebaseMessagingHandler.flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()!
    .createNotificationChannel(FirebaseMessagingHandler.channel_call);

    FirebaseMessagingHandler.flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()!
    .createNotificationChannel(FirebaseMessagingHandler.channel_message);
  }

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});





  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(360,780),
        builder: (context,child)=> GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      builder: EasyLoading.init(),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
        ));
  }
}
