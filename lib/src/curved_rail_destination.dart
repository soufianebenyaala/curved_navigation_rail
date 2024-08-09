import 'package:curved_navigation_rail/src/curve_painter.dart';
import 'package:flutter/material.dart';

class CurvedRailDestination extends StatefulWidget {
  const CurvedRailDestination({
    super.key,
    required this.minWidth,
    required this.minExtendedWidth,
    required this.icon,
    required this.label,
    required this.selected,
    required this.iconTheme,
    required this.labelTextStyle,
    required this.onTap,
    this.padding,
    this.indicatorColor,
    this.indicatorShape,
    this.disabled = false,
  });
  final double minWidth;
  final double minExtendedWidth;
  final Widget icon;
  final Widget label;
  final bool selected;
  final IconThemeData iconTheme;
  final TextStyle labelTextStyle;
  final VoidCallback onTap;
  final EdgeInsetsGeometry? padding;
  final Color? indicatorColor;
  final ShapeBorder? indicatorShape;
  final bool disabled;
  @override
  State<CurvedRailDestination> createState() => _CurvedRailDestinationState();
}

class _CurvedRailDestinationState extends State<CurvedRailDestination>
    with TickerProviderStateMixin {
  late AnimationController _controller1;
  late AnimationController _controller2;

  late Animation<double> _anim1;
  late Animation<double> _anim2;
  late Animation<double> _anim3;

  bool hovered = false;

  @override
  void initState() {
    super.initState();
    _controller1 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _controller2 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 275),
    );

    _anim1 = Tween(begin: widget.minWidth, end: widget.minWidth * 0.8)
        .animate(_controller1);
    _anim2 = Tween(begin: widget.minWidth, end: widget.minWidth * 0.05)
        .animate(_controller2);
    _anim3 = Tween(begin: widget.minWidth, end: widget.minWidth * 0.2)
        .animate(_controller2);

    _controller1.addListener(() {
      setState(() {});
    });
    _controller2.addListener(() {
      setState(() {});
    });
  }

  @override
  void didUpdateWidget(CurvedRailDestination oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!widget.selected) {
      _controller1.reverse();
      _controller2.reverse();
    } else {
      _controller1.forward();
      _controller2.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final Widget themedIcon = IconTheme(
      data: widget.disabled
          ? widget.iconTheme
              .copyWith(color: theme.colorScheme.onSurface.withOpacity(0.38))
          : widget.iconTheme,
      child: widget.icon,
    );
    final Widget styledLabel = DefaultTextStyle(
      style: widget.disabled
          ? widget.labelTextStyle
              .copyWith(color: theme.colorScheme.onSurface.withOpacity(0.38))
          : widget.labelTextStyle,
      child: widget.label,
    );
    return GestureDetector(
      onTap: () {
        widget.onTap();
      },
      child: MouseRegion(
        onEnter: (value) {
          setState(() {
            hovered = true;
          });
        },
        onExit: (value) {
          setState(() {
            hovered = false;
          });
        },
        child: Container(
          width: widget.minWidth,
          padding: widget.padding ??
              const EdgeInsets.symmetric(
                  horizontal: _horizontalDestinationPadding),
          color:
              hovered && !widget.selected ? Colors.white12 : Colors.transparent,
          child: Stack(
            children: [
              Positioned(
                child: CustomPaint(
                  painter: CurvePainter(
                    value1: 5,
                    animValue1: _anim3.value,
                    animValue2: _anim2.value,
                    animValue3: _anim1.value,
                    minWidth: widget.minWidth,
                  ),
                ),
              ),
              Container(
                constraints: BoxConstraints(
                  minWidth: widget.minWidth,
                  minHeight: widget.minWidth * 0.75,
                ),
                padding: widget.padding ??
                    const EdgeInsets.symmetric(
                        horizontal: _horizontalDestinationPadding),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    //  topSpacing,
                    themedIcon,
                    const SizedBox(
                      width: 5,
                    ),
                    styledLabel,
                    //   bottomSpacing,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

const double _horizontalDestinationPadding = 8.0;
