class ApiEndpoints {
  // static String baseUrl = "http://169.254.134.24:3333";
  static String baseUrl = "http://localhost:3333";
  // static String baseUrl = "https://coinly-server.onrender.com";

  // Auth Endpoints
  static String signIn = "/auth/signin";
  static String signUp = "/auth/signup";

  // Home
  static String userAmount = "/users/me/amount";

  // Expense
  static String transaction = "/expense/user";
  static String addTransaction = "/expense/create-expense";
  static String expenseCategory = "/expense-category/all-categories";
}
