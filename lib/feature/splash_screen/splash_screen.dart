import 'dart:async';

import '../../global_imports.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  final String appName = "Ibn Rushd Academy";
  int currentIndex = 0;
  Timer? _timer;

  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    );

    _startLetterAnimation();
  }

  void _startLetterAnimation() {
    _timer = Timer.periodic(const Duration(milliseconds: 90), (timer) async {
      if (currentIndex < appName.length) {
        setState(() {
          currentIndex++;
        });
      } else {
        _timer?.cancel();
        _fadeController.forward();
        await _initializeApp();
        // Future.delayed(const Duration(seconds: 2), () async {
        final token = await getIt<AuthLocalDataSource>().getToken();
        if (token != null) {
          context.go(AppRoutes.home);
        } else {
          // context.go(AppRoutes.mainScreen);
        }
        // });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _fadeController.dispose();

    super.dispose();
  }

  Future<void> _initializeApp() async {
    try {
      await EnvConstant.init();

      await HiveServices().init();

      initGetIt();
      await getIt<AppServices>().initAppServices();

      HttpOverrides.global = MyHttpOverrides();
      Bloc.observer = AppBlocObserver();
    } catch (e) {
      logger.e("Init error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    String firstWord = 'Ibn Rushd';
    String visibleText = appName.substring(0, currentIndex);
    String firstVisible = '';
    String secondVisible = '';

    if (currentIndex <= firstWord.length) {
      firstVisible = visibleText;
    } else {
      firstVisible = visibleText.substring(0, firstWord.length);
      secondVisible = visibleText.substring(firstWord.length);
    }

    if (currentIndex <= firstWord.length) {
      firstVisible = visibleText;
    } else {
      firstVisible = visibleText.substring(0, firstWord.length);
      secondVisible = visibleText.substring(firstWord.length);
    }
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          // crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: const TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
                children: [
                  TextSpan(
                    text: firstVisible,
                    style: const TextStyle(
                      color: Color(0xFF002754),
                      shadows: [
                        Shadow(
                          blurRadius: 5,
                          color: Color(0xFF02438E),
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                  ),
                  TextSpan(
                    text: secondVisible,
                    style: const TextStyle(
                      color: Color(0xFF00A665),
                      shadows: [
                        Shadow(
                          blurRadius: 5,
                          color: Color(0xFF04B670),
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            10.gap,
            FadeTransition(
              opacity: _fadeAnimation,
              child: const Text(
                "المركز الافضل في قطر لخدمتك",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  // fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
