import 'package:flutter/material.dart';
import 'package:mobiletest/Models/RepoModel.dart';

class RepoViewPage extends StatelessWidget {
  const RepoViewPage({Key? key,required this.repo}) : super(key: key);
  final Item repo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(repo.name ?? 'reponame'),
      ),
      body: Column(
        children: [
          Hero(
            tag: repo.id.toString(),
            child: Image.network(
              repo.owner?.avatarUrl ??
                'https://lh3.googleusercontent.com/a-/AOh14GgBlE_CuFpC07PgYdNqOx3gsveSktbNHl4muoxu=s40',
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height*.25,
                fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              repo.description ?? 'repo description',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: MediaQuery.of(context).size.width*.05
              ),
              
            ),
          ),
           Align(
             alignment: Alignment.bottomLeft,
             child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text('By '+
                (repo.owner?.login ?? 'owner name'),
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
                     ),
           )
        ],
      ),
    );
  }
}
