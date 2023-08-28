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
import 'package:appcenter/appcenter.dart';
import 'package:appcenter_analytics/appcenter_analytics.dart';
import 'package:appcenter_crashes/appcenter_crashes.dart';
import 'package:flutter/foundation.dart';






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

  void initAppCenter() async{
    final ios = defaultTargetPlatform == TargetPlatform.iOS;
    var app_secret = ios ? "123cfac9-123b-123a-123f-123273416a48" : "5f536a48-e01c-42b2-863d-21aaa3a38855";

    await AppCenter.start(app_secret, [AppCenterAnalytics.id, AppCenterCrashes.id]);
  }



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
