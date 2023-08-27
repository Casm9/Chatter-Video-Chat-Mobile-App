import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatter/common/values/values.dart';
import 'package:chatter/pages/profile/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

AppBar buildAppbar() {
  return AppBar(
    title: Text(
      "Profile",
      style: TextStyle(
        color: AppColors.primaryText,
        fontSize: 16.sp,
        fontWeight: FontWeight.normal,
      ),
    ),
  );
}
Future<void> fetchImageWithTimeout(String imageUrl) async {
  try {
    final response = await http.get(Uri.parse(imageUrl)).timeout(const Duration(seconds: 30));
    if (response.statusCode != 200) {
      throw Exception('Image request failed with status code: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Image request failed: $e');
  }


}

Widget buildProfilePhoto(ProfileController controller, BuildContext context) {
  String originalImageUrl = controller.state.profile_detail.value.avatar!;
  String updatedImageUrl = originalImageUrl.replaceFirst("http://localhost/", SERVER_API_URL);
  return Stack(
    alignment: Alignment.center,
    children: [
      Container(
        width: 100.w,
        height: 110.h,
        decoration: BoxDecoration(
            color: AppColors.primarySecondaryBackground,
            borderRadius: BorderRadius.all(Radius.circular(60.r)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(0, 1),
              )
            ]),
        child: FutureBuilder(
          future: fetchImageWithTimeout(updatedImageUrl),
          builder: (context,snapshot){
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              return CachedNetworkImage(
                  imageUrl: updatedImageUrl,
                  httpHeaders: const {"Connection": "keep-alive"},
                  height: 120.h,
                  width: 120.w,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(60.r)),
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.fill)),
                  )
              );

            }
          },
        )
      ),
      Positioned(
          bottom: 0.w,
          right: 0.w,
          height: 35.h,
          child: GestureDetector(
            onTap: (){
              _showPicker(context,controller);
            },
            child: Container(
              height: 35.h,
              width: 35.w,
              padding: EdgeInsets.all(7.w),
              decoration: BoxDecoration(
                  color: AppColors.primaryElement,
                  borderRadius: BorderRadius.all(Radius.circular(40.r))),
              child: Image.asset("assets/icons/edit.png"),
            ),
          ))
    ],
  );
}

void _showPicker(BuildContext context,ProfileController controller){
  showModalBottomSheet(context: context, builder: (BuildContext context)
  => SafeArea(
      child: Wrap(
          //direction: Axis.horizontal,
          children: [
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text("Gallery"),
              onTap: (){
                  controller.imgFromGallery();
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_camera),
              title: Text("Camera"),
              onTap: (){
                  controller.imgFromCamera();
              },
            )
          ],
      )
  )
  );
}

Widget buildCompleteBtn(ProfileController controller) {
  return GestureDetector(
    onTap: () {
      controller.goSave();
    },
    child: Container(
      width: 295.w,
      height: 44.h,
      margin: EdgeInsets.only(top: 60.h, bottom: 30.h),
      decoration: BoxDecoration(
          color: AppColors.primaryElement,
          borderRadius: BorderRadius.all(Radius.circular(5.r)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(0, 1),
            )
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Complete",
            style: TextStyle(
              color: AppColors.primaryElementText,
              fontSize: 14.sp,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildLogoutBtn(ProfileController controller) {
  return GestureDetector(
    child: Container(
      width: 295.w,
      height: 44.h,
      margin: EdgeInsets.only(top: 0.h, bottom: 30.h),
      decoration: BoxDecoration(
          color: AppColors.primarySecondaryElementText,
          borderRadius: BorderRadius.all(Radius.circular(5.r)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(0, 1),
            )
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Logout",
            style: TextStyle(
              color: AppColors.primaryElementText,
              fontSize: 14.sp,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    ),
    onTap: () {
      Get.defaultDialog(
          title: "Are you sure to log out?",
          content: Container(),
          onConfirm: () {
            controller.goLogout();
          },
          onCancel: () {},
          textConfirm: "Confirm",
          textCancel: "Cancel",
          confirmTextColor: Colors.white);
    },
  );
}

Widget buildName(ProfileController controller,
    void Function(String value)? func, String text) {
  return Container(
    width: 295.w,
    height: 44.h,
    margin: EdgeInsets.only(bottom: 20.h, top: 60.h),
    decoration: BoxDecoration(
        color: AppColors.primaryBackground,
        borderRadius: BorderRadius.all(Radius.circular(5.r)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 1),
          )
        ]),
    child: _profileTextField(controller, controller.nameController, func, text),
  );
}

Widget buildDescription(ProfileController controller,
    void Function(String value)? func, String text) {
  return Container(
    width: 295.w,
    height: 44.h,
    margin: EdgeInsets.only(bottom: 20.h, top: 0.h),
    decoration: BoxDecoration(
        color: AppColors.primaryBackground,
        borderRadius: BorderRadius.all(Radius.circular(5.r)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 1),
          )
        ]),
    child: _profileTextField(controller, controller.descriptionController, func, text),
  );
}

Widget _profileTextField(
    ProfileController controller,
    TextEditingController textEditingController,
    void Function(String value)? func,
    String text){
  return TextField(
    onChanged: (value) => func!(value),
    controller: textEditingController,
    maxLines: null,
    keyboardType: TextInputType.multiline,
    autofocus: false,
    decoration: InputDecoration(
        hintText: text,
        contentPadding: EdgeInsets.only(left: 15.w, top: 0.h, bottom: 0.h),
        border: const OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.transparent,
        )),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent)),
        disabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent)),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent)),
        hintStyle: const TextStyle(
          color: AppColors.primaryText,
        )),
    style: TextStyle(
        color: AppColors.primaryText,
        fontFamily: "Avenir",
        fontWeight: FontWeight.normal,
        fontSize: 14.sp),
  );
}
