import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'package:tails_app/utils/environment.dart';
import 'package:tails_app/domain/feature/auth.dart';

/// This is settings screen page/view content
class SettingsView extends StatelessWidget {
  const SettingsView({
    super.key,
    required this.hiveBox,
  });

  final Box hiveBox;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Consumer<AuthInfo>(
          builder: (context, value, child) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Center(
                    child: Text(
                      'Settings screen',
                      style: Theme.of(context).textTheme.bodyLarge!,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                value.isLoggedIn == false
                    ? Center(
                        child: TextButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Environment.whiteColor),
                          ),
                          onPressed: () {
                            context.go('/menu/settings/login');
                          },
                          child: Text(
                            AppLocalizations.of(context)!.logInOrSignUp,
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            );
          },
        );
      },
    );
  }
}
