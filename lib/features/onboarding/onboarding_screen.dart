// import 'package:flutter/material.dart';
//
// class OnboardingScreen extends StatefulWidget {
//   const OnboardingScreen({super.key});
//
//   @override
//   State<OnboardingScreen> createState() => _OnboardingScreenState();
// }
//
// class _OnboardingScreenState extends State<OnboardingScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold();
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rock_paper_scissors/core/extensions/asset.dart';
import 'package:rock_paper_scissors/core/extensions/build_context.dart';
import 'package:rock_paper_scissors/core/extensions/size_extension.dart';
import 'package:rock_paper_scissors/core/utils/app_color.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  List<OnboardingDetails> onboardingDetails = [
    OnboardingDetails(imageUrl: 'big_scissors'.svg, title: 'Scissors'),
    OnboardingDetails(imageUrl: 'big_rock'.svg, title: 'Rock'),
    OnboardingDetails(imageUrl: 'big_paper'.svg, title: 'Paper'),
  ];

  int _currentPage = 0;
  final PageController _pageController = PageController();

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Wave background
          Positioned.fill(
            child: ClipPath(
              clipper: WaveBackgroundClipper(),
              child: Container(
                color: const Color(
                    0xFF7CD5F9), // Light blue color matching the image
              ),
            ),
          ),
          Expanded(
              child: PageView.builder(
            controller: _pageController,
            itemCount: onboardingDetails.length,
            itemBuilder: (context, index) {
              final onboardingDetail = onboardingDetails[index];
              return Column(
                children: [
                  123.sbH,
                  SvgPicture.asset(onboardingDetail.imageUrl),
                  12.sbH,
                  Text(
                    onboardingDetail.title,
                    style: context.textTheme.bodyLarge
                        ?.copyWith(color: AppColor.black),
                  ),
                ],
              );
            },
          ))
          // Content
          // SafeArea(
          //   child: Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: 24.0),
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         // const Spacer(flex: 2),
          //         // Scissors icon
          //         Container(
          //           width: 100,
          //           height: 100,
          //           padding: const EdgeInsets.all(16),
          //           decoration: BoxDecoration(
          //             color: Colors.grey[200],
          //             borderRadius: BorderRadius.circular(8),
          //           ),
          //           child: Image.asset(
          //             'assets/scissors.png', // You'll need to add your own scissors image
          //             // Alternative using icon:
          //             // Icon(
          //             //   Icons.content_cut,
          //             //   size: 50,
          //             //   color: Colors.grey[700],
          //             // ),
          //           ),
          //         ),
          //         const Spacer(flex: 3),
          //         // Title
          //         const Text(
          //           'Scissors',
          //           style: TextStyle(
          //             fontSize: 32,
          //             fontWeight: FontWeight.w600,
          //             color: Colors.black,
          //           ),
          //         ),
          //         const SizedBox(height: 40),
          //         // Next button
          //         Align(
          //           alignment: Alignment.centerRight,
          //           child: TextButton(
          //             onPressed: () {},
          //             style: TextButton.styleFrom(
          //               backgroundColor: const Color(0xFFFAD4B8),
          //               // Peachy color matching the image
          //               padding: const EdgeInsets.symmetric(
          //                 horizontal: 20,
          //                 vertical: 8,
          //               ),
          //               shape: RoundedRectangleBorder(
          //                 borderRadius: BorderRadius.circular(20),
          //               ),
          //             ),
          //             child: Row(
          //               mainAxisSize: MainAxisSize.min,
          //               children: const [
          //                 Text(
          //                   'Next',
          //                   style: TextStyle(
          //                     color: Colors.black87,
          //                     fontSize: 16,
          //                   ),
          //                 ),
          //                 SizedBox(width: 4),
          //                 Icon(
          //                   Icons.arrow_forward,
          //                   size: 16,
          //                   color: Colors.black87,
          //                 ),
          //               ],
          //             ),
          //           ),
          //         ),
          //         const SizedBox(height: 40),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

class WaveBackgroundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    // Start from the bottom-right corner
    path.moveTo(size.width, size.height);

    // Draw line to bottom-left corner
    path.lineTo(0, size.height);

    // Create the higher wave
    path.cubicTo(
      // size.width * 0.1, // First control point x
      // size.height * 0.65, // First control point y (adjusted higher)
      // size.width * 0.45, // Second control point x
      // size.height * 0.5, // Second control point y (adjusted higher)
      // size.width, // End point x
      // size.height * 0.6, // End point y (adjusted higher)
      size.width * 0.1, // First control point x
      size.height * 0.50, // First control point y (adjusted higher)
      size.width * 0.3, // Second control point x
      size.height * 0.55, // Second control point y (adjusted higher)
      size.width, // End point x
      size.height * 0.6, // End point y (adjusted higher)
    );

    // Close the path
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class OnboardingDetails {
  final String imageUrl;
  final String title;

  OnboardingDetails({required this.imageUrl, required this.title});
}
