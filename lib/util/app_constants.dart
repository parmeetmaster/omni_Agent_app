import 'package:six_cash/data/model/response/language_model.dart';

import 'images.dart';

class AppConstants {
  static const String APP_NAME = 'OMNI Kredi Ajan';
  static const String BASE_URL = 'https://ok.omninovas.com';
  static const bool DEMO = false;

  static const String WEB_SITE_LINK_IMAGE_URI = '$BASE_URL/storage/app/public/website/';
  static const String AGENT_PHONE_CHECK_URI = '/api/v1/agent/auth/check-phone';
  static const String AGENT_PHONE_RESEND_OTP_URI = '/api/v1/agent/auth/resend-otp';
  static const String AGENT_PHONE_VERIFY_URI = '/api/v1/agent/auth/verify-phone';
  static const String CUSTOMER_REGISTRATION_URI = '/api/v1/customer/auth/register';
  static const String AGENT_UPDATE_PROFILE = '/api/v1/agent/update-profile';
  static const String AGENT_LOGIN_URI = '/api/v1/agent/auth/login';
  static const String AGENT_LOGOUT_URI = '/api/v1/agent/logout';
  static const String AGENT_FORGET_PASS_OTP_URI = '/api/v1/agent/auth/forgot-password';
  static const String AGENT_FORGET_PASS_VERIFICATION = '/api/v1/agent/auth/verify-token';
  static const String AGENT_FORGET_PASS_RESET = '/api/v1/agent/auth/reset-password';
  static const String AGENT_LINKED_WEBSITE= '/api/v1/agent/linked-website';
  static const String AGENT_BANNER= '/api/v1/agent/get-banner';
  static const String AGENT_TRANSACTION_HISTORY= '/api/v1/agent/transaction-history';
  // static const String AGENT_PURPOSE_URL = '/api/v1/agent/get-purpose';
  static const String CONFIG_URI = '/api/v1/config';
  static const String IMAGE_CONFIG_URL_API_NEED = '/storage/app/public/purpose/';
  static const String AGENT_PROFILE_DATA = '/api/v1/agent/get-agent';
  static const String AGENT_CHECK_OTP = '/api/v1/agent/check-otp';
  static const String AGENT_VERIFY_OTP = '/api/v1/agent/verify-otp';
  static const String AGENT_CHANGE_PIN = '/api/v1/agent/change-pin';
  static const String AGENT_UPDATE_TWO_FACTOR = '/api/v1/agent/update-two-factor';
  // static const String AGENT_SEND_MONEY = '/api/v1/agent/send-money';
  static const String AGENT_REQUEST_MONEY = '/api/v1/agent/request-money';
  static const String AGENT_CASH_OUT = '/api/v1/agent/cash-out';
  static const String AGENT_CASH_IN = '/api/v1/agent/send-money';
  static const String AGENT_PIN_VERIFY = '/api/v1/agent/verify-pin';
  static const String AGENT_ADD_MONEY = '/api/v1/agent/add-money';
  static const String FAQ_URI = '/api/v1/faq';
  static const String NOTIFICATION_URI = '/api/v1/agent/get-notification';
  static const String TRANSACTION_HISTORY_URI = '/api/v1/agent/transaction-history';
  static const String REQUESTED_MONEY_URI = '/api/v1/agent/get-requested-money';
  static const String ACCEPTED_REQUESTED_MONEY_URI = '/api/v1/agent/request-money/approve';
  static const String DENIED_REQUESTED_MONEY_URI = '/api/v1/agent/request-money/deny';
  static const String TOKEN_URI = '/api/v1/agent/update-fcm-token';
  static const String CHECK_CUSTOMER_URI = '/api/v1/check-customer';
  static const String CHECK_AGENT_URI = '/api/v1/check-agent';

  // Shared Key
  static const String THEME = 'theme';
  static const String TOKEN = 'token';
  static const String AGENT_COUNTRY_CODE = 'agent_country_code';//not in project
  static const String LANGUAGE_CODE = 'language_code';
  static const String CART_LIST = 'cart_list';
  static const String USER_PASSWORD = 'user_password';
  static const String USER_ADDRESS = 'user_address';
  static const String USER_NUMBER = 'user_number';
  static const String SEARCH_ADDRESS = 'search_address';
  static const String TOPIC = 'notify';
  static const String CONFIG = 'config';
  static const String AGENT_NAME = 'agent_name';
  static const String COUNTRY_CODE = 'country_code';
  static const String AGENT_NUMBER = 'agent_number';
  static const String AGENT_QR_CODE = 'agent_qr_code';
  static const String SEND_MONEY_SUGGEST_LIST = 'send_money_suggest';
  static const String REQUEST_MONEY_SUGGEST_LIST = 'request_money_suggest';
  static const String RECENT_AGENT_LIST = 'recent_agent_list';
  static const String PENDING = 'pending';
  static const String APPROVED = 'approved';
  static const String DENIED = 'denied';

  static const String CASH_IN = 'cash_in';
  static const String CASH_OUT = 'cash_out';
  static const String SEND_MONEY = 'send_money';
  static const String RECEIVED_MONEY = 'received_money';
  static const String ADMIN_CHARGE = 'admin_charge';
  static const String ADD_MONEY = 'add_money';
  static const String AGENT_COMMISSION = 'agent_commission';

  static const String SHOW_ONBOARD_SCREEN = 'show_onboard_screen';
  
  //topic
  static const String ALL = 'all';
  static const String AGENT = 'agents';

  // App Theme
  static const String THEME_1 = 'theme_1';
  static const String THEME_2 = 'theme_2';
  static const String THEME_3 = 'theme_3';

  static const List<String> inputAmountList =  [ '500', '1,000', '2,000', '5,000', '10,000', '57,0059'];

  static List<LanguageModel> languages = [
    LanguageModel(imageUrl: Images.english, languageName: 'English', countryCode: 'US', languageCode: 'en'),
    LanguageModel(imageUrl: Images.saudi, languageName: 'Ayisyen', countryCode: 'SA', languageCode: 'ar'),
    LanguageModel(imageUrl: Images.spanish, languageName: 'Spanish', countryCode: 'ES', languageCode: 'sp'),
    LanguageModel(imageUrl: Images.french, languageName: 'French', countryCode: 'FR', languageCode: 'fr'),
  ];
}
