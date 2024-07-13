// Current SDK version: 3.22.1
import 'package:flutter/material.dart';

// ListView, Gridview, SizedBox, ListTile, Divider

void main() {
  runApp(IntroApp());
}

class IntroApp extends StatelessWidget {
  const IntroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      home: Home(),
      title: 'Intro app',
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> friendList = ['Fahad', 'Iram', 'Touhid', 'Sakib', 'Niloy'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Home'),
          backgroundColor: Colors.blue,
        ),
        // body: Center(
        //   child: SingleChildScrollView(
        //     child: Column(
        //       children: [
        //         SizedBox(
        //           height: 100,
        //           width: 100,
        //           child: Center(
        //             child: Text('Box1'),
        //           ),
        //         ),
        //     SizedBox(
        //       height: 100,
        //       width: 100,
        //       child: Center(
        //         child: Text('Box1'),
        //       ),
        //     ),
        //     SizedBox(
        //       height: 100,
        //       width: 100,
        //       child: Center(
        //         child: Text('Box1'),
        //       ),
        //     ),
        //     SizedBox(
        //       height: 100,
        //       width: 100,
        //       child: Center(
        //         child: Text('Box1'),
        //       ),
        //     ),
        //     SizedBox(
        //       height: 100,
        //       width: 100,
        //       child: Center(
        //         child: Text('Box1'),
        //       ),
        //     ),
        //
        //         SizedBox(
        //           height: 100,
        //           width: 100,
        //           child: Center(
        //             child: Text('Box1'),
        //           ),
        //         ),
        //         SizedBox(
        //           height: 100,
        //           width: 100,
        //           child: Center(
        //             child: Text('Box1'),
        //           ),
        //         ),
        //
        //       ],
        //     ),
        //   ),
        // )

        // body: ListView.builder(
        //     itemCount: 10,
        //     itemBuilder: (context, index) {
        //     return SizedBox(
        //       height: 100,
        //       width: 100,
        //       child: Center(
        //         child: Text(index.toString()),
        //       ),
        //     );
        //     })
        // body: ListView.builder(
        //     itemCount: friendList.length,
        //     itemBuilder: (context, index) {
        //       return Text(friendList[index]);
        //     })
        // body: ListView.separated(
        //   itemCount: friendList.length,
        //   itemBuilder: (context, index) {
        //     return ListTile(
        //       title: Text(friendList[index]),
        //       subtitle: Text('Friends'),
        //       onTap: () {
        //         print('Tapped..');
        //       },
        //       tileColor: Colors.cyan.shade400,
        //       trailing: Column(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           Icon(
        //             Icons.do_not_disturb_on_total_silence_rounded,
        //             color: Colors.green,
        //             size: 10,
        //           ),
        //           Text(
        //             'Active',
        //             style: TextStyle(color: Colors.red.shade600),
        //           )
        //         ],
        //       ),
        //       titleTextStyle:
        //           TextStyle(fontSize: 24, color: Colors.red.shade800),
        //       leading: Text(
        //         (index + 1).toString(),
        //       ),
        //     );
        //   },
        //   separatorBuilder: (context, index) {
        //     return Divider(
        //       color: Colors.black,
        //       thickness: 2,
        //       endIndent: 4,
        //       indent: 4,
        //     );

        body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 4,
            mainAxisSpacing: 10,
            childAspectRatio: 1
          ),
          itemCount: friendList.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Text(index.toString()),
                Text(friendList[index]),
              ],
            );
          },
        ),
        // body: GridView.builder(
        //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //     crossAxisCount: 3,
        //     crossAxisSpacing: 4,
        //     mainAxisSpacing: 10,
        //     childAspectRatio: 1
        //   ),
        //   itemCount: friendList.length,
        //   itemBuilder: (context, index) {
        //     return Column(
        //       children: [
        //         Text(index.toString()),
        //         Text(friendList[index]),
        //       ],
        //     );
        //   },
        // ),
        );
  }
}
