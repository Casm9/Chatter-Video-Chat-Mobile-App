import 'dart:convert';

import 'package:chatter/common/apis/apis.dart';
import 'package:chatter/common/entities/entities.dart';
import 'package:chatter/common/routes/routes.dart';
import 'package:chatter/common/store/store.dart';
import 'package:chatter/common/utils/utils.dart';
import 'package:chatter/common/widgets/toast.dart';
import 'package:chatter/pages/frame/sign_in/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInController extends GetxController{
  SignInController();
  final state = SignInState();

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'openid'
    ]
  );

  void handleSignIn(String type) async{
    //1:email , 2:google, 3:facebook, 4:apple, 5:phone
    try{
      if(type=="phone number"){

      }else if(type == "google"){
       var user = await _googleSignIn.signIn();
       if(user!=null){

        String? displayName = user.displayName;
        String email = user.email;
        String id = user.id;
        String photoUrl = user.photoUrl??"assets/icons/google.png";

        LoginRequestEntity loginPanelListRequestEntity= LoginRequestEntity();
        loginPanelListRequestEntity.avatar = photoUrl;
        loginPanelListRequestEntity.name = displayName;
        loginPanelListRequestEntity.email = email;
        loginPanelListRequestEntity.open_id = id;
        loginPanelListRequestEntity.type = 2;
        print(jsonEncode(loginPanelListRequestEntity));
        asyncPostAllData(loginPanelListRequestEntity);

       }
      }else{

      }
    }catch(e){
      print('...error with login $e');
    }
  }

  asyncPostAllData(LoginRequestEntity loginRequestEntity) async{
    /*
    var response = await HttpUtil().get(
      '/api/index'
    );
    print(response);


    UserStore.to.setIsLogin=true;


     */

    EasyLoading.show(
      indicator: const CircularProgressIndicator(),
      maskType: EasyLoadingMaskType.clear,
      dismissOnTap: true
    );
    var result = await UserAPI.Login(params: loginRequestEntity);
    //backend success code 0
    if(result.code==0){
      await UserStore.to.saveProfile(result.data!);
      EasyLoading.dismiss();
    }else{
      EasyLoading.dismiss();
      toastInfo(msg: "Internet Error");
    }

    Get.offAllNamed(AppRoutes.Message);
  }



}