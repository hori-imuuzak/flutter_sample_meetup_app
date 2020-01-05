import 'package:meta/meta.dart';

class CurrentUser {
  final String id;
  final String name;
  final String photoUrl;
  final bool isAnonymous;
  final DateTime createAt;
  final DateTime updateAt;

  CurrentUser(
      {@required this.id,
      @required this.name,
      @required this.photoUrl,
      @required this.isAnonymous,
      @required this.createAt,
      @required this.updateAt})
      : assert(id != null),
        assert(name != null),
        assert(photoUrl != null),
        assert(isAnonymous != null),
        assert(createAt != null),
        assert(updateAt != null);
}
