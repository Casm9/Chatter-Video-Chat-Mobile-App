import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatter/common/entities/entities.dart';
import 'package:chatter/common/routes/names.dart';
import 'package:chatter/common/utils/utils.dart';
import 'package:chatter/common/values/values.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chatter/pages/message/controller.dart';
import 'package:get/get.dart';

class MessagePage extends GetView<MessageController> {
  const MessagePage({Key? key}) : super(key: key);

  Widget _headBar(){
  return Center(
    child: Container(
      width: 320.w,
      height: 44.h,
      margin: EdgeInsets.only(bottom: 20.h,top: 20.h),
      child: Row(
        children: [
          Stack(
            children: [
              GestureDetector(
                child: Container(
                  width: 44.w,
                  height: 44.h,
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
                  child: controller.state.head_detail.value.avatar==null?
                  Image(image: AssetImage("assets/images/account_header.png")):
                  CachedNetworkImage(
                      imageUrl: controller.state.head_detail.value.avatar!,
                      height: 44.h,
                      width: 44.w,
                      imageBuilder: (context,imageProvider) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(22.r)),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.fill
                          )
                        ),
                      ),
                    errorWidget: (context,url,error) => Image(
                        image: AssetImage(
                          'assets/images/account_header.png'
                        )
                    ),
                  ),
                ),
                onTap: (){
                  controller.goProfile();
                },
              ),
              Positioned(
                  bottom: 5.w,
                  right: 0.w,
                  height: 14.w,
                  child: Container(
                    width: 14.w,
                    height: 14.w,
                    decoration: BoxDecoration(
                      border: Border.all(
                            width: 2.w,
                            color: AppColors.primaryElementText,
                           ),
                      color: AppColors.primaryElementStatus,
                      borderRadius: BorderRadius.all(Radius.circular(12.r)),

                    ),
                 ),
              )
            ],
          )
        ],
      ),
    ),
  );
 }

  Widget _headTabs(){
   return Container(
     height: 48.h,
     width: 320.w,
     decoration: BoxDecoration(
         color: AppColors.primarySecondaryBackground,
         borderRadius: BorderRadius.all(Radius.circular(5.r))
     ),
     padding: EdgeInsets.all(4.h),
     child: Row(
       mainAxisAlignment: MainAxisAlignment.spaceBetween,
       children: [
         GestureDetector(
           onTap: (){
             controller.goTabStatus();
           },
           child: Container(
             width: 150.w,
             height: 40.h,
             decoration: controller.state.tapStatus.value ? BoxDecoration(
                 color: AppColors.primaryBackground,
                 borderRadius: BorderRadius.all(Radius.circular(5.r)),
                 boxShadow: [
                   BoxShadow(
                       color: Colors.grey.withOpacity(0.1),
                       spreadRadius: 2,
                       blurRadius: 3,
                       offset: Offset(0,2)
                   )
                 ]
             ) : BoxDecoration(),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Text(
                   "Chat",
                   style: TextStyle(
                       color: AppColors.primaryThreeElementText,
                       fontWeight: FontWeight.normal,
                       fontSize: 14.sp
                   ),
                 ),
               ],
             ),
           ),
         ),
         GestureDetector(
           onTap: (){
             controller.goTabStatus();
           },
           child: Container(
             width: 150.w,
             height: 40.h,
             decoration: controller.state.tapStatus.value ? BoxDecoration():BoxDecoration(
                 color: AppColors.primaryBackground,
                 borderRadius: BorderRadius.all(Radius.circular(5.r)),
                 boxShadow: [
                   BoxShadow(
                       color: Colors.grey.withOpacity(0.1),
                       spreadRadius: 2,
                       blurRadius: 3,
                       offset: Offset(0,2)
                   )
                 ]
             ),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Text(
                   "Call",
                   style: TextStyle(
                       color: AppColors.primaryThreeElementText,
                       fontWeight: FontWeight.normal,
                       fontSize: 14.sp
                   ),
                 ),
               ],
             ),
           ),
         )
       ],
     ),
   );

 }

  Widget _chatListItem(Message item){
   return Container(
     padding: EdgeInsets.only(top:10.h,left: 0.w,right: 0.w,bottom: 10.h),
     child: InkWell(
       onTap: (){
        if(item.doc_id!=null){
          Get.toNamed("/chat",
          parameters: {
            "doc_id" : item.doc_id!,
            "to_token" : item.token!,
            "to_name" : item.name!,
            "to_avatar" : item.avatar!,
            "to_online" : item.online.toString()
          }
          );
        }
       },
       child: Row(
         children: [
           Container(
             width: 44.w,
             height: 44.h,
             margin: EdgeInsets.only(top: 0.h,left: 0.w,right: 10.w),
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
             child: item.avatar==null?
             Image(image: AssetImage("assets/images/account_header.png")):
             CachedNetworkImage(
               imageUrl: item.avatar!,
               height: 44.h,
               width: 44.w,
               imageBuilder: (context,imageProvider) => Container(
                 decoration: BoxDecoration(
                     borderRadius: BorderRadius.all(Radius.circular(22.r)),
                     image: DecorationImage(
                         image: imageProvider,
                         fit: BoxFit.fill
                     )
                 ),
               ),
               errorWidget: (context,url,error) => Image(
                   image: AssetImage(
                       'assets/images/account_header.png'
                   )
               ),
             ),


           ),
           Container(
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               crossAxisAlignment: CrossAxisAlignment.center,
               children: [
                 SizedBox(
                   width: 175.w,
                   height: 44.w,
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Text("${item.name}",
                         overflow: TextOverflow.clip,
                         maxLines: 1,
                         softWrap: false,
                         style: TextStyle(
                           fontFamily: "Avenir",
                           fontWeight: FontWeight.bold,
                           color: AppColors.thirdElement,
                           fontSize: 14.sp
                         ),
                       ),
                       Text("${item.last_msg}",
                           overflow: TextOverflow.clip,
                           maxLines: 1,
                           softWrap: false,
                           style: TextStyle(
                               fontFamily: "Avenir",
                               fontWeight: FontWeight.normal,
                               color: AppColors.primarySecondaryElementText,
                               fontSize: 12.sp
                           )
                       )
                     ],
                   ),
                 ),
                 SizedBox(
                   width: 86.w,
                   height: 44.h,
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     crossAxisAlignment: CrossAxisAlignment.end,
                     children: [
                       Text(
                           item.last_time==null ? "" : duTimeLineFormat(
                               (item.last_time as Timestamp).toDate()),
                         textAlign: TextAlign.end,
                         maxLines: 1,
                         overflow: TextOverflow.fade,
                         style: TextStyle(
                             fontFamily: "Avenir",
                             fontWeight: FontWeight.normal,
                             color: AppColors.primaryElementText,
                             fontSize: 11.sp
                         ),
                       ),
                       item.msg_num == 0 ? Container() : Container(
                         decoration: BoxDecoration(
                           color: Colors.red,
                           borderRadius: BorderRadius.all(Radius.circular(10.r)),
                         ),
                         padding: EdgeInsets.only(left: 4.w,right: 4.w),
                         child: Text("${item.msg_num}",
                           maxLines: 1,
                           softWrap: false,
                           style: TextStyle(
                               fontFamily: "Avenir",
                               fontWeight: FontWeight.normal,
                               color: AppColors.primaryElementText,
                               fontSize: 11.sp
                           ),
                         ),
                       )
                     ],
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

  Widget _callListItem(CallMessage item){
    return Container(
      padding: EdgeInsets.only(top:10.h,left: 0.w,right: 0.w,bottom: 10.h),
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  width: 1, color: AppColors.primarySecondaryBackground))),
      child: InkWell(
        onTap: (){},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 44.w,
              height: 44.h,
              margin: EdgeInsets.only(top: 0.h,left: 0.w,right: 10.w),
              decoration: BoxDecoration(
                  color: AppColors.primarySecondaryBackground,
                  borderRadius: BorderRadius.all(Radius.circular(22.r)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: const Offset(0,1)
                    )
                  ]
              ),
              child: item.avatar==null?
              Image(image: AssetImage("assets/images/account_header.png"))
              :CachedNetworkImage(
                imageUrl: item.avatar!,
                height: 44.h,
                width: 44.w,
                imageBuilder: (context,imageProvider) => Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(22.r)),
                      image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.fill
                      )
                  ),
                ),
                errorWidget: (context,url,error) => Image(
                    image: AssetImage(
                        'assets/images/account_header.png'
                    )
                ),
              ),


            ),
            Container(
              padding: EdgeInsets.only(top: 0.w, left: 0.w, right: 0.w, bottom: 0.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 175.w,
                    height: 44.w,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${item.name}",
                          overflow: TextOverflow.clip,
                          maxLines: 1,
                          softWrap: false,
                          style: TextStyle(
                              fontFamily: "Avenir",
                              fontWeight: FontWeight.bold,
                              color: AppColors.thirdElement,
                              fontSize: 14.sp
                          ),
                        ),
                        Text("${item.call_time}",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            softWrap: false,
                            style: TextStyle(
                                fontFamily: "Avenir",
                                fontWeight: FontWeight.normal,
                                color: AppColors.primarySecondaryElementText,
                                fontSize: 12.sp
                            )
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 86.w,
                    height: 44.h,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          item.last_time==null ? "" : duTimeLineFormat(
                              (item.last_time as Timestamp).toDate()),
                          textAlign: TextAlign.end,
                          overflow: TextOverflow.fade,
                          maxLines: 1,
                          style: TextStyle(
                              fontFamily: "Avenir",
                              fontWeight: FontWeight.normal,
                              color: AppColors.primaryElementText,
                              fontSize: 11.sp
                          ),
                        ),
                        Text(
                          item.type == null ? "" : "${item.type}",
                          textAlign: TextAlign.end,
                          overflow: TextOverflow.fade,
                          maxLines: 1,
                          style: TextStyle(
                            fontFamily: 'Avenir',
                            fontWeight: FontWeight.normal,
                            color: AppColors.thirdElementText,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
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
    return Scaffold(
        body: Obx(() => SafeArea(
          child: Stack(
            children: [
              CustomScrollView(
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    title: _headBar(),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.symmetric(vertical: 0.h,horizontal: 20.w),
                    sliver: SliverToBoxAdapter(
                      child: _headTabs(),
                    ),
                  ),
                  SliverPadding(
                      padding: EdgeInsets.symmetric(vertical: 0.h,horizontal: 20.w),
                      sliver: controller.state.tapStatus.value ?  SliverList(
                          delegate:  SliverChildBuilderDelegate(
                             (context,index){
                                var item = controller.state.msgList[index];
                                return _chatListItem(item);
                             },
                            childCount: controller.state.msgList.length
                          ),
                  ) : SliverList(
                        delegate:  SliverChildBuilderDelegate(
                                (context,index){
                              var item = controller.state.callList[index];
                              return _callListItem(item);
                            },
                            childCount: controller.state.callList.length
                        ),
                    )
                  )
                ],
              ),
              Positioned(
                right: 20.w,
                bottom: 70.h,
                height: 50.h,
                width: 50.w,
                child: GestureDetector(
                  child: Container(
                    height: 50.h,
                    width: 50.w,
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                        color: AppColors.primaryElement,
                        borderRadius: BorderRadius.all(Radius.circular(40.r)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 2,
                              offset: Offset(1,1)
                          )
                        ]
                    ),
                    child: Image.asset("assets/icons/contact.png"),
                  ),
                  onTap: (){
                    Get.toNamed(AppRoutes.Contact);
                  },
                ),
              ),
            ],
          ),
        ))
    );
  }

}
