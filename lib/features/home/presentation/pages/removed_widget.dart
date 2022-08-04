            // Timer(const Duration(seconds: 2), () {
    // toggleScrolling();
    // });
            
            
            
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   children: [
              //     container(
              //         bordercolor: AppColor.grey,
              //         width: w(300),
              //         hight: h(45),
              //         color: Colors.white,
              //         borderRadius: 5,
              //         child: Row(
              //           children: [
              //             SizedBox(
              //               width: w(20),
              //             ),
              //             SvgPicture.asset("assets/images/search.svg"),
              //             SizedBox(
              //               width: w(20),
              //             ),
              //             container(
              //               width: w(200),
              //               child: textform(
              //                 hintsize: 14.sp,
              //                 controller: searchc,
              //                 function: (val) {
              //                   search = val;
              //                 },
              //                 hint: "search",
              //                 validation: "name",
              //                 hintColor: AppColor.hintcolor,
              //               ),
              //             ),
              //           ],
              //         )),
              //     container(
              //         hight: h(45),
              //         width: w(35),
              //         color: AppColor.blue,
              //         child: Center(
              //             child:
              //                 SvgPicture.asset("assets/images/searchFilter.svg")))
              //   ],
              // ),

              // SizedBox(
              //   height: h(20),
              // ),
              // SizedBox(
              //   height: h(50),
              //   width: MediaQuery.of(context).size.width,
              //   child: NotificationListener(
              //     onNotification: (notif) {
              //       double maxScroll = scrollController.position.maxScrollExtent;
              //       double currentScroll = scrollController.position.pixels;
              //       if (currentScroll == 0) {
              //         Timer(const Duration(seconds: 1), () {
              //           if (scrollController.hasClients) {
              //             _scroll();
              //           }
              //         });
              //       }
              //       if (maxScroll - currentScroll == 0) {
              //         scrollback();
              //       }

              //       return true;
              //     },
              //     child: ListView.builder(
              //       scrollDirection: Axis.horizontal,
              //       itemCount: values.length,
              //       controller: scrollController,
              //       itemBuilder: (context, index) => Padding(
              //         padding: EdgeInsets.symmetric(horizontal: h(10)),
              //         child: container(
              //           color: Colors.white,
              //           borderRadius: 4,
              //           child: ConstrainedBox(
              //             constraints:
              //                 BoxConstraints(maxWidth: w(170), minWidth: w(50)),
              //             child: Padding(
              //               padding: EdgeInsets.all(w(5)),
              //               child: text(
              //                   textAlign: TextAlign.center,
              //                   text: values[index],
              //                   color: AppColor.hintcolor,
              //                   // textDecoration: TextDecoration.underline,
              //                   fontsize: 16.sp),
              //             ),
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: h(10),
              // ),






              //////////
              ///
              ///    //  container(
                    //     color: Colors.white,
                    //     width: w(320),
                    //     hight: h(120),
                    //     child: Column(
                    //       children: [
                    //         Row(
                    //           children: [
                    //             SizedBox(
                    //               width: w(5),
                    //             ),
                    //             Column(children: [
                    //               SizedBox(
                    //                 height: h(10),
                    //               ),
                    //               ClipRRect(
                    //                 child: container(
                    //                     hight: h(100),
                    //                     width: w(150),
                    //                     child: Container(
                    //                       color: Colors.grey,
                    //                     )),
                    //               )
                    //             ]),
                    //             SizedBox(
                    //               height: h(150),
                    //               width: w(160),
                    //               child: Column(
                    //                 crossAxisAlignment:
                    //                     CrossAxisAlignment.center,
                    //                 mainAxisAlignment: MainAxisAlignment.start,
                    //                 children: [
                    //                   SizedBox(
                    //                     height: h(30),
                    //                   ),
                    //                   text(
                    //                       text: "King of Crowns",
                    //                       fontsize: 14.sp),
                    //                   SizedBox(
                    //                     height: h(5),
                    //                   ),
                    //                   text(
                    //                       text: "Praesent ac libero NFT",
                    //                       fontsize: 14.sp,
                    //                       color: AppColor.hintcolor),
                    //                   SizedBox(
                    //                     height: h(10),
                    //                   ),
                    //                   container(
                    //                       width: w(140),
                    //                       hight: h(40),
                    //                       borderRadius: 5,
                    //                       color: AppColor.blue,
                    //                       child: text(
                    //                           text: "Place a Bid",
                    //                           color: Colors.white)),
                    //                 ],
                    //               ),
                    //             )
                    //           ],
                    //         )
                    //       ],
                    //     )),

                    /////////
                    ///
                    ///
                    ///
                    ///
                    ///
                    /// // _scroll() {
  //   if (scrollController.hasClients) {
  //     double maxExtent = scrollController.position.maxScrollExtent;
  //     double distanceDifference = maxExtent - scrollController.offset;
  //     double durationDouble = distanceDifference / speedFactor;

  //     scrollController.animateTo(scrollController.position.maxScrollExtent,
  //         duration: Duration(seconds: durationDouble.toInt()),
  //         curve: Curves.linear);
  //   }
  // }

  // scrollback() {
  //   // double maxExtent = scrollController.position.maxScrollExtent;
  //   // double distanceDifference = maxExtent - scrollController.offset;
  //   double durationDouble = values.length.toDouble();

  //   scrollController.animateTo(scrollController.position.minScrollExtent,
  //       duration: Duration(seconds: durationDouble.toInt()),
  //       curve: Curves.linear);
  // }

  // toggleScrolling() {
  //   // setState(() {
  //   scroll = !scroll;
  //   // });

  //   if (scroll) {
  //     _scroll();
  //   }
  // else {
  //   scrollController.animateTo(scrollController.offset,
  //       duration: const Duration(seconds: 1), curve: Curves.linear);
  // }