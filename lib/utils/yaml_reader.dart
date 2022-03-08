import 'dart:io';

import 'package:yaml/yaml.dart' as yaml;

Map<String, dynamic> loadYaml(String path) {
  File yamlFile = File(path);
  final data = yamlFile.readAsStringSync();
  return formatMap(data);
}

Map<String, dynamic> formatMap(String data) {
  yaml.YamlMap yamlText = yaml.loadYaml(data);
  return Map<String, dynamic>.from(yamlText.value);
}
