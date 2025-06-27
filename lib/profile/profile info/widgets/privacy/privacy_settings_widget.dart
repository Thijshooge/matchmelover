import 'package:flutter/material.dart';
import 'package:matchme_lover/app%20info%20/widgets/privacy_widget.dart';
import '../../../../app info /widgets/community_richtlijnen_widget.dart';
import '../../../../app info /widgets/terms_widget.dart';
import '../../../../app info /widgets/cookie_widget.dart';
import '../../../../app info /widgets/veelgestelde_vragen_widget.dart';
import '../../../../app info /widgets/veiligheid_centrum_widget.dart';
import '../../../../app info /widgets/veiligheid_tips_widget.dart';

class PrivacySettingsWidget extends StatefulWidget {
  const PrivacySettingsWidget({super.key});

  @override
  State<PrivacySettingsWidget> createState() => _PrivacySettingsWidgetState();
}

class _PrivacySettingsWidgetState extends State<PrivacySettingsWidget> {
  // Profile Visibility Settings
  bool showAge = true;
  bool showDistance = true;
  bool showLastActive = false;
  bool showOnlineStatus = false;
  bool incognitoMode = false;

  // Communication Settings
  bool allowMessages = true;
  bool allowSuperLikes = true;
  bool allowBoosts = false;
  bool readReceipts = true;
  bool typingIndicators = true;

  // Discovery Settings
  String ageRange = "18-35";
  String maxDistance = "50 km";
  bool showMeInDiscovery = true;
  bool globalMode = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Terms & Conditions Section
        Container(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.description_outlined,
                    color: Theme.of(context).colorScheme.primary,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Algemene Voorwaarden',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                'Bekijk onze algemene voorwaarden',
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 1),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TermsWidget(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.open_in_new, size: 14),
                  label: const Text(
                    'Bekijk Voorwaarden',
                    style: TextStyle(fontSize: 14),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 2,
                      horizontal: 8,
                    ),
                    minimumSize: const Size(0, 28),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.description_outlined,
                    color: Theme.of(context).colorScheme.primary,
                    size: 20,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Privacybeleid',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                'Bekijk onze algemene privacybeleid',
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 1),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PrivacyWidget(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.open_in_new, size: 14),
                  label: const Text(
                    'Bekijk beleid',
                    style: TextStyle(fontSize: 14),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 2,
                      horizontal: 8,
                    ),
                    minimumSize: const Size(0, 28),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.cookie,
                    size: 16,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Cookie Beleid',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                'Bekijk ons cookie beleid',
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 1),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CookieWidget(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.open_in_new, size: 14),
                  label: const Text(
                    'Bekijk Cookies',
                    style: TextStyle(fontSize: 14),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 2,
                      horizontal: 8,
                    ),
                    minimumSize: const Size(0, 28),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.cookie,
                    size: 16,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Community Richtlijnen',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                'Bekijk ons community richtlijnen',
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 1),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const CommunityRichtlijnenWidget(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.open_in_new, size: 14),
                  label: const Text(
                    'Bekijk Community richtlijnen',
                    style: TextStyle(fontSize: 14),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 2,
                      horizontal: 8,
                    ),
                    minimumSize: const Size(0, 28),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.cookie,
                    size: 16,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Veiligheids Tips',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                'Bekijk ons veiligheids tips',
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 1),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const VeiligheidTipsWidget(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.open_in_new, size: 14),
                  label: const Text(
                    'Bekijk veiligheids tips',
                    style: TextStyle(fontSize: 14),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 2,
                      horizontal: 8,
                    ),
                    minimumSize: const Size(0, 28),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.cookie,
                    size: 16,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Veelgestelde Vragen',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                'Bekijk ons veelgestelde vragen',
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 1),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const VeelgesteldeVragenWidget(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.open_in_new, size: 14),
                  label: const Text(
                    'Bekijk Veelgestelde vragen',
                    style: TextStyle(fontSize: 14),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 2,
                      horizontal: 8,
                    ),
                    minimumSize: const Size(0, 28),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.cookie,
                    size: 16,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Veiligheid Centrum',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                'Bekijk ons veiligheids centrum',
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 1),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const VeiligheidCentrumWidget(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.open_in_new, size: 14),
                  label: const Text(
                    'Bekijk veiligheid centrum',
                    style: TextStyle(fontSize: 14),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 2,
                      horizontal: 8,
                    ),
                    minimumSize: const Size(0, 28),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // Profile Visibility Section
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.visibility_outlined,
                    color: Theme.of(context).colorScheme.primary,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Profiel Zichtbaarheid',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildPrivacyToggle(
                context,
                'Toon leeftijd',
                'Anderen kunnen je leeftijd zien',
                Icons.cake_outlined,
                showAge,
                (value) => setState(() => showAge = value),
              ),
              const SizedBox(height: 12),
              _buildPrivacyToggle(
                context,
                'Toon afstand',
                'Anderen kunnen je afstand tot hen zien',
                Icons.location_on_outlined,
                showDistance,
                (value) => setState(() => showDistance = value),
              ),
              const SizedBox(height: 12),
              _buildPrivacyToggle(
                context,
                'Toon laatst actief',
                'Anderen kunnen zien wanneer je laatst online was',
                Icons.access_time,
                showLastActive,
                (value) => setState(() => showLastActive = value),
              ),
              const SizedBox(height: 12),
              _buildPrivacyToggle(
                context,
                'Online status',
                'Toon een groene stip wanneer je online bent',
                Icons.circle,
                showOnlineStatus,
                (value) => setState(() => showOnlineStatus = value),
              ),
              const SizedBox(height: 12),
              _buildPrivacyToggle(
                context,
                'Incognito modus',
                'Bekijk profielen zonder dat zij het weten',
                Icons.visibility_off_outlined,
                incognitoMode,
                (value) => setState(() => incognitoMode = value),
                isPremium: true,
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // Discovery Settings Section
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.explore_outlined,
                    color: Theme.of(context).colorScheme.primary,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Ontdekking Instellingen',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildSettingItem(
                context,
                'Leeftijdsbereik',
                ageRange,
                Icons.people_outline,
                () => _showAgeRangeDialog(context),
              ),
              const SizedBox(height: 12),
              _buildSettingItem(
                context,
                'Maximale afstand',
                maxDistance,
                Icons.location_searching,
                () => _showDistanceDialog(context),
              ),
              const SizedBox(height: 12),
              _buildPrivacyToggle(
                context,
                'Toon mij in ontdekking',
                'Anderen kunnen je profiel vinden',
                Icons.search,
                showMeInDiscovery,
                (value) => setState(() => showMeInDiscovery = value),
              ),
              const SizedBox(height: 12),
              _buildPrivacyToggle(
                context,
                'Globale modus',
                'Zoek wereldwijd naar matches',
                Icons.public,
                globalMode,
                (value) => setState(() => globalMode = value),
                isPremium: true,
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // Communication Settings Section
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.chat_outlined,
                    color: Theme.of(context).colorScheme.primary,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Communicatie Instellingen',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildPrivacyToggle(
                context,
                'Berichten toestaan',
                'Anderen kunnen je berichten sturen',
                Icons.message_outlined,
                allowMessages,
                (value) => setState(() => allowMessages = value),
              ),
              const SizedBox(height: 12),
              _buildPrivacyToggle(
                context,
                'Super Likes toestaan',
                'Anderen kunnen je Super Likes geven',
                Icons.star_outline,
                allowSuperLikes,
                (value) => setState(() => allowSuperLikes = value),
              ),
              const SizedBox(height: 12),
              _buildPrivacyToggle(
                context,
                'Boost notificaties',
                'Ontvang meldingen over Boosts',
                Icons.rocket_launch_outlined,
                allowBoosts,
                (value) => setState(() => allowBoosts = value),
              ),
              const SizedBox(height: 12),
              _buildPrivacyToggle(
                context,
                'Leesbevestigingen',
                'Toon wanneer je berichten hebt gelezen',
                Icons.done_all,
                readReceipts,
                (value) => setState(() => readReceipts = value),
              ),
              const SizedBox(height: 12),
              _buildPrivacyToggle(
                context,
                'Typ indicatoren',
                'Toon wanneer je aan het typen bent',
                Icons.keyboard,
                typingIndicators,
                (value) => setState(() => typingIndicators = value),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPrivacyToggle(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    bool value,
    Function(bool) onChanged, {
    bool isPremium = false,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          color: isPremium && !value
              ? Theme.of(context).colorScheme.onSurfaceVariant
              : Theme.of(context).colorScheme.primary,
          size: 20,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                  if (isPremium) ...[
                    const SizedBox(width: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'PRO',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        Switch(
          value: value,
          onChanged: isPremium
              ? (val) {
                  if (val) {
                    _showPremiumDialog(context);
                  } else {
                    onChanged(val);
                  }
                }
              : onChanged,
          activeColor: Theme.of(context).colorScheme.primary,
        ),
      ],
    );
  }

  Widget _buildSettingItem(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Icon(icon, color: Theme.of(context).colorScheme.primary, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }

  void _showPremiumDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Premium Feature'),
          content: const Text(
            'Deze functie is alleen beschikbaar voor Premium gebruikers. Upgrade je account om toegang te krijgen.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Annuleren'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                // TODO: Navigate to premium upgrade
              },
              child: const Text('Upgrade'),
            ),
          ],
        );
      },
    );
  }

  void _showAgeRangeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Leeftijdsbereik'),
          content: const Text(
            'Stel je gewenste leeftijdsbereik in voor matches.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Annuleren'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                // TODO: Show age range picker
              },
              child: const Text('Wijzigen'),
            ),
          ],
        );
      },
    );
  }

  void _showDistanceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Maximale Afstand'),
          content: const Text(
            'Stel de maximale afstand in voor het zoeken naar matches.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Annuleren'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                // TODO: Show distance picker
              },
              child: const Text('Wijzigen'),
            ),
          ],
        );
      },
    );
  }
}
