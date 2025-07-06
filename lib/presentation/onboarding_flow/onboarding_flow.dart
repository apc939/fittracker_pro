import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/onboarding_page_widget.dart';
import './widgets/page_indicator_widget.dart';
import './widgets/permission_bottom_sheet_widget.dart';

class OnboardingFlow extends StatefulWidget {
  const OnboardingFlow({super.key});

  @override
  State<OnboardingFlow> createState() => _OnboardingFlowState();
}

class _OnboardingFlowState extends State<OnboardingFlow>
    with TickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _parallaxController;
  int _currentPage = 0;
  final int _totalPages = 4;

  final List<Map<String, dynamic>> _onboardingData = [
    {
      "id": 1,
      "title": "Track Your Workouts",
      "description":
          "Log your daily exercises with ease. Monitor workout duration, intensity, and track your fitness journey with comprehensive analytics.",
      "image":
          "https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3",
      "buttonText": "Next"
    },
    {
      "id": 2,
      "title": "Monitor Your Progress",
      "description":
          "Visualize your fitness data with beautiful charts and graphs. See your improvement over time and stay motivated with detailed insights.",
      "image":
          "https://images.pexels.com/photos/669578/pexels-photo-669578.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "buttonText": "Continue"
    },
    {
      "id": 3,
      "title": "Set & Achieve Goals",
      "description":
          "Define your fitness objectives and track your progress. Get personalized recommendations and celebrate your achievements.",
      "image":
          "https://cdn.pixabay.com/photo/2017/08/07/14/02/people-2604149_1280.jpg",
      "buttonText": "Continue"
    },
    {
      "id": 4,
      "title": "Stay Motivated",
      "description":
          "Receive workout reminders and track your streaks. Join a community of fitness enthusiasts and achieve your health goals together.",
      "image":
          "https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3",
      "buttonText": "Get Started"
    }
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _parallaxController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _parallaxController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
    _parallaxController.forward().then((_) {
      _parallaxController.reverse();
    });
  }

  void _nextPage() {
    if (_currentPage < _totalPages - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _showPermissionBottomSheet();
    }
  }

  void _skipOnboarding() {
    Navigator.pushReplacementNamed(context, '/splash-screen');
  }

  void _showPermissionBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => PermissionBottomSheetWidget(
        onComplete: () {
          Navigator.pushReplacementNamed(context, '/splash-screen');
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: _buildPageView(),
            ),
            _buildBottomNavigation(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: 20.w),
          PageIndicatorWidget(
            currentPage: _currentPage,
            totalPages: _totalPages,
          ),
          GestureDetector(
            onTap: _skipOnboarding,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppTheme.lightTheme.colorScheme.outline,
                  width: 1,
                ),
              ),
              child: Text(
                'Skip',
                style: AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                  color: AppTheme.lightTheme.colorScheme.onSurface,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageView() {
    return PageView.builder(
      controller: _pageController,
      onPageChanged: _onPageChanged,
      itemCount: _totalPages,
      itemBuilder: (context, index) {
        final data = _onboardingData[index];
        return OnboardingPageWidget(
          title: data["title"] as String,
          description: data["description"] as String,
          imageUrl: data["image"] as String,
          parallaxController: _parallaxController,
        );
      },
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
      child: Row(
        children: [
          _currentPage > 0
              ? GestureDetector(
                  onTap: () {
                    _pageController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(3.w),
                    decoration: BoxDecoration(
                      color: AppTheme.lightTheme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppTheme.lightTheme.colorScheme.outline,
                        width: 1,
                      ),
                    ),
                    child: CustomIconWidget(
                      iconName: 'arrow_back',
                      color: AppTheme.lightTheme.colorScheme.onSurface,
                      size: 6.w,
                    ),
                  ),
                )
              : SizedBox(width: 12.w),
          const Spacer(),
          _buildPrimaryButton(),
        ],
      ),
    );
  }

  Widget _buildPrimaryButton() {
    final buttonText = _onboardingData[_currentPage]["buttonText"] as String;

    return GestureDetector(
      onTap: _nextPage,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.colorScheme.primary,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppTheme.lightTheme.colorScheme.primary
                  .withValues(alpha: 0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              buttonText,
              style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
                color: AppTheme.lightTheme.colorScheme.onPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(width: 2.w),
            CustomIconWidget(
              iconName: 'arrow_forward',
              color: AppTheme.lightTheme.colorScheme.onPrimary,
              size: 5.w,
            ),
          ],
        ),
      ),
    );
  }
}
