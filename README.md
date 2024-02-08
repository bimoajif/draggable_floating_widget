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

<a href="https://www.buymeacoffee.com/bimoajif" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" style="height: 60px !important;width: 217px !important;" ></a>
