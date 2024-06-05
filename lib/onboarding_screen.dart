import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: "Welcome to Sloffee",
          body: "Your personal career assistant.",
          image: Center(
            child: Image.asset("assets/sloffee_logo.png", height: 175.0),
          ),
          decoration: PageDecoration(
            titleTextStyle: const TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
            bodyTextStyle: TextStyle(
              fontSize: 20.0,
              color: Colors.grey[700],
            ),
            imagePadding: const EdgeInsets.all(24.0),
            boxDecoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white, Colors.purple.shade50],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
        PageViewModel(
          title: "Analyze Your Resume",
          body: "Get feedback on your resume instantly.",
          image: Center(
            child: Image.asset("assets/sloffee_analyst.png", height: 175.0),
          ),
          decoration: PageDecoration(
            titleTextStyle: const TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
            bodyTextStyle: TextStyle(
              fontSize: 20.0,
              color: Colors.grey[700],
            ),
            imagePadding: const EdgeInsets.all(24.0),
            boxDecoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white, Colors.purple.shade50],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
        PageViewModel(
          title: "Job Recommendations",
          body: "Find the best job matches for your profile.",
          image: Center(
            child: Image.asset("assets/sloffee_strategist.png", height: 175.0),
          ),
          decoration: PageDecoration(
            titleTextStyle: const TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
            bodyTextStyle: TextStyle(
              fontSize: 20.0,
              color: Colors.grey[700],
            ),
            imagePadding: const EdgeInsets.all(24.0),
            boxDecoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white, Colors.purple.shade50],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
      ],
      onDone: () {
        Navigator.of(context).pushReplacementNamed('/login');
      },
      onSkip: () {
        Navigator.of(context).pushReplacementNamed('/login');
      },
      showSkipButton: true,
      skip: const Icon(Icons.skip_next, color: Colors.deepPurple),
      next: const Icon(Icons.arrow_forward, color: Colors.deepPurple),
      done: const Text(
        "Done",
        style: TextStyle(fontWeight: FontWeight.w600, color: Colors.deepPurple),
      ),
      dotsDecorator: DotsDecorator(
        size: const Size.square(10.0),
        activeSize: const Size(20.0, 10.0),
        activeColor: Colors.deepPurple,
        color: Colors.black26,
        spacing: const EdgeInsets.symmetric(horizontal: 3.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
      curve: Curves.fastOutSlowIn, // Animation for transitions between pages
    );
  }
}
