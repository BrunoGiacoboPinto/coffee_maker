# Network Package

Network connectivity and HTTP client utilities for the Coffee Maker app.

## Features

- **ConnectivityCubit**: Monitors network connectivity status (online, offline, no network)
- **InternetProber**: Checks actual internet connectivity by probing endpoints
- **HttpClientProvider**: Provides HTTP client instances for network requests

## Usage

```dart
import 'package:network/network.dart';

// Get connectivity status
final connectivityCubit = getIt<ConnectivityCubit>();
await connectivityCubit.initialize();

// Check internet connectivity
final internetProber = getIt<InternetProber>();
final isOnline = await internetProber.checkOnline();

// Get HTTP client
final httpProvider = getIt<HttpClientProvider>();
final client = httpProvider.createClient();
```

## Dependencies

This package depends on:
- `environment` package for configuration (probe timeout, endpoint)
- Injectable for dependency injection
- Connectivity Plus for network status monitoring
- HTTP for making network requests

## Configuration

The package uses environment variables for configuration:
- `PROBE_TIMEOUT`: Timeout for connectivity checks (default: 3 seconds)
- `PROBE_ENDPOINT`: URL for connectivity checks (default: Google's connectivity check)
