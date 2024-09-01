import 'package:first_project/presentation/widgets/responsive_builder.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
        mobile: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'HUMMING\nBIRD .',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
          drawer: Drawer(
            child: Column(
              children: [
                Container(
                  height: 200,
                  width: 400,
                  color: Colors.greenAccent.shade200,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'SKILL UP NOW',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'TAP HERE',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  alignment: Alignment.center,
                ),
                const SizedBox(
                  height: 40,
                ),
                const Row(
                  children: [
                    SizedBox(
                      width: 56,
                    ),
                    Icon(
                      Icons.ondemand_video_sharp,
                    ),
                    SizedBox(width: 32),
                    Text(
                      'Episodes',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                const Row(
                  children: [
                    SizedBox(
                      width: 56,
                    ),
                    Icon(
                      Icons.message,
                    ),
                    SizedBox(width: 32),
                    Text(
                      'About',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          body: _buildForMobile(),
        ),
        tablet: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: const Text(
              'HUMMING\nBIRD .',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            actions: [
              const Text(
                'Episodes',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(
                width: 40,
              ),
              const Text(
                'About',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(
                width: 50,
              ),
            ],
          ),
          body: _buildForTablet(),
        ),
        desktop: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: const Padding(padding: EdgeInsets.all(60)),
            title: const Text(
              'HUMMING\nBIRD .',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            actions: [
              const Text(
                'Episodes',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(
                width: 50,
              ),
              const Text(
                'About',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(
                width: 60,
              ),
            ],
          ),
          body: _buildForDesktop(),
        ));
  }

  Center _buildForMobile() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'FLUTTER WEB.\n  THE BASICS',
            style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'In this course we will go over the basics of using\nFlutter Web'
            ' for development. Topics will include\nResponsive Layout, Deploying,'
            'Font changes, Hover\nfunctionality, Modals and more.',
            style: TextStyle(
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 80,
          ),
          SizedBox(
            height: 42,
            width: 310,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.greenAccent.shade200,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
              ),
              onPressed: () {},
              child: const Text(
                'Join course',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Center _buildForTablet() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'FLUTTER WEB.\n  THE BASICS',
            style: TextStyle(fontSize: 60, fontWeight: FontWeight.w900),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'In this course we will go over the basics of using\nFlutter Web'
            ' for development. Topics will include\nResponsive Layout, Deploying,'
            'Font changes, Hover\nfunctionality, Modals and more.',
            style: TextStyle(
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 80,
          ),
          SizedBox(
            height: 42,
            width: 160,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.greenAccent.shade200,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
              ),
              onPressed: () {},
              child: const Text(
                'Join course',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Padding _buildForDesktop() {
    return Padding(
      padding: const EdgeInsets.only(left: 60),
      child: Row(
        children: [
          const Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'FLUTTER WEB.\nTHE BASICS',
                    style: TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'In this course we will go over the basics of using\nFlutter Web'
                    ' for development. Topics will include\nResponsive Layout, Deploying,'
                    'Font changes, Hover\nfunctionality, Modals and more.',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.start,
                    maxLines: 4,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            width: 200,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 42,
                width: 165,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent.shade200,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Join course',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
