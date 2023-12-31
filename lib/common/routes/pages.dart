import 'package:chatter/pages/contact/index.dart';
import 'package:chatter/pages/message/chat/index.dart';
import 'package:chatter/pages/message/index.dart';
import 'package:chatter/pages/frame/sign_in/index.dart';
import 'package:chatter/pages/frame/welcome/index.dart';
import 'package:chatter/pages/message/videoCall/index.dart';
import 'package:chatter/pages/message/voicecall/index.dart';
import 'package:chatter/pages/profile/index.dart';
import 'package:flutter/material.dart';
import 'package:chatter/common/middlewares/middlewares.dart';
import 'package:get/get.dart';
import 'routes.dart';

class AppPages {
  static const INITIAL = AppRoutes.INITIAL;
  static final RouteObserver<Route> observer = RouteObservers();
  static List<String> history = [];

  static final List<GetPage> routes = [


    GetPage(
      name: AppRoutes.INITIAL,
      page: () => WelcomePage(),
      binding: WelcomeBinding(),
    ),

    GetPage(
      name: AppRoutes.Message,
      page: () => MessagePage(),
      binding: MessageBinding(),
      middlewares: [
      RouteAuthMiddleware(priority: 1)
      ],
    ),

    GetPage(
      name: AppRoutes.SIGN_IN,
      page: () => SignInPage(),
      binding: SignInBinding(),
    ),

    GetPage(
        name: AppRoutes.Profile,
        page: () => ProfilePage(),
        binding: ProfileBinding()
    ),

    GetPage(
        name: AppRoutes.Contact,
        page: () => ContactPage(),
        binding: ContactBinding()
    ),

    GetPage(
        name: AppRoutes.Chat,
        page: () => ChatPage(),
        binding: ChatBinding()
    ),

    GetPage(
        name: AppRoutes.VoiceCall,
        page: () => VoiceCallPage(),
        binding: VoiceCallBinding()
    ),

    GetPage(
        name: AppRoutes.VideoCall,
        page: () => VideoCallPage(),
        binding: VideoCallBinding()
    ),

    /*

    // GetPage(
    //   name: AppRoutes.Application,
    //   page: () => ApplicationPage(),
    //   binding: ApplicationBinding(),
    //   middlewares: [
    //     RouteAuthMiddleware(priority: 1),
    //   ],
    // ),

    //
    GetPage(name: AppRoutes.EmailLogin, page: () => EmailLoginPage(), binding: EmailLoginBinding()),
    GetPage(name: AppRoutes.Register, page: () => RegisterPage(), binding: RegisterBinding()),
    GetPage(name: AppRoutes.Forgot, page: () => ForgotPage(), binding: ForgotBinding()),
    GetPage(name: AppRoutes.Phone, page: () => PhonePage(), binding: PhoneBinding()),
    GetPage(name: AppRoutes.SendCode, page: () => SendCodePage(), binding: SendCodeBinding()),
    //



    //

    GetPage(name: AppRoutes.Photoimgview, page: () => PhotoImgViewPage(), binding: PhotoImgViewBinding()),

    */
  ];






}
