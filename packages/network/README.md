# Network Package

Network connectivity and HTTP client utilities for the Coffee Maker app.

## Features

- **ConnectivityCubit**: Monitors network connectivity status (online, offline, no network)
- **InternetProber**: Checks actual internet connectivity by probing endpoints using Dio

## Usage

```dart
import 'package:network_new/network_new.dart';

// Get connectivity status
final connectivityCubit = getIt<ConnectivityCubit>();
await connectivityCubit.initialize();

// Check internet connectivity
final internetProber = getIt<InternetProber>();
final isOnline = await internetProber.checkOnline();
```

## Dependencies

This package depends on:
- `environment_new` package for configuration (probe timeout, endpoint)
- Dio for making network requests
- Connectivity Plus for network status monitoring

## Configuration

The package uses environment variables for configuration:
- `PROBE_TIMEOUT`: Timeout for connectivity checks (default: 3 seconds)
- `PROBE_ENDPOINT`: URL for connectivity checks (default: Google's connectivity check)