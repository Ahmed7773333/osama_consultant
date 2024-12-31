class EndPoints {
  //Authentication
  static const String login = '/api/login';
  static const String loginGoogle = '/api/social/login';
  static const String signup = '/api/register';
  static const String signupGoogle = '/api/social/register';
  static const String logout = '/api/logout';
  //get schedules and slots
  static const String schedules = '/api/schedules';
  static const String slots = '/api/slots';
  //payment
  static const String getToken = '/auth/tokens';
  static const String getOrderId = '/ecommerce/orders';
  static const String getRequestToken = '/acceptance/payment_keys';
  //notification
  static const String sendNotification = '/api/fcm/push';
  //confirmBooking
  static const String meeting = '/api/meetings';
  static const String approveMeetings = '/api/meetings/approve/';
  static const String inProgressMeetings = '/api/meetings/in-progress/';
  static const String finishMeetings = '/api/meetings/finish/';
  static const String generateRtcToken = '/api/user/rtcToken';
  //consultants counter
  static const String consultantPlus = '/api/consultant/store';
  static const String consultantMinus = '/api/consultant/';
  //edit profile
  static const String editProfile = '/api/user/profile';
  //forgetPassword
  static const String forgetPasswordRequest = '/api/password/forgot';
  static const String resetPassword = '/api/password/reset';
  //quote
  static const String getQuotes = '/api/quote';
  static const String enterCode = '/api/user/code';
  static const String addMember = '/api/user/addUser';
}
