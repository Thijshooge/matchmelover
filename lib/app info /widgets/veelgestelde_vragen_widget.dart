import 'package:flutter/material.dart';

class VeelgesteldeVragenWidget extends StatefulWidget {
  const VeelgesteldeVragenWidget({super.key});

  @override
  State<VeelgesteldeVragenWidget> createState() =>
      _VeelgesteldeVragenWidgetState();
}

class _VeelgesteldeVragenWidgetState extends State<VeelgesteldeVragenWidget> {
  final List<bool> _expandedStates = List.generate(8, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      appBar: AppBar(
        title: const Text('Veelgestelde Vragen'),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        foregroundColor: Theme.of(context).colorScheme.primary,
        toolbarHeight: 45,
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(
                  context,
                ).colorScheme.surface.withValues(alpha: 0.1),

                borderRadius: BorderRadius.circular(16),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.help_outline,
                          color: Theme.of(context).colorScheme.onPrimary,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'FAQ',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.surface,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Veelgestelde vragen',
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(
                                  context,
                                ).colorScheme.surface.withValues(alpha: 0.7),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Vind snel antwoorden op de meest gestelde vragen over MatchMe. Staat je vraag er niet bij? Neem dan contact met ons op.',
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.5,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Expandable FAQ Sections
            _buildExpandableCard(
              0,
              '1. Hoe maak ik een account aan?',
              'Het aanmaken van een MatchMe account is eenvoudig en gratis.\n\nStappen om te beginnen:\n• Download de MatchMe app uit de App Store of Google Play Store\n• Kies voor "Account aanmaken" op het welkomstscherm\n• Voer je e-mailadres en een veilig wachtwoord in\n• Verifieer je e-mailadres via de link die we je sturen\n• Vul je profiel aan met foto\'s en persoonlijke informatie\n• Begin met swipen en ontmoet nieuwe mensen!',
              Icons.person_add_outlined,
            ),

            _buildExpandableCard(
              1,
              '2. Hoe kan ik mijn profiel bewerken?',
              'Je kunt je profiel altijd aanpassen om jezelf beter te presenteren.\n\nProfiel bewerken:\n• Ga naar je profiel door op je profielfoto te tikken\n• Tik op "Profiel bewerken" of het potlood icoon\n• Voeg nieuwe foto\'s toe of verwijder oude foto\'s\n• Update je bio en persoonlijke informatie\n• Pas je voorkeuren aan voor leeftijd en afstand\n• Sla je wijzigingen op door op "Opslaan" te tikken',
              Icons.edit_outlined,
            ),

            _buildExpandableCard(
              2,
              '3. Hoe werkt het matchen systeem?',
              'MatchMe gebruikt een slim algoritme om je te koppelen aan compatibele personen.\n\nZo werkt het:\n• Swipe naar rechts als je iemand leuk vindt\n• Swipe naar links als je niet geïnteresseerd bent\n• Als jullie beide naar rechts swipen, hebben jullie een match!\n• Je krijgt een notificatie wanneer je een nieuwe match hebt\n• Je kunt dan beginnen met chatten in de berichten sectie\n• Gebruik filters om mensen te vinden die bij je passen',
              Icons.favorite_outline,
            ),

            _buildExpandableCard(
              3,
              '4. Kan ik berichten versturen zonder match?',
              'Bij MatchMe kun je alleen berichten versturen naar mensen waarmee je een match hebt.\n\nWaarom alleen matches:\n• Dit zorgt voor een veiligere en respectvollere omgeving\n• Het voorkomt spam en ongewenste berichten\n• Beide personen hebben interesse getoond door te matchen\n• Het maakt gesprekken betekenisvoller en echter\n• Je kunt wel Super Likes gebruiken om extra interesse te tonen\n• Premium gebruikers hebben toegang tot extra functies',
              Icons.message_outlined,
            ),

            _buildExpandableCard(
              4,
              '5. Wat zijn Super Likes en hoe gebruik ik ze?',
              'Super Likes zijn een speciale manier om extra interesse te tonen in iemand.\n\nSuper Likes uitgelegd:\n• Swipe omhoog of tik op de blauwe ster om een Super Like te geven\n• De persoon ziet dat je hem/haar een Super Like hebt gegeven\n• Dit verhoogt je kansen op een match aanzienlijk\n• Gratis gebruikers krijgen 1 Super Like per dag\n• Premium gebruikers krijgen meer Super Likes\n• Gebruik ze strategisch bij mensen die je echt interessant vindt',
              Icons.star_outline,
            ),

            _buildExpandableCard(
              5,
              '6. Hoe kan ik iemand rapporteren of blokkeren?',
              'Je veiligheid staat voorop. Je kunt altijd gebruikers rapporteren of blokkeren.\n\nVeiligheidsopties:\n• Tik op de drie puntjes in het profiel of chat\n• Kies "Rapporteren" voor ongepast gedrag\n• Kies "Blokkeren" om alle contact te stoppen\n• Geblokkeerde personen kunnen je niet meer zien of contacteren\n• Gerapporteerde gebruikers worden onderzocht door ons team\n• Ernstige overtredingen kunnen leiden tot een ban',
              Icons.report_outlined,
            ),

            _buildExpandableCard(
              6,
              '7. Wat is MatchMe Premium?',
              'MatchMe Premium biedt extra functies voor een betere dating ervaring.\n\nPremium voordelen:\n• Onbeperkt liken en Super Likes\n• Zie wie je al heeft geliket voordat je swipet\n• Rewind functie om onbedoelde swipes ongedaan te maken\n• Passport functie om wereldwijd te daten\n• Geen advertenties tijdens het gebruik\n• Prioriteit in de wachtrij voor meer zichtbaarheid\n• Geavanceerde filters voor betere matches',
              Icons.workspace_premium_outlined,
            ),

            _buildExpandableCard(
              7,
              '8. Hoe kan ik contact opnemen met support?',
              'Ons support team staat klaar om je te helpen met vragen of problemen.\n\nContact opnemen:\n• Ga naar Instellingen > Help & Support\n• Stuur een e-mail naar support@matchme.com\n• Gebruik de in-app chat functie voor directe hulp\n• Bekijk onze online help center voor veelvoorkomende problemen\n• Volg ons op sociale media voor updates en tips\n• We reageren meestal binnen 24 uur op je vraag',
              Icons.support_agent_outlined,
            ),

            const SizedBox(height: 24),

            // Last updated info
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(
                  context,
                ).colorScheme.surface.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.schedule,
                    size: 20,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Laatst bijgewerkt: ${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildExpandableCard(
    int index,
    String title,
    String content,
    IconData icon,
  ) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.1),
      child: Column(
        children: [
          // Header
          InkWell(
            onTap: () {
              setState(() {
                _expandedStates[index] = !_expandedStates[index];
              });
            },
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(
                  context,
                ).colorScheme.surface.withValues(alpha: 0.1),
                borderRadius: _expandedStates[index]
                    ? const BorderRadius.vertical(top: Radius.circular(12))
                    : BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(
                    icon,
                    color: Theme.of(context).colorScheme.surface,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.surface,
                      ),
                    ),
                  ),
                  AnimatedRotation(
                    turns: _expandedStates[index] ? 0.5 : 0,
                    duration: const Duration(milliseconds: 300),
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Expandable Content
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(
                  context,
                ).colorScheme.surface.withValues(alpha: 0.1),
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(12),
                ),
              ),
              child: Text(
                content,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.4,
                  color: Theme.of(
                    context,
                  ).colorScheme.surface.withValues(alpha: 0.8),
                ),
              ),
            ),
            crossFadeState: _expandedStates[index]
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
          ),
        ],
      ),
    );
  }
}
