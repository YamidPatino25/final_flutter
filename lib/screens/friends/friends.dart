import 'package:flutter/material.dart';
import 'package:final_flutter/base/model.dart';
import 'package:final_flutter/base/view.dart';
import 'package:final_flutter/shared/loading.dart';
import 'package:final_flutter/viewmodels/friends_viewmodel.dart';

class Friends extends StatefulWidget {
  @override
  _FriendsState createState() => _FriendsState();
}

class _FriendsState extends State<Friends> {
  dynamic selectedList;

  @override
  Widget build(BuildContext context) {
    return BaseView<FriendsViewModel>(
      builder: (context, model, child) {
        return Scaffold(
          resizeToAvoidBottomPadding: false,
          appBar: AppBar(title: Text('Home'), actions: <Widget>[
            IconButton(
              onPressed: () {
                model.logout();
              },
              icon: Icon(Icons.exit_to_app, color: Colors.black, size: 24.0),
            )
          ]),
          body: model.state == ViewState.Busy
              ? Center(child: Loading())
              : friendsView(model),
        );
      },
    );
  }

  Widget friendsView(FriendsViewModel model) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15.0),
        child: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Column(children: <Widget>[
            Text(
              'Amigos',
            )
          ]),
        ),
      ),
    );
  }
}
