import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ms200_companion/data/local/app_database.dart';
import 'package:ms200_companion/providers/providers.dart';

class DbDebugScreen extends ConsumerStatefulWidget {
  const DbDebugScreen({super.key});

  @override
  ConsumerState<DbDebugScreen> createState() => _DbDebugScreenState();
}

class _DbDebugScreenState extends ConsumerState<DbDebugScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<SensingDataEntry> _sensingData = [];
  List<FallEventEntry> _fallEvents = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _load();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final db = ref.read(appDatabaseProvider);
      final sensing = await db.getAllSensingData();
      final fall = await db.getAllFallEvents();
      if (mounted) {
        setState(() {  
          _sensingData = sensing;
          _fallEvents = fall;
          _loading = false;
        });
      }
    } catch (e, st) {
      if (mounted) {
        setState(() {
          _error = '$e\n$st';
          _loading = false;
        });
      }
    }
  }

  String _formatTs(int ms) {
    if (ms <= 0) return '-';
    return DateTime.fromMillisecondsSinceEpoch(ms).toLocal().toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DB Debug'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Sensing (${_sensingData.length})'),
            Tab(text: 'Fall Events (${_fallEvents.length})'),
          ],
        ),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(_error!, style: TextStyle(color: Theme.of(context).colorScheme.error)),
                        const SizedBox(height: 16),
                        FilledButton(
                          onPressed: _load,
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  ),
                )
              : TabBarView(
                  controller: _tabController,
                  children: [
                    _SensingList(entries: _sensingData, formatTs: _formatTs),
                    _FallEventList(entries: _fallEvents, formatTs: _formatTs),
                  ],
                ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: _load,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

class _SensingList extends StatelessWidget {
  final List<SensingDataEntry> entries;
  final String Function(int) formatTs;

  const _SensingList({required this.entries, required this.formatTs});

  @override
  Widget build(BuildContext context) {
    if (entries.isEmpty) {
      return const Center(child: Text('No sensing data'));
    }
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: entries.length,
      itemBuilder: (context, i) {
        final e = entries[i];
        final tempC = e.temperature / 10.0;
        final hum = e.humidity / 10.0;
        final hi = e.heatIndex / 10.0;
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('#${e.id} ${formatTs(e.createdAt)}',
                    style: Theme.of(context).textTheme.labelSmall),
                const SizedBox(height: 4),
                Text(
                  'HR: ${e.heartRate} | Temp: ${tempC.toStringAsFixed(1)}°C | Hum: ${hum.toStringAsFixed(1)}% | HI: ${hi.toStringAsFixed(1)}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text('Battery: ${e.batteryLevel}% | Synced: ${e.synced}'),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _FallEventList extends StatelessWidget {
  final List<FallEventEntry> entries;
  final String Function(int) formatTs;

  const _FallEventList({required this.entries, required this.formatTs});

  @override
  Widget build(BuildContext context) {
    if (entries.isEmpty) {
      return const Center(child: Text('No fall events'));
    }
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: entries.length,
      itemBuilder: (context, i) {
        final e = entries[i];
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('#${e.id} ${formatTs(e.createdAt)}',
                    style: Theme.of(context).textTheme.labelSmall),
                const SizedBox(height: 4),
                Text('Source: ${e.source} | Uploaded: ${e.uploaded}'),
                Text('HR: ${e.heartRate} | Temp: ${(e.temperature / 10).toStringAsFixed(1)}°C'),
              ],
            ),
          ),
        );
      },
    );
  }
}
