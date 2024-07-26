import 'package:flutter/material.dart';
import 'package:library_app/screens/user_account/settings.dart';
import 'package:library_app/themes.dart';

void main() => runApp(ProfilePage());

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UserProfile(),
    );
  }
}

class UserProfile extends StatefulWidget {
  static const nameRoute = '/userProfile';

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  String _username = 'Ryu Sun Jae';
  String _bio = 'Lovely Runner <3';
  final int _followers = 100;
  final int _following = 50;

  List<ActivityItem> _activityFeed = [
    ActivityItem(
      type: ActivityType.like,
      description: 'You liked a story',
      timestamp: 'Yesterday',
    ),
    ActivityItem(
      type: ActivityType.post,
      description: 'You commented a story',
      timestamp: '2 days ago',
    ),
  ];

  void _updateProfile(String newName, String newBio) {
    setState(() {
      _username = newName;
      _bio = newBio;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: const Text('User Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsPage(
                    onUpdateProfile: _updateProfile,
                  ),
                ),
              ).then((result) {
                if (result != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(result)),
                  );
                }
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(20.0),
              color: Colors.white,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 50.0,
                    backgroundImage: NetworkImage('assets/images/user.png'),
                  ),
                  const SizedBox(width: 20.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _username,
                        style: const TextStyle(color: Colors.black),
                      ),
                      const SizedBox(height: 5.0),
                      Text(
                        _bio,
                        style: const TextStyle(color: Colors.black),
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        children: [
                          const Icon(Icons.people, color: Colors.black, size: 16.0),
                          const SizedBox(width: 5.0),
                          Text(
                            '$_followers Followers',
                            style: const TextStyle(color: Colors.black),
                          ),
                          const SizedBox(width: 20.0),
                          const Icon(Icons.person_add, color: Colors.black, size: 16.0),
                          const SizedBox(width: 5.0),
                          Text(
                            '$_following Following',
                            style: const TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    'Recent Activity',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _activityFeed.length,
                  itemBuilder: (context, index) {
                    ActivityItem activity = _activityFeed[index];
                    return ListTile(
                      leading: const CircleAvatar(
                        backgroundImage: NetworkImage('assets/images/user.png'),
                      ),
                      title: Text(
                        activity.description,
                        style: const TextStyle(color: Colors.black),
                      ),
                      subtitle: Text(
                        activity.timestamp,
                        style: const TextStyle(color: Colors.grey),
                      ),
                      onTap: () {
                        if (activity.type == ActivityType.post) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('View post: ${activity.description}'),
                            ),
                          );
                        } else if (activity.type == ActivityType.like) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Liked post: ${activity.description}'),
                            ),
                          );
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

enum ActivityType {
  post,
  like,
}

class ActivityItem {
  final ActivityType type;
  final String description;
  final String timestamp;

  ActivityItem({
    required this.type,
    required this.description,
    required this.timestamp,
  });
}
