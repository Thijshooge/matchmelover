import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SecurityWidget extends StatefulWidget {
  const SecurityWidget({super.key});

  @override
  State<SecurityWidget> createState() => _SecurityWidgetState();
}

class _SecurityWidgetState extends State<SecurityWidget> {
  bool _securityEnabled = false;
  final LocalAuthentication _localAuth = LocalAuthentication();

  @override
  void initState() {
    super.initState();
    _loadSecuritySetting();
  }

  // Laad de opgeslagen beveiligingsinstelling
  Future<void> _loadSecuritySetting() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _securityEnabled = prefs.getBool('app_security_enabled') ?? false;
    });
  }

  // Sla de beveiligingsinstelling op
  Future<void> _saveSecuritySetting(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('app_security_enabled', enabled);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        // Security widget
        GestureDetector(
          onTap: () {
            _showSecurityModal(context);
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white, width: 1),
              color: Theme.of(
                context,
              ).colorScheme.surface.withValues(alpha: 0.1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'App Beveiliging',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    if (!_securityEnabled)
                      const Text(
                        'Toevoegen',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          decoration: TextDecoration.underline,
                        ),
                      )
                    else
                      const Text(
                        '� Actief',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _toggleSecurity(bool enabled) {
    if (enabled) {
      _enableSecurity();
    } else {
      _disableSecurity();
    }
  }

  Future<void> _enableSecurity() async {
    // Test eerst of biometric authentication beschikbaar is
    final bool isAvailable = await _localAuth.canCheckBiometrics;
    final bool isDeviceSupported = await _localAuth.isDeviceSupported();

    if (!isAvailable || !isDeviceSupported) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Biometrische authenticatie niet beschikbaar op dit apparaat',
          ),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    _showSecurityModal(context);
  }

  Future<void> _disableSecurity() async {
    setState(() {
      _securityEnabled = false;
    });
    await _saveSecuritySetting(false);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('App beveiliging uitgeschakeld'),
        backgroundColor: Colors.grey,
      ),
    );
  }

  void _showSecurityModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      isScrollControlled: true,
      builder: (BuildContext modalContext) {
        return _SecurityModal(
          isEnabled: _securityEnabled,
          onSecurityChanged: (enabled) {
            setState(() {
              _securityEnabled = enabled;
            });
          },
        );
      },
    );
  }
}

class _SecurityModal extends StatefulWidget {
  final bool isEnabled;
  final Function(bool) onSecurityChanged;

  const _SecurityModal({
    required this.isEnabled,
    required this.onSecurityChanged,
  });

  @override
  State<_SecurityModal> createState() => _SecurityModalState();
}

class _SecurityModalState extends State<_SecurityModal> {
  bool _localSecurityEnabled = false;

  @override
  void initState() {
    super.initState();
    _localSecurityEnabled = widget.isEnabled;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.5,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'App Beveiliging',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    widget.onSecurityChanged(_localSecurityEnabled);
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Klaar',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Security toggle
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[600]!, width: 1),
                color: Colors.grey[800],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Biometrische beveiliging',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Vingerafdruk, Face ID of PIN-code',
                        style: TextStyle(color: Colors.grey[400], fontSize: 14),
                      ),
                    ],
                  ),
                  Switch(
                    value: _localSecurityEnabled,
                    onChanged: (value) {
                      if (value) {
                        _testBiometricAuth();
                      } else {
                        setState(() {
                          _localSecurityEnabled = false;
                        });
                      }
                    },
                    activeColor: Theme.of(context).colorScheme.primary,
                    inactiveThumbColor: Colors.grey,
                    inactiveTrackColor: Colors.grey.withValues(alpha: 0.3),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Info tekst
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Theme.of(
                  context,
                ).colorScheme.primary.withValues(alpha: 0.1),
                border: Border.all(
                  color: Theme.of(
                    context,
                  ).colorScheme.primary.withValues(alpha: 0.3),
                ),
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
                        'App Beveiliging',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Wanneer ingeschakeld, moet je je identiteit bevestigen telkens wanneer je de app opent. Dit kan met je vingerafdruk, Face ID, of je telefoon PIN-code.',
                    style: TextStyle(
                      color: Colors.grey[300],
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Status
            if (_localSecurityEnabled)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.green.withValues(alpha: 0.2),
                  border: Border.all(color: Colors.green, width: 1),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Beveiliging ingeschakeld',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _testBiometricAuth() async {
    try {
      final LocalAuthentication localAuth = LocalAuthentication();

      // Controleer of biometric authentication beschikbaar is
      final bool isAvailable = await localAuth.canCheckBiometrics;
      final bool isDeviceSupported = await localAuth.isDeviceSupported();

      if (!isAvailable || !isDeviceSupported) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Biometrische authenticatie niet beschikbaar'),
            backgroundColor: Colors.orange,
          ),
        );
        return;
      }

      // Probeer te authenticeren
      final bool didAuthenticate = await localAuth.authenticate(
        localizedReason:
            'Bevestig je identiteit om app beveiliging in te schakelen',
        options: const AuthenticationOptions(
          biometricOnly: false,
          stickyAuth: true,
        ),
      );

      if (didAuthenticate) {
        setState(() {
          _localSecurityEnabled = true;
        });

        // Sla de instelling op
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('app_security_enabled', true);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('App beveiliging ingeschakeld'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Authenticatie geannuleerd'),
            backgroundColor: Colors.orange,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Fout bij authenticatie: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
