import '../../../../../common/imports/imports.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  FormGroup formGroup = FormGroup(
    {
      InputKeys.username:
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
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
