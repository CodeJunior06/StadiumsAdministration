import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ModuleHomeState();
}

class _ModuleHomeState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    print(user!.uid);

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => const TextField(
              decoration:
                  InputDecoration(suffixIcon: Icon(Icons.search_rounded)),
            ),
            icon:const Icon((Icons.manage_search_outlined)),
          ),
          actions: [
            PopupMenuButton<int>(
              onSelected: (item) => onSelect(context, item),
              itemBuilder: (context) => [
                PopupMenuItem<int>(
                  value: 0,
                  child: Row(children: const [
                    Icon(
                      Icons.logout,
                      color: Colors.black,
                    ),
                    Text("Sign Out")
                  ]),
                )
              ],
            )
          ],
        ),
        body: Center(
          child: Container(),
        ));
  }
}

onSelect(BuildContext context, int item) {
  switch (item) {
    case 0:
      FirebaseAuth.instance.signOut();
  }
}
