import 'package:flutter/material.dart';

class UserProfileTabBarTile extends StatefulWidget {
  const UserProfileTabBarTile({
    super.key,
    required this.isSelected,
    required this.text,
    required this.onTap,
  });

  final bool isSelected;
  final String text;
  final VoidCallback onTap;

  @override
  State<UserProfileTabBarTile> createState() => _UserProfileTabBarTileState();
}

class _UserProfileTabBarTileState extends State<UserProfileTabBarTile> {
  late ThemeData theme;
  bool isHovered = false;

  @override
  void didChangeDependencies() {
    theme = Theme.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        decoration: BoxDecoration(
            color: widget.isSelected ? theme.primaryColor : Colors.transparent,
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: Center(
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            onEnter: (event) => _setState(true),
            onExit: (event) => _setState(false),
            child: Text(
              widget.text,
              style: theme.textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: widget.isSelected
                      ? theme.colorScheme.onPrimary
                      : isHovered
                          ? theme.colorScheme.primary.withOpacity(0.8)
                          : null),
            ),
          ),
        ),
      ),
    );
  }

  void _setState(bool value) {
    if (mounted) {
      setState(() {
        isHovered = value;
      });
    }
  }
}
