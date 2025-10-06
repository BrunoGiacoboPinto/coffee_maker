# Environment Configuration

Type-safe environment configuration using envied.

## Available Configuration Variables

### Public (non-obfuscated):
- `API_BASE_URL`: Base URL for API endpoints
- `CONNECT_TIMEOUT`: Connection timeout in seconds
- `RECEIVE_TIMEOUT`: Receive timeout in seconds
- `PROBE_TIMEOUT`: Internet connectivity probe timeout in seconds
- `PROBE_ENDPOINT`: URL for connectivity checks

### Sensitive (obfuscated):
- `API_KEY`: API authentication key

## Usage

```dart
import 'package:environment_new/environment_new.dart';

final baseUrl = Environment.apiBaseUrl;
final timeout = Duration(seconds: Environment.connectTimeout);
```

## Code Generation

After modifying environment.dart, run:

```bash
cd packages/environment_new
dart pub get
dart pub run build_runner build --delete-conflicting-outputs
```