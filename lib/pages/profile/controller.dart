import 'package:chatter/common/store/store.dart';
import 'package:chatter/pages/profile/index.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfileController extends GetxController{
  ProfileController();
  final state = ProfileState();

  @override
  void onInit(){
    super.onInit();
    var userItem = Get.arguments;
    if(userItem != null){
      state.profile_detail.value = userItem;
    }
  }

 Future<void> goLogout() async{
    await GoogleSignIn().signOut();
    await UserStore.to.onLogout();
  }




}