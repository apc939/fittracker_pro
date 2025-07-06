import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import './user_preference_widget.dart';

class PermissionBottomSheetWidget extends StatefulWidget {
  final VoidCallback onComplete;

  const PermissionBottomSheetWidget({
    super.key,
    required this.onComplete,
  });

  @override
  State<PermissionBottomSheetWidget> createState() =>
      _PermissionBottomSheetWidgetState();
}

class _PermissionBottomSheetWidgetState
    extends State<PermissionBottomSheetWidget> {
  bool _notificationPermissionGranted = false;
  bool _healthDataPermissionGranted = false;
  bool _showUserPreferences = false;

  final List<Map<String, dynamic>> _permissions = [
    {
      "id": 1,
      "title": "Workout Notifications",
      "description":
          "Get reminders for your scheduled workouts and celebrate your achievements",
      "icon": "notifications",
      "isRequired": false,
    },
    {
      "id": 2,
      "title": "Health Data Access",
      "description":
          "Sync with your device's health app to track comprehensive fitness metrics",
      "icon": "favorite",
      "isRequired": true,
    },
  ];

  void _requestNotificationPermission() {
    setState(() {
      _notificationPermissionGranted = !_notificationPermissionGranted;
    });
  }

  void _requestHealthDataPermission() {
    setState(() {
      _healthDataPermissionGranted = !_healthDataPermissionGranted;
    });
  }

  void _continueToPreferences() {
    setState(() {
      _showUserPreferences = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85.h,
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: _showUserPreferences
          ? UserPreferenceWidget(onComplete: widget.onComplete)
          : _buildPermissionContent(),
    );
  }

  Widget _buildPermissionContent() {
    return Column(
      children: [
        _buildHandle(),
        _buildHeader(),
        Expanded(
          child: _buildPermissionList(),
        ),
        _buildContinueButton(),
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
            'Enable Permissions',
            style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurface,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 1.h),
          Text(
            'Allow FitTracker Pro to provide you with the best fitness tracking experience',
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

  Widget _buildPermissionList() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 6.w),
      itemCount: _permissions.length,
      itemBuilder: (context, index) {
        final permission = _permissions[index];
        final isNotification = permission["id"] == 1;
        final isGranted = isNotification
            ? _notificationPermissionGranted
            : _healthDataPermissionGranted;

        return Container(
          margin: EdgeInsets.only(bottom: 3.h),
          padding: EdgeInsets.all(4.w),
          decoration: BoxDecoration(
            color: AppTheme.lightTheme.colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppTheme.lightTheme.colorScheme.outline
                  .withValues(alpha: 0.2),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(3.w),
                decoration: BoxDecoration(
                  color: isGranted
                      ? AppTheme.lightTheme.colorScheme.primary
                          .withValues(alpha: 0.1)
                      : AppTheme.lightTheme.colorScheme.outline
                          .withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: CustomIconWidget(
                  iconName: permission["icon"] as String,
                  color: isGranted
                      ? AppTheme.lightTheme.colorScheme.primary
                      : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                  size: 6.w,
                ),
              ),
              SizedBox(width: 4.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            permission["title"] as String,
                            style: AppTheme.lightTheme.textTheme.titleMedium
                                ?.copyWith(
                              color: AppTheme.lightTheme.colorScheme.onSurface,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (permission["isRequired"] as bool)
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 2.w, vertical: 0.5.h),
                            decoration: BoxDecoration(
                              color: AppTheme.lightTheme.colorScheme.error
                                  .withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'Required',
                              style: AppTheme.lightTheme.textTheme.labelSmall
                                  ?.copyWith(
                                color: AppTheme.lightTheme.colorScheme.error,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      permission["description"] as String,
                      style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                        color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 2.w),
              GestureDetector(
                onTap: isNotification
                    ? _requestNotificationPermission
                    : _requestHealthDataPermission,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                  decoration: BoxDecoration(
                    color: isGranted
                        ? AppTheme.lightTheme.colorScheme.primary
                        : AppTheme.lightTheme.colorScheme.outline
                            .withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    isGranted ? 'Granted' : 'Allow',
                    style: AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                      color: isGranted
                          ? AppTheme.lightTheme.colorScheme.onPrimary
                          : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildContinueButton() {
    final canContinue = _healthDataPermissionGranted;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
      child: GestureDetector(
        onTap: canContinue ? _continueToPreferences : null,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 2.h),
          decoration: BoxDecoration(
            color: canContinue
                ? AppTheme.lightTheme.colorScheme.primary
                : AppTheme.lightTheme.colorScheme.outline
                    .withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            'Continue',
            style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
              color: canContinue
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
