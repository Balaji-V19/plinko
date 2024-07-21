import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plinko/notifiers/player_notifier.dart';
import 'package:plinko/views/splash/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:plinko/router.dart' as Router;
import 'constants/app_colors.dart';
import 'constants/app_textstyle.dart';


final GlobalKey<NavigatorState> navigatorKey = GlobalKey();
GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
GlobalKey<ScaffoldMessengerState>();
void main() {
  runApp(const Plinko());
}


class Plinko extends StatefulWidget {
  const Plinko({Key? key}) : super(key: key);

  @override
  State<Plinko> createState() => _PlinkoState();
}

class _PlinkoState extends State<Plinko> {
  late PlayerNotifier _playerNotifier;

  @override
  void initState() {
    super.initState();
    _playerNotifier = PlayerNotifier();
  }
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => _playerNotifier),
        ],
        builder: (context, child) {
          ScreenUtil.init(context);
          return MaterialApp(
            scaffoldMessengerKey: scaffoldMessengerKey,
            theme: ThemeData(
                brightness: Brightness.light,
                primaryColor: AppColors.primary,
                hintColor: AppColors.secondary,
                textTheme: TextTheme(
                  bodyLarge: AppTextStyles.text16w600,
                  bodyMedium: AppTextStyles.text14w500,
                ),
                appBarTheme:
                const AppBarTheme(backgroundColor: AppColors.primary)),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              primaryColor: AppColors.secondary,
              hintColor: AppColors.primary,
              appBarTheme:
              const AppBarTheme(backgroundColor: AppColors.primary),
              textTheme: TextTheme(
                bodyLarge:
                AppTextStyles.text16w600.copyWith(color: AppColors.white),
                bodyMedium:
                AppTextStyles.text14w500.copyWith(color: AppColors.white),
              ),
            ),
            themeMode: ThemeMode.system,
            navigatorKey: navigatorKey,
            builder: (context, child) {
              return child!;
            },
            debugShowCheckedModeBanner: false,
            title: 'Plinko',
            home: const SplashScreen(),
            onGenerateRoute: Router.Router().routes,
          );
        });
  }
}
