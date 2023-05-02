import 'package:flutter/material.dart';

class Search extends SearchDelegate {

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return <Widget>[
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.close))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(onPressed: () {
      Navigator.pop(context);
    }, icon: Icon(Icons.arrow_back));
  }

  String selectedResult = "";

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Container(
      child: Center(
        child: Text(selectedResult),
      ),
    );
  }

  final List<String> listExample;
  Search(this.listExample);

  List<String> recentList = ["Text 4", "Text 3"];

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    List<String> _suggestionList = [];
    query.isEmpty
        ? _suggestionList = recentList
        : _suggestionList.addAll(listExample.where((element) => element.contains(query)
    ));

    return ListView.builder(
        itemCount: _suggestionList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_suggestionList[index]),
            leading: query.isEmpty ? Icon(Icons.access_time) : SizedBox(),
            onTap: () {
              selectedResult = _suggestionList[index];
              showResults(context);
            },
          );
        });
  }
}
