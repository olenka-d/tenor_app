import 'package:flutter/material.dart';
import 'Home.dart';

class SearchField extends StatefulWidget {
  final HomeState homeState;

  const SearchField({required Key key, required this.homeState}) : super(key: key);

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextField(
      controller: widget.homeState.textFieldController,
      obscureText: false,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Пошук картинок',
      ),
      onSubmitted: (text) {
        widget.homeState.fetchUrls();
      },
    ),
    );
  }
}

