import 'package:flutter/material.dart';

import '../../constants/padding.dart';

class CardTag extends StatelessWidget {
  const CardTag({super.key, required this.tag});

  final tag;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: ProjectDecorations.aSymetricPadding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text('#$tag',
              style: Theme.of(context).textTheme.bodyText1?.copyWith(color:Colors.blue)),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}