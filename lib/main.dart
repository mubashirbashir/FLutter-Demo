import 'package:flutter/material.dart';
import 'package:flutter_app/response_display.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

import 'app_state.dart';
import 'feedback_card.dart';
import 'firebase_handler.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Plunes Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ChangeNotifierProvider<AppState>(
          builder: (_) => AppState(),
          child: MyHomePage(),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final notifications = FlutterLocalNotificationsPlugin();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Plunes"),
          actions: Provider.of<AppState>(context).toggleAppbarButtons()
              ? <Widget>[
                  IconButton(
                      onPressed: () {
                        Provider.of<AppState>(context).deleteSelected();
                      },
                      icon: Icon(
                        Icons.delete,
                      )),
                  IconButton(
                      onPressed: () {
                        Provider.of<AppState>(context).unselectAll();
                      },
                      icon: Icon(
                        Icons.clear,
                      ))
                ]
              : <Widget>[
                  IconButton(
                    icon: Icon(Icons.account_circle),
                    onPressed: () {
                      showGeneralDialog(
                          barrierColor: Colors.black.withOpacity(0.1),
                          transitionBuilder: (context, a1, a2, widget) {
                            return Transform.scale(
                              scale: a1.value,
                              child: Opacity(
                                opacity: a1.value,
                                child: Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  elevation: 0.0,
//                        backgroundColor: Colors.transparent,

                                  child: FeedbackCard(),
                                ),
                              ),
                            );
                          },
                          transitionDuration: Duration(milliseconds: 200),
                          barrierDismissible: true,
                          barrierLabel: '',
                          context: context,
                          pageBuilder: (context, animation1, animation2) {});
                    },
                  )
                ]),
      floatingActionButton: FloatingActionButton(
        child: IconButton(
          icon: Icon(
            Icons.refresh,
            color: Colors.white,
          ),
        ),
        onPressed: () => Provider.of<AppState>(context).fetchData(),
      ),
      body: ResponseDisplay(),
    );
  }

  @override
  void initState() {
    new FirebaseNotifications().setUpFirebase();

    final settingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    final settingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: (id, title, body, payload) =>
            onSelectNotification(payload));

    notifications.initialize(
        InitializationSettings(settingsAndroid, settingsIOS),
        onSelectNotification: onSelectNotification);

  }
  Future onSelectNotification(String payload) async {}

}
