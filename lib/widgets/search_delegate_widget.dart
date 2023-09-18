import 'package:flutter/material.dart';
import 'package:hjbhjn/models/product_model.dart';

import '../pages/product_details_page.dart';

class SearchDelegateWidget extends SearchDelegate<Product> {
  SearchDelegateWidget({this.contextPage, required this.suggestions1});
  BuildContext? contextPage;
  List<Product> suggestions1;

  @override
  String get searchFieldLabel => "Search";

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        color: Colors.black,
        progress: transitionAnimation,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    debugPrint(query);
    List<Product> suggestions = suggestions1
        .where((element) =>
            element.title!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.separated(
        shrinkWrap: true,
        separatorBuilder: (context, index) => const SizedBox(height: 15),
        itemCount: suggestions.length,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        itemBuilder: (content, i) => ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(
                  suggestions[i].thumbnail ??
                      "https://images.unsplash.com/photo-1489389944381-3471b5b30f04?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80",
                ),
              ),
              title: Text(
                suggestions[i].title ?? "",
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black),
              ),
              subtitle: Text(
                suggestions[i].description ?? "",
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: Colors.black),
              ),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ProductDetailsPage(product: suggestions[i]),
                ),
              ),
            ));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Product> suggestions = suggestions1
        .where((element) =>
            element.title!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.separated(
        shrinkWrap: true,
        separatorBuilder: (context, index) => const SizedBox(height: 15),
        itemCount: suggestions.length,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        itemBuilder: (content, i) => ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(
                  suggestions[i].thumbnail ??
                      "https://images.unsplash.com/photo-1489389944381-3471b5b30f04?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80",
                ),
              ),
              title: Text(
                suggestions[i].title ?? "",
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black),
              ),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ProductDetailsPage(product: suggestions[i]),
                ),
              ),
            ));
  }
}
