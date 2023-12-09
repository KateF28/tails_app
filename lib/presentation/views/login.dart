import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'package:tails_app/utils/environment.dart';
import 'package:tails_app/domain/feature/auth.dart';

/// This is login screen page/view content
class LoginView extends StatefulWidget {
  const LoginView({
    super.key,
  });

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Text(
                'Login screen',
                style: Theme.of(context).textTheme.bodyLarge!,
                textAlign: TextAlign.center,
              ),
            ),
            Center(
              child: TextButton(
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Environment.textColor),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Environment.textColor),
                ),
                onPressed: () {
                  // Log a user in, letting all the listeners know
                  context.read<AuthInfo>().login();
                  context.go('/menu/settings');
                },
                child: Text(
                  appLocalizations.logIn,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Environment.whiteColor,
                      ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Center(
                child: TextButton(
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.transparent),
                  ),
                  onPressed: () {
                    context.go('/menu/settings/signup');
                  },
                  child: Text(
                    appLocalizations.createAccount,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Environment.textColor,
                        ),
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
