import 'dart:async';
import 'dart:io';

import 'package:chat_bubbles/bubbles/bubble_special_one.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:tradpool/Core/consts.dart';
import 'package:tradpool/Core/remote_data_function/http_methods.dart';

import 'package:tradpool/Widgets/nav.dart';

import 'package:tradpool/features/add_auction/presentation/bloc/add_item_bloc.dart'
    as add;
import 'package:tradpool/features/auction_details/data/model/messages_request_body.dart';
import 'package:tradpool/features/auction_details/presentation/bloc/auction_details_bloc.dart';
import 'package:tradpool/features/auction_details/presentation/widgets/image_widget.dart';

import '../../../../Widgets/text_form.dart';
import '../../../../injection_container.dart';
import '../../data/model/auction_details.dart';

// ignore: must_be_immutable
class ChatRoom extends StatefulWidget {
  final String auctionId;
  List<Message> messages;
  ChatRoom({Key key, this.messages, this.auctionId}) : super(key: key);

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  ScrollController scroll = ScrollController();
  TextEditingController desc = TextEditingController();
  String des;
  final ImagePicker picker = ImagePicker();
  AuctionDetailsBloc auctionDetailsBloc = sl<AuctionDetailsBloc>();
  TextEditingController messageController = TextEditingController();
  add.AddItemBloc addItemBloc = sl<add.AddItemBloc>();
  String imageId;
  @override
  void initState() {
          
    timer();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: const Text(
            "chat",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          iconTheme: IconThemeData(color: AppColor.blue),
        ),
        body: Column(
          children: [
            BlocConsumer(
              bloc: auctionDetailsBloc,
              listener: (context, state) {
                if (state is Error) {
                  Toast.show(state.error, context, gravity: 2);
                }
              },
              builder: (context, state) {
                if (state is SendMessagesState) {
                  widget.messages = state.messagesModel;
                }
                return Expanded(
                  
                  child: ListView.builder(
                    controller: scroll,
                    padding: const EdgeInsets.all(10),
                    reverse: false,
                    itemBuilder: (context, index) {
                      if (widget.messages[index] != null) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: messageAlignment(
                            widget.messages[index],
                          ),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                    // separatorBuilder: (context, index) =>
                    //     const SizedBox(height: 4),
                    itemCount: widget.messages.length,
                  ),
                );
              },
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 10,
                right: 10,
                top: 10,
                bottom: 20,
              ),
              child: BlocConsumer(
                bloc: addItemBloc,
                listener: (context, state) {
                  if (state is add.AddFileState) {
                    imageId = state.addFileResponse[0].id;
             
                    auctionDetailsBloc.add(
                      SendMessagesEvent(MessageRequestBody(
                          attachments: [SellRequest(id: imageId)],
                          message: desc.text,
                          sellRequest: SellRequest(id: widget.auctionId),
                          sender: SellRequest(
                              id: sl<SharedPreferences>()
                                  .getString(Con.token)))),
                    );
                  }
                },
                builder: (context, state) {
                  return sendingShape(context);
                },
              ),
            ),
          ],
        ));
  }

  void sendMessage(context, text) {
    if (widget.messages.length < 50) {
      auctionDetailsBloc.add(SendMessagesEvent(MessageRequestBody(
          sender: SellRequest(id: sl<SharedPreferences>().getString(Con.token)),
          message: text,
          sellRequest: SellRequest(id: widget.auctionId),
          attachments: [])));
    }
  }

  Widget sendingShape(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(35),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                sendMessage(context, messageController.text);
                messageController.clear();
              },
              child: CircleAvatar(
                radius: 18,
                backgroundColor: AppColor.blue,
                child: const Center(
                  child: Padding(
                      padding: EdgeInsets.only(left: 4),
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                      )),
                ),
              ),
            ),
            Expanded(
                child: TextField(
              keyboardType: TextInputType.text,
              controller: messageController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
            )),
            GestureDetector(
                onTap: () {
                  chooseImage(true, context);
                },
                child: Icon(
                  Icons.image,
                  color: AppColor.blue,
                ))
          ],
        ),
      ),
    );
  }

  Future<List<XFile>> chooseImage(bool iscamera, BuildContext context) async {
    final pickedfile = await picker.pickImage(source: ImageSource.gallery);

    // source: iscamera ? ImageSource.camera : ImageSource.gallery);

    if (pickedfile != null) {
      showAlertDialog(context, pickedfile);
      // return pickedfile;
    } else {
      List<XFile> list = [];
      return list;
    }
    return null;
  }

  showAlertDialog(BuildContext context, XFile image) {
    // set up the button
    Widget okButton = TextButton(
      child: const Text("send"),
      onPressed: () {
        addItemBloc.add(add.UploadFileEvent('', [image]));

        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      scrollable: true,
      content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.file(File(image.path)),
            textform(
                validation: "name",
                controller: desc,
                hint: "add description here",
                function: (val) {
                  des = val;
                })
          ]),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget messageAlignment(Message msg) {
    bool isMe = msg.senderType.toString() == "BUYER" ? true : false;
    return Column(
      crossAxisAlignment:
          isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        (msg.attachments.isNotEmpty)
            ? GestureDetector(
                onTap: () {
                  nav(context, ImageZoom(image: msg.attachments[0].publicUrl));
                },
                child: Image.network(
                  msg.attachments[0].publicUrl,
                  height: 70.h,
                  width: 150.w,
                  fit: BoxFit.contain,
                ),
              )
            : const SizedBox(),
        Container(
          padding: const EdgeInsets.all(10),
          child: Directionality(
            textDirection: isMe ? TextDirection.rtl : TextDirection.ltr,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: isMe
                      ? const Color.fromRGBO(195, 199, 214, 1)
                      : Colors.white,
                  child: Center(
                    child: Padding(
                        padding: const EdgeInsets.only(left: 0),
                        child: Icon(
                          Icons.person,
                          size: 20,
                          color: AppColor.blue,
                        )),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      BubbleSpecialOne(
                        text: msg.message,
                        isSender: isMe,
                        color: isMe
                            ? const Color.fromRGBO(195, 199, 214, 1)
                            : Colors.white,
                        textStyle: TextStyle(
                          fontSize: 16,
                          color: !isMe
                              ? const Color.fromRGBO(195, 199, 214, 1)
                              : Colors.white,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // msg.attachments.isNotEmpty ? container(hight: 100,width: 100,child: Image.network(msg.attachments[0].publicUrl)):const SizedBox()
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  timer() {
    Timer(const Duration(seconds: 3), () async {
      NetworkFunctions networkFunctions = NetworkFunctionsImp();

      Future.delayed(const Duration(seconds: 2)).then((_) async {
        if (mounted) {
          var response = await networkFunctions.getMethod(
            
              
              baseurl: "http://159.89.51.204:8080",
              url:
                  "/tradepool/buy-and-sell/get-sell-request-messages?sellRequest=${widget.auctionId}&user=${sl<SharedPreferences>().getString(Con.token)}");
                  

          var messages = messagesFromJson(response);

          widget.messages = messages;

          // Anything else you want


        }
      }).then((value) {
        setState(() {
          timer();
  });
      });
    });
  }
}



// To parse this JSON data, do
//
//     final messages = messagesFromJson(jsonString);



// List<Messages> messagesFromJson(String str) => List<Messages>.from(json.decode(str).map((x) => Messages.fromJson(x)));

// String messagesToJson(List<Messages> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class Messages {
//     Messages({
//         this.attachments,
//         this.message,
//         this.sender,
//         this.senderType,
//     });

//     List<Attachment> attachments;
//     String message;
//     Sender sender;
//     String senderType;

//     factory Messages.fromJson(Map<String, dynamic> json) => Messages(
//         attachments: List<Attachment>.from(json["attachments"].map((x) => Attachment.fromJson(x))),
//         message: json["message"],
//         sender: Sender.fromJson(json["sender"]),
//         senderType: json["senderType"],
//     );

//     Map<String, dynamic> toJson() => {
//         "attachments": List<dynamic>.from(attachments.map((x) => x.toJson())),
//         "message": message,
//         "sender": sender.toJson(),
//         "senderType": senderType,
//     };
// }

// class Attachment {
//     Attachment({
//         this.publicUrl,
//     });

//     String publicUrl;

//     factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
//         publicUrl: json["publicURL"],
//     );

//     Map<String, dynamic> toJson() => {
//         "publicURL": publicUrl,
//     };
// }

// class Sender {
//     Sender({
//         this.name,
//     });

//     String name;

//     factory Sender.fromJson(Map<String, dynamic> json) => Sender(
//         name: json["name"],
//     );

//     Map<String, dynamic> toJson() => {
//         "name": name,
//     };
// }
