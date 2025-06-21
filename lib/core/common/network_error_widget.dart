import 'package:flutter/material.dart';

class NetworkErrorWidget extends StatefulWidget {
  final String errorMsg;
  final bool large;
  final Future<void> Function()? onTap;

  const NetworkErrorWidget({
    super.key,
    required this.errorMsg,
    this.onTap,
    required this.large,
  });

  @override
  State<NetworkErrorWidget> createState() => _NetworkErrorWidgetState();
}

class _NetworkErrorWidgetState extends State<NetworkErrorWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.wifi_off_rounded,
            size: widget.large ? 80 : 40,
            color: Colors.grey,
          ),
          const SizedBox(height: 16),
          Text(
            "Network Error",
            style: widget.large
                ? Theme.of(context).textTheme.titleLarge
                : Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            widget.errorMsg,
            textAlign: TextAlign.center,
            style: widget.large
                ? Theme.of(context).textTheme.bodyMedium
                : Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () async {
              if (widget.onTap != null) {
                await widget.onTap!();
              }
            },
            icon: const Icon(Icons.refresh),
            label: Text(
              "Try Again",
              style: widget.large
                  ? Theme.of(context).textTheme.bodyMedium
                  : Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}
