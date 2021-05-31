
class User {

  User.fromJson(Map<String, dynamic> map):
    this.login = map['login'],
    this.name = map['nome'],
    this.email = map['email'],
    this.token = map['token'],
    this.roles = map['roles'] != null 
        ? map['roles'].map<String>((role) => role.toString()).toList()
        : null;
  

  String login;
  String name; 
  String email;
  String token;

  List<String> roles;

  @override
  String toString() {
      return 'User(login: $login, name: $name, email: $email, token: $token, reles $roles)';
    }
}