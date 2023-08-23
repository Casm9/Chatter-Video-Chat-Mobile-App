import 'package:chatter/common/values/values.dart';
import 'package:chatter/pages/message/chat/index.dart';
import 'package:chatter/pages/message/chat/widgets/chat_left_list.dart';
import 'package:chatter/pages/message/chat/widgets/chat_right_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChatList extends GetView<ChatController> {
  const ChatList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
      color: AppColors.primaryBackground,
      padding: EdgeInsets.only(bottom: 70.h),
      child: GestureDetector(
        child: CustomScrollView(
          controller: controller.myScrollController,
          reverse: true,
          slivers: [
            SliverPadding(
              padding: EdgeInsets.symmetric(
                  vertical: 0.h,
                  horizontal: 0.w,
                ),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context,index){
                  var item = controller.state.msgContentList[index];
                  if(controller.token == item.token){ //user token with msglist token
                    return ChatRightList(item);
                  }
                  return ChatLeftList(item);
                },
                  childCount: controller.state.msgContentList.length
                ),
              ),

            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(vertical: 0.h,horizontal: 0.w),
              sliver: SliverToBoxAdapter(
                  child: controller.state.isLoading.value?Align(
                    alignment: Alignment.center,
                    child: Text("loading...")
                  ):Container()
              ),
            )
          ],
        ),
        onTap: (){
          controller.closeAllPop();
        },
      ),
    ));
  }
}
