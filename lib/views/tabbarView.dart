import 'package:flutter/material.dart';
import 'package:translation_app/HomePage.dart';
import 'ai_tools_page.dart';
import 'more_page.dart';
import 'package:translation_app/settingsScreen.dart';

class LanguageTranslatorHome extends StatelessWidget {
  final List<Tab> myTabs = [
    Tab(text: 'Translation'),
    Tab(text: 'AI Tools'),
    Tab(text: 'More'),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        appBar: AppBar(

          leading:IconButton(
            icon: Icon(Icons.menu),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingScreen()));
            },

          ),
          title: Text('Language Translator'),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 1,
          bottom: TabBar(
            tabs: myTabs,

            indicatorColor: Colors.blue,
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.black54,
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: TabBarView(
            children: [
             HomePage(),
              AiToolsPage(),
              MorePage(),
            ],
          ),
        ),

    );
  }
}
