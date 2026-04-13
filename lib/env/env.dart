import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'CLOUD_API_KEY', obfuscate: true)
  static final String cloudApiKey = _Env.cloudApiKey;
}
