import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_text_styles.dart';

// ---------------------------------------------------------------------------
// Workspace Detail Screen
// ---------------------------------------------------------------------------

class WorkspaceDetailScreen extends StatefulWidget {
  const WorkspaceDetailScreen({super.key});

  @override
  State<WorkspaceDetailScreen> createState() => _WorkspaceDetailScreenState();
}

class _WorkspaceDetailScreenState extends State<WorkspaceDetailScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPalette.background,
      appBar: _WorkspaceDetailAppBar(title: 'Workspace: NextDev'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md, vertical: AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            // Repository URL row
            _RepoUrlRow(url: 'github.com/devhub-org'),
            SizedBox(height: AppSpacing.lg),

            // Overview card
            _OverviewCard(
              progress: 0.65,
              teamCount: 12,
              taskCount: 45,
              openPRCount: 12,
              developerCount: 8,
              milestoneName: 'MVP Release',
              milestoneDue: 'Aug 15, 2026',
            ),
            SizedBox(height: AppSpacing.lg),

            // Teams section (grid layout)
            _SectionHeader(title: 'Teams', actionLabel: 'View All'),
            SizedBox(height: AppSpacing.sm),
            _TeamsGrid(
              teams: [
                _TeamData(
                  acronym: 'FE',
                  name: 'Frontend',
                  memberCount: 8,
                  completedTasks: 16,
                  totalTasks: 20,
                  color: Color(0xFF3525CD),
                ),
                _TeamData(
                  acronym: 'BE',
                  name: 'Backend',
                  memberCount: 8,
                  completedTasks: 6,
                  totalTasks: 15,
                  color: Color(0xFF892200),
                ),
                _TeamData(
                  acronym: 'DS',
                  name: 'Design',
                  memberCount: 4,
                  completedTasks: 9,
                  totalTasks: 12,
                  color: Color(0xFF10B981),
                ),
                _TeamData(
                  acronym: 'QA',
                  name: 'QA',
                  memberCount: 3,
                  completedTasks: 5,
                  totalTasks: 8,
                  color: Color(0xFFF59E0B),
                ),
              ],
            ),
            SizedBox(height: AppSpacing.lg),

            // Quick Actions section
            _SectionHeader(title: 'Quick Actions'),
            SizedBox(height: AppSpacing.sm),
            _QuickActionsGrid(),
            SizedBox(height: AppSpacing.md),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Page-level AppBar
// ---------------------------------------------------------------------------

class _WorkspaceDetailAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  const _WorkspaceDetailAppBar({required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppPalette.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: AppPalette.black),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text(
        title,
        style: AppTextStyles.title.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: AppPalette.headingTextColor,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.more_vert, color: AppPalette.black),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

// ---------------------------------------------------------------------------
// Repository URL Row
// ---------------------------------------------------------------------------

class _RepoUrlRow extends StatelessWidget {
  final String url;
  const _RepoUrlRow({required this.url});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.link, size: 16, color: AppPalette.mutedTextColor),
        const SizedBox(width: 6),
        Text(
          url,
          style: AppTextStyles.caption.copyWith(
            color: AppPalette.surfaceTint,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Section Header
// ---------------------------------------------------------------------------

class _SectionHeader extends StatelessWidget {
  final String title;
  final String? actionLabel;

  const _SectionHeader({required this.title, this.actionLabel});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTextStyles.title.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppPalette.headingTextColor,
          ),
        ),
        if (actionLabel != null)
          GestureDetector(
            onTap: () {},
            child: Text(
              actionLabel!,
              style: AppTextStyles.caption.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppPalette.surfaceTint,
              ),
            ),
          ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Overview Card
// ---------------------------------------------------------------------------

class _OverviewCard extends StatelessWidget {
  final double progress;
  final int teamCount;
  final int taskCount;
  final int openPRCount;
  final int developerCount;
  final String milestoneName;
  final String milestoneDue;

  const _OverviewCard({
    required this.progress,
    required this.teamCount,
    required this.taskCount,
    required this.openPRCount,
    required this.developerCount,
    required this.milestoneName,
    required this.milestoneDue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppPalette.white,
        borderRadius: AppRadius.primaryBorderRadius,
        border: Border.all(color: AppPalette.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(8), // 0.03 * 255 approx 8
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(AppSpacing.paddingCard),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Overview',
            style: AppTextStyles.title.copyWith(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppPalette.headingTextColor,
            ),
          ),
          const SizedBox(height: AppSpacing.md),

          // Overall progress row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Overall Progress',
                style: AppTextStyles.bodyMedium.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppPalette.mutedTextColor,
                ),
              ),
              Text(
                '${(progress * 100).toInt()}%',
                style: AppTextStyles.bodyMedium.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppPalette.surfaceTint,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),

          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 7,
              backgroundColor: AppPalette.outlineVariant,
              valueColor:
                  const AlwaysStoppedAnimation<Color>(AppPalette.surfaceTint),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),

          // Stats row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _StatItem(value: '$teamCount', label: 'TEAMS'),
              _StatItem(value: '$taskCount', label: 'TASKS'),
              _StatItem(value: '$openPRCount', label: 'OPEN PRS'),
              _StatItem(value: '$developerCount', label: 'DEVELOPERS'),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          const Divider(color: AppPalette.border, height: 1),
          const SizedBox(height: AppSpacing.md),

          // Active Milestone
          Text(
            'ACTIVE MILESTONE',
            style: AppTextStyles.overline.copyWith(
              color: AppPalette.mutedTextColor,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(Icons.flag_outlined,
                  size: 16, color: AppPalette.surfaceTint),
              const SizedBox(width: 6),
              Text(
                milestoneName,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppPalette.headingTextColor,
                  fontSize: 13,
                ),
              ),
              const Spacer(),
              Text(
                'Due: $milestoneDue',
                style: AppTextStyles.caption.copyWith(
                  color: AppPalette.mutedTextColor,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Stat Item — used inside Overview card
// ---------------------------------------------------------------------------

class _StatItem extends StatelessWidget {
  final String value;
  final String label;

  const _StatItem({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          value,
          style: AppTextStyles.title.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppPalette.headingTextColor,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: AppTextStyles.overline.copyWith(
            color: AppPalette.mutedTextColor,
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Team Data model
// ---------------------------------------------------------------------------

class _TeamData {
  final String acronym;
  final String name;
  final int memberCount;
  final int completedTasks;
  final int totalTasks;
  final Color color;

  const _TeamData({
    required this.acronym,
    required this.name,
    required this.memberCount,
    required this.completedTasks,
    required this.totalTasks,
    required this.color,
  });
}

// ---------------------------------------------------------------------------
// Teams Grid
// ---------------------------------------------------------------------------

class _TeamsGrid extends StatelessWidget {
  final List<_TeamData> teams;

  const _TeamsGrid({required this.teams});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: teams.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppSpacing.sm,
        mainAxisSpacing: AppSpacing.sm,
        childAspectRatio: 1.4,
      ),
      itemBuilder: (context, index) => _TeamCard(team: teams[index]),
    );
  }
}

// ---------------------------------------------------------------------------
// Team Card — tile in the teams grid
// ---------------------------------------------------------------------------

class _TeamCard extends StatelessWidget {
  final _TeamData team;

  const _TeamCard({required this.team});

  @override
  Widget build(BuildContext context) {
    final taskProgress =
        team.totalTasks > 0 ? team.completedTasks / team.totalTasks : 0.0;

    return Container(
      decoration: BoxDecoration(
        color: AppPalette.white,
        borderRadius: AppRadius.mdBorderRadius,
        border: Border.all(color: AppPalette.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(5), // 0.02 * 255 approx 5
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(AppSpacing.sm + 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              // Team avatar
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: team.color,
                  borderRadius: AppRadius.smBorderRadius,
                ),
                alignment: Alignment.center,
                child: Text(
                  team.acronym,
                  style: AppTextStyles.caption.copyWith(
                    color: AppPalette.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      team.name,
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: AppPalette.headingTextColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '${team.memberCount} Members',
                      style: AppTextStyles.caption.copyWith(
                        fontSize: 11,
                        color: AppPalette.mutedTextColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tasks label
              Text(
                '${team.completedTasks}/${team.totalTasks} Tasks',
                style: AppTextStyles.caption.copyWith(
                  fontSize: 11,
                  color: AppPalette.mutedTextColor,
                ),
              ),
              const SizedBox(height: 4),
              // Progress bar
              ClipRRect(
                borderRadius: BorderRadius.circular(3),
                child: LinearProgressIndicator(
                  value: taskProgress,
                  minHeight: 5,
                  backgroundColor: AppPalette.outlineVariant,
                  valueColor: AlwaysStoppedAnimation<Color>(team.color),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Quick Actions Grid
// ---------------------------------------------------------------------------

class _QuickActionsGrid extends StatelessWidget {
  const _QuickActionsGrid();

  @override
  Widget build(BuildContext context) {
    const actions = [
      _QuickActionData(
        icon: Icons.group_add_outlined,
        label: 'Create Team',
      ),
      _QuickActionData(
        icon: Icons.person_add_outlined,
        label: 'Invite Member',
      ),
      _QuickActionData(
        icon: Icons.add_task_outlined,
        label: 'Create Task',
      ),
      _QuickActionData(
        icon: Icons.settings_outlined,
        label: 'Workspace Settings',
      ),
    ];

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: actions.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppSpacing.sm,
        mainAxisSpacing: AppSpacing.sm,
        childAspectRatio: 2.2,
      ),
      itemBuilder: (context, index) =>
          _QuickActionTile(data: actions[index]),
    );
  }
}

// ---------------------------------------------------------------------------
// Quick Action Data model
// ---------------------------------------------------------------------------

class _QuickActionData {
  final IconData icon;
  final String label;

  const _QuickActionData({
    required this.icon,
    required this.label,
  });
}

// ---------------------------------------------------------------------------
// Quick Action Tile
// ---------------------------------------------------------------------------

class _QuickActionTile extends StatelessWidget {
  final _QuickActionData data;

  const _QuickActionTile({required this.data});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: AppPalette.white,
          borderRadius: AppRadius.mdBorderRadius,
          border: Border.all(color: AppPalette.border),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(5),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md, vertical: AppSpacing.sm),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppPalette.primaryFixed,
                borderRadius: AppRadius.smBorderRadius,
              ),
              alignment: Alignment.center,
              child: Icon(data.icon, size: 18, color: AppPalette.surfaceTint),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(
                data.label,
                style: AppTextStyles.caption.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppPalette.headingTextColor,
                ),
                maxLines: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
