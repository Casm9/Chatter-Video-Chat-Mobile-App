import 'package:chatter/common/entities/entities.dart';
import 'package:chatter/common/values/values.dart';
import 'package:chatter/pages/contact/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ContactList extends GetView<ContactController> {
  const ContactList({Key? key}) : super(key: key);

  Widget _buildListItem(ContactItem item){
    return Container(
      padding: EdgeInsets.only(top: 10.h),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,color: AppColors.primarySecondaryBackground
          )
        )
      ),
      child: InkWell(
        onTap: (){
         controller.goChat(item);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
                Container(
                width: 44.w,
                height: 44.w,
                decoration: BoxDecoration(
                  color: AppColors.primarySecondaryBackground,
                  borderRadius: BorderRadius.all(Radius.circular(22.r)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: Offset(0,1)
                      )
                    ]
                  ),
                child: CachedNetworkImage(
                    imageUrl: item.avatar!,
                    height: 50.h,
                    width: 50.w,
                    imageBuilder: (context,imageProvider)=>Container(
                      decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(22.r)),
                      image: DecorationImage(
                              image: imageProvider
                            )
                          ),
                        ),
                    errorWidget: (context,url,error)=>Image(
                      image: AssetImage('assets/icons/empty_person_avatar.png')
                      ),
                  ),
                ),
                Container(
                width: 275.w,
                padding: EdgeInsets.only(top: 10.h,left: 10.w,right: 0.w,bottom: 0.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 200.w,
                      height: 42.h,
                      child: Text(
                        "${item.name}",
                        overflow: TextOverflow.clip,
                        maxLines: 1,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.thirdElement,
                          fontSize: 16.sp,
                          fontFamily: "Avenir"
                        ),
                      ),
                    ),
                    Container(
                      width: 12.w,
                      height: 12.h,
                      margin: EdgeInsets.only(top: 5.h),
                      child: Image.asset(
                        "assets/icons/ang.png"
                      ),
                    )
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 20.w),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    var item = controller.state.contactList[index];
                    print(item.name);
                    return _buildListItem(item);

                  },
                  childCount: controller.state.contactList.length
              ),

            ),
          )
        ],
      );
   });

  }
}
