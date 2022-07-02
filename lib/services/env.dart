class Env {
  static const serverSSl = "api.dictionaryapi.dev";
  static const uri = serverSSl;
  static const https = "https://$uri";
  static const baseUrl = https;
  static const headersReq = {"content-type": "application/json"};
  static var headersReqLogIn = {
    // 'Authorization': UserPreferences().getToken().toString(),
    "content-type": "application/json"
  };
}