import '../imports/imports.dart';

extension WidgetExtension on GlobalKey {
  double? getWidgetSize() {
    final RenderBox? renderBox =
        currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      return renderBox.size.width;
    }
    return null;
  }
}

// Example usage:
// GlobalKey widgetKey = GlobalKey();

// Get the widget width:
// double width = widgetKey.getWidgetSize();
