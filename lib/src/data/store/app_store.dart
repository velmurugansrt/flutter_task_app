class AppStore {
  static final AppStore _appStore = AppStore._();
  factory AppStore() => _appStore;
  AppStore._() {}
  bool _networkStatus = false;
  String _sessionCookie;

  String getSessionCookie() {
    return _sessionCookie;
  }

  void setCookie(String cookie) {
    _sessionCookie = cookie;
  }

  void setNetworkStatus(bool status) {
    _networkStatus = status;
  }

  bool getNetworkStatus() {
    return _networkStatus;
  }
}
