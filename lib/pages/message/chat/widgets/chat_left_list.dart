import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatter/common/entities/entities.dart';
import 'package:chatter/common/values/colors.dart';
import 'package:chatter/common/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget ChatLeftList(Msgcontent item){
  var imagePath = null;
  if(item.type=="image"){
    imagePath = item.content?.replaceAll("http://localhost/", SERVER_API_URL);
  }
  return Container(
    padding: EdgeInsets.symmetric(
        vertical: 10.h,
        horizontal: 20.w
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
              maxWidth: 250.w,
              minHeight: 40.h
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: AppColors.primaryElement,
                    borderRadius: BorderRadius.all(Radius.circular(5.r))
                ),
                padding: EdgeInsets.only(
                    top: 10.h,
                    bottom: 10.h,
                    left: 10.w,
                    right: 10.w
                ),
                child: item.type == "text" ? Text(
                  "${item.content}",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.primaryElementText,

                  ),
                )
                    :ConstrainedBox(
                  constraints: BoxConstraints(
                      maxWidth: 90.w
                  ),
                  child: GestureDetector(
                    child: CachedNetworkImage(
                      imageUrl: imagePath!,
                    ),
                    onTap: (){

                    },
                  ),
                ),

              )
            ],
          ),
        )
      ],
    ),
  );
}