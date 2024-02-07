import 'package:flutter/material.dart';

class DraggableFloatingWidget extends StatefulWidget {
  final Size size;
  final Widget child;
  final BuildContext context;
  final double? hidePercentage;
  final bool? fullHide;
  final bool? showDismiss;
  final bool? dockToSide;

  const DraggableFloatingWidget({
    super.key,
    required this.context,
    required this.child,
    required this.size,
    this.hidePercentage,
    this.fullHide,
    this.showDismiss,
    this.dockToSide,
  });

  @override
  State<DraggableFloatingWidget> createState() =>
      _DraggableFloatingWidgetState();
}

class _DraggableFloatingWidgetState extends State<DraggableFloatingWidget> {
  final GlobalKey _widgetKey = GlobalKey();

  late Size size;

  bool showWidget = true,
      showDismiss = true,
      fullHide = false,
      dockToSide = false,
      showFab = true;
  int duration = 0;
  late double mindy, maxdy;
  double hidePercentage = 0.8;
  Alignment dismissBtnAlignment = Alignment.topLeft;

  late Offset position;
  late double halfScreenHeight,
      halfScreenWidth,
      halfWidthRelative,
      halfHeightRelative;

  @override
  void initState() {
    size = widget.size;
    fullHide = widget.fullHide ?? fullHide;
    dockToSide = widget.dockToSide ?? fullHide;
    showDismiss = widget.showDismiss ?? showDismiss;
    hidePercentage =
        widget.hidePercentage == null ? hidePercentage : widget.hidePercentage!;

    ///
    /// Get half of screen w and h of device
    ///
    halfScreenHeight = MediaQuery.of(widget.context).size.height / 2;
    halfScreenWidth = MediaQuery.of(widget.context).size.width / 2;

    // Relative half width to widget size
    halfWidthRelative = halfScreenWidth - (size.width / 2);
    halfHeightRelative = halfScreenHeight - (size.height / 2);

    // mindy = size.height / 2;
    mindy = MediaQuery.of(widget.context).padding.top;
    maxdy = halfScreenHeight * 2 -
        size.height -
        MediaQuery.of(widget.context).padding.bottom;
    // maxdy = halfScreenHeight * 2 - size.height * 2;

    // Inital position of widget
    position = Offset((halfScreenWidth * 2) - (size.width + 10), maxdy);

    super.initState();
  }

  void setOffset({required Offset offset}) {
    late double dy;
    setState(() {
      duration = 0;
      position = offset;

      Future.delayed(const Duration(milliseconds: 50)).whenComplete(() {
        // double dy = offset.dy < 0 ? size.height / 2 : offset.dy;
        if (offset.dy < MediaQuery.of(widget.context).padding.top) {
          dy = mindy;
        } else if (offset.dy + size.height * 2 > halfScreenHeight * 2) {
          dy = maxdy;
        } else {
          dy = offset.dy;
        }
        setState(() {
          duration = 400;
          position = Offset(
            dockToSide
                ? (offset.dx < halfWidthRelative
                    ? 0
                    : (halfScreenWidth * 2) - (size.width + 10))
                : offset.dx,
            dy,
          );
          dismissBtnAlignment = offset.dx < halfWidthRelative
              ? Alignment.topRight
              : Alignment.topLeft;
          showWidget = true;
        });
      });
    });
  }

  void dismissCallback(Offset offset, double percent) {
    double percentage = (size.width * percent);

    setState(() {
      duration = 300;
      showWidget
          ? position = Offset(
              (offset.dx < halfScreenWidth
                  ? 0 - percentage
                  : offset.dx + percentage),
              offset.dy)
          : position = Offset(
              (offset.dx < halfScreenWidth ? 0 : offset.dx - percentage),
              offset.dy,
            );
      showWidget = !showWidget;
    });
  }

  // void fabCallback(Offset offset) {
  //   if (!showWidget) {
  //     dismissCallback(offset, 0.0);
  //   } else {
  //     widget.childCallback();
  //     setState(() {
  //       showWidget = true;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      key: _widgetKey,
      duration: Duration(milliseconds: duration),
      curve: Curves.easeOutBack,
      left: position.dx,
      top: position.dy,
      child: Draggable(
        feedback: _buildWidget(offset: position),
        childWhenDragging: const SizedBox(),
        onDragEnd: (details) {
          setOffset(offset: details.offset);
        },
        child: _buildWidget(offset: position),
      ),
    );
  }

  Widget _buildWidget({required Offset offset}) {
    return Stack(
      alignment: dismissBtnAlignment,
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Center(
            child: widget.child,
          ),
        ),
        showDismiss ? _buildDismiss(offset) : const SizedBox()
      ],
    );
  }

  Widget _buildDismiss(Offset offset) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          dismissCallback(offset, fullHide ? 1.5 : hidePercentage);
        },
        borderRadius: BorderRadius.circular(12),
        child: Ink(
          height: 24,
          width: 24,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.black.withOpacity(0.65),
          ),
          child: const Icon(
            Icons.clear_rounded,
            weight: 10,
            size: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
