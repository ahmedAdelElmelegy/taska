class Validator {
  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    if (!emailRegex.hasMatch(email)) {
      return 'Invalid email format';
    }
    return null;
  }

  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password is required';
    }
    if (password.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  static String? validateFullName(String? fullName) {
    if (fullName == null || fullName.isEmpty) {
      return 'Full name is required';
    }
    if (fullName.length < 3) {
      return 'Full name must be at least 3 characters long';
    }
    return null;
  }

  static String? validateUsername(String? username) {
    if (username == null || username.isEmpty) {
      return 'Username is required';
    }
    final usernameRegex = RegExp(r'^[a-zA-Z][a-zA-Z0-9_]{2,29}$');
    if (!usernameRegex.hasMatch(username)) {
      return 'Username must start with a letter and can only contain letters, numbers and underscores and must be between 3 and 30 characters long';
    }
    return null;
  }

  static String? validatePhone(String? phone) {
    if (phone == null || phone.isEmpty) {
      return 'Phone number is required';
    }
    final phoneRegex = RegExp(r'^\+?[0-9]{10,15}$');
    if (!phoneRegex.hasMatch(phone)) {
      return 'Invalid phone number format';
    }
    return null;
  }

  static String? validateDateOfBirth(String? date) {
    if (date == null || date.isEmpty) {
      return 'Date of birth is required';
    }
    final dateRegex = RegExp(r'^\d{1,2}/\d{1,2}/\d{4}$');
    if (!dateRegex.hasMatch(date)) {
      return 'Invalid date format. Use MM/DD/YYYY';
    }
    return null;
  }

  static String? role(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }
}
