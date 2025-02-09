class AppStrings {
  // Common
  static const String add = "Add";
  static const String next = "Next";

  // Email validation
  static const String emailPattern =
      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$";
  static const String emailCannotBeEmpty = "Email cannot be empty";
  static const String enterValidEmailAddress = "Enter a valid email address";

  // Password Validation
  static const String passwordCannotBeEmpty = "Password cannot be empty";
  static const String passwordMustBeLong =
      "Password must be at least 8 characters long";
  static const String passwordContainUppercaseLetter =
      "Password must contain at least one uppercase letter";
  static const String passwordContainLowercaseLetter =
      "Password must contain at least one uppercase letter";
  static const String passwordContainNumber =
      "Password must contain at least one number";
  static const String passwordContainSpecialCharacter =
      "Password must contain at least one special character";

  // Username Validation
  static const String userNameCannotBeEmpty = "Username Cannot be empty";
  static const String userNameTooShort = "Username too short";

  // Auth
  static const String appName = "COINLY";
  static const String loginToYourAccount = "Login to Your Account";
  static const String createNewAccount = "Create New Account";
  static const String email = "Email";
  static const String userName = "Username";
  static const String password = "Password";
  static const String signIn = "Sign In";
  static const String signUp = "Sign Up";
  static const String dontHaveAccount = "Don't have an account? ";
  static const String alreadyHaveAnAccount = "Already have an account? ";

  // Home
  static const String search = "Search";
  static const String totalBalance = "Total Balance";
  static const String totalDebit = "Total Debit";
  static const String totalCredit = "Total Credit";
  static const String recentTransactions = "Recent Transactions";

  // Ai Assistant
  static const String aiAssistant = "AI Assistant";

  // Debit
  static const String debit = "Debit";
  static const String amount = "Amount";
  static const String expenseName = "Name";
  static const String date = "Date";
  static const String otherDetails = "Other Details";

  // Credit
  static const String credit = "Credit";

  // Add Amount Bottom Sheet
  static const String setYourCurrentBalance =
      "Set your current balance to accurately reflect your finances.";
  static const String addYourCurrentBalance = "Add Current Balance";

  // Expense
  static const String expense = "Expense";
}
