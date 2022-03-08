class RemoteRoot {
  final String host;
  final List<RemoteLab> projects;

  const RemoteRoot(this.host, this.projects);
}

abstract class RemoteLab {}

class RemoteSub implements RemoteLab {
  final String name;
  final List<RemoteLab> sub;

  const RemoteSub(this.name, this.sub);
}

class RemoteLib implements RemoteLab {
  final String name;
  final List<LibBranch> library;

  const RemoteLib(this.name, this.library);
}

class LibBranch {
  final String name;
  final String repo;
  final String branch;

  const LibBranch(this.name, this.repo, this.branch);
}

class FormatYamlException implements Exception {}