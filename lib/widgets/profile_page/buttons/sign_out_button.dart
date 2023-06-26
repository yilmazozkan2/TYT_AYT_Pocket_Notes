import 'package:flutter/material.dart';
import 'package:untitled1/widgets/profile_page/square_tile_navigate.dart';

import '../../../services/firebase_auth_service.dart';

// ignore: must_be_immutable
class SignOutButton extends StatelessWidget {
  SignOutButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () async {
          await AuthService().signOut();
          Navigator.of(context).pushReplacement(SquareTileNavigate());
        },
        child: Text('5. Oturumu Kapat'));
  }
}
