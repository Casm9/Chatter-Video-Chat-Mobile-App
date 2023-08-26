import 'dart:io';
import 'package:chatter/common/apis/apis.dart';
import 'package:chatter/common/entities/entities.dart';
import 'package:chatter/common/store/store.dart';
import 'package:chatter/common/widgets/toast.dart';
import 'package:chatter/pages/profile/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController{
  ProfileController();
  final state = ProfileState();
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  File? _photo;
  final ImagePicker _picker = ImagePicker();


  @override
  void onInit(){
    super.onInit();
    var userItem = Get.arguments;
    if(userItem != null){
      state.profile_detail.value = userItem;
    }
  }

  @override
  void onClose(){
    nameController.dispose();
    descriptionController.dispose();
    super.onClose();
  }

 Future<void> goLogout() async{
    await GoogleSignIn().signOut();
    await UserStore.to.onLogout();
  }

 Future<void> goSave() async{

    if(state.profile_detail.value.name == null || state.profile_detail.value.name!.isEmpty){
      toastInfo(msg: "Name can not be empty");
      return;
    }
    if(state.profile_detail.value.description == null || state.profile_detail.value.description!.trim().isEmpty){
      toastInfo(msg: "Description can not be empty");
      return;
    }

    LoginRequestEntity loginRequestEntity = LoginRequestEntity();
    var userItem = state.profile_detail.value;
    loginRequestEntity.avatar = userItem.avatar;
    loginRequestEntity.name = userItem.name;
    loginRequestEntity.description = userItem.description;
    loginRequestEntity.online = userItem.online;

    var result = await UserAPI.UpdateProfile(params: loginRequestEntity);
    if(result.code == 0){
      UserItem userItem = state.profile_detail.value;
      await UserStore.to.saveProfile(userItem);
      Get.back(result: "finish");
    }else{
      print("${result.msg}");
    }
  }


  Future imgFromGallery() async {
   final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
   if(pickedFile!=null){
     _photo = File(pickedFile.path);
     uploadFile();

   }else{
     print("No image selected");
   }
  }

  Future imgFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if(pickedFile!=null){
      _photo = File(pickedFile.path);
      uploadFile();

    }else{
      print("No image selected");
    }
  }


  Future uploadFile() async{
    var result = await ChatAPI.upload_img(file: _photo);
    if(result.code ==0){
      state.profile_detail.value.avatar = result.data;
      state.profile_detail.refresh();
    }else{
      toastInfo(msg: "image upload error");
    }
  }







}