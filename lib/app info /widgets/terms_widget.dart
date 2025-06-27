import 'package:flutter/material.dart';

class TermsWidget extends StatefulWidget {
  const TermsWidget({super.key});

  @override
  State<TermsWidget> createState() => _TermsWidgetState();
}

class _TermsWidgetState extends State<TermsWidget> {
  final List<bool> _expandedStates = List.generate(11, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      appBar: AppBar(
        title: const Text('Algemene Voorwaarden'),
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
                          Icons.description_outlined,
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
                              'Voorwaarden',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.surface,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Onze gebruiksvoorwaarden',
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
                    'Welkom bij MatchMe! Door gebruik te maken van onze app of website ga je akkoord met de onderstaande gebruiksvoorwaarden. Lees deze voorwaarden zorgvuldig door voordat je onze diensten gebruikt. Deze voorwaarden vormen een juridisch bindende overeenkomst tussen jou en MatchMe.',
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

            // Expandable Terms Sections
            _buildExpandableCard(
              0,
              '1. Definities',
              '"Wij", "Ons", "MatchMe": Verwijst naar het bedrijf dat de app en website aanbiedt, gevestigd in Leiden.\n"Gebruiker", "Jij": Verwijst naar elke persoon die de app of website gebruikt.\n"App": De mobiele applicatie van MatchMe.\n"Website": De website van MatchMe, bereikbaar via www.matchme.app.\n"Dienst": De diensten die door MatchMe worden aangeboden, inclusief het verbinden van gebruikers op basis van profielinformatie, voorkeuren en locatie.',
              Icons.book_outlined,
            ),

            _buildExpandableCard(
              1,
              '2. Toegang tot de Diensten',
              'Je hebt toegang tot onze diensten onder de voorwaarde dat je:\n\n• Ten minste 18 jaar oud bent\n• Alle benodigde informatie verstrekt bij registratie en deze informatie actueel en juist houdt\n• Een account aanmaakt en akkoord gaan met deze gebruiksvoorwaarden en ons privacybeleid\n\nMatchMe behoudt zich het recht voor om je toegang tot de app of website te beperken of te beëindigen als je deze voorwaarden overtreedt.',
              Icons.login_outlined,
            ),

            _buildExpandableCard(
              2,
              '3. Verantwoordelijkheden van de Gebruiker',
              'Als gebruiker ben je verantwoordelijk voor:\n\n• Het beveiligd houden van je accountgegevens, zoals je gebruikersnaam en wachtwoord\n• Het verantwoordelijk gebruik van onze diensten, zonder anderen te storen, lastig te vallen of schade toe te brengen aan hun ervaring\n• Het niet plaatsen van content die in strijd is met de wet of die andere gebruikers kan schaden, zoals haatzaaiende taal, bedreigingen of pornografisch materiaal\n• Het respecteren van de privacy van andere gebruikers, door geen persoonlijke informatie van anderen zonder toestemming te delen',
              Icons.person_outline,
            ),

            _buildExpandableCard(
              3,
              '4. Verboden Gedrag',
              'Het is verboden om:\n\n• Onze diensten te gebruiken voor illegale activiteiten, zoals fraude, intimidatie of oplichting\n• Je te voeden met valse of misleidende informatie tijdens het gebruik van onze app\n• Het platform te gebruiken om te spammen, adverteren of commerciële aanbiedingen te doen zonder toestemming van MatchMe\n• Onze app te gebruiken op een manier die schade kan toebrengen aan onze systemen of aan andere gebruikers (zoals het verspreiden van virussen of andere schadelijke software)',
              Icons.block_outlined,
            ),

            _buildExpandableCard(
              4,
              '5. Intellectuele Eigendomsrechten',
              'Alle inhoud op MatchMe, inclusief tekst, afbeeldingen, logo\'s, software en andere materialen, is eigendom van MatchMe of onze licentiegevers en is beschermd door auteursrechten en andere intellectuele eigendomsrechten.\n\nJe krijgt een beperkt, niet-exclusief, niet-overdraagbaar recht om de app te gebruiken, uitsluitend voor persoonlijk gebruik.\n\nJe mag geen inhoud van MatchMe zonder onze schriftelijke toestemming kopiëren, verspreiden, aanpassen of op een andere manier gebruiken.',
              Icons.copyright_outlined,
            ),

            _buildExpandableCard(
              5,
              '6. Betalingen en Aankopen',
              'MatchMe biedt zowel gratis als betaalde functies aan. Betalingen voor premium functies kunnen via de app of website worden gedaan. Alle betalingen worden beheerd door externe betalingsproviders en zijn onderworpen aan hun voorwaarden.\n\nAls je premium functies gebruikt, worden de volgende voorwaarden van toepassing:\n• Je hebt geen recht op restitutie voor aangekochte functies, tenzij anders bepaald\n• Betalingen zijn niet overdraagbaar naar andere accounts of gebruikers',
              Icons.payment_outlined,
            ),

            _buildExpandableCard(
              6,
              '7. Beëindiging van je Account',
              'Je kunt je account te allen tijde deactiveren of verwijderen door naar de instellingen van je account te gaan. Wij behouden ons het recht voor om je account te beëindigen of te schorsen als je deze gebruiksvoorwaarden overtreedt, zonder voorafgaande kennisgeving.\n\nBij beëindiging van je account worden je gegevens volgens ons privacybeleid behandeld.',
              Icons.account_circle_outlined,
            ),

            _buildExpandableCard(
              7,
              '8. Aansprakelijkheid en Beperkingen',
              'MatchMe is niet aansprakelijk voor:\n\n• Verlies van gegevens, verlies van toegang of verlies van inkomsten die het gevolg zijn van het gebruik van onze diensten\n• Inhoud die door gebruikers is geüpload en/of gedeeld via de app\n• Schade veroorzaakt door derde partijen die toegang hebben tot de app of website\n\nJe gebruikt MatchMe op eigen risico. De app en website worden "as is" geleverd zonder garanties op bruikbaarheid, beschikbaarheid of foutloze werking.',
              Icons.warning_amber_outlined,
            ),

            _buildExpandableCard(
              8,
              '9. Wijzigingen in de Gebruikersvoorwaarden',
              'MatchMe behoudt zich het recht voor om deze gebruiksvoorwaarden op elk moment te wijzigen. Wij zullen je op de hoogte stellen van belangrijke wijzigingen, maar het is je verantwoordelijkheid om de voorwaarden regelmatig te controleren.\n\nWijzigingen zijn van kracht zodra ze op onze website of in de app zijn gepubliceerd.',
              Icons.update_outlined,
            ),

            _buildExpandableCard(
              9,
              '10. Toepasselijk Recht en Geschillen',
              'Deze gebruiksvoorwaarden worden beheerst door het Nederlandse recht. Eventuele geschillen zullen exclusief worden voorgelegd aan de bevoegde rechtbanken in Nederland.',
              Icons.gavel_outlined,
            ),

            _buildExpandableCard(
              10,
              '11. Contactgegevens',
              'Als je vragen hebt over deze gebruiksvoorwaarden, neem dan contact met ons op via:\n\n📧 support@matchme.app\n\nWe helpen je graag met:\n• Vragen over deze voorwaarden\n• Technische ondersteuning\n• Account gerelateerde vragen\n• Feedback en suggesties',
              Icons.contact_support_outlined,
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
