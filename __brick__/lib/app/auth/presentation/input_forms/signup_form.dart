import 'package:reactive_forms/reactive_forms.dart';
import '../../../../common/constant/input_keys.dart';

class SignUpForm {
  static FormGroup formGroup = FormGroup(
    {
      InputKeys.fullName:
          FormControl<String>(validators: [Validators.required]),
      InputKeys.lastName:
          FormControl<String>(validators: [Validators.required]),
      InputKeys.email: FormControl<String>(validators: [Validators.required]),
      InputKeys.image: FormControl<String>(validators: []),
      InputKeys.birthdate: FormControl<DateTime>(validators: []),
      InputKeys.phoneNumber:
          FormControl<String>(validators: [Validators.required]),
      InputKeys.password: FormControl<String>(
        validators: [Validators.required, Validators.minLength(8)],
      ),
      InputKeys.confirmPassword: FormControl<String>(
        validators: [Validators.required, Validators.minLength(8)],
      ),
    },
    validators: [
      Validators.mustMatch(
        InputKeys.password,
        InputKeys.confirmPassword,
      ),
    ],
  );
}
