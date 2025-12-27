import 'package:app_name/common/extensions/form_group_extension.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../common/constant/input_keys.dart';

class LoginForm {
  static FormGroup formGroup = FormGroup({
    InputKeys.email: FormControl<String>(
      validators: [
        Validators.required,
        Validators.email,
      ],
    ),
    InputKeys.password: FormControl<String>(
      validators: [Validators.required, Validators.minLength(4)],
    ),
  });

  static String getEmail() {
    return formGroup.getString(InputKeys.email);
  }

  static String getPassword() {
    return formGroup.getString(InputKeys.password);
  }
}
