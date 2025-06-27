import 'package:flutter/material.dart';

class VeiligheidTipsWidget extends StatefulWidget {
  const VeiligheidTipsWidget({super.key});

  @override
  State<VeiligheidTipsWidget> createState() => _VeiligheidTipsWidgetState();
}

class _VeiligheidTipsWidgetState extends State<VeiligheidTipsWidget> {
  final List<bool> _expandedStates = List.generate(7, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      appBar: AppBar(
        title: const Text('Veiligheid Tips'),
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
                          Icons.security_outlined,
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
                              'Jouw veiligheid is onze prioriteit',
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
                    'Bij MatchMe is jouw veiligheid onze prioriteit. Hoewel we ons best doen om een veilige en respectvolle omgeving te bieden, is het belangrijk dat jij zelf ook voorzorgsmaatregelen neemt om je privacy te beschermen en veilig te blijven. De onderstaande tips helpen je om veilig te blijven tijdens het gebruik van de app.',
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

            // Expandable Safety Sections
            _buildExpandableCard(
              0,
              '1. Blijf voorzichtig met persoonlijke info',
              'Deel geen gevoelige persoonlijke informatie, zoals je adres, financiële gegevens of wachtwoorden, via de app of chat. Dit geldt ook voor informatie zoals je werkplek, huisadres of andere gegevens die je privacy kunnen schaden.\n\nWe raden aan om in eerste instantie algemene gegevens te delen en pas later, als je de persoon vertrouwt, meer te delen.\n\nBescherm jezelf door:\n• Geen volledige adressen of exacte locaties te delen\n• Geen financiële informatie prijs te geven\n• Voorzichtig te zijn met werkplek informatie\n• Wachtwoorden nooit te delen\n• Eerst vertrouwen op te bouwen voordat je meer deelt',
              Icons.person_outline,
            ),

            _buildExpandableCard(
              1,
              '2. Ontmoet op een veilige plek',
              'Wanneer je ervoor kiest om iemand in persoon te ontmoeten, zorg er dan voor dat je afspreekt op een openbare en goed verlichte plek. Vermijd het ontmoeten van mensen in geïsoleerde of privé omgevingen, zoals hun huis of afgelegen locaties.\n\nInformeer altijd een vriend of familielid over de locatie van je afspraak en het tijdstip van je ontmoeting.\n\nVeilige eerste date tips:\n• Kies altijd een openbare plek zoals een café of restaurant\n• Vermijd privé locaties of afgelegen plekken\n• Zorg voor goede verlichting en veel mensen in de buurt\n• Laat vrienden of familie weten waar je bent\n• Deel je locatie en tijdstip van de afspraak\n• Kom met eigen vervoer of gebruik openbaar vervoer',
              Icons.location_on_outlined,
            ),

            _buildExpandableCard(
              2,
              '3. Gebruik chat binnen de app',
              'Blijf communiceren via de chatfunctie binnen de app in plaats van persoonlijke telefoonnummers of privéberichten direct uit te wisselen. De chatfunctie biedt een extra laag bescherming en maakt het gemakkelijker om rapporten in te dienen als je verdachte activiteiten tegenkomt.\n\nVeilige communicatie:\n• Gebruik alleen de MatchMe chat functie in het begin\n• Wacht met het delen van telefoonnummers\n• Vermijd andere platforms totdat je vertrouwen hebt\n• Houd gesprekken binnen de beveiligde omgeving van de app\n• Meld verdachte berichten via de app-functie',
              Icons.chat_bubble_outline,
            ),

            _buildExpandableCard(
              3,
              '4. Herken verdachte signalen',
              'Let altijd op verdachte signalen in het gedrag van andere gebruikers. Bijvoorbeeld:\n\n• Iemand die zich veel te snel te persoonlijk opstelt\n• Vragen om geld, geschenken of privéinformatie\n• Iemand die druk op je uitoefent om privécontacten te delen of een fysieke ontmoeting aan te gaan\n• Ongebruikelijke of onlogische verzoeken\n\nAls je iets verdachts tegenkomt, neem dan geen risico\'s en stop het contact.\n\nWaarschuwingssignalen:\n• Te snel te persoonlijk worden\n• Vragen om financiële hulp\n• Druk uitoefenen voor snelle ontmoetingen\n• Verhalen die niet kloppen\n• Weigeren te videobellen\n• Agressief of controlerend gedrag',
              Icons.warning_amber_outlined,
            ),

            _buildExpandableCard(
              4,
              '5. Nooit geld sturen',
              'Stuur nooit geld of waardevolle spullen naar iemand die je online hebt ontmoet, zelfs als ze beweren in financiële problemen te verkeren of als ze je om hulp vragen.\n\nOnline oplichting is helaas een veelvoorkomend probleem en kan leiden tot verlies van geld of schade. MatchMe zal je nooit vragen om betalingen of financiële transacties via de app uit te voeren.\n\nBescherm jezelf:\n• Stuur nooit geld naar online contacten\n• Geef geen financiële informatie prijs\n• Wees sceptisch bij verhalen over financiële nood\n• MatchMe vraagt nooit om betalingen\n• Meld verdachte verzoeken om geld onmiddellijk\n• Vertrouw niemand die om financiële hulp vraagt',
              Icons.money_off_outlined,
            ),

            _buildExpandableCard(
              5,
              '6. Meld ongepast gedrag',
              'Als je een gebruiker tegenkomt die zich ongepast, intimiderend of bedreigend gedraagt, of als je iets ziet dat in strijd is met onze gedragscode, meld dit dan onmiddellijk aan ons.\n\nJe kunt ongepast gedrag melden via de app. MatchMe zal dergelijke meldingen serieus nemen en actie ondernemen, waaronder het blokkeren of verwijderen van accounts die de richtlijnen overtreden.\n\nMeld het volgende gedrag:\n• Intimidatie of bedreigingen\n• Ongepaste berichten of foto\'s\n• Verzoeken om geld of geschenken\n• Agressief of controlerend gedrag\n• Schending van gedragscode\n• Verdachte of oplichting-achtige activiteiten',
              Icons.report_outlined,
            ),

            _buildExpandableCard(
              6,
              '7. Vertrouw op je gevoel',
              'Als iets niet goed voelt of als je twijfels hebt over een gesprek, interactie of ontmoeting, vertrouw dan altijd op je gevoel. Je hebt het recht om het contact te beëindigen en je account te verwijderen als je je onveilig voelt.\n\nJe intuïtie is je beste bescherming - luister altijd naar je innerlijke stem.\n\nVertrouw op jezelf:\n• Als iets niet goed voelt, ga dan weg\n• Je hoeft niet beleefd te zijn ten koste van je veiligheid\n• Het is oké om contact te beëindigen\n• Praat met vrienden of familie over je ervaringen\n• Zoek hulp als je je bedreigd voelt\n• Je veiligheid gaat altijd voor\n• Meld ernstige situaties bij de autoriteiten',
              Icons.psychology_outlined,
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
