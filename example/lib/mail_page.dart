import 'package:empty_placeholder_view/emptylistplaceholderview.dart';
import 'package:example/mail_page_store.dart';
import 'package:example/mail_tile.dart';
import 'package:example/values/extensions.dart';
import 'package:example/values/strings.dart';
import 'package:example/values/vectors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class MailPage extends StatefulObserverWidget {
  @override
  _MailPageState createState() => _MailPageState();
}

class _MailPageState extends State<MailPage> {
  List<Mail> mails = [];
  late MailPageStore store;

  @override
  void initState() {
    super.initState();
    store = (provide<Mail>() as MailPageStore)..fetchMailData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            const Padding(padding: EdgeInsets.only(top: 8)),
            Expanded(
              child: mails.isNotEmpty
                  ? ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return MailTile(mails[index % mails.length]);
                      })
                  : const EmptyListPlaceholder(
                      state: ApiState.loading,
                      loadingTitle: AppStrings.loadingTitle,
                      loadingSubtitle: AppStrings.loadingSubTitle,
                      buttonColor: Color(0xffEE5366),
                      buttonTextColor: Colors.white,
                      titleFontSize: 25,
                      subTitleFontSize: 20,
                      svgPlaceholder: Vectors.keyReleaseIllustration,
                      svgDarkPlaceholder: Vectors.keyReleaseIllustrationDark,
                      buttonText: AppStrings.refresh,
                      loadingWidgetName: LoaderName.hourGlass,
                      loadingColor: Color(0xffEB495C),
                    ),
            )
          ],
        ),
      ),
    );
  }
}

class Mail {
  String sender;
  String sub;
  String msg;
  String date;
  bool isUnread;

  Mail({
    required this.sender,
    required this.sub,
    required this.msg,
    required this.date,
    required this.isUnread,
  });
}
