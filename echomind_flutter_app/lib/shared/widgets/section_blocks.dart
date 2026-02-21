import 'package:flutter/material.dart';

import '../../features/specs/page_spec.dart';

class SectionCard extends StatelessWidget {
  const SectionCard({
    super.key,
    required this.section,
    required this.onNavigate,
  });

  final SectionSpec section;
  final void Function(String route) onNavigate;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(section.title, style: theme.textTheme.titleMedium),
            if (section.subtitle != null) ...<Widget>[
              const SizedBox(height: 4),
              Text(section.subtitle!, style: theme.textTheme.bodySmall),
            ],
            const SizedBox(height: 10),
            _buildBody(context),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    switch (section.type) {
      case SectionType.dashboard:
        return _DashboardBody(section: section, onNavigate: onNavigate);
      case SectionType.list:
        return _ListBody(section: section, onNavigate: onNavigate);
      case SectionType.tags:
        return _TagsBody(section: section, onNavigate: onNavigate);
      case SectionType.tree:
        return _TreeBody(section: section, onNavigate: onNavigate);
      case SectionType.heatmap:
        return _HeatmapBody(section: section, onNavigate: onNavigate);
      case SectionType.timeline:
        return _TimelineBody(section: section);
      case SectionType.table:
        return _TableBody(section: section, onNavigate: onNavigate);
      case SectionType.chat:
        return _ChatBody(section: section, onNavigate: onNavigate);
      case SectionType.flashcard:
        return _FlashcardBody(section: section);
      case SectionType.placeholder:
        return const Text('该模块正在开发中。');
    }
  }
}

class _DashboardBody extends StatelessWidget {
  const _DashboardBody({required this.section, required this.onNavigate});

  final SectionSpec section;
  final void Function(String route) onNavigate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: section.items
              .map(
                (item) => Container(
                  constraints: const BoxConstraints(minWidth: 120),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F7FF),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFFD8E6FF)),
                  ),
                  child: Text(item),
                ),
              )
              .toList(growable: false),
        ),
        if (section.primaryRoute != null ||
            section.secondaryRoute != null) ...<Widget>[
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              if (section.primaryRoute != null)
                FilledButton(
                  onPressed: () => onNavigate(section.primaryRoute!),
                  child: const Text('进入主流程'),
                ),
              if (section.secondaryRoute != null)
                OutlinedButton(
                  onPressed: () => onNavigate(section.secondaryRoute!),
                  child: const Text('查看详情'),
                ),
            ],
          ),
        ],
      ],
    );
  }
}

class _ListBody extends StatelessWidget {
  const _ListBody({required this.section, required this.onNavigate});

  final SectionSpec section;
  final void Function(String route) onNavigate;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: section.items
          .asMap()
          .entries
          .map(
            (entry) => InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: section.primaryRoute == null
                  ? null
                  : () => onNavigate(
                      // In profile menu keep distinct target by row.
                      section.id == 'three-row-navigation' && entry.key == 1
                          ? '/weekly-review'
                          : section.id == 'three-row-navigation' &&
                                entry.key == 2
                          ? '/register-strategy'
                          : section.primaryRoute!,
                    ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: <Widget>[
                    Expanded(child: Text(entry.value)),
                    const Icon(
                      Icons.chevron_right_rounded,
                      color: Color(0xFF9CA3AF),
                    ),
                  ],
                ),
              ),
            ),
          )
          .toList(growable: false),
    );
  }
}

class _TagsBody extends StatelessWidget {
  const _TagsBody({required this.section, required this.onNavigate});

  final SectionSpec section;
  final void Function(String route) onNavigate;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: section.tags
          .map(
            (tag) => ActionChip(
              label: Text(tag),
              onPressed: section.primaryRoute == null
                  ? null
                  : () => onNavigate(section.primaryRoute!),
            ),
          )
          .toList(growable: false),
    );
  }
}

class _TreeBody extends StatelessWidget {
  const _TreeBody({required this.section, required this.onNavigate});

  final SectionSpec section;
  final void Function(String route) onNavigate;

  @override
  Widget build(BuildContext context) {
    final tree = <String, List<String>>{};
    for (final item in section.items) {
      final parts = item.split(' > ');
      if (parts.length < 2) {
        tree.putIfAbsent('其他', () => <String>[]).add(item);
      } else {
        final parent = parts.first;
        tree
            .putIfAbsent(parent, () => <String>[])
            .add(parts.skip(1).join(' > '));
      }
    }

    return Column(
      children: tree.entries
          .map(
            (entry) => ExpansionTile(
              title: Text(entry.key),
              tilePadding: EdgeInsets.zero,
              childrenPadding: EdgeInsets.zero,
              children: entry.value
                  .map(
                    (node) => ListTile(
                      dense: true,
                      contentPadding: const EdgeInsets.only(left: 12, right: 0),
                      title: Text(node, style: const TextStyle(fontSize: 13.5)),
                      trailing: const Icon(
                        Icons.chevron_right_rounded,
                        size: 20,
                      ),
                      onTap: section.primaryRoute == null
                          ? null
                          : () => onNavigate(section.primaryRoute!),
                    ),
                  )
                  .toList(growable: false),
            ),
          )
          .toList(growable: false),
    );
  }
}

class _HeatmapBody extends StatelessWidget {
  const _HeatmapBody({required this.section, required this.onNavigate});

  final SectionSpec section;
  final void Function(String route) onNavigate;

  Color _colorOf(String token) {
    switch (token) {
      case '优':
        return const Color(0xFFDCFCE7);
      case '稳':
        return const Color(0xFFDBEAFE);
      case '警':
        return const Color(0xFFFEF3C7);
      case '险':
        return const Color(0xFFFEE2E2);
      default:
        return const Color(0xFFE5E7EB);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        for (final row in section.matrix)
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              children: row
                  .map(
                    (cell) => Expanded(
                      child: GestureDetector(
                        onTap: section.primaryRoute == null
                            ? null
                            : () => onNavigate(section.primaryRoute!),
                        child: Container(
                          height: 34,
                          margin: const EdgeInsets.only(right: 6),
                          decoration: BoxDecoration(
                            color: _colorOf(cell),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: const Color(0xFFE5E7EB)),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            cell,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(growable: false),
            ),
          ),
      ],
    );
  }
}

class _TimelineBody extends StatelessWidget {
  const _TimelineBody({required this.section});

  final SectionSpec section;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: section.items
          .map(
            (it) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                children: <Widget>[
                  const Icon(
                    Icons.fiber_manual_record,
                    size: 10,
                    color: Color(0xFF1677FF),
                  ),
                  const SizedBox(width: 8),
                  Expanded(child: Text(it)),
                ],
              ),
            ),
          )
          .toList(growable: false),
    );
  }
}

class _TableBody extends StatelessWidget {
  const _TableBody({required this.section, required this.onNavigate});

  final SectionSpec section;
  final void Function(String route) onNavigate;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        headingRowHeight: 38,
        dataRowMinHeight: 36,
        dataRowMaxHeight: 56,
        columns: section.tableHeaders
            .map(
              (h) => DataColumn(
                label: Text(
                  h,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            )
            .toList(growable: false),
        rows: section.tableRows
            .map(
              (row) => DataRow(
                cells: row
                    .map((cell) => DataCell(Text(cell)))
                    .toList(growable: false),
                onSelectChanged: section.primaryRoute == null
                    ? null
                    : (_) => onNavigate(section.primaryRoute!),
              ),
            )
            .toList(growable: false),
      ),
    );
  }
}

class _ChatBody extends StatelessWidget {
  const _ChatBody({required this.section, required this.onNavigate});

  final SectionSpec section;
  final void Function(String route) onNavigate;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        for (var i = 0; i < section.items.length; i++)
          Align(
            alignment: i.isEven ? Alignment.centerLeft : Alignment.centerRight,
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: i.isEven
                    ? const Color(0xFFEFF3F8)
                    : const Color(0xFF1677FF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                section.items[i],
                style: TextStyle(
                  color: i.isEven ? const Color(0xFF111827) : Colors.white,
                ),
              ),
            ),
          ),
        if (section.primaryRoute != null || section.secondaryRoute != null)
          Wrap(
            spacing: 8,
            children: <Widget>[
              if (section.primaryRoute != null)
                FilledButton(
                  onPressed: () => onNavigate(section.primaryRoute!),
                  child: const Text('进入下一步'),
                ),
              if (section.secondaryRoute != null)
                OutlinedButton(
                  onPressed: () => onNavigate(section.secondaryRoute!),
                  child: const Text('返回'),
                ),
            ],
          ),
      ],
    );
  }
}

class _FlashcardBody extends StatefulWidget {
  const _FlashcardBody({required this.section});

  final SectionSpec section;

  @override
  State<_FlashcardBody> createState() => _FlashcardBodyState();
}

class _FlashcardBodyState extends State<_FlashcardBody> {
  var _flipped = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () => setState(() => _flipped = !_flipped),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: _flipped
                  ? const Color(0xFFECFDF5)
                  : const Color(0xFFEEF2FF),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFD1D5DB)),
            ),
            child: Text(
              _flipped ? widget.section.items.last : widget.section.items.first,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          children: <Widget>[
            OutlinedButton(onPressed: () {}, child: const Text('忘了')),
            FilledButton(onPressed: () {}, child: const Text('记得')),
            OutlinedButton(onPressed: () {}, child: const Text('简单')),
          ],
        ),
      ],
    );
  }
}
