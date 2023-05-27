import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../constants/padding.dart';

class PrivacyPolicyLinkAndTermsOfService extends StatelessWidget {
  const PrivacyPolicyLinkAndTermsOfService({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: ProjectDecorations.symetricPadding,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(10),
        child: Center(
            child: Text.rich(
                TextSpan(
                    text: 'By continuing, you agree to our ', style: Theme.of(context).textTheme.bodyText1?.copyWith(color:Colors.black),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Terms of Service', style: Theme.of(context).textTheme.bodyText1?.copyWith(color:Colors.black, decoration: TextDecoration.underline),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // code to open / launch terms of service link here
                            }
                      ),
                      TextSpan(
                          text: ' and ', style: Theme.of(context).textTheme.bodyText1?.copyWith(color:Colors.black),
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Privacy Policy', style: Theme.of(context).textTheme.bodyText1?.copyWith(color:Colors.black, decoration: TextDecoration.underline),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                  }
                            )
                          ]
                      )
                    ]
                )
            )
        ),
      ),
    );
  }
}