import '../utils/yaml_reader.dart';
import 'model.dart';

RemoteRoot rootFromJson(Map<String, dynamic> json) => RemoteRoot(
    json['host'],
    json['projects'].map<RemoteLab>((element) {
      try {
        return subFromJson(formatMap(element.toString()));
      } on FormatException {
        return libsFromJson(formatMap(element.toString()));
      } catch (e) {
        throw FormatYamlException;
      }
    }).toList());

RemoteSub subFromJson(Map<String, dynamic> json) {
  if (json['sub'] == null) throw FormatException();
  return RemoteSub(
      json['name'],
      json['sub'].map<RemoteLab>((element) {
        try {
          return subFromJson(formatMap(element.toString()));
        } on FormatException {
          return libsFromJson(formatMap(element.toString()));
        } catch (e) {
          throw FormatYamlException;
        }
      }).toList());
}

RemoteLib libsFromJson(Map<String, dynamic> json) => RemoteLib(
    json['name'],
    json['library']
        .map<LibBranch>((element) => libFromJson(formatMap(element.toString())))
        .toList());

LibBranch libFromJson(Map<String, dynamic> json) =>
    LibBranch(json['name'], json['repo'], json['branch']);
