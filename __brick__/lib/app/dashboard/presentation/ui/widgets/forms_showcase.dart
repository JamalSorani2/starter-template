import '/app/auth/presentation/ui/widget/email_field.dart';
import '/app/auth/presentation/ui/widget/passwrod_field.dart';
import '/app/auth/presentation/ui/widget/phone_number_field.dart';
import '/app/auth/presentation/ui/widget/user_name_field.dart';
import '/common/imports/imports.dart';

class FormsShowcase extends StatefulWidget {
  const FormsShowcase({super.key});

  @override
  State<FormsShowcase> createState() => _FormsShowcaseState();
}

class _FormsShowcaseState extends State<FormsShowcase> {
  late final FormGroup _form;

  final List<FileModel> _pickedImages = [];

  final phoneController = PhoneController();

  @override
  void initState() {
    super.initState();
    _form = FormGroup({
      'username': FormControl<String>(validators: [Validators.required]),
      'email': FormControl<String>(validators: [Validators.email]),
      'password': FormControl<String>(),
      'country': FormControl<String>(),
      'date': FormControl<DateTime>(),
      'dateRange': FormControl<DateTimeRange>(),
      'search': FormControl<String>(),
      'number': FormControl<num>(),
    });
  }

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Forms Showcase', style: tt.displayLarge),
        CustomDivider(height: 4.h, margin: REdgeInsets.symmetric(vertical: 8)),
        ReactiveForm(
          formGroup: _form,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text fields
              const UsernameField(
                withTitle: true,
              ),
              12.verticalSpace,
              const EmailField(),
              12.verticalSpace,
              const PasswordField(
                hintText: 'Your secure password',
                isConfirmPassword: false,
              ),
              12.verticalSpace,
              PhoneNumberField(
                controller: phoneController,
                title: AppString.phoneNumber,
              ),
              12.verticalSpace,
              // Dropdown
              CustomReactiveDropdown<String>(
                title: 'Country',
                controller: 'country',
                hintText: 'Select your country',
                prefixIcon: Icons.public,
                items: [
                  DropDownModel(id: 'us', name: 'United States'),
                  DropDownModel(id: 'uk', name: 'United Kingdom'),
                  DropDownModel(id: 'de', name: 'Germany'),
                ],
              ),

              12.verticalSpace,
              // Date pickers
              const CustomDatePicker(controller: 'date', title: 'Date'),
              12.verticalSpace,
              CustomReactiveDateRangePicker(
                title: 'Date Range',
                hintText: 'Pick a start and end date',
                controller: 'dateRange',
                formGroup: _form,
              ),

              12.verticalSpace,
              // Search & number
              CustomSearchField(
                controller: 'search',
                hintText: 'Search...',
                onSubmitted: (FormControl<dynamic> control) {
                  BotToast.showText(text: 'Searched: ${control.value}');
                },
              ),
              12.verticalSpace,
              const CustomReactiveNumberField(
                controller: 'number',
                title: 'Amount',
                hintText: 'Enter a number',
                prefixIcon: Icons.attach_money,
              ),

              20.verticalSpace,
              // Images picker demo

              ImagesPickerField(
                images: _pickedImages,
                title: "Images Picker",
                onPickImages: (files) {
                  setState(() => _pickedImages.addAll(files));
                },
                onEditImage: (index, image) {
                  setState(() {
                    if (image.isNetwork) {
                      return;
                    }
                    _pickedImages[index] = image;
                  });
                },
                onDeleteImage: (index) {
                  setState(() {
                    if (index >= 0 && index < _pickedImages.length) {
                      _pickedImages.removeAt(index);
                    }
                  });
                },
              ),

              20.verticalSpace,
              // Submit preview
              Align(
                alignment: Alignment.centerLeft,
                child: CustomButton.primary(
                  isLoading: false,
                  text: 'Print Form Value',
                  onPressed: () {
                    if (_form.valid) {
                      BotToast.showText(text: _form.value.toString());
                    } else {
                      _form.markAllAsTouched();
                      BotToast.showText(text: 'Please fill required fields');
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
