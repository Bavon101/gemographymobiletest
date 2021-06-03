import 'package:flutter/material.dart';
import 'package:mobiletest/Controllers/DataController.dart';
import 'package:mobiletest/Controllers/ShortCalls.dart';
import 'package:mobiletest/Models/RepoModel.dart';

DataController _dataController = new DataController();

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int wayBack = 30;
  RepoModel? _repomodel;
  bool timedOut = false;
  bool error = false;
  @override
  void initState() {
    super.initState();
    _dataController.gerRepos(gitUrl: gitUrl(wayBack: wayBack)).then((data) => {
          setState(() {
            if (!data.contains('error')) {
            } else {
              error = true;
            }
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trending Repos'),
      ),
    );
  }
}
