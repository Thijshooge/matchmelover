import 'package:flutter/material.dart';

class CookieWidget extends StatefulWidget {
  const CookieWidget({super.key});

  @override
  State<CookieWidget> createState() => _CookieWidgetState();
}

class _CookieWidgetState extends State<CookieWidget> {
  final List<bool> _expandedStates = List.generate(8, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      appBar: AppBar(
        toolbarHeight: 45,
        title: const Text('Cookie Beleid'),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        foregroundColor: Theme.of(context).colorScheme.primary,
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
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
                          Icons.cookie,
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
                              'Cookie Beleid',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.surface,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Cookies en vergelijkbare technologieën',
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
                    'MatchMe maakt gebruik van cookies en vergelijkbare technologieën (zoals pixels en SDK\'s) om jouw ervaring te verbeteren wanneer je onze app of website gebruikt. Dit cookiebeleid legt uit wat cookies zijn, welke cookies we gebruiken, hoe we ze gebruiken en hoe je ze kunt beheren.\n\nDoor onze diensten te gebruiken, geef je toestemming voor het gebruik van cookies zoals beschreven in dit beleid, tenzij je deze via je browserinstellingen hebt uitgeschakeld.',
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

            // Expandable Cookie Sections
            _buildExpandableCard(
              0,
              '1. Wat zijn cookies?',
              'Cookies zijn kleine tekstbestandjes die op je apparaat (zoals je smartphone of computer) worden geplaatst wanneer je een website of app bezoekt. Ze stellen ons in staat om gegevens te verzamelen over je gebruik van de app, zodat we jouw ervaring kunnen verbeteren, bijvoorbeeld door je voorkeuren te onthouden of te zorgen dat de app goed functioneert.\n\nEr zijn verschillende soorten cookies, zoals sessie cookies (die worden verwijderd zodra je de app of website verlaat) en permanente cookies (die op je apparaat blijven totdat je ze handmatig verwijdert of ze na een bepaalde periode automatisch vervallen).',
              Icons.info_outlined,
            ),

            _buildExpandableCard(
              1,
              '2. Welke cookies gebruiken wij?',
              'Wij gebruiken de volgende soorten cookies:\n\nFunctionele cookies\nDeze cookies zijn noodzakelijk voor de werking van onze diensten, bijvoorbeeld om je ingelogd te houden en je voorkeuren te onthouden. Zonder deze cookies kunnen sommige functies van de app niet goed functioneren.\n\nAnalytische cookies\nWij gebruiken deze cookies om te begrijpen hoe gebruikers onze app en website gebruiken (bijvoorbeeld via Google Analytics), zodat we de gebruikerservaring kunnen verbeteren. Deze cookies verzamelen anonieme gegevens over je gebruik, zoals welke pagina\'s je hebt bezocht.\n\nTracking Cookies\nMet jouw toestemming gebruiken wij cookies om je gedrag binnen de app te volgen en je gepersonaliseerde advertenties of content aan te bieden.\n\nAdvertentie Cookies\nDeze cookies worden gebruikt om relevante advertenties aan te bieden en je niet te blijven volgen met dezelfde advertenties na interactie met een bepaalde campagne.',
              Icons.category_outlined,
            ),

            _buildExpandableCard(
              2,
              '3. Hoelang blijven cookies bewaard?',
              'De duur van de cookies hangt af van hun type:\n\nSessiecookies blijven slechts gedurende je sessie actief en worden verwijderd zodra je de app of website verlaat.\n\nPermanente cookies blijven op je apparaat bewaard totdat ze verlopen of totdat je ze handmatig verwijdert. De bewaartermijn van deze cookies varieert, maar bedraagt meestal 30 dagen tot 2 jaar.',
              Icons.schedule_outlined,
            ),

            _buildExpandableCard(
              3,
              '4. Cookie Voorkeuren beheren',
              'Je kunt zelf bepalen welke cookies je wilt accepteren. Dit kun je doen via de cookie-instellingen in onze app of via de instellingen van je browser. Als je ervoor kiest om bepaalde cookies uit te schakelen, kan het zijn dat sommige functies van onze app of website niet correct functioneren.\n\nVia de app:\nGa naar de instellingen en beheer je cookievoorkeuren.\n\nVia je browser:\nJe kunt je browser zo instellen dat je gewaarschuwd wordt wanneer een website cookies probeert te plaatsen, of je kunt cookies helemaal blokkeren. Raadpleeg de hulpfuncties van je browser voor meer informatie over hoe je cookies kunt beheren.',
              Icons.tune_outlined,
            ),

            _buildExpandableCard(
              4,
              '5. Derde partijen en gegevensverwerking',
              'Wij maken gebruik van derde partijen voor bepaalde diensten, zoals analytics en advertenties. Deze derde partijen kunnen ook cookies op je apparaat plaatsen en verzamelen gegevens over jouw interacties met MatchMe. We hebben geen controle over de cookies die door deze derde partijen worden geplaatst. We raden je aan de privacy- en cookie begeleiden van deze derden te raadplegen.\n\nEnkele van de derde partijen die wij gebruiken zijn:\n• Google Analytics voor het analyseren van websiteverkeer\n• Google Ads en Facebook Ads voor het tonen van gepersonaliseerde advertenties',
              Icons.share_outlined,
            ),

            _buildExpandableCard(
              5,
              '6. Jouw rechten als gebruiker',
              'Als gebruiker van MatchMe heb je verschillende rechten met betrekking tot je gegevens die via cookies worden verzameld:\n\nRecht op inzage:\nJe hebt het recht om te weten welke gegevens we via cookies verzamelen.\n\nRecht op rectificatie:\nJe kunt verzoeken om gegevens die we via cookies verzamelen te corrigeren of bij te werken.\n\nRecht op verwijdering:\nJe kunt verzoeken om cookies te verwijderen of je voorkeuren voor het verzamelen van gegevens aan te passen.\n\nRecht op bezwaar:\nJe kunt bezwaar maken tegen het gebruik van bepaalde cookies, zoals voor advertenties.\n\nVoor meer informatie over je rechten en hoe je ze kunt uitoefenen, kun je onze privacy voorwaarden raadplegen.',
              Icons.account_circle_outlined,
            ),

            _buildExpandableCard(
              6,
              '7. Wijzigingen in dit beleid',
              'MatchMe behoudt zich het recht voor om dit cookiebeleid op elk moment te wijzigen. Als we belangrijke wijzigingen aanbrengen die invloed hebben op de manier waarop we cookies gebruiken, zullen we je hiervan op de hoogte stellen via een melding in de app of per e-mail. We raden je aan om dit beleid regelmatig te raadplegen.\n\nDe datum van de laatste wijziging wordt altijd bovenaan dit beleid vermeld.',
              Icons.update_outlined,
            ),

            _buildExpandableCard(
              7,
              '8. Contact',
              'Als je vragen hebt over dit cookiebeleid of hoe we cookies gebruiken, kun je contact met ons opnemen via:\n\n📧 privacy@matchme.app\n\nWe helpen je graag met al je cookie-gerelateerde vragen en zorgen ervoor dat je volledig geïnformeerd bent over ons gebruik van cookies en vergelijkbare technologieën.',
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
