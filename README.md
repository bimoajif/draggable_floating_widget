<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

# Draggable Floating Widget
---
A package provides a widget that draggable across your flutter screen.

## How to use

```dart
import 'package:draggable_floating_widget/draggable_floating_widget.dart';
```

```dart
class DraggableFloatingWidgetExample extends StatelessWidget {
  const DraggableFloatingWidgetExample({super.key});

  @override
  Widget build(BuildContext context) {
    DraggableFloatingWidget draggableFloatingWidget = DraggableFloatingWidget(
        context: context,
        size: const Size(80, 80),
        dockToSide: false,
        showDismiss: true,
        fullHide: true,
        hidePercentage: 0.8,
        child: Material(
          child: Container(
            height: 80,
            width: 80,
            color: Colors.blue,
            child: const Center(child: Text('example')),
          ),
        ));

    return Scaffold(
      body: Stack(children: [draggableFloatingWidget]),
    );
  }
}
```
for detailed example please check `/example` folder.

## Additional information

<a href="https://www.buymeacoffee.com/bimoajif" target="_blank"><img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRgd3lKuAPV9303IOElJJr1f-ZvLFtAztPPOsdk2fS_w9z5GOLgop0zduT0-t_nc7wgRQ&usqp=CAU" alt="Buy Me A Coffee" height="60"></a>
