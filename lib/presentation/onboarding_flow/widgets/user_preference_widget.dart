import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class UserPreferenceWidget extends StatefulWidget {
  final VoidCallback onComplete;

  const UserPreferenceWidget({
    super.key,
    required this.onComplete,
  });

  @override
  State<UserPreferenceWidget> createState() => _UserPreferenceWidgetState();
}

class _UserPreferenceWidgetState extends State<UserPreferenceWidget> {
  String _selectedFitnessLevel = '';
  List<String> _selectedActivities = [];
  String _selectedGoal = '';

  final List<Map<String, dynamic>> _fitnessLevels = [
    {
      "id": "beginner",
      "title": "Beginner",
      "description": "Just starting my fitness journey",
      "icon": "star_border",
    },
    {
      "id": "intermediate",
      "title": "Intermediate",
      "description": "Regular exercise routine",
      "icon": "star_half",
    },
    {
      "id": "advanced",
      "title": "Advanced",
      "description": "Experienced fitness enthusiast",
      "icon": "star",
    },
  ];

  final List<Map<String, dynamic>> _activities = [
    {
      "id": "running",
      "title": "Running",
      "icon": "directions_run",
    },
    {
      "id": "cycling",
      "title": "Cycling",
      "icon": "directions_bike",
    },
    {
      "id": "swimming",
      "title": "Swimming",
      "icon": "pool",
    },
    {
      "id": "weightlifting",
      "title": "Weight Lifting",
      "icon": "fitness_center",
    },
    {
      "id": "yoga",
      "title": "Yoga",
      "icon": "self_improvement",
    },
    {
      "id": "hiking",
      "title": "Hiking",
      "icon": "terrain",
    },
  ];

  final List<Map<String, dynamic>> _goals = [
    {
      "id": "weight_loss",
      "title": "Weight Loss",
      "description": "Lose weight and get lean",
      "icon": "trending_down",
    },
    {
      "id": "muscle_gain",
      "title": "Muscle Gain",
      "description": "Build strength and muscle",
      "icon": "trending_up",
    },
    {
      "id": "endurance",
      "title": "Endurance",
      "description": "Improve cardiovascular fitness",
      "icon": "favorite",
    },
    {
      "id": "general_fitness",
      "title": "General Fitness",
      "description": "Stay healthy and active",
      "icon": "health_and_safety",
    },
  ];

  void _selectFitnessLevel(String level) {
    setState(() {
      _selectedFitnessLevel = level;
    });
  }

  void _toggleActivity(String activity) {
    setState(() {
      if (_selectedActivities.contains(activity)) {
        _selectedActivities.remove(activity);
      } else {
        _selectedActivities.add(activity);
      }
    });
  }

  void _selectGoal(String goal) {
    setState(() {
      _selectedGoal = goal;
    });
  }

  void _completeSetup() {
    widget.onComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHandle(),
        _buildHeader(),
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 6.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildFitnessLevelSection(),
                SizedBox(height: 4.h),
                _buildActivitiesSection(),
                SizedBox(height: 4.h),
                _buildGoalsSection(),
                SizedBox(height: 4.h),
              ],
            ),
          ),
        ),
        _buildCompleteButton(),
      ],
    );
  }

  Widget _buildHandle() {
    return Container(
      margin: EdgeInsets.only(top: 2.h),
      width: 12.w,
      height: 0.5.h,
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.outline.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
      child: Column(
        children: [
          Text(
            'Personalize Your Experience',
            style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurface,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 1.h),
          Text(
            'Help us customize FitTracker Pro to match your fitness goals and preferences',
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildFitnessLevelSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'What\'s your fitness level?',
          style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
            color: AppTheme.lightTheme.colorScheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 2.h),
        Column(
          children: _fitnessLevels.map((level) {
            final isSelected = _selectedFitnessLevel == level["id"];
            return GestureDetector(
              onTap: () => _selectFitnessLevel(level["id"] as String),
              child: Container(
                margin: EdgeInsets.only(bottom: 2.h),
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppTheme.lightTheme.colorScheme.primary
                          .withValues(alpha: 0.1)
                      : AppTheme.lightTheme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected
                        ? AppTheme.lightTheme.colorScheme.primary
                        : AppTheme.lightTheme.colorScheme.outline
                            .withValues(alpha: 0.2),
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Row(
                  children: [
                    CustomIconWidget(
                      iconName: level["icon"] as String,
                      color: isSelected
                          ? AppTheme.lightTheme.colorScheme.primary
                          : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                      size: 6.w,
                    ),
                    SizedBox(width: 4.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            level["title"] as String,
                            style: AppTheme.lightTheme.textTheme.titleSmall
                                ?.copyWith(
                              color: AppTheme.lightTheme.colorScheme.onSurface,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 0.5.h),
                          Text(
                            level["description"] as String,
                            style: AppTheme.lightTheme.textTheme.bodySmall
                                ?.copyWith(
                              color: AppTheme
                                  .lightTheme.colorScheme.onSurfaceVariant,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildActivitiesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'What activities do you enjoy?',
          style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
            color: AppTheme.lightTheme.colorScheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 1.h),
        Text(
          'Select all that apply',
          style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
            color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
          ),
        ),
        SizedBox(height: 2.h),
        Wrap(
          spacing: 3.w,
          runSpacing: 2.h,
          children: _activities.map((activity) {
            final isSelected = _selectedActivities.contains(activity["id"]);
            return GestureDetector(
              onTap: () => _toggleActivity(activity["id"] as String),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppTheme.lightTheme.colorScheme.primary
                          .withValues(alpha: 0.1)
                      : AppTheme.lightTheme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected
                        ? AppTheme.lightTheme.colorScheme.primary
                        : AppTheme.lightTheme.colorScheme.outline
                            .withValues(alpha: 0.2),
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomIconWidget(
                      iconName: activity["icon"] as String,
                      color: isSelected
                          ? AppTheme.lightTheme.colorScheme.primary
                          : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                      size: 5.w,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      activity["title"] as String,
                      style:
                          AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                        color: isSelected
                            ? AppTheme.lightTheme.colorScheme.primary
                            : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildGoalsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'What\'s your primary goal?',
          style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
            color: AppTheme.lightTheme.colorScheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 2.h),
        Column(
          children: _goals.map((goal) {
            final isSelected = _selectedGoal == goal["id"];
            return GestureDetector(
              onTap: () => _selectGoal(goal["id"] as String),
              child: Container(
                margin: EdgeInsets.only(bottom: 2.h),
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppTheme.lightTheme.colorScheme.primary
                          .withValues(alpha: 0.1)
                      : AppTheme.lightTheme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected
                        ? AppTheme.lightTheme.colorScheme.primary
                        : AppTheme.lightTheme.colorScheme.outline
                            .withValues(alpha: 0.2),
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Row(
                  children: [
                    CustomIconWidget(
                      iconName: goal["icon"] as String,
                      color: isSelected
                          ? AppTheme.lightTheme.colorScheme.primary
                          : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                      size: 6.w,
                    ),
                    SizedBox(width: 4.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            goal["title"] as String,
                            style: AppTheme.lightTheme.textTheme.titleSmall
                                ?.copyWith(
                              color: AppTheme.lightTheme.colorScheme.onSurface,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 0.5.h),
                          Text(
                            goal["description"] as String,
                            style: AppTheme.lightTheme.textTheme.bodySmall
                                ?.copyWith(
                              color: AppTheme
                                  .lightTheme.colorScheme.onSurfaceVariant,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildCompleteButton() {
    final canComplete = _selectedFitnessLevel.isNotEmpty &&
        _selectedActivities.isNotEmpty &&
        _selectedGoal.isNotEmpty;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
      child: GestureDetector(
        onTap: canComplete ? _completeSetup : null,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 2.h),
          decoration: BoxDecoration(
            color: canComplete
                ? AppTheme.lightTheme.colorScheme.primary
                : AppTheme.lightTheme.colorScheme.outline
                    .withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            'Complete Setup',
            style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
              color: canComplete
                  ? AppTheme.lightTheme.colorScheme.onPrimary
                  : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
