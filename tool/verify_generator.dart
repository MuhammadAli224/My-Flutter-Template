import 'dart:io';

/// Exercises both Mason variants in a disposable copy of the application.
Future<void> main() async {
  final root = Directory.current;
  await _run('mason', ['get'], root.path);
  final temp = await Directory.systemTemp.createTemp(
    'flutter_feature_verification_',
  );
  try {
    for (final name in [
      'pubspec.yaml',
      'pubspec.lock',
      'analysis_options.yaml',
    ]) {
      File('${root.path}/$name').copySync('${temp.path}/$name');
    }
    for (final name in ['lib', 'assets']) {
      _copy(Directory('${root.path}/$name'), Directory('${temp.path}/$name'));
    }
    // Satisfy the declared asset without copying developer credentials.
    File('${temp.path}/.env').writeAsStringSync('');
    await _run('flutter', ['pub', 'get', '--offline'], temp.path);
    // Reuse the disposable build cache so the second variant is incremental.
    for (final cached in [false, true]) {
      await _run('mason', [
        'make',
        'feature',
        '--name',
        'architecture_probe',
        '--with_cache',
        '$cached',
        '--on-conflict',
        'overwrite',
        '-o',
        temp.path,
      ], root.path);
      await _run('dart', ['run', 'build_runner', 'build'], temp.path);
      await _run('dart', [
        'format',
        'lib/feature/architecture_probe',
      ], temp.path);
      await _run('flutter', [
        'analyze',
        '--no-pub',
        'lib/feature/architecture_probe',
      ], temp.path);
      stdout.writeln('Verified generated feature (with_cache=$cached).');
    }
  } finally {
    if (Platform.environment['KEEP_GENERATOR_FIXTURE'] == '1') {
      stdout.writeln('Preserved fixtures: ${temp.path}');
    } else {
      await temp.delete(recursive: true);
    }
  }
}

void _copy(Directory source, Directory target) {
  target.createSync(recursive: true);
  for (final entity in source.listSync()) {
    final name = entity.uri.pathSegments.where((part) => part.isNotEmpty).last;
    if (entity is File) {
      entity.copySync('${target.path}/$name');
    } else if (entity is Directory) {
      _copy(entity, Directory('${target.path}/$name'));
    }
  }
}

Future<void> _run(
  String executable,
  List<String> arguments,
  String directory,
) async {
  stdout.writeln('> $executable ${arguments.join(' ')}');
  final process = await Process.start(
    executable,
    arguments,
    workingDirectory: directory,
    mode: ProcessStartMode.inheritStdio,
  );
  final code = await process.exitCode;
  if (code != 0) {
    throw ProcessException(executable, arguments, 'Verification failed', code);
  }
}
