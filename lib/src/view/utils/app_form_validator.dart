class AppFormValidator {
  static String? generalEmptyValidator(String? orgText) {
    final text = orgText?.trimRight();
    if (text == null || text.isEmpty) {
      return 'This field can not be empty';
    }
    return null;
  }

  static String? generalEmailValidator(String? orgText) {
    final String? emptyValidation = generalEmptyValidator(orgText);
    if (emptyValidation == null) {
      if (!orgText!.contains('@')) {
        return 'Please add a vaild email';
      }
      return null;
    }
    return emptyValidation;
  }

  static String? generalPasswordValidator(String? orgText) {
    final String? emptyValidation = generalEmptyValidator(orgText);
    if (emptyValidation == null) {
      if (orgText!.length < 6) {
        return 'Please add a valid password';
      }
      return null;
    }
    return emptyValidation;
  }
}
