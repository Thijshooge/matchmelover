import 'package:flutter/material.dart';

class PrestatiesWidget extends StatelessWidget {
  const PrestatiesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Icon(
                Icons.analytics_outlined,
                color: Theme.of(context).colorScheme.primary,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                'Mijn Prestaties',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.surface,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Stats Grid
          Row(
            children: [
              // Matches
              Expanded(
                child: _buildStatCard(
                  context,
                  'Matches',
                  '12',
                  Icons.favorite,
                  Colors.pink,
                ),
              ),
              const SizedBox(width: 12),
              // Gesprekken
              Expanded(
                child: _buildStatCard(
                  context,
                  'Gesprekken',
                  '8',
                  Icons.chat_bubble_outline,
                  Colors.blue,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              // Profiel views
              Expanded(
                child: _buildStatCard(
                  context,
                  'Profiel views',
                  '45',
                  Icons.visibility,
                  Colors.green,
                ),
              ),
              const SizedBox(width: 12),
              // Likes gegeven
              Expanded(
                child: _buildStatCard(
                  context,
                  'Likes gegeven',
                  '28',
                  Icons.thumb_up_outlined,
                  Colors.orange,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Activity Chart Section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(
                context,
              ).colorScheme.surface.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Activiteit deze week',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ),

                const SizedBox(height: 12),

                // Simple activity bars
                _buildActivityBar(context, 'Ma', 0.7),
                const SizedBox(height: 4),
                _buildActivityBar(context, 'Di', 0.4),
                const SizedBox(height: 4),
                _buildActivityBar(context, 'Wo', 0.9),
                const SizedBox(height: 4),
                _buildActivityBar(context, 'Do', 0.6),
                const SizedBox(height: 4),
                _buildActivityBar(context, 'Vr', 0.8),
                const SizedBox(height: 4),
                _buildActivityBar(context, 'Za', 0.3),
                const SizedBox(height: 4),
                _buildActivityBar(context, 'Zo', 0.5),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Achievement Section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(
                context,
              ).colorScheme.surface.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Laatste Achievement',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ),

                const SizedBox(height: 8),

                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.star,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Eerste Match!',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.surface,
                            ),
                          ),
                          Text(
                            'Je hebt je eerste match gemaakt!',
                            style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.surface,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).colorScheme.surface,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildActivityBar(
    BuildContext context,
    String day,
    double percentage,
  ) {
    return Row(
      children: [
        SizedBox(
          width: 20,
          child: Text(
            day,
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            height: 6,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(3),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: percentage,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
