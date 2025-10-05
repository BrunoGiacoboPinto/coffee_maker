// ignore_for_file: cascade_invocations

import 'dart:io';
import 'package:args/args.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as path;

final _logger = Logger('VersionManager');

void main(List<String> arguments) {
  _setupLogging();

  final parser = ArgParser()
    ..addOption('version', abbr: 'v', help: 'New version to set (x.y.z format)')
    ..addFlag(
      'show-all',
      help: 'Show current versions of all packages',
      negatable: false,
    )
    ..addOption(
      'show',
      abbr: 's',
      help:
          'Show version of specific package (app, coffee_photos_repository, environment, network)',
      valueHelp: 'package',
    )
    ..addFlag(
      'help',
      abbr: 'h',
      help: 'Show usage information',
      negatable: false,
    );

  try {
    final results = parser.parse(arguments);

    if (results['help'] as bool) {
      _logger.info(
        'Version Manager - Updates versions across all pubspec.yaml files',
      );
      _logger.info('Usage: dart run version_manager [options]');
      _logger.info(parser.usage);
      return;
    }

    if (results['show-all'] as bool) {
      showCurrentVersions(null);
      return;
    }

    if (results.wasParsed('show')) {
      final showPackage = results['show'] as String?;
      if (showPackage == null || showPackage.isEmpty) {
        _logger.severe('Package name required for --show');
        _logger.info(
          'Available packages: app, coffee_photos_repository, environment, network',
        );
        exit(1);
      }
      showCurrentVersions(showPackage);
      return;
    }

    final version = results['version'] as String?;
    if (version == null) {
      _logger.severe('Version is required');
      _logger.info('Usage: dart run version_manager --version <version>');
      exit(1);
    }

    final versionRegex = RegExp(r'^\d+\.\d+\.\d+$');
    if (!versionRegex.hasMatch(version)) {
      _logger.severe('Invalid version format. Expected: x.y.z');
      exit(1);
    }

    updateVersions(version);
  } catch (e) {
    _logger.severe('Error parsing arguments: $e');
    _logger.info('Usage: dart run version_manager --version <version>');
    exit(1);
  }
}

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    final emoji = switch (record.level) {
      Level.INFO => '🚀',
      Level.WARNING => '⚠️',
      Level.SEVERE => '❌',
      _ => '✅',
    };

    if (record.level == Level.INFO || record.level >= Level.WARNING) {
      print('$emoji ${record.message}');
    }
  });
}

void updateVersions(String newVersion) {
  _logger.info('Updating versions to $newVersion...');

  // When running from project root, use current directory
  // When running from tools/version_manager, go up 2 levels
  final currentDir = Directory.current.path;
  final projectRoot = currentDir.contains('tools/version_manager')
      ? path.dirname(path.dirname(currentDir))
      : currentDir;

  final pubspecFiles = [
    path.join(projectRoot, 'pubspec.yaml'),
    path.join(
      projectRoot,
      'packages',
      'coffee_photos_repository',
      'pubspec.yaml',
    ),
    path.join(projectRoot, 'packages', 'environment', 'pubspec.yaml'),
    path.join(projectRoot, 'packages', 'network', 'pubspec.yaml'),
  ];

  for (final filePath in pubspecFiles) {
    if (File(filePath).existsSync()) {
      updatePubspecVersion(filePath, newVersion);
    } else {
      _logger.warning('File not found: $filePath');
    }
  }

  _logger.info('Version update completed!');
}

void showCurrentVersions([String? targetPackage]) {
  // When running from project root, use current directory
  // When running from tools/version_manager, go up 2 levels
  final currentDir = Directory.current.path;
  final projectRoot = currentDir.contains('tools/version_manager')
      ? path.dirname(path.dirname(currentDir))
      : currentDir;

  final packageMap = {
    'app': ('Main App', path.join(projectRoot, 'pubspec.yaml')),
    'coffee_photos_repository': (
      'Coffee Photos Repository',
      path.join(
        projectRoot,
        'packages',
        'coffee_photos_repository',
        'pubspec.yaml',
      ),
    ),
    'environment': (
      'Environment',
      path.join(projectRoot, 'packages', 'environment', 'pubspec.yaml'),
    ),
    'network': (
      'Network',
      path.join(projectRoot, 'packages', 'network', 'pubspec.yaml'),
    ),
  };

  if (targetPackage != null) {
    // Show specific package version (raw output for CI)
    final packageInfo = packageMap[targetPackage.toLowerCase()];
    if (packageInfo == null) {
      _logger.severe('Unknown package: $targetPackage');
      _logger.info('Available packages: ${packageMap.keys.join(', ')}');
      exit(1);
    }

    final (_, filePath) = packageInfo;
    if (File(filePath).existsSync()) {
      final version = _getCurrentVersion(filePath);
      if (version != null) {
        // Raw output without formatting for CI/scripts
        print(version);
      } else {
        _logger.severe('Version not found in ${path.relative(filePath)}');
        exit(1);
      }
    } else {
      _logger.severe('File not found at ${path.relative(filePath)}');
      exit(1);
    }
    return;
  }

  // Show all versions with formatting
  _logger.info('Current versions:');
  for (final (packageName, filePath) in packageMap.values) {
    if (File(filePath).existsSync()) {
      final version = _getCurrentVersion(filePath);
      if (version != null) {
        _logger.info('$packageName: $version');
      } else {
        _logger.warning(
          '$packageName: Version not found in ${path.relative(filePath)}',
        );
      }
    } else {
      _logger.warning(
        '$packageName: File not found at ${path.relative(filePath)}',
      );
    }
  }
}

String? _getCurrentVersion(String filePath) {
  try {
    final file = File(filePath);
    final content = file.readAsStringSync();

    final versionMatch = RegExp(
      r'^version:\s+(.+)$',
      multiLine: true,
    ).firstMatch(content);

    return versionMatch?.group(1)?.trim();
  } catch (error) {
    _logger.severe('Failed to read version from $filePath: $error');
    return null;
  }
}

void updatePubspecVersion(String filePath, String version) {
  try {
    final file = File(filePath);
    final content = file.readAsStringSync();

    final versionMatch = RegExp(
      r'^version:\s+(\d+\.\d+\.\d+)(\+\d+)?$',
      multiLine: true,
    ).firstMatch(content);

    var buildNumber = '+1';

    if (versionMatch != null && versionMatch.group(2) != null) {
      final currentBuild = int.parse(versionMatch.group(2)!.substring(1));
      buildNumber = '+${currentBuild + 1}';
    }

    final updatedContent = content.replaceFirst(
      RegExp(r'^version:\s+.*$', multiLine: true),
      'version: $version$buildNumber',
    );

    file.writeAsStringSync(updatedContent);
    _logger.info(
      'Updated ${path.relative(filePath)} to version $version$buildNumber',
    );
  } catch (error) {
    _logger.severe('Failed to update $filePath: $error');
    exit(1);
  }
}
