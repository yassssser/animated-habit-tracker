import 'package:flutter/material.dart';
import 'package:habit_tracker_flutter/constants/app_assets.dart';
import 'package:habit_tracker_flutter/ui/common_widgets/centered_svg_icon.dart';
import 'package:habit_tracker_flutter/ui/task/task_completion_ring.dart';
import 'package:habit_tracker_flutter/ui/theming/app_theme.dart';

class AnimatedTask extends StatefulWidget {
  AnimatedTask({Key key, @required this.iconName}) : super(key: key);

  final String iconName;

  @override
  _AnimatedTaskState createState() => _AnimatedTaskState();
}

class _AnimatedTaskState extends State<AnimatedTask>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _curveAnimation;
  bool _showCheckIcon = false;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: Duration(milliseconds: 750), vsync: this);
    _animationController.addStatusListener(_checkStatusUpdates);
    _curveAnimation =
        _animationController.drive(CurveTween(curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _animationController.removeStatusListener(_checkStatusUpdates);
    _animationController.dispose();
    super.dispose();
  }

  void _checkStatusUpdates(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      setState(() => _showCheckIcon = true);
      Future.delayed(Duration(seconds: 1), () {
        setState(() => _showCheckIcon = false);
      });
    }
  }

  void _handleTapDown(TapDownDetails details) {
    if (_animationController.status != AnimationStatus.completed) {
      _animationController.forward();
    } else {
      _animationController.value = 0.0;
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (_animationController.status != AnimationStatus.completed) {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      child: AnimatedBuilder(
        animation: _curveAnimation,
        builder: (context, child) {
          final themeData = AppTheme.of(context);
          final progress = _curveAnimation.value;
          final hasCompleted = progress == 1.0;
          final iconColor =
              hasCompleted ? themeData.accentNegative : themeData.taskIcon;
          return Stack(
            children: [
              TaskCompletionRing(
                progress: _curveAnimation.value,
              ),
              Positioned.fill(
                child: CenteredSvgIcon(
                  iconName: hasCompleted && _showCheckIcon
                      ? AppAssets.check
                      : widget.iconName,
                  color: iconColor,
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
