import 'package:flt_keep/resources/app_colors.dart';
import 'package:flt_keep/screen/item_add_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:provider/provider.dart';

import 'models.dart' show CurrentUser;
import 'screens.dart' show HomeScreen, LoginScreen, NoteEditor, SettingsScreen;
import 'styles.dart';

void main() => runApp(NotesApp());

class NotesApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => StreamProvider.value(
        value: FirebaseAuth.instance.onAuthStateChanged
            .map((user) => CurrentUser.create(user)),
        initialData: CurrentUser.initial,
        child: Consumer<CurrentUser>(
          builder: (context, user, _) => MaterialApp(
            title: 'Dailo',
            theme: Theme.of(context).copyWith(
              backgroundColor: Color(AppColors.background),
              brightness: Brightness.light,
              primaryColor: Color(AppColors.green),
              accentColor: kAccentColorLight,
              appBarTheme: AppBarTheme.of(context).copyWith(
                elevation: 0,
                brightness: Brightness.light,
                iconTheme: IconThemeData(
                  color: kIconTintLight,
                ),
              ),
              scaffoldBackgroundColor: Colors.white,
              bottomAppBarColor: kBottomAppBarColorLight,
              primaryTextTheme: Theme.of(context).primaryTextTheme.copyWith(
                    // title
                    headline: const TextStyle(
                      color: kIconTintLight,
                    ),
                  ),
            ),
            home: user.isInitialValue
                ? Scaffold(body: const SizedBox())
                : user.data != null ? HomeScreen() : LoginScreen(),
            routes: {
              '/settings': (_) => SettingsScreen(),
            },
            onGenerateRoute: _generateRoute,
          ),
        ),
      );

  /// Handle named route
  Route _generateRoute(RouteSettings settings) {
    try {
      return _doGenerateRoute(settings);
    } catch (e, s) {
      debugPrint("failed to generate route for $settings: $e $s");
      return null;
    }
  }

  Route _doGenerateRoute(RouteSettings settings) {
    if (settings.name?.isNotEmpty != true) return null;

    final uri = Uri.parse(settings.name);
    final path = uri.path ?? '';
    // final q = uri.queryParameters ?? <String, String>{};
    switch (path) {
      case '/note':
        {
          final note = (settings.arguments as Map ?? {})['note'];
          return _buildRoute(settings, (_) => NoteEditor(note: note));
        }
      default:
        return null;
    }
  }

  /// Create a [Route].
  Route _buildRoute(RouteSettings settings, WidgetBuilder builder) =>
      MaterialPageRoute<void>(
        settings: settings,
        builder: builder,
      );
}
