import 'package:empty_placeholder_view/emptylistplaceholderview.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Expanded(
                child: /*true
                        ? ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                return MailTile();
                              }
                              return MailTile();
                            })
                        :*/
                    EmptyListPlaceholder(
                  state: ApiState.loading,
                  loadingTitle: 'emptyKeyReleaseTitle',
                  loadingSubtitle: 'store.serverError',
                  buttonColor: Colors.amber,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
