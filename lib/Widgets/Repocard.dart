import 'package:flutter/material.dart';
import 'package:mobiletest/Controllers/ShortCalls.dart';
import 'package:mobiletest/Models/RepoModel.dart';
import 'package:mobiletest/Pages/RepoViewPage.dart';

class RepoCard extends StatelessWidget {
  const RepoCard({Key? key, required this.repo}) : super(key: key);
  final Item repo;

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w500
    );
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (contex) => RepoViewPage(repo: repo))),
      child: Container(
        height: MediaQuery.of(context).size.height * .18,
        child: Card(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(repo.name ?? 'reponame',style:style.copyWith(fontWeight: FontWeight.bold,fontSize:MediaQuery.of(context).size.width*.05)),
                  //Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(repo.description ?? 'repo description',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 2
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [owner(), stars()],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget owner() => Row(
        children: [
          Container(
              height: 50,
              width: 50,
              child: Hero(
                tag: repo.id.toString(),
                child: Image.network(repo.owner?.avatarUrl ??
                    'https://lh3.googleusercontent.com/a-/AOh14GgBlE_CuFpC07PgYdNqOx3gsveSktbNHl4muoxu=s40',
                    fit: BoxFit.cover,
                    ),
              )),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(repo.owner?.login ?? 'owner name',style:TextStyle(fontWeight: FontWeight.w600) ,),
          )
        ],
      );

  Widget stars() => Row(
        children: [
          Icon(Icons.star),
          Text(getEditedNumeric(value: repo.watchers ?? 0))
        ],
      );
}
