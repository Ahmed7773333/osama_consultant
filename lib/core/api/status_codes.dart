class HttpStatusCodes {
  // Informational responses
  static const int continue_ = 100;
  static const int switchingProtocols = 101;
  static const int processing = 102;

  // Successful responses
  static const int ok = 200;
  static const int created = 201;
  static const int accepted = 202;
  static const int nonAuthoritativeInformation = 203;
  static const int noContent = 204;
  static const int resetContent = 205;
  static const int partialContent = 206;

  // Redirection messages
  static const int multipleChoices = 300;
  static const int movedPermanently = 301;
  static const int found = 302;
  static const int seeOther = 303;
  static const int notModified = 304;
  static const int useProxy = 305;
  static const int temporaryRedirect = 307;
  static const int permanentRedirect = 308;

  // Client error responses
  static const int badRequest = 400;
  static const int unauthorized = 401;
  static const int paymentRequired = 402;
  static const int forbidden = 403;
  static const int notFound = 404;
  static const int methodNotAllowed = 405;
  static const int notAcceptable = 406;
  static const int proxyAuthenticationRequired = 407;
  static const int requestTimeout = 408;
  static const int conflict = 409;
  static const int gone = 410;

  // Server error responses
  static const int internalServerError = 500;
  static const int notImplemented = 501;
  static const int badGateway = 502;
  static const int serviceUnavailable = 503;
  static const int gatewayTimeout = 504;
  static const int httpVersionNotSupported = 505;

  // Method to interpret status codes
  static String getStatusMessage(int statusCode) {
    switch (statusCode) {
      case ok:
        return 'Success';
      case created:
        return 'Resource created';
      case accepted:
        return 'Request accepted';
      case noContent:
        return 'No content';
      case badRequest:
        return 'Bad request';
      case unauthorized:
        return 'Unauthorized';
      case forbidden:
        return 'Forbidden';
      case notFound:
        return 'Not found';
      case internalServerError:
        return 'Internal server error';
      case serviceUnavailable:
        return 'Service unavailable';
      default:
        return 'Unknown status code';
    }
  }
}
