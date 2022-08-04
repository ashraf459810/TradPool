import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tradpool/App/app.dart';
import 'package:tradpool/Core/consts.dart';


import 'package:tradpool/Widgets/nav.dart';

import 'package:tradpool/Widgets/text.dart';

import 'package:tradpool/features/auction_details/presentation/pages/auction_details.dart';

import 'package:tradpool/features/notifications/data/model/notification_model.dart';
import 'package:tradpool/features/notifications/presentation/bloc/notifications_bloc.dart';

import '../../../../injection_container.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key key}) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  var marked = [];
  ScrollController scrollController = ScrollController();
  List<NotificationsList> notifications = [];
  int page = 0;
  int size = 10;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<NotificationsBloc>()..add(FetchUserNotificationEvent(page, size)),
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(h(60)),
            child: AppBar(
              backgroundColor: Colors.grey[50],
              elevation: 0,
              actions: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                    Icons.close,
                    color: AppColor.blue,
                  ),
                ),
                SizedBox(
                  width: w(20),
                ),
              ],
              title: text(
                  text: "Notifications",
                  color: AppColor.darkBlue,
                  fontsize: 30.sp,
                  fontWeight: FontWeight.bold),
            ),
          ),
          body: ListView(
            shrinkWrap: true,
            children: [
              GestureDetector(
                onTap: ()
                 async {
                 
                 
                  Client client = Client();

                  int size;
                  if (marked.isEmpty) {
                    size = 100;
                  } else {
                    size = marked.length;
                  }
                await client.get(Uri.parse(
                      "https://tradpool.com/client/mark-all-notifications-as-seen?client=${sl<SharedPreferences>().get(Con.token)}&page=$page&size=$size"));
                   sl<NotificationsBloc>().add(FetchUserNotificationEvent(page, size));

                       
                 },

                
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      text(
                          text: "MarkAllAsRead",
                          color: AppColor.blue,
                          fontsize: 12.sp,
                          fontWeight: FontWeight.bold),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: h(10),
              ),
              BlocBuilder<NotificationsBloc, NotificationsState>(
                builder: (context, state) {
                  if (state is Loading) {
                    // return const Center(child: LoadingState());
                  }
                  if (state is FetchUserNotificationState) {
                    notifications = state.notifications;
                  }
                  return notifications.isNotEmpty
                      ? NotificationListener<ScrollNotification>(
                          onNotification: (notification) {
                            if (notification is ScrollEndNotification &&
                                scrollController.position.extentAfter == 0) {
                              page++;

                              context
                                  .read<NotificationsBloc>()
                                  .add(FetchUserNotificationEvent(page, size));
                            }

                            return false;
                          },
                          child: SizedBox(
                            child: ListView.builder(
                              shrinkWrap: true,
                              controller: scrollController,
                              itemCount: notifications.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    if (notifications[index].seen == false) {
                                      log('here false ');
                                      context.read<NotificationsBloc>().add(
                                          MarkNotificationSeenEvent(
                                              notifications[index].id));
                                    }
                                    {
                                      nav(
                                        context,
                                        AuctionDetails(
                                            auctionId: notifications[index]
                                                .context
                                                .id),
                                      );
                                    }
                                  },
                                  onLongPress: () {
                                    marked.add(index);
                                    setState(() {});
                                  },
                                  child: Container(
                                    color: marked.contains(index)
                                        ? Colors.grey[300]
                                        : Colors.transparent,
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Container(
                                                width: w(10),
                                                height: h(10),
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: notifications[index]
                                                            .seen
                                                        ? AppColor.blue
                                                        : AppColor.hintcolor),
                                              ),
                                              text(
                                                  text: notifications[index]
                                                      .title),
                                              Column(
                                                children: [
                                                  text(
                                                      text: notifications[index]
                                                              .creationDate
                                                              .hour
                                                              .toString() +
                                                          " : " +
                                                          notifications[index]
                                                              .creationDate
                                                              .minute
                                                              .toString(),
                                                      fontsize: 16.sp,
                                                      color: AppColor.grey),
                                                  text(
                                                      text:
                                                          notifications[index]
                                                                  .creationDate
                                                                  .day
                                                                  .toString() +
                                                              "-" +
                                                              notifications[
                                                                      index]
                                                                  .creationDate
                                                                  .month
                                                                  .toString() +
                                                              "-" +
                                                              notifications[
                                                                      index]
                                                                  .creationDate
                                                                  .year
                                                                  .toString(),
                                                      color: AppColor.blue),
                                                ],
                                              )
                                            ],
                                          ),
                                          Container(
                                            height: h(1),
                                            width: w(300),
                                            color: AppColor.grey,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ))
                      : const SizedBox();
                },
              )
            ],
          )),
    );
  }
}
