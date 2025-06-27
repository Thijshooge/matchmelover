import 'package:flutter/material.dart';

class AbbonementWidget extends StatefulWidget {
  const AbbonementWidget({super.key});

  @override
  State<AbbonementWidget> createState() => _AbbonementWidgetState();
}

class _AbbonementWidgetState extends State<AbbonementWidget> {
  String currentPlan = 'gratis'; // gratis, plus, premium

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
                Icons.workspace_premium_outlined,
                color: Theme.of(context).colorScheme.primary,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                'Mijn Abonnement',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.surface,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Current Plan Section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  Theme.of(context).colorScheme.primary.withOpacity(0.05),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        _getPlanIcon(currentPlan),
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
                            _getPlanName(currentPlan),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          Text(
                            _getPlanPrice(currentPlan),
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Text(
                        'ACTIEF',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                if (currentPlan != 'gratis') ...[
                  const SizedBox(height: 12),
                  Text(
                    'Vernieuwt automatisch op 15 maart 2024',
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Features Section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.tertiary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Jouw Features',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 12),
                ..._getCurrentPlanFeatures().map(
                  (feature) => _buildFeatureItem(context, feature),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Upgrade Section (only show if not premium)
          if (currentPlan != 'premium') ...[
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFFD700), Color(0xFFFFA500)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.white, size: 24),
                      const SizedBox(width: 8),
                      Text(
                        currentPlan == 'gratis'
                            ? 'Upgrade naar Plus'
                            : 'Upgrade naar Premium',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    currentPlan == 'gratis'
                        ? 'Krijg meer matches en onbeperkte likes!'
                        : 'Ontgrendel alle premium features!',
                    style: const TextStyle(fontSize: 12, color: Colors.white),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        _showUpgradeDialog(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFFFFA500),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Upgrade Nu - ${currentPlan == 'gratis' ? '€9,99/maand' : '€19,99/maand'}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],

          // Usage Stats
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(
                context,
              ).colorScheme.surfaceContainerHighest.withOpacity(0.5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Gebruik deze maand',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 12),
                _buildUsageItem(
                  context,
                  'Likes gebruikt',
                  15,
                  _getLikesLimit(),
                ),
                const SizedBox(height: 8),
                _buildUsageItem(
                  context,
                  'Super Likes gebruikt',
                  2,
                  _getSuperLikesLimit(),
                ),
                const SizedBox(height: 8),
                _buildUsageItem(
                  context,
                  'Boosts gebruikt',
                  1,
                  _getBoostsLimit(),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Manage Subscription Button
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                _showManageSubscriptionDialog(context);
              },
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                side: BorderSide(color: Theme.of(context).colorScheme.primary),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Abonnement Beheren',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getPlanName(String plan) {
    switch (plan) {
      case 'gratis':
        return 'Gratis Plan';
      case 'plus':
        return 'MatchMe Plus';
      case 'premium':
        return 'MatchMe Premium';
      default:
        return 'Onbekend Plan';
    }
  }

  String _getPlanPrice(String plan) {
    switch (plan) {
      case 'gratis':
        return 'Gratis voor altijd';
      case 'plus':
        return '€9,99 per maand';
      case 'premium':
        return '€19,99 per maand';
      default:
        return '';
    }
  }

  IconData _getPlanIcon(String plan) {
    switch (plan) {
      case 'gratis':
        return Icons.person_outline;
      case 'plus':
        return Icons.star_outline;
      case 'premium':
        return Icons.diamond_outlined;
      default:
        return Icons.help_outline;
    }
  }

  List<String> _getCurrentPlanFeatures() {
    switch (currentPlan) {
      case 'gratis':
        return [
          '5 likes per dag',
          '1 super like per dag',
          'Basis matching',
          'Beperkte filters',
        ];
      case 'plus':
        return [
          'Onbeperkte likes',
          '5 super likes per dag',
          '1 boost per maand',
          'Geavanceerde filters',
          'Zie wie je leuk vindt',
          'Rewind functie',
        ];
      case 'premium':
        return [
          'Alles van Plus',
          'Onbeperkte super likes',
          '5 boosts per maand',
          'Prioriteit in matching',
          'Incognito modus',
          'Lees bevestigingen',
          'Premium support',
        ];
      default:
        return [];
    }
  }

  int _getLikesLimit() {
    switch (currentPlan) {
      case 'gratis':
        return 5;
      case 'plus':
      case 'premium':
        return -1; // Onbeperkt
      default:
        return 0;
    }
  }

  int _getSuperLikesLimit() {
    switch (currentPlan) {
      case 'gratis':
        return 1;
      case 'plus':
        return 5;
      case 'premium':
        return -1; // Onbeperkt
      default:
        return 0;
    }
  }

  int _getBoostsLimit() {
    switch (currentPlan) {
      case 'gratis':
        return 0;
      case 'plus':
        return 1;
      case 'premium':
        return 5;
      default:
        return 0;
    }
  }

  Widget _buildFeatureItem(BuildContext context, String feature) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: Colors.green, size: 16),
          const SizedBox(width: 8),
          Text(
            feature,
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUsageItem(
    BuildContext context,
    String label,
    int used,
    int limit,
  ) {
    final isUnlimited = limit == -1;
    final percentage = isUnlimited ? 0.0 : (used / limit).clamp(0.0, 1.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            Text(
              isUnlimited ? '$used gebruikt' : '$used/$limit',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        if (!isUnlimited) ...[
          LinearProgressIndicator(
            value: percentage,
            backgroundColor: Theme.of(
              context,
            ).colorScheme.surfaceContainerHighest,
            valueColor: AlwaysStoppedAnimation<Color>(
              percentage > 0.8
                  ? Colors.red
                  : Theme.of(context).colorScheme.primary,
            ),
          ),
        ] else ...[
          Container(
            height: 4,
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.3),
              borderRadius: BorderRadius.circular(2),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
        ],
      ],
    );
  }

  void _showUpgradeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Upgrade Abonnement'),
          content: Text(
            currentPlan == 'gratis'
                ? 'Wil je upgraden naar MatchMe Plus voor €9,99 per maand?'
                : 'Wil je upgraden naar MatchMe Premium voor €19,99 per maand?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Annuleren'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                // TODO: Implement upgrade logic
                setState(() {
                  currentPlan = currentPlan == 'gratis' ? 'plus' : 'premium';
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Geüpgraded naar ${_getPlanName(currentPlan)}!',
                    ),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              child: const Text('Upgrade'),
            ),
          ],
        );
      },
    );
  }

  void _showManageSubscriptionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Abonnement Beheren'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Huidige plan: ${_getPlanName(currentPlan)}'),
              const SizedBox(height: 8),
              Text('Prijs: ${_getPlanPrice(currentPlan)}'),
              if (currentPlan != 'gratis') ...[
                const SizedBox(height: 8),
                const Text('Vernieuwt automatisch op 15 maart 2024'),
              ],
            ],
          ),
          actions: [
            if (currentPlan != 'gratis') ...[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  // TODO: Implement cancel subscription
                  setState(() {
                    currentPlan = 'gratis';
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Abonnement geannuleerd'),
                      backgroundColor: Colors.orange,
                    ),
                  );
                },
                child: const Text(
                  'Annuleren',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Sluiten'),
            ),
          ],
        );
      },
    );
  }
}
