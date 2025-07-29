enum Environment { dev }

abstract class Info {
  static const Environment _environment = Environment.dev;

  static String get appUrl => _environment._appUrl;
}

extension EnvironmentExtention on Environment {
  static const _appApiUrls = {
    Environment.dev: "https://fakestoreapi.com",
  };

  String get _appUrl => _appApiUrls[this]!;
}