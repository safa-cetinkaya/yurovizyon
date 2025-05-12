class Session {
  String sessionPk;
  int userFk;
  Map<String, dynamic> vars;
  DateTime timeUpdated;

  Session({
    required this.sessionPk,
    required this.userFk,
    required this.vars,
    required this.timeUpdated,
  });

  factory Session.fromJson(Map<String, dynamic> json) {
    if (json['vars'] is String) {
      json['vars'] = {};
    }

    return Session(
        sessionPk: json['session_pk'],
        userFk: json['user_fk'],
        vars: json['vars'],
        timeUpdated: DateTime.parse(json['time_updated']));
  }
}
