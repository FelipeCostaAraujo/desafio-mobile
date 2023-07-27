import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: DefaultTabController(
          initialIndex: 0,
          length: 3,
          child: NestedScrollView(
            scrollDirection: Axis.vertical,
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              const SliverToBoxAdapter(
                child: Column(
                  children: [
                    SizedBox(height: 16),
                    TabBar(
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.grey,
                      labelStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      tabs: [
                        Tab(child: Text("Words list")),
                        Tab(child: Text("History")),
                        Tab(
                          child: Text("Favorites"),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
            body: TabBarView(
              children: [
                fakerPage("Faker 1"),
                fakerPage("Faker 2"),
                fakerPage("Faker 3"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget fakerPage(String title) {
  return Scaffold(
    appBar: AppBar(),
    body: Center(
      child: Text(title),
    ),
  );
}
