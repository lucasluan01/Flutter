import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animations Intro',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const LogoApp(),
    );
  }
}

class LogoApp extends StatefulWidget {
  const LogoApp({super.key});

  @override
  State<LogoApp> createState() => _LogoAppState();
}

class _LogoAppState extends State<LogoApp> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    animation = CurvedAnimation(parent: controller, curve: Curves.elasticOut);
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        Future.delayed(const Duration(seconds: 3)).then((value) => controller.forward());
      }
    });

    controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TransitionCustom(
        animation: animation,
        child: const LogoWidget(),
      ),
    );
  }
}

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const FlutterLogo();
  }
}

class HeartWidget extends StatelessWidget {
  const HeartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.favorite,
      color: Colors.red,
      size: 200,
    );
  }
}

class TransitionCustom extends StatelessWidget {
  TransitionCustom({
    super.key,
    required this.child,
    required this.animation,
  });

  final Widget child;
  final Animation<double> animation;
  final sizeTween = Tween<double>(begin: 0, end: 300);
  final opacity = Tween<double>(begin: 0.1, end: 1);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxHeight: 500,
          maxWidth: 500,
          minHeight: 0,
          minWidth: 0,
        ),
        child: AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            return Opacity(
              opacity: opacity.evaluate(animation).clamp(0, 1.0),
              child: SizedBox(
                width: sizeTween.evaluate(animation),
                height: sizeTween.evaluate(animation),
                child: child,
              ),
            );
          },
          child: child,
        ),
      ),
    );
  }
}
