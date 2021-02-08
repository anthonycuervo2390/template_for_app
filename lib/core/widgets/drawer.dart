import 'file:///C:/Users/antho/Documents/App_Development/firestore_demo/lib/core/widgets/oval_right_clipper.dart';
import 'package:firestore_demo/core/presentation/res/routes.dart';
import 'package:firestore_demo/features/wods/data/services/models/app_wod.dart';
import 'package:flutter/material.dart';
import 'package:firestore_demo/features/home/presentation/pages/home.dart';

class BuildDrawer extends StatelessWidget {
  const BuildDrawer({
    Key key,
    @required this.primary,
    @required this.active,
  }) : super(key: key);

  final Color primary;
  final Color active;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: OvalRightBorderClipper(),
      child: Drawer(
        child: Container(
          padding: const EdgeInsets.only(left: 16.0, right: 40),
          decoration: BoxDecoration(
              color: primary, boxShadow: [BoxShadow(color: Colors.black45)]),
          width: 300,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 90,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                            colors: [Colors.pink, Colors.deepPurple])),
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage('image'),
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    "erika costell",
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                  Text(
                    "@erika07",
                    style: TextStyle(color: active, fontSize: 16.0),
                  ),
                  SizedBox(height: 30.0),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(children: [
                      Icon(
                        Icons.home,
                        color: active,
                      ),
                      SizedBox(width: 10.0),
                      Text(
                        "Today's WOD",
                        style: TextStyle(color: active, fontSize: 16.0),
                      ),
                    ]),
                  ),
                  Divider(
                    color: active,
                  ),
                  InkWell(
                    onTap: () =>
                        Navigator.pushNamed(context, AppRoutes.profile),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(children: [
                        Icon(
                          Icons.person_pin,
                          color: active,
                        ),
                        SizedBox(width: 10.0),
                        Text(
                          "Class Schedule",
                          style: TextStyle(color: active, fontSize: 16.0),
                        ),
                      ]),
                    ),
                  ),
                  Divider(
                    color: active,
                  ),
                  InkWell(
                    onTap: () =>
                        Navigator.pushNamed(context, AppRoutes.addResult),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(children: [
                        Icon(
                          Icons.settings,
                          color: active,
                        ),
                        SizedBox(width: 10.0),
                        Text(
                          "Add results",
                          style: TextStyle(color: active, fontSize: 16.0),
                        ),
                      ]),
                    ),
                  ),
                  Divider(
                    color: active,
                  ),
                  InkWell(
                    onTap: () =>
                        Navigator.pushNamed(context, AppRoutes.results),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(children: [
                        Icon(
                          Icons.email,
                          color: active,
                        ),
                        SizedBox(width: 10.0),
                        Text(
                          "Whiteboard",
                          style: TextStyle(color: active, fontSize: 16.0),
                        ),
                      ]),
                    ),
                  ),
                  Divider(
                    color: active,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(children: [
                      Icon(
                        Icons.info_outline,
                        color: active,
                      ),
                      SizedBox(width: 10.0),
                      Text(
                        "Performance History",
                        style: TextStyle(color: active, fontSize: 16.0),
                      ),
                    ]),
                  ),
                  Divider(
                    color: active,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(children: [
                      Icon(
                        Icons.info_outline,
                        color: active,
                      ),
                      SizedBox(width: 10.0),
                      Text(
                        "IMC Calculator",
                        style: TextStyle(color: active, fontSize: 16.0),
                      ),
                    ]),
                  ),
                  Divider(
                    color: active,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(children: [
                      Icon(
                        Icons.info_outline,
                        color: active,
                      ),
                      SizedBox(width: 10.0),
                      Text(
                        "Group Chat",
                        style: TextStyle(color: active, fontSize: 16.0),
                      ),
                    ]),
                  ),
                  Divider(
                    color: active,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(children: [
                      Icon(
                        Icons.info_outline,
                        color: active,
                      ),
                      SizedBox(width: 10.0),
                      Text(
                        "Logout",
                        style: TextStyle(color: active, fontSize: 16.0),
                      ),
                    ]),
                  ),
                  Divider(
                    color: active,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
