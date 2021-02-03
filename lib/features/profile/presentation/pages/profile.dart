import 'package:firestore_demo/core/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:firestore_demo/core/presentation/res/analytics.dart';
import 'package:firestore_demo/core/presentation/res/routes.dart';
import 'package:firestore_demo/features/auth/data/model/user_repository.dart';
import 'package:firestore_demo/features/profile/presentation/widgets/avatar.dart';
import 'package:firestore_demo/generated/l10n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';

class UserProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Consumer(
        builder: (context, watch, _) {
          final user = watch(userRepoProvider).user;
          return SingleChildScrollView(
            child: Column(
              children: [
                if (user != null) ...[
                  ProfileHeader(
                    avatar: user.photoUrl != null
                        ? NetworkImage(user.photoUrl)
                        : CachedNetworkImageProvider(
                            "http://via.placeholder.com/350x150"),
                    coverImage: user.photoUrl != null
                        ? NetworkImage(user.photoUrl)
                        : CachedNetworkImageProvider(
                            "http://via.placeholder.com/350x150"),
                    title: user.name,
                    actions: [
                      MaterialButton(
                        color: Colors.white,
                        shape: CircleBorder(),
                        elevation: 0,
                        child: Icon(Icons.edit),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  UserInfo(),
                ],
                ...ListTile.divideTiles(
                  color: Theme.of(context).dividerColor,
                  tiles: [
                    ListTile(
                      leading: Icon(Icons.edit),
                      title: Text(S.of(context).editProfile),
                      onTap: () => Navigator.pushNamed(
                          context, AppRoutes.editProfile,
                          arguments: user),
                    ),
                    ListTile(
                      leading: Icon(Icons.exit_to_app),
                      title: Text(S.of(context).logoutButtonText),
                      onTap: () async {
                        await logEvent(context, AppAnalyticsEvents.logOut);
                        await context.read(userRepoProvider).signOut();
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class UserInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
            alignment: Alignment.topLeft,
            child: Text(
              'User Information',
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Card(
            child: Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  Column(
                    children: [
                      ...ListTile.divideTiles(
                        color: Colors.grey,
                        tiles: [
                          ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            leading: Icon(Icons.home),
                            title: Text('Address'),
                            subtitle: Text('Barcelona'),
                          ),
                          ListTile(
                            leading: Icon(Icons.email),
                            title: Text('Email'),
                            subtitle: Text('user@email.com'),
                          ),
                          ListTile(
                            leading: Icon(Icons.phone),
                            title: Text('Phone'),
                            subtitle: Text('123-456-789'),
                          ),
                          ListTile(
                            leading: Icon(Icons.email),
                            title: Text('About me'),
                            subtitle: Text(
                                'This is a about me link and you can know about me in this section.'),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  final ImageProvider<dynamic> coverImage;
  final ImageProvider<dynamic> avatar;
  final String title;
  final String subtitle;
  final List<Widget> actions;

  const ProfileHeader(
      {Key key,
      @required this.coverImage,
      @required this.avatar,
      @required this.title,
      this.subtitle,
      this.actions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Ink(
          height: 200,
          decoration: BoxDecoration(
            image: DecorationImage(image: coverImage, fit: BoxFit.cover),
          ),
        ),
        Ink(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.black38,
          ),
        ),
        if (actions != null)
          Container(
            width: double.infinity,
            height: 200,
            padding: const EdgeInsets.only(bottom: 0.0, right: 0.0),
            alignment: Alignment.bottomRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: actions,
            ),
          ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 130),
          child: Column(
            children: [
              Avatar(
                image: avatar,
                radius: 60,
                backgroundColor: Colors.white,
                borderColor: Colors.grey.shade300,
                borderWidth: 4.0,
              ),
              Text(
                title,
                style: Theme.of(context).textTheme.subtitle2,
              )
            ],
          ),
        )
      ],
    );
  }
}

class Avatar extends StatelessWidget {
  final ImageProvider<dynamic> image;
  final Color borderColor;
  final Color backgroundColor;
  final double radius;
  final double borderWidth;

  const Avatar(
      {Key key,
      @required this.image,
      this.borderColor,
      this.backgroundColor,
      this.radius,
      this.borderWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius + borderWidth,
      backgroundColor: borderColor,
      child: CircleAvatar(
        radius: radius,
        backgroundColor: backgroundColor != null
            ? backgroundColor
            : Theme.of(context).primaryColor,
        child: CircleAvatar(
          radius: radius - borderWidth,
          backgroundImage: image,
        ),
      ),
    );
  }
}
