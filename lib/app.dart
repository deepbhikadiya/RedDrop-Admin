
import 'package:web_redrop/package/config_packages.dart';
import 'package:web_redrop/package/screen_packages.dart';

class RedDrop extends StatefulWidget {
  const RedDrop({super.key});

  @override
  State<RedDrop> createState() => _RedDropState();
}

class _RedDropState extends State<RedDrop> with WidgetsBindingObserver {
  var locales = [
    const Locale('en', ''),
  ];

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      title: 'RedDrop',
      debugShowCheckedModeBanner: false,
      themeMode: AppPref().isDark == null
          ? ThemeMode.system
          : (AppPref().isDark! ? ThemeMode.dark : ThemeMode.light),
      locale: const Locale('en', ''),
      supportedLocales: locales,
      home: AppPref().isLogin == true ? const DashBoardViewScreen() : const LoginScreen(),
      builder: (context, child) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: (MediaQuery.of(context).platformBrightness == Brightness.dark
              ? SystemUiOverlayStyle.light
              : SystemUiOverlayStyle.dark),
          child: child ?? Container(),
        );
      },
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
