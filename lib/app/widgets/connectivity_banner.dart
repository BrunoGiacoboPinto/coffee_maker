import 'package:coffee_maker/di/injection.dart';
import 'package:coffee_maker/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:network/network.dart';

final class ConnectivityBanner extends StatelessWidget {
  const ConnectivityBanner({
    required this.child,
    this.noNetworkMessage,
    this.offlineMessage,
    this.retryText,
    super.key,
  });

  final Widget child;
  final String? noNetworkMessage;
  final String? offlineMessage;
  final String? retryText;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ConnectivityCubit, ConnectivityStatus>(
      bloc: getIt<ConnectivityCubit>(),
      listener: (context, status) {
        final messenger = ScaffoldMessenger.of(context);

        switch (status) {
          case ConnectivityStatus.online:
            messenger.clearMaterialBanners();
          case ConnectivityStatus.offline:
          case ConnectivityStatus.noNetwork:
            _showConnectivityBanner(context, status);
        }
      },
      child: child,
    );
  }

  void _showConnectivityBanner(
    BuildContext context,
    ConnectivityStatus status,
  ) {
    final messenger = ScaffoldMessenger.of(context);
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    messenger.clearMaterialBanners();

    final message = status == ConnectivityStatus.noNetwork
        ? (noNetworkMessage ?? l10n.noNetworkMessage)
        : (offlineMessage ?? l10n.offlineMessage);

    messenger.showMaterialBanner(
      MaterialBanner(
        content: Row(
          children: [
            Icon(
              Icons.wifi_off,
              color: theme.colorScheme.onErrorContainer,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  color: theme.colorScheme.onErrorContainer,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: theme.colorScheme.errorContainer,
        actions: [
          TextButton(
            onPressed: () async {
              await getIt<ConnectivityCubit>().checkConnectivity();
            },
            child: Text(
              retryText ?? l10n.retry,
              style: TextStyle(
                color: theme.colorScheme.onErrorContainer,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
