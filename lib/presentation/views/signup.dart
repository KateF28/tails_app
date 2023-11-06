import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:tails_app/domain/feature/auth.dart';
import 'package:tails_app/utils/constants.dart';

/// This is signup screen page/view content
class SignupView extends StatelessWidget {
  const SignupView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Text(
                'Signup screen',
                style: Theme.of(context).textTheme.bodyLarge!,
                textAlign: TextAlign.center,
              ),
            ),
            Center(
              child: TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(textColor),
                  backgroundColor: MaterialStateProperty.all<Color>(textColor),
                ),
                onPressed: () {
                  Provider.of<AuthInfo>(context, listen: false).login();
                  context.go('/menu/settings');
                },
                child: Text(
                  AppLocalizations.of(context)!.createAccount,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: whiteColor,
                      ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
