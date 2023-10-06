class Router {
  //auth
  static String login = "/api/user/login";
  static String register = "/register";
  static String profileDetail = "/api/user/details";
  static String updatePassword = "/api/user/change";

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

  //calendar
  static String attendance = '/api/attendance/attendance';
  //forgot_pass
  static String sendEmail = '/api/auth/checkAndSendOtpToEmail';
  static String verifyOtp = '/api/auth/verifyOtpFromUser';
}
