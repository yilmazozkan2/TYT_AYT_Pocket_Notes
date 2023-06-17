import 'package:flutter/material.dart';

import '../../pages/sign_page.dart';

MaterialPageRoute<dynamic> SquareTileNavigate(currentIndex) {
  return MaterialPageRoute(
    builder: (context) => SignPage(currentIndex: currentIndex),
  );
}
