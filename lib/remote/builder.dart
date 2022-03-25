import 'dart:io' show Directory, Process, Platform;

import '../utils/yaml_reader.dart';
import 'model.dart';
import 'remote_reader.dart';

Future<void> build() async {
  try {
    var packageRoot = Directory.current.path;
    var root = rootFromJson(
        loadYaml('$packageRoot${Platform.pathSeparator}remote.yaml'));
    await Future.forEach<RemoteLab>(root.projects, (node) async {
      await deepSearch(node, packageRoot, root.host);
    });
  } on FormatYamlException {
  } catch (e, stack) {
    print('build -> $stack');
  }
}

Future<void> deepSearch(RemoteLab root, String path, String host) async {
  if (root is RemoteSub) {
    var dir = Directory('$path${Platform.pathSeparator}${root.name}');
    if (!dir.existsSync()) dir.createSync();
    await Future.forEach<RemoteLab>(root.sub, (node) async {
      await deepSearch(node, dir.path, host);
    });
  } else if (root is RemoteLib) {
    var dir = Directory('$path${Platform.pathSeparator}${root.name}');
    if (!dir.existsSync()) dir.createSync();
    Future.forEach<LibBranch>(
        root.library,
        (lib) =>
            pull(lib, '${dir.path}${Platform.pathSeparator}${lib.name}', host));
  }
}

Future<void> pull(LibBranch lib, String target, String host) async {
  var dir = Directory(target);
  print('current directory: $target');
  if (!dir.existsSync()) {
    var result = await Process.run(
        'git', ['clone', '-b', '$target', '$host/${lib.repo}']);
    print('${result.stdout}');
  } else {
    await Future.forEach<Future>([
      Process.run('git', ['fetch'], workingDirectory: target),
      Process.run('git', ['checkout', '${lib.branch}'],
          workingDirectory: target),
      Process.run('git', ['pull'], workingDirectory: target),
    ], (command) async {
      var result = await command;
      print('${result.stdout}');
    });
  }
}
