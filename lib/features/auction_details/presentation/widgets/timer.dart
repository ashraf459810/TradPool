
import 'package:countdown_flutter/countdown_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradpool/App/app.dart';
import 'package:tradpool/Widgets/container.dart';

 Widget timerWidget (Duration duration){ return Container(color: Colors.grey[50],
   child: Center(
     child: Row(mainAxisAlignment: MainAxisAlignment.center,
       children: [
         container(width: w(150),color: Colors.grey[50],
                                        child: Countdown(
                                          duration : duration??const   Duration(seconds: 0),
                                          onFinish: () {
                                    
                                          },
                                          builder:
                                              (BuildContext ctx, Duration remaining) {
                                            return Row(mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                remaining.inDays != 0
                                                    ? Text(
                                                        '${remaining.inDays}days ',
                                                        style:
                                                            TextStyle(fontSize: 14.sp,color: Colors.black),
                                                      )
                                                    : const SizedBox(),
                                                Text(
                                                  '${remaining.inHours.remainder(24)}H ',
                                                  style: TextStyle(fontSize: 14.sp,color: Colors.black),
                                                ),
                                                Text(
                                                  '${remaining.inMinutes.remainder(60)}M ',
                                                  style: TextStyle(fontSize: 14.sp,color: Colors.black),
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      ),
       ],
     ),
   ),
 );}