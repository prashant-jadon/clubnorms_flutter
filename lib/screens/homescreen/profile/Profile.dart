import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // Initialize the TabController with length matching the number of tabs
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Profile Picture, Username, and Email Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  // Profile Picture
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(
                      'https://example.com/profile_picture.jpg', // Replace with actual URL or asset
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Username and Email
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'John Doe',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'johndoe@example.com',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Tab Bar
            TabBar(
              controller: _tabController,
              labelColor: Colors.black,
              indicatorColor: Colors.blue,
              tabs: const [
                Tab(text: 'Earlier'),
                Tab(text: 'Ongoing'),
              ],
            ),
            
            // Tab Bar View
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Earlier Virtual Groups
                  ListView(
                    padding: const EdgeInsets.all(16.0),
                    children: const [
                      ListTile(
                        leading: Icon(Icons.group),
                        title: Text('Group 1'),
                        subtitle: Text('Joined on: 2024-01-01'),
                      ),
                      ListTile(
                        leading: Icon(Icons.group),
                        title: Text('Group 2'),
                        subtitle: Text('Joined on: 2023-12-01'),
                      ),
                      // Add more earlier groups as needed
                    ],
                  ),
                  
                  // Ongoing Virtual Groups
                  ListView(
                    padding: const EdgeInsets.all(16.0),
                    children: const [
                      ListTile(
                        leading: Icon(Icons.group),
                        title: Text('Ongoing Group 1'),
                        subtitle: Text('Started on: 2024-02-01'),
                      ),
                      ListTile(
                        leading: Icon(Icons.group),
                        title: Text('Ongoing Group 2'),
                        subtitle: Text('Started on: 2024-01-15'),
                      ),
                      // Add more ongoing groups as needed
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
