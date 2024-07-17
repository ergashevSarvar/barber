import 'package:barber/l10n/l10n.dart';
import 'package:barber/l10n/local_string.dart';
import 'package:barber/presentation/blocs/langs/lang_bloc.dart';
import 'package:barber/presentation/blocs/login/login_bloc.dart';
import 'package:barber/presentation/blocs/logout/logout_bloc.dart';
import 'package:barber/presentation/blocs/register/register_bloc.dart';
import 'package:barber/routes.dart';
import 'package:barber/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:barber/presentation/controller/init_controller.dart' as di;
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final onboarding = prefs.getBool("onboarding")??false;
  final currentLang = prefs.getString("lang");
  Locale locale = Locale("uz");
  if(currentLang == "fr") {
    locale = Locale("fr");
  } else if (currentLang == "ru"){
    locale = Locale("ru");
  }
  await di.init();
  runApp(MainApp(onboarding: onboarding, locale: locale));
}

class MainApp extends StatelessWidget {
  final bool onboarding;
  final Locale locale;
  MainApp({super.key, this.onboarding = false, required this.locale});

  final Routes _routes = Routes();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => LoginBloc()),
          BlocProvider(create: (context) => RegisterBloc()),
          BlocProvider(create: (context) => LogoutBloc()),
          BlocProvider(create: (context) => LangBloc()),
        ],
        child: GetMaterialApp(
          title: 'Barber management app',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: kWhite),
            useMaterial3: true,
          ),
          initialRoute: onboarding ? Routes.signinType : Routes.onBoarding,
          translations: LocalString(),
          locale: locale,
          builder: EasyLoading.init(),
          onGenerateRoute: Routes.generateRoute,
        )
    );
  }
}