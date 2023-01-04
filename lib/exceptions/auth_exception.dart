class AuthException implements Exception {
  static const Map<String, String> errors = {
    'EMAIL_EXISTS' : 'Email já existe.',
    'OPERATION_NOT_ALLOWED' : 'Não foi permitida a operação.',
    'TOO_MANY_ATTEMPTS_TRY_LATER' : 'Acesso bloqueado temporariamente. Tente mais tarde',
    'EMAIL_NOT_FOUND' : 'Email não foi encontrado.',
    'INVALID_PASSWORD' : 'Password inválida',
    'USER_DISABLED' : 'A conta foi desabilitada',
  };
  final String key;

  AuthException(this.key);

  @override
  String toString() {
    return errors[key] ?? 'Aconteceu um erro durante a autenticação.';
  }
}