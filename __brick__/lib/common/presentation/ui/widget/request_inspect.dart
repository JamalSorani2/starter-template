import 'package:draggable_float_widget/draggable_float_widget.dart';
import 'package:flutter_alice/alice.dart';

import '../../../../app/app.dart';
import '../../../imports/imports.dart';

class RequestInspect extends StatefulWidget {
  const RequestInspect({super.key, required this.child, this.enabled = false});

  final bool enabled;
  final Widget child;

  @override
  State<RequestInspect> createState() => _RequestInspectState();
}

class _RequestInspectState extends State<RequestInspect> {
  late Alice alice;

  @override
  void initState() {
    if (!widget.enabled) {
      return;
    }
    alice = Alice(
      showNotification: false,
      showInspectorOnShake: true,
      navigatorKey: navigatorKey,
    );

    if (!getIt.isRegistered<Alice>()) {
      getIt.registerLazySingleton<Alice>(() => alice);
    }
    getIt<Dio>().interceptors.add(alice.getDioInterceptor());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) {
      return widget.child;
    }
    return Overlay(
      initialEntries: [
        OverlayEntry(
          builder: (context) {
            return Stack(
              children: [
                widget.child,
                DraggableFloatWidget(
                  config: const DraggableFloatWidgetBaseConfig(
                    isFullScreen: false,
                    initPositionYInTop: false,
                    initPositionYMarginBorder: 50,
                  ),
                  child: FloatingActionButton(
                    child: const Icon(Icons.construction_outlined),
                    onPressed: () {
                      alice.showInspector();
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
