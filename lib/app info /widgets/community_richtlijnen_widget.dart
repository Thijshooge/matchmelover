import 'package:flutter/material.dart';

class CommunityRichtlijnenWidget extends StatefulWidget {
  const CommunityRichtlijnenWidget({super.key});

  @override
  State<CommunityRichtlijnenWidget> createState() =>
      _CommunityRichtlijnenWidgetState();
}

class _CommunityRichtlijnenWidgetState
    extends State<CommunityRichtlijnenWidget> {
  final List<bool> _expandedStates = List.generate(9, (index) => false);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      appBar: AppBar(
        title: const Text('Community Richtlijnen'),
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
                          Icons.people_outline,
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
                              'Community',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.surface,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Onze gedragsregels',
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
                    'Bij MatchMe streven we ernaar om een positieve, veilige en respectvolle gemeenschap te creëren. Deze richtlijnen zijn bedoeld om ervoor te zorgen dat alle gebruikers zich kunnen gedragen in overeenstemming met de waarden van MatchMe en dat iedereen een prettige ervaring heeft. Door de app te gebruiken, ga je akkoord met deze richtlijnen en draag je bij aan een veilige en inclusieve omgeving voor iedereen.',
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

            // Expandable Community Sections
            _buildExpandableCard(
              0,
              '1. Veiligheid',
              'De veiligheid van onze gebruikers staat voorop. We verwachten van iedereen dat ze zich op een respectvolle manier gedragen en geen gevaar vormen voor anderen. Dit betekent dat we elke vorm van intimidatie, bedreigingen of gewelddadig gedrag niet tolereren.\n\nWe nemen veiligheidsproblemen zeer serieus en moedigen gebruikers aan om verdachte of schadelijke gedragingen te melden.\n\nVeiligheidsprincipes:\n• Respectvol gedrag naar alle gebruikers\n• Geen intimidatie, bedreigingen of geweld\n• Meld verdachte of schadelijke gedragingen\n• Draag bij aan een veilige omgeving voor iedereen\n• Bescherm jezelf en anderen',
              Icons.security_outlined,
            ),

            _buildExpandableCard(
              1,
              '2. Verbod op illegale activiteiten',
              'Het is strikt verboden om de app te gebruiken voor illegale activiteiten. Dit omvat, maar is niet beperkt tot, het verspreiden van illegale goederen of diensten, fraude, oplichting, en het schenden van lokale wetten.\n\nAls we vermoeden dat je betrokken bent bij illegale activiteiten, kan je account zonder waarschuwing worden geschorst of verwijderd.\n\nVerboden activiteiten:\n• Verspreiden van illegale goederen of diensten\n• Fraude en oplichting\n• Schenden van lokale wetten\n• Elke vorm van illegale handel\n• Criminele activiteiten\n• Account kan zonder waarschuwing worden geschorst',
              Icons.block_outlined,
            ),

            _buildExpandableCard(
              2,
              '3. Anti-scam en fraude bescherming',
              'MatchMe heeft een strikt anti-scam beleid en we werken actief aan het voorkomen van frauduleuze activiteiten. We tolereren geen pogingen tot oplichting, zoals het vragen om geld, het delen van valse informatie, of misleidende gedragingen.\n\nHoud er rekening mee dat je nooit gevraagd zal worden om betalingen of persoonlijke financiële informatie te verstrekken via de app. Als je vermoedens hebt van oplichting, meld dit dan onmiddellijk bij onze ondersteuning.\n\nAnti-scam maatregelen:\n• Strikt verbod op oplichting en fraude\n• Geen vragen om geld of financiële informatie\n• Geen valse informatie of misleidende gedragingen\n• MatchMe vraagt nooit om betalingen via de app\n• Meld verdachte activiteiten onmiddellijk\n• Actieve preventie van frauduleuze activiteiten',
              Icons.shield_outlined,
            ),

            _buildExpandableCard(
              3,
              '4. Discriminatie en inclusiviteit',
              'MatchMe is toegewijd aan het bevorderen van diversiteit en inclusiviteit. We verwachten dat gebruikers zich respectvol gedragen tegenover mensen van alle achtergronden, ongeacht geslacht, ras, etniciteit, seksuele geaardheid, religie of andere persoonlijke kenmerken.\n\nDiscriminatie, haatspraak of intimidatie op basis van welke reden dan ook, wordt niet getolereerd. Dit zorgt ervoor dat iedereen zich welkom en veilig voelt.\n\nInclusiviteitsrichtlijnen:\n• Respectvol gedrag naar alle achtergronden\n• Geen discriminatie op basis van geslacht, ras, etniciteit\n• Geen haatspraak of intimidatie\n• Respecteer seksuele geaardheid en religie\n• Iedereen moet zich welkom en veilig voelen\n• Bevordering van diversiteit en inclusiviteit',
              Icons.diversity_3_outlined,
            ),

            _buildExpandableCard(
              4,
              '5. Content Beperking',
              'We vragen gebruikers om respectvolle en geschikte content te delen in de app. Het is verboden om materiaal te plaatsen of te delen dat:\n\n• Ongepaste taal bevat (schelden, haatspraak, bedreigingen)\n• Obscene of seksuele inhoud bevat die in strijd is met de normen van de gemeenschap\n• Geweld of haat promoot\n• Aanstootgevend of schokkend is voor andere gebruikers\n\nWe behouden ons het recht voor om content te verwijderen die in strijd is met onze richtlijnen en om accounts die herhaaldelijk inbreuk maken op deze regels te schorsen of te verwijderen.\n\nVerboden content:\n• Ongepaste taal, schelden, haatspraak\n• Obscene of ongepaste seksuele inhoud\n• Gewelddadige of haatdragende content\n• Aanstootgevende of schokkende materialen\n• Content wordt verwijderd bij overtreding\n• Herhaalde overtredingen leiden tot schorsing',
              Icons.content_paste_off_outlined,
            ),

            _buildExpandableCard(
              5,
              '6. Gebruikers Verantwoordelijkheid',
              'Als gebruiker van MatchMe ben je verantwoordelijk voor je eigen gedrag. Dit betekent dat je:\n\n• Jezelf gedraagt volgens de communityrichtlijnen\n• Andere gebruikers met respect behandelt\n• Geen activiteiten onderneemt die schadelijk kunnen zijn voor andere gebruikers of de app zelf\n\nWij verwachten van iedere gebruiker dat ze zich aan de regels houden, zodat we een positieve omgeving kunnen creëren voor iedereen.\n\nJouw verantwoordelijkheden:\n• Gedrag volgens communityrichtlijnen\n• Respectvolle behandeling van andere gebruikers\n• Geen schadelijke activiteiten ondernemen\n• Bijdragen aan positieve omgeving\n• Naleven van alle regels en richtlijnen\n• Verantwoordelijkheid voor eigen acties',
              Icons.person_outline,
            ),

            _buildExpandableCard(
              6,
              '7. Moderatie en handhaving',
              'MatchMe behoudt zich het recht voor om gebruikersaccounts te modereren en in te grijpen wanneer gebruikers zich niet aan de richtlijnen houden. Dit kan variëren van waarschuwingen tot tijdelijke schorsingen of permanente verwijdering van accounts bij ernstige of herhaalde inbreuken.\n\nAlle meldingen worden serieus genomen en onderzoeken worden op een eerlijke en vertrouwelijke manier uitgevoerd.\n\nModeratiebeleid:\n• Recht om accounts te modereren en in te grijpen\n• Waarschuwingen bij lichte overtredingen\n• Tijdelijke schorsingen bij herhaalde inbreuken\n• Permanente verwijdering bij ernstige overtredingen\n• Alle meldingen worden serieus genomen\n• Eerlijke en vertrouwelijke onderzoeken',
              Icons.gavel_outlined,
            ),

            _buildExpandableCard(
              7,
              '8. Privacy en gegevensbescherming',
              'Wij respecteren de privacy van al onze gebruikers en stellen alles in het werk om je gegevens te beschermen. Het delen van vertrouwelijke of persoonlijke informatie zonder toestemming is ten strengste verboden.\n\nZie ons Privacybeleid voor meer informatie over hoe we omgaan met gegevensbescherming.\n\nPrivacy principes:\n• Respect voor privacy van alle gebruikers\n• Bescherming van persoonlijke gegevens\n• Verbod op delen van vertrouwelijke informatie zonder toestemming\n• Strikte gegevensbescherming\n• Raadpleeg ons Privacybeleid voor details\n• Veilige omgang met gebruikersgegevens',
              Icons.privacy_tip_outlined,
            ),

            _buildExpandableCard(
              8,
              '9. Zorg voor kwetsbare groepen',
              'Bij MatchMe zorgen we ervoor dat kwetsbare groepen zich veilig voelen in de app. Dit omvat onder andere minderjarigen, mensen met een beperking, of mensen die mogelijk slachtoffer kunnen worden van misbruik of oplichting.\n\nWe nemen extra voorzorgsmaatregelen om deze groepen te beschermen en zorgen ervoor dat onze gemeenschap veilig en ondersteunend is voor iedereen.\n\nBescherming kwetsbare groepen:\n• Extra zorg voor minderjarigen\n• Bescherming van mensen met beperkingen\n• Preventie van misbruik en oplichting\n• Extra voorzorgsmaatregelen voor kwetsbare gebruikers\n• Veilige en ondersteunende gemeenschap\n• Speciale aandacht voor risicogroepen',
              Icons.health_and_safety_outlined,
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
}
