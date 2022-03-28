import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ------ Provider listener

class ProviderListener<Notifier extends ChangeNotifier> extends StatefulWidget {
  const ProviderListener({Key? key, required this.listener, required this.child}) : super(key: key);

  final Widget child;
  final void Function(BuildContext context, Notifier provider) listener;

  @override
  _ProviderListenerState createState() => _ProviderListenerState<Notifier>();
}

class _ProviderListenerState<Notifier extends ChangeNotifier> extends State<ProviderListener<Notifier>> {
  late Notifier _notifier;

  @override
  void initState() {
    _notifier = context.read<Notifier>();
    _notifier.addListener(_listenerCallback);
    super.initState();
  }

  @override
  void dispose() {
    _notifier.removeListener(_listenerCallback);
    super.dispose();
  }

  void _listenerCallback() {
    widget.listener(context, _notifier);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

// ------ Consumer listener
// Consumer listener = Consumer + Provider listener

class ConsumerListener<Notifier extends ChangeNotifier> extends StatelessWidget {
  const ConsumerListener({Key? key, required this.listener, required this.builder}) : super(key: key);

  final void Function(BuildContext context, Notifier provider) listener;
  final Widget Function(BuildContext context, Notifier provider) builder;

  @override
  Widget build(BuildContext context) {
    return ProviderListener(
      listener: listener,
      child: Consumer<Notifier>(
        builder: (context, provider, _) => builder(context, provider),
      ),
    );
  }
}
