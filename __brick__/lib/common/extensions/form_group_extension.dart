import 'package:reactive_forms/reactive_forms.dart';

extension FormGroupX on FormGroup {
  // ----------------------
  // 🔹 GETTERS
  // ----------------------

  T? valueOf<T>(String name) {
    return control(name).value as T?;
  }

  String getString(String name) => valueOf<String>(name) ?? '';

  int getInt(String name) => valueOf<int>(name) ?? 0;

  double getDouble(String name) => valueOf<double>(name) ?? 0.0;

  bool getBool(String name) => valueOf<bool>(name) ?? false;

  DateTime? getDate(String name) => valueOf<DateTime>(name);

  // ----------------------
  // 🔹 SETTERS
  // ----------------------

  void setValueOf<T>(
    String name,
    T value, {
    bool emitEvent = true,
    bool markAsDirty = true,
  }) {
    final control = this.control(name);

    control.updateValue(
      value,
      emitEvent: emitEvent,
    );

    if (markAsDirty) {
      control.markAsDirty();
    }
  }

  void setValues(
    Map<String, dynamic> values, {
    bool emitEvent = true,
  }) {
    patchValue(
      values,
      emitEvent: emitEvent,
    );
  }

  // ----------------------
  // 🔹 STATE HELPERS
  // ----------------------

  void disable(String name) => control(name).markAsDisabled();

  void enable(String name) => control(name).markAsEnabled();

  void touch(String name) => control(name).markAsTouched();

  void resetControl(String name) => control(name).reset();

  bool isValid(String name) => control(name).valid;

  bool isInvalid(String name) => control(name).invalid;

  bool isTouched(String name) => control(name).touched;

  bool isDirty(String name) => control(name).dirty;

  // ----------------------
  // 🔹 ERROR HELPERS
  // ----------------------

  bool hasError(String name, String error) {
    return control(name).hasError(error);
  }

  Map<String, dynamic>? errorsOf(String name) {
    return control(name).errors;
  }
}
