import 'package:flutter/material.dart';

class SecurityWidget extends StatefulWidget {
  const SecurityWidget({super.key});

  @override
  State<SecurityWidget> createState() => _SecurityWidgetState();
}

class _SecurityWidgetState extends State<SecurityWidget> {
  // Security Settings
  bool twoFactorAuth = false;
  bool biometricLogin = true;
  bool loginNotifications = true;
  bool suspiciousActivityAlerts = true;
  bool autoLogout = false;

  String lastLoginLocation = "Amsterdam, Nederland";
  String lastLoginTime = "Vandaag om 14:30";
  int activeDevices = 2;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),

        // Login Information Section
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
                    Icons.info_outline,
                    color: Theme.of(context).colorScheme.primary,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Login Informatie',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildInfoItem(
                context,
                'Laatste login',
                lastLoginTime,
                Icons.access_time,
              ),
              const SizedBox(height: 12),
              _buildInfoItem(
                context,
                'Locatie',
                lastLoginLocation,
                Icons.location_on_outlined,
              ),
              const SizedBox(height: 12),
              _buildInfoItem(
                context,
                'Actieve apparaten',
                '$activeDevices apparaten',
                Icons.devices,
                onTap: () => _showActiveDevicesDialog(context),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // Security Settings Section
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
                    Icons.security,
                    color: Theme.of(context).colorScheme.primary,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Beveiligings Instellingen',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildSecurityToggle(
                context,
                'Twee-factor authenticatie',
                'Extra beveiligingslaag voor je account',
                Icons.security,
                twoFactorAuth,
                (value) => setState(() => twoFactorAuth = value),
              ),
              const SizedBox(height: 12),
              _buildSecurityToggle(
                context,
                'Biometrische login',
                'Gebruik vingerafdruk of gezichtsherkenning',
                Icons.fingerprint,
                biometricLogin,
                (value) => setState(() => biometricLogin = value),
              ),
              const SizedBox(height: 12),
              _buildSecurityToggle(
                context,
                'Login notificaties',
                'Ontvang meldingen bij nieuwe logins',
                Icons.notifications_outlined,
                loginNotifications,
                (value) => setState(() => loginNotifications = value),
              ),
              const SizedBox(height: 12),
              _buildSecurityToggle(
                context,
                'Verdachte activiteit waarschuwingen',
                'Waarschuw bij ongebruikelijke activiteit',
                Icons.warning_outlined,
                suspiciousActivityAlerts,
                (value) => setState(() => suspiciousActivityAlerts = value),
              ),
              const SizedBox(height: 12),
              _buildSecurityToggle(
                context,
                'Automatisch uitloggen',
                'Log automatisch uit na inactiviteit',
                Icons.logout,
                autoLogout,
                (value) => setState(() => autoLogout = value),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // Password & Access Section
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
                    Icons.lock_outline,
                    color: Theme.of(context).colorScheme.primary,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Wachtwoord & Toegang',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildActionItem(
                context,
                'Wachtwoord wijzigen',
                'Wijzig je huidige wachtwoord',
                Icons.lock_outline,
                () => _showChangePasswordDialog(context),
              ),
              const SizedBox(height: 12),
              _buildActionItem(
                context,
                'Backup codes',
                'Genereer backup codes voor 2FA',
                Icons.qr_code,
                () => _showBackupCodesDialog(context),
              ),
              const SizedBox(height: 12),
              _buildActionItem(
                context,
                'Sessies beheren',
                'Bekijk en beheer actieve sessies',
                Icons.computer,
                () => _showSessionsDialog(context),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // Emergency Actions
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
                  Icon(Icons.emergency, color: Colors.red, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Noodacties',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildActionItem(
                context,
                'Account vergrendelen',
                'Vergrendel tijdelijk je account',
                Icons.lock,
                () => _showLockAccountDialog(context),
                isDestructive: true,
              ),
              const SizedBox(height: 12),
              _buildActionItem(
                context,
                'Alle sessies beëindigen',
                'Log uit op alle apparaten',
                Icons.logout,
                () => _showLogoutAllDialog(context),
                isDestructive: true,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSecurityToggle(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    bool value,
    Function(bool) onChanged,
  ) {
    return Row(
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
          onChanged: onChanged,
          activeColor: Theme.of(context).colorScheme.primary,
        ),
      ],
    );
  }

  Widget _buildInfoItem(
    BuildContext context,
    String title,
    String value,
    IconData icon, {
    VoidCallback? onTap,
  }) {
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
            if (onTap != null)
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

  Widget _buildActionItem(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap, {
    bool isDestructive = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Icon(
              icon,
              color: isDestructive
                  ? Colors.red
                  : Theme.of(context).colorScheme.primary,
              size: 20,
            ),
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
                      color: isDestructive
                          ? Colors.red
                          : Theme.of(context).colorScheme.surface,
                    ),
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

  // Dialog methods
  void _showActiveDevicesDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Actieve Apparaten'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDeviceItem('iPhone 15 Pro', 'Huidig apparaat', true),
              const SizedBox(height: 8),
              _buildDeviceItem('MacBook Pro', '2 uur geleden', false),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Sluiten'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDeviceItem(String device, String lastUsed, bool isCurrent) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isCurrent
            ? Colors.green.withValues(alpha: 0.1)
            : Colors.grey.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.devices, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  device,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                Text(lastUsed, style: const TextStyle(fontSize: 12)),
              ],
            ),
          ),
          if (isCurrent)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Huidig',
                style: TextStyle(color: Colors.white, fontSize: 10),
              ),
            ),
        ],
      ),
    );
  }

  void _showChangePasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Wachtwoord Wijzigen'),
          content: const Text(
            'Je wordt doorgestuurd naar het wachtwoord wijzigen scherm.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Annuleren'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                // TODO: Navigate to change password screen
              },
              child: const Text('Doorgaan'),
            ),
          ],
        );
      },
    );
  }

  void _showBackupCodesDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Backup Codes'),
          content: const Text(
            'Genereer backup codes om toegang te behouden als je je 2FA apparaat kwijtraakt.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Annuleren'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                // TODO: Generate backup codes
              },
              child: const Text('Genereren'),
            ),
          ],
        );
      },
    );
  }

  void _showSessionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sessies Beheren'),
          content: const Text(
            'Bekijk en beheer alle actieve sessies op verschillende apparaten.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Annuleren'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                // TODO: Show sessions management screen
              },
              child: const Text('Beheren'),
            ),
          ],
        );
      },
    );
  }

  void _showLockAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Account Vergrendelen'),
          content: const Text(
            'Weet je zeker dat je je account tijdelijk wilt vergrendelen? Je kunt het later weer ontgrendelen.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Annuleren'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                // TODO: Lock account
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Vergrendelen'),
            ),
          ],
        );
      },
    );
  }

  void _showLogoutAllDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Alle Sessies Beëindigen'),
          content: const Text(
            'Dit zal je uitloggen op alle apparaten. Je moet opnieuw inloggen op elk apparaat.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Annuleren'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                // TODO: Logout all sessions
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Uitloggen'),
            ),
          ],
        );
      },
    );
  }
}
