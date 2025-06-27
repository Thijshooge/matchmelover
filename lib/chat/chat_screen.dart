import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      appBar: AppBar(
        toolbarHeight: 45,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        foregroundColor: Theme.of(context).colorScheme.primary,
        title: Row(
          children: [
            // Logo links
            Image.asset(
              'assets/logo.png',
              height: 32,
              width: 32,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 12),
            // Tekst naast logo
            Text(
              'CHAT',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/matchme/chat_settings');
            },
            padding: EdgeInsets.symmetric(horizontal: 4),
            constraints: BoxConstraints(),
            icon: Icon(
              Icons.settings_outlined,
              color: Theme.of(context).colorScheme.primary,
              size: 24,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Tab Bar bovenaan
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TabBar(
              controller: tabController,
              unselectedLabelColor: Theme.of(
                context,
              ).colorScheme.surface.withValues(alpha: 0.5),
              labelColor: Theme.of(context).colorScheme.primary,
              indicatorColor: Theme.of(context).colorScheme.primary,
              tabs: const [
                Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    'FUCK',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    'KISS',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    'MARRY',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          // Tab Bar View
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                // FUCK tab content
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Nieuwe matches sectie
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Nieuwe matches',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // Horizontale lijst met matches
                    SizedBox(
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 12.0),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.red.withOpacity(0.3),
                                  child: Text(
                                    'F${index + 1}',
                                    style: TextStyle(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'User $index',
                                  style: TextStyle(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.surface,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    // Chats sectie
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Chats',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // Chat lijst
                    Expanded(
                      child: ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.red.withOpacity(0.3),
                              child: Text('F'),
                            ),
                            title: Text(
                              'Fuck Chat $index',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.surface,
                              ),
                            ),
                            subtitle: Text(
                              'Last message here...',
                              style: TextStyle(
                                color: Theme.of(
                                  context,
                                ).colorScheme.surface.withValues(alpha: 0.5),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                // KISS tab content
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Nieuwe matches sectie
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Nieuwe matches',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // Horizontale lijst met matches
                    SizedBox(
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 12.0),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.pink.withOpacity(0.3),
                                  child: Text(
                                    'K${index + 1}',
                                    style: TextStyle(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'User $index',
                                  style: TextStyle(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    // Chats sectie
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Chats',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // Chat lijst
                    Expanded(
                      child: ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.pink.withOpacity(0.3),
                              child: Text('K'),
                            ),
                            title: Text(
                              'Kiss Chat $index',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            subtitle: Text(
                              'Last message here...',
                              style: TextStyle(
                                color: Theme.of(
                                  context,
                                ).colorScheme.primary.withOpacity(0.7),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                // MARRY tab content
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Nieuwe matches sectie
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Nieuwe matches',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // Horizontale lijst met matches
                    SizedBox(
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 12.0),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Theme.of(
                                    context,
                                  ).colorScheme.surface.withValues(alpha: 0.1),
                                  child: Text(
                                    'M${index + 1}',
                                    style: TextStyle(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'User $index',
                                  style: TextStyle(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    // Chats sectie
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Chats',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // Chat lijst
                    Expanded(
                      child: ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Theme.of(
                                context,
                              ).colorScheme.surface.withValues(alpha: 0.1),
                              child: Text('M'),
                            ),
                            title: Text(
                              'Marry Chat $index',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.surface,
                              ),
                            ),
                            subtitle: Text(
                              'Last message here...',
                              style: TextStyle(
                                color: Theme.of(
                                  context,
                                ).colorScheme.surface.withValues(alpha: 0.5),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
