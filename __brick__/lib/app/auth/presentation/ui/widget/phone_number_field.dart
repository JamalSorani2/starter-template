import '/common/imports/imports.dart';
import 'package:phone_form_field/phone_form_field.dart';

class PhoneNumberField extends StatelessWidget {
  const PhoneNumberField({
    super.key,
    required this.controller,
    this.phoneFocus,
    this.title,
  });
  final PhoneController controller;
  final FocusNode? phoneFocus;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (title != null) TitleWidget(title: title!),
        Directionality(
          textDirection: TextDirection.ltr,
          child: PhoneFormField(
            controller: controller,
            focusNode: phoneFocus,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(hintText: AppString.phoneNumber),
            countryButtonStyle: CountryButtonStyle(
              padding: REdgeInsets.only(left: 16, right: 16),
            ),
            validator: (PhoneNumber? p) {
              if (p == null) {
                return AppString.phoneNumberIsRequired;
              }
              if (!p.isValid()) {
                return AppString.phoneNumberIsInvalid;
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}

void setPhoneNumberFromString({
  required PhoneController phoneNumberController,
  required String fullNumber,
}) {
  if (fullNumber.isEmpty) {
    return;
  }

  try {
    final phoneNumber = PhoneNumber.parse(fullNumber);
    phoneNumberController.value = phoneNumber;
  } catch (_) {
    // ignore invalid phone format
  }
}
