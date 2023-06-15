import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/padding.dart';

// ignore: must_be_immutable
class SearchField extends StatefulWidget {
  SearchField({super.key, required this.onSearch});
  Function(String) onSearch;

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: ProjectDecorations.aSymetricPadding,
      child: Row(
        children: [
          Text(
            'Hacker Community',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Flexible(
            child: Padding(
              padding: ProjectDecorations.onlyLeftPadding,
              child: TextField(
                onChanged: (val) => initiateSearch(val),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey,
                  prefixIcon: Container(
                    padding: EdgeInsets.all(15),
                    child: Icon(Icons.search),
                    width: 18,
                  ),
                  hintText: "search".tr,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
                controller: _controller,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void initiateSearch(String val) {
    widget.onSearch(val.toLowerCase().trim());
  }
}
