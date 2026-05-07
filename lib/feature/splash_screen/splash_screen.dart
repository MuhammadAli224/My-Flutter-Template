import 'dart:async';

import '../../global_imports.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
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
      final appName = LocaleKeys.appName.tr();

      if (currentIndex < appName.length) {
        setState(() {
          currentIndex++;
        });
        return;
      }

      _timer?.cancel();
      _fadeController.forward();
      await Future<void>.delayed(Duration.zero);

      if (mounted) {
        context.go(AppRoutes.home);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appName = LocaleKeys.appName.tr();
    final splitIndex = appName.length >= 9 ? 9 : appName.length;
    final visibleText = appName.substring(0, currentIndex);
    final firstVisible = visibleText.substring(
      0,
      currentIndex > splitIndex ? splitIndex : currentIndex,
    );
    final secondVisible = currentIndex > splitIndex
        ? visibleText.substring(splitIndex)
        : '';

    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: AppTextStyle.style28B.copyWith(letterSpacing: 0),
                children: [
                  TextSpan(
                    text: firstVisible,
                    style: const TextStyle(
                      color: AppColor.primaryColor,
                      shadows: [
                        Shadow(
                          blurRadius: 5,
                          color: AppColor.primaryColor200,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                  ),
                  TextSpan(
                    text: secondVisible,
                    style: const TextStyle(
                      color: AppColor.secondaryColor,
                      shadows: [
                        Shadow(
                          blurRadius: 5,
                          color: AppColor.secondaryColor100,
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
              child: Text(
                LocaleKeys.appTagline.tr(),
                style: AppTextStyle.style16.copyWith(color: AppColor.textMuted),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
