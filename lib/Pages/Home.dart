import 'package:flutter/material.dart';
import 'package:mobiletest/Controllers/DataController.dart';
import 'package:mobiletest/Controllers/ShortCalls.dart';
import 'package:mobiletest/Models/RepoModel.dart';
import 'package:mobiletest/Widgets/Repocard.dart';

DataController _dataController = new DataController();

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int wayBack = 30;
  RepoModel? _repomodel;
  bool error = false;
  int toDisplay = 30;
  int nextPage = 2;
  ScrollController? controller;
  bool updating = false;
  changeUpdatingStatus() {
    if (mounted) {
      setState(() {
        updating = !updating;
      });
    }
  }

  int getItemCount() {
    return _repomodel == null
        ? 0
        : _repomodel!.items!.length <= toDisplay
            ? toDisplay
            : 0;
  }

  updateToDisplay(int value) {
    if (mounted) {
      setState(() {
        toDisplay = toDisplay + value;
      });
    }
    changeUpdatingStatus();
  }

   updateData() {
    if (toDisplay < _repomodel!.items!.length) {
      if (toDisplay + 30 <= _repomodel!.items!.length) {
        updateToDisplay(30);
        //print('ADDED MORE');
      } else {
        updateToDisplay(_repomodel!.items!.length - toDisplay);
        //print('ADDED REMAINING');
      }
    } else if (_repomodel?.incompleteResults ?? false) {
      //always false
      getMoreRepos();
    } else {
      //print('GOT MORE');
      getMoreRepos();
    }
    
  }

  getMoreRepos() {
    changeUpdatingStatus();
    _dataController
        .gerRepos(
      gitUrl: gitUrl(wayBack: wayBack, page: '&page=$nextPage'),
    )
        .then((data) {
      if (!data.contains('error')) {
        RepoModel repoModel = repoModelFromJson(data);
        if (mounted) {
          setState(() {
            _repomodel?.incompleteResults = repoModel.incompleteResults;
            List<Item> items = repoModel.items ?? [];
            _repomodel?.items?.addAll(items);
            _repomodel = _repomodel;
            nextPage++;
            print('NEW DATA:' + _repomodel!.items!.length.toString());
          });
          updateData();
        }
      } else {
        changeUpdatingStatus();
      }
    });
  }

  void _scrollListener() {
    if (controller!.offset >= controller!.position.maxScrollExtent &&
        !controller!.position.outOfRange) {
      if (!updating) {
        updateData();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    controller = new ScrollController()..addListener(_scrollListener);
    getRepos();
  }

  getRepos() {
    setState(() {
      error = false;
    });
    _dataController.gerRepos(gitUrl: gitUrl(wayBack: wayBack)).then((data) => {
          if (mounted)
            {
              setState(() {
                if (!data.contains('error')) {
                  _repomodel = repoModelFromJson(data);
                } else {
                  error = true;
                }
              })
            }
        });
  }

  @override
  void dispose() {
    controller!.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trending Repos'),
        centerTitle: true,
      ),
      body: Center(
        child: error
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Something broke\nPlease refresh',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: MediaQuery.of(context).size.width * .08),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:
                        TextButton(onPressed: getRepos, child: Text('Refresh')),
                  )
                ],
              )
            : _repomodel == null
                ? CircularProgressIndicator()
                : Scrollbar(
                    child: ListView.builder(
                        controller: controller,
                        itemCount: getItemCount(),
                        itemBuilder: (context, index) {
                          return RepoCard(repo: _repomodel!.items![index]);
                        }),
                  ),
      ),
      bottomNavigationBar: Container(
        height: updating ? 40 : 0,
        child: Center(
          child: updating ? CircularProgressIndicator() : null,
        ),
      ),
    );
  }
}
