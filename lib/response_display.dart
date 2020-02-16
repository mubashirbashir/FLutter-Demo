import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_state.dart';

class ResponseDisplay extends StatefulWidget {
  @override
  _ResponseDisplayState createState() => _ResponseDisplayState();
}

class _ResponseDisplayState extends State<ResponseDisplay> {
  var isSelected = false;

  var _listKey;
  List colors= [Colors.accents];
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal:16.0),
      child: appState.isFetching
          ? Center(child: CircularProgressIndicator())
          : appState.getResponseJson() != null
              ? ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: appState.getResponseJson().length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        key: _listKey,

            leading: CircleAvatar(
              backgroundColor: (colors.toList()..shuffle()).first[index%14],

           child:appState.getResponseJson()[index]["selected"]
               ?Icon(Icons.check): Text(appState.getResponseJson()[index]["name"].toString().substring(0,1)),
            ),
                        selected: isSelected,
                        title: Text(
                          appState.getResponseJson()[index]["name"],
                        ),
                        subtitle: Text(appState
                            .getResponseJson()[index]["email"]
                            .toString()),
//                        trailing: appState.getResponseJson()[index]["selected"]
//                            ? Icon(Icons.check_circle)
//                            : Container(
//                                height: 0,
//                                width: 0,
//                              ),
                        onLongPress: () {
                          toggleSelection(index, appState);
                        },
                      ),
                    );
                  },
                )
              : Center(child: Text("Hit refresh to fetch data / Use Firebase Console to check Fcm functionality")),
    );
  }

  void toggleSelection(int index, final appState) {
    if (appState.getResponseJson()[index]["selected"]) {
      appState.getResponseJson()[index]["selected"] = false;
    } else {
      appState.getResponseJson()[index]["selected"] = true;
    }

    appState.toggleAppbarButtons();
    appState.notifyListeners();
  }
}
