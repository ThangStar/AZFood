class Router {
  //auth
  static String login = "/api/user/login";
  static String register = "/register";
  static String profileDetail = "/api/user/details";

  //product
  static String listProduct = "/api/products/list";
  static String category = "/api/products/category";
  static String productsFilter = '/api/products/filterData';
  static String searchProduct = '/api/products/searchProducts';

  //table
  static String updateStatusTable = '/api/table/updateStatus';

  //order
  static String createOrder = '/api/orders/create';
  static String getOrderInTable = '/api/orders/getOrder';
  static String payBill = '/api/orders/payBill';

  //invoice
  static String getAllInvoice = '/api/invoice/list';
  static String getInvoiceByIdUser = '/api/invoice/listbyiduser';

  //calendar
  static String attendance = '/api/attendance/attendance';

  //forgot_pass
  static String sendEmail = '/api/auth/checkAndSendOtpToEmail';
  static String verifyOtp = '/api/auth/verifyOtpFromUser';
  static String resetPass = '/api/auth/resetPassword';

  //profile
  static String updatePassword = "/api/user/change";
  static String updateProfile = "/api/user/updateinfo";

  //Income
  static String inComeAYear = "/api/stats/revenue-year";
  static String inComeAMonth = "/api/stats/revenue-month";
}
