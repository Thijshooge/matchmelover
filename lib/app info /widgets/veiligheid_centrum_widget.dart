import 'package:flutter/material.dart';

class VeiligheidCentrumWidget extends StatefulWidget {
  const VeiligheidCentrumWidget({super.key});

  @override
  State<VeiligheidCentrumWidget> createState() =>
      _VeiligheidCentrumWidgetState();
}

class _VeiligheidCentrumWidgetState extends State<VeiligheidCentrumWidget> {
  final List<bool> _expandedStates = List.generate(6, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      appBar: AppBar(
        title: const Text('Veiligheid Centrum'),
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
                          Icons.shield_outlined,
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
                              'Veiligheid',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.surface,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Jouw veiligheidscentrum',
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
                    'Welkom bij het MatchMe Veiligheidscentrum. Hier vind je alle tools, informatie en hulpmiddelen om veilig en vertrouwd te daten.',
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

            // Expandable Safety Center Sections
            _buildExpandableCard(
              0,
              '1. Veilig Daten Gids',
              'Leer de basis van veilig online daten en hoe je jezelf kunt beschermen.\n\nBelangrijke onderwerpen:\n• Eerste indrukken en profielveiligheid\n• Veilige communicatie en grenzen stellen\n• Herkennen van verdacht gedrag en rode vlaggen\n• Tips voor veilige eerste ontmoetingen\n• Wat te doen bij oncomfortabele situaties\n• Vertrouwen opbouwen met nieuwe matches',
              Icons.menu_book_outlined,
            ),

            _buildExpandableCard(
              1,
              '2. Rapportage en Blokkeren',
              'Gebruik onze tools om ongewenst gedrag te melden en jezelf te beschermen.\n\nVeiligheidstools:\n• Hoe je een gebruiker kunt rapporteren\n• Verschillende soorten meldingen (spam, intimidatie, etc.)\n• Gebruikers blokkeren en contact voorkomen\n• Wat gebeurt er na een melding?\n• Onze moderatie en veiligheidsmaatregelen\n• Anoniem rapporteren en privacy bescherming',
              Icons.report_gmailerrorred_outlined,
            ),

            _buildExpandableCard(
              2,
              '3. Privacy Instellingen',
              'Beheer je privacy en bepaal wie je informatie kan zien.\n\nPrivacy opties:\n• Profielzichtbaarheid en wie je kan vinden\n• Locatie-instellingen en afstand filters\n• Foto privacy en wie je foto\'s kan zien\n• Berichtenprivacy en chat instellingen\n• Social media koppelingen beheren\n• Account privacy en gegevensbescherming',
              Icons.privacy_tip_outlined,
            ),

            _buildExpandableCard(
              3,
              '4. Noodcontacten',
              'Belangrijke telefoonnummers en contacten voor noodsituaties.\n\nNoodhulp contacten:\n• Politie: 112 (Nederland) of 101 (België)\n• Slachtofferhulp Nederland: 0900-0101\n• Veilig Thuis (huiselijk geweld): 0800-2000\n• Korrelatie (seksueel geweld): 0800-0188\n• Crisis helplijnen en chat ondersteuning\n• MatchMe Support: support@matchme.com',
              Icons.contact_phone_outlined,
            ),

            _buildExpandableCard(
              4,
              '5. Veiligheidsresources',
              'Handige links en bronnen voor meer informatie over online veiligheid.\n\nNuttige bronnen:\n• Politie.nl - Online veiligheid en cybercrime\n• VeiligheidNL - Algemene veiligheidstips\n• Centrum Veilig Internet - Online gedrag\n• Slachtofferhulp.nl - Ondersteuning en advies\n• Veilig Thuis - Huiselijk geweld preventie\n• Dating veiligheid blogs en artikelen',
              Icons.library_books_outlined,
            ),

            _buildExpandableCard(
              5,
              '6. Contact met MatchMe',
              'Heb je vragen over veiligheid of wil je iets melden? Neem contact met ons op.\n\nContact opties:\n• E-mail: safety@matchme.com voor veiligheidskwesties\n• In-app rapportage voor directe meldingen\n• Support chat voor algemene vragen\n• Telefonische hulplijn: 020-1234567 (werkdagen 9-17u)\n• Social media: @MatchMeSupport\n• We reageren binnen 24 uur op veiligheidsmeldingen',
              Icons.headset_mic_outlined,
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
