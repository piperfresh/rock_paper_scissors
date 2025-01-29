import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rock_paper_scissors/core/extensions/asset.dart';
import 'package:rock_paper_scissors/core/extensions/build_context.dart';
import 'package:rock_paper_scissors/core/extensions/size_extension.dart';
import 'package:rock_paper_scissors/core/utils/app_color.dart';
import 'package:rock_paper_scissors/features/authentication/presentation/screens/sign_in_screen.dart';
import 'package:rock_paper_scissors/features/onboarding/widgets/onboarding_details.dart';
import 'package:rock_paper_scissors/features/onboarding/widgets/wave_background_clipper.dart';

// class OnboardingScreen extends StatefulWidget {
//   const OnboardingScreen({super.key});
//
//   @override
//   State<OnboardingScreen> createState() => _OnboardingScreenState();
// }
//
// class _OnboardingScreenState extends State<OnboardingScreen> {
//   int _currentPage = 0;
//   final PageController _pageController = PageController();
//
//   List<OnboardingDetails> onboardingDetails = [
//     OnboardingDetails(imageUrl: 'big_scissors'.svg, title: 'Scissors'),
//     OnboardingDetails(imageUrl: 'big_rock'.svg, title: 'Rock'),
//     OnboardingDetails(imageUrl: 'big_paper'.svg, title: 'Paper'),
//   ];
//
//   List<Map<String, dynamic>> indicatorAssets = [
//     {
//       'active': 'active_scissors'.svg,
//       'inactive': 'inactive_scissors'.svg,
//     },
//     {
//       'active': 'active_rock'.svg,
//       'inactive': 'inactive_rock'.svg,
//     },
//     {
//       'active': 'active_paper'.svg,
//       'inactive': 'inactive_paper'.svg,
//     },
//   ];
//
//   Color _getClipColor(int index) {
//     switch (index) {
//       case 0:
//         return AppColor.lightBlue;
//       case 1:
//         return AppColor.pink;
//       case 2:
//         return AppColor.lightYellow;
//       default:
//         return AppColor.lightBlue;
//     }
//   }
//
//   void _onPageChanged(int index) {
//     setState(() {
//       _currentPage = index;
//     });
//   }
//
//   void _navigateToNextPage() {
//     if (_currentPage < onboardingDetails.length - 1) {
//       _pageController.nextPage(
//           duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
//     } else {}
//   }
//
//   void _navigateToPreviousPage() {
//     if (_currentPage > 0) {
//       _pageController.previousPage(
//           duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
//     } else {}
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Stack(
//         children: [
//           Positioned.fill(
//             child: ClipPath(
//               clipper: WaveBackgroundClipper(),
//               child: Container(
//                 color: _getClipColor(_currentPage),
//               ),
//             ),
//           ),
//           Expanded(
//               child: PageView.builder(
//             controller: _pageController,
//             itemCount: onboardingDetails.length,
//               onPageChanged: _onPageChanged,
//               itemBuilder: (context, index) {
//                 final onboardingDetail = onboardingDetails[index];
//                 return Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     123.sbH,
//                     SizedBox(
//                         child: SvgPicture.asset(onboardingDetail.imageUrl)),
//                     50.sbH,
//                     Column(
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.only(right: 80.0.w),
//                           child: Align(
//                             alignment: Alignment.centerRight,
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: List.generate(
//                                 onboardingDetails.length,
//                                 (index) => Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 4.0),
//                                   child: SvgPicture.asset(
//                                     index == _currentPage
//                                         ? indicatorAssets[index]['active']
//                                         : indicatorAssets[index]['inactive'],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         100.sbH,
//                         Text(onboardingDetail.title,
//                             style: context.textTheme.bodyLarge),
//                       ],
//                     ),
//                     Padding(
//                       padding: EdgeInsets.symmetric(
//                           horizontal: 16.0.w, vertical: 10.h),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           if (_currentPage == 0) 16.sbW,
//                           if (_currentPage == 1 || _currentPage == 2)
//                             GestureDetector(
//                                 onTap: _navigateToPreviousPage,
//                                 child: SvgPicture.asset('back_button'.svg)),
//                           if (_currentPage == 0 || _currentPage == 1)
//                             GestureDetector(
//                                 onTap: _navigateToNextPage,
//                                 child: SvgPicture.asset('next_button'.svg)),
//                           if (_currentPage == 2)
//                             GestureDetector(
//                               onTap: () {},
//                               child: SvgPicture.asset('start_button'.svg),
//                             )
//                         ],
//                       ),
//                     )
//                   ],
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentPage = 0;
  final PageController _pageController = PageController();

  List<OnboardingDetails> onboardingDetails = [
    OnboardingDetails(imageUrl: 'big_scissors'.svg, title: 'Scissors'),
    OnboardingDetails(imageUrl: 'big_rock'.svg, title: 'Rock'),
    OnboardingDetails(imageUrl: 'big_paper'.svg, title: 'Paper'),
  ];

  List<Map<String, dynamic>> indicatorAssets = [
    {
      'active': 'active_scissors'.svg,
      'inactive': 'inactive_scissors'.svg,
    },
    {
      'active': 'active_rock'.svg,
      'inactive': 'inactive_rock'.svg,
    },
    {
      'active': 'active_paper'.svg,
      'inactive': 'inactive_paper'.svg,
    },
  ];

  Color _getClipColor(int index) {
    switch (index) {
      case 0:
        return AppColor.lightBlue;
      case 1:
        return AppColor.pink;
      case 2:
        return AppColor.lightYellow;
      default:
        return AppColor.lightBlue;
    }
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  void _navigateToNextPage() {
    if (_currentPage < onboardingDetails.length - 1) {
      _pageController.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  void _navigateToPreviousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned.fill(
            child: ClipPath(
              clipper: WaveBackgroundClipper(),
              child: Container(
                color: _getClipColor(_currentPage),
              ),
            ),
          ),
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return PageView.builder(
                  controller: _pageController,
                  itemCount: onboardingDetails.length,
                  onPageChanged: _onPageChanged,
                  itemBuilder: (context, index) {
                    final onboardingDetail = onboardingDetails[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                      child: Column(
                        children: [
                          SizedBox(height: constraints.maxHeight * 0.15),
                          SizedBox(
                            height: constraints.maxHeight * 0.35,
                            child: SvgPicture.asset(
                              onboardingDetail.imageUrl,
                              fit: BoxFit.contain,
                            ),
                          ),
                          SizedBox(height: constraints.maxHeight * 0.06),
                          Padding(
                            padding: EdgeInsets.only(right: 70.0.w,top: 15.h),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: List.generate(
                                  onboardingDetails.length,
                                      (index) => Padding(
                                    padding:  EdgeInsets.symmetric(horizontal: 4.0.w),
                                    child: SvgPicture.asset(
                                      index == _currentPage
                                          ? indicatorAssets[index]['active']
                                          : indicatorAssets[index]['inactive'],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: constraints.maxHeight * 0.1),
                          Text(
                            onboardingDetail.title,
                            style: context.textTheme.bodyLarge,
                          ),
                          const Spacer(),
                          Padding(
                            padding: EdgeInsets.only(bottom: 10.h,left: 10.w,right: 10.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                if (_currentPage == 0)
                                  SizedBox(width: 16.w)
                                else
                                  GestureDetector(
                                    onTap: _navigateToPreviousPage,
                                    child: SvgPicture.asset('back_button'.svg),
                                  ),
                                if (_currentPage == 2)
                                  GestureDetector(
                                    onTap: () {
                                      context.push(MaterialPageRoute(builder: (context) {
                                        return const SignInScreen();
                                      },));
                                    },
                                    child: SvgPicture.asset('start_button'.svg),
                                  )
                                else
                                  GestureDetector(
                                    onTap: _navigateToNextPage,
                                    child: SvgPicture.asset('next_button'.svg),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

