class EndPoints {
  //Authentication
  static const String login = '/api/login';
  static const String signup = '/api/register';
  //get schedules and slots
  static const String schedules = '/api/schedules';
  static const String slots = '/api/slots';
  //payment
  static const String getToken = '/auth/tokens';
  static const String getOrderId = '/ecommerce/orders';
  static const String getRequestToken = '/acceptance/payment_keys';
}
