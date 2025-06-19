import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:travel/presentation/onboarding/ui/widgets/travel_intro_screen.dart';

import '../../../core/routes/route_names.dart';
import '../../../core/utils/shared_pref_services.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();
  @override
  Widget build(BuildContext context) {

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      showBottomPart: false,
      showNextButton: false,
      showDoneButton: false,
      showBackButton: false,
      rawPages: [
        TravelIntroScreen(
          backgroundImage: 'assets/images/intro1.png',
          title: 'Discover Egypt',
          description:
              'Book trips, find hotels, and explore Egypt’s top destinations—with chatbot help every step of the way',
          nextText: 'Next',
          onNextPressed: () => introKey.currentState?.next(),
        ),
        TravelIntroScreen(
          backgroundImage: 'assets/images/intro2.png',
          title: 'Explore. Book. Travel',
          description:
              'Discover and book trips across Egypt, reserve hotels, and get instant help from our smart chatbot',
          nextText: 'Next',
          backText: 'Back',
          onNextPressed: () => introKey.currentState?.next(),
        ),
        TravelIntroScreen(
          backgroundImage: 'assets/images/intro4.png',
          title: 'Unforgettable Trips Await',
          description:
              'Browse a wide range of adventures, from Nile cruises to desert safaris—plan every detail effortlessly',
          nextText: 'Next',
          backText: 'Back',
          onNextPressed: () => introKey.currentState?.next(),
          onBackPressed: () => introKey.currentState?.previous(),
        ),
        TravelIntroScreen(
          backgroundImage: 'assets/images/intro5.png',
          title: 'Treasures of Ancient Egypt',
          description:
              'Explore the grand temples like Karnak and hidden gems like local museums—journey through Egypt’s rich history with smart guidance every step of the way',
          nextText: 'Next',
          backText: 'Back',
          onNextPressed: () => introKey.currentState?.next(),
          onBackPressed: () => introKey.currentState?.previous(),
        ),
        TravelIntroScreen(
          backgroundImage: 'assets/images/intro3.png',
          title: 'Smart Travel Made Simple',
          description:
              'Plan your Egypt trip with ease—book tours, stay in top hotels, and chat with your AI travel assistant',
          nextText: 'Finish',
          backText: 'Back',
          onNextPressed: () async {
            introKey.currentState?.next();
            await SharedPrefService.instance.setOnboardingViewed(true);
            Navigator.pushReplacementNamed(
              context,
              isLoggedIn ? RouteNames.homeScreen : RouteNames.login,
            );
          },
          onBackPressed: () => introKey.currentState?.previous(),
        ),
      ],
    );
  }

  bool get isLoggedIn => SharedPrefService.instance.getToken() != null;
}
