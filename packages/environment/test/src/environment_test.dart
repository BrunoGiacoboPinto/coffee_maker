import 'package:environment/environment.dart';
import 'package:test/test.dart';

void main() {
  group('Environment', () {
    test('should have default values for all configuration variables', () {
      expect(Environment.apiBaseUrl, 'https://coffee.alexflipnote.dev');
      expect(Environment.connectTimeout, 30);
      expect(Environment.receiveTimeout, 30);
      expect(Environment.probeTimeout, 3);
      expect(Environment.probeEndpoint, 'https://www.gstatic.com/generate_204');
    });

    test('should maintain constant types', () {
      expect(Environment.apiBaseUrl, isA<String>());
      expect(Environment.connectTimeout, isA<int>());
      expect(Environment.receiveTimeout, isA<int>());
      expect(Environment.probeTimeout, isA<int>());
      expect(Environment.probeEndpoint, isA<String>());
    });

    test('should have reasonable timeout values', () {
      expect(Environment.connectTimeout, greaterThan(0));
      expect(Environment.receiveTimeout, greaterThan(0));
      expect(Environment.probeTimeout, greaterThan(0));
    });

    test('should have valid URLs', () {
      expect(Environment.apiBaseUrl, startsWith('https://'));
      expect(Environment.probeEndpoint, startsWith('https://'));
    });
  });
}
