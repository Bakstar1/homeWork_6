import 'package:flutter/material.dart';

class TelegramApp extends StatefulWidget {
  const TelegramApp({super.key});

  @override
  State<TelegramApp> createState() => _TelegramAppState();
}

class _TelegramAppState extends State<TelegramApp> {
  bool isDarkTheme = false;

  void changeTheme(bool value) {
    setState(() {
      isDarkTheme = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // ТЕМА

      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,

        colorScheme: const ColorScheme.light(primary: Color(0xFF2AABEE)),

        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
        ),

        drawerTheme: const DrawerThemeData(backgroundColor: Colors.white),

        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Color(0xFF2AABEE),
          unselectedItemColor: Colors.grey,
        ),
      ),

      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,

        colorScheme: const ColorScheme.dark(primary: Color(0xFF2AABEE)),

        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF212121),
          surfaceTintColor: Colors.transparent,
        ),

        drawerTheme: const DrawerThemeData(backgroundColor: Color(0xFF212121)),

        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Color(0xFF2AABEE),
          unselectedItemColor: Colors.grey,
        ),
      ),

      themeMode: isDarkTheme ? ThemeMode.dark : ThemeMode.light,

      home: HomePage(isDarkTheme: isDarkTheme, onThemeChanged: changeTheme),
    );
  }
}

// главная страницв

class HomePage extends StatefulWidget {
  final bool isDarkTheme;
  final Function(bool) onThemeChanged;

  const HomePage({
    super.key,
    required this.isDarkTheme,
    required this.onThemeChanged,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  final List<String> titles = ['Telegram', 'Звонки', 'Контакты'];

  // чаты

  final List<Map<String, dynamic>> chats = [
    {
      'name': 'T-800',
      'phone': '+996 555 123 456',
      'message': "I'll be back",
      'time': '17:20',
      'avatar': 'images/aaa.jpg',
      'color': Colors.blue,
      'unread': 2,
    },
    {
      'name': 'Ваня',
      'phone': '+996 700 456 789',
      'message': 'И тебя вылечат, и меня вылечат...',
      'time': '16:45',
      'avatar': 'images/Ivan.jpeg',
      'color': Colors.green,
      'unread': 0,
    },
    {
      'name': 'Соня',
      'phone': '+996 502 111 222',
      'message': 'Посмотри это видео 😄',
      'time': '15:32',
      'avatar': 'images/IMG_1704.jpeg',
      'color': Colors.teal,
      'unread': 4,
    },
    {
      'name': 'Стивен Кинг',
      'phone': '+996 555 987 654',
      'message': 'А ВОТ И ДЖОННИ!!!',
      'time': '14:10',
      'avatar': 'images/King.jpeg',
      'color': Colors.orange,
      'unread': 0,
    },
    {
      'name': 'живой Шон Бин',
      'phone': '+996 777 333 111',
      'message': 'Нельзя просто так взять и не сделать домашку',
      'time': '13:28',
      'avatar': 'images/Bor.jpeg',
      'color': Colors.purple,
      'unread': 1,
    },
  ];

  // звонки

  final List<Map<String, dynamic>> calls = [
    {
      'name': 'T-800',
      'phone': '+996 555 123 456',
      'avatar': 'images/aaa.jpg',
      'color': Colors.blue,
      'type': 'Пропущенный',
      'icon': Icons.call_received,
      'time': '17:10',
      'missed': true,
    },
    {
      'name': 'Соня',
      'phone': '+996 502 111 222',
      'avatar': 'images/IMG_1704.jpeg',
      'color': Colors.pink,
      'type': 'Входящий',
      'icon': Icons.call_received,
      'time': '15:45',
      'missed': false,
    },
    {
      'name': 'Живой Шон Бин',
      'phone': '+996 700 456 789',
      'avatar': 'images/Bor.jpeg',
      'color': Colors.green,
      'type': 'Исходящий',
      'icon': Icons.call_made,
      'time': '14:20',
      'missed': false,
    },
  ];

  // контакты

  final List<Map<String, dynamic>> contacts = [
    {
      'name': 'T-800',
      'phone': '+996 555 123 456',
      'avatar': 'images/aaa.jpg',
      'color': Colors.blue,
    },
    {
      'name': 'Cоня',
      'phone': '+996 502 111 222',
      'avatar': 'images/IMG_1704.jpeg',
      'color': Colors.pink,
    },
    {
      'name': 'Живой Шон Бин',
      'phone': '+996 700 456 789',
      'avatar': 'images/Bor.jpeg',
      'color': Colors.green,
    },
    {
      'name': 'Стивен Кинг',
      'phone': '+996 555 777 888',
      'avatar': 'images/King.jpeg',
      'color': Colors.teal,
    },
    {
      'name': 'Ваня',
      'phone': '+996 555 987 654',
      'avatar': 'images/Ivan.jpeg',
      'color': Colors.orange,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          titles[currentIndex],
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),

        actions: [
          if (currentIndex == 0)
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: ChatSearchDelegate(chats),
                );
              },
            ),
        ],
      ),
      drawer: AppDrawer(
        isDarkTheme: widget.isDarkTheme,
        onThemeChanged: widget.onThemeChanged,
        onChatsPressed: () {
          setState(() {
            currentIndex = 0;
          });
          Navigator.pop(context);
        },
        onCallsPressed: () {
          setState(() {
            currentIndex = 1;
          });
          Navigator.pop(context);
        },
        onContactsPressed: () {
          setState(() {
            currentIndex = 2;
          });
          Navigator.pop(context);
        },
      ),
      body: IndexedStack(
        index: currentIndex,

        children: [
          ChatsPage(chats: chats),
          CallsPage(calls: calls),
          ContactsPage(contacts: contacts),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,

        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            activeIcon: Icon(Icons.chat_bubble),
            label: 'Чаты',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.call_outlined),
            activeIcon: Icon(Icons.call),
            label: 'Звонки',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.contacts_outlined),
            activeIcon: Icon(Icons.contacts),
            label: 'Контакты',
          ),
        ],
      ),

      // тут кнопка нового сооьщения
      floatingActionButton: currentIndex == 0
          ? FloatingActionButton(
              backgroundColor: const Color(0xFF2AABEE),

              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Новое сообщение')),
                );
              },

              child: const Icon(Icons.edit, color: Colors.white),
            )
          : null,
    );
  }
}

// страница чатов

class ChatsPage extends StatelessWidget {
  final List<Map<String, dynamic>> chats;

  const ChatsPage({super.key, required this.chats});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: chats.length,

      itemBuilder: (context, index) {
        final chat = chats[index];

        return ChatTile(
          name: chat['name'],
          message: chat['message'],
          time: chat['time'],
          avatar: chat['avatar'],
          color: chat['color'],
          unread: chat['unread'],

          onTap: () {
            Navigator.push(
              context,

              MaterialPageRoute(
                builder: (_) => ChatPage(
                  name: chat['name'],
                  phone: chat['phone'],
                  avatar: chat['avatar'],
                  color: chat['color'],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class ChatTile extends StatelessWidget {
  final String name;
  final String message;
  final String time;
  final String avatar;
  final Color color;
  final int unread;
  final VoidCallback onTap;

  const ChatTile({
    super.key,
    required this.name,
    required this.message,
    required this.time,
    required this.avatar,
    required this.color,
    required this.unread,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),

      leading: CircleAvatar(
        radius: 28,
        backgroundColor: color,
        backgroundImage: AssetImage(avatar),
      ),

      title: Text(
        name,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),

      subtitle: Text(message, maxLines: 1, overflow: TextOverflow.ellipsis),

      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,

        children: [
          Text(
            time,
            style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
          ),

          const SizedBox(height: 6),

          if (unread > 0)
            Container(
              width: 22,
              height: 22,

              alignment: Alignment.center,

              decoration: const BoxDecoration(
                color: Color(0xFF2AABEE),
                shape: BoxShape.circle,
              ),

              child: Text(
                '$unread',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),

      onTap: onTap,
    );
  }
}

// звонки

class CallsPage extends StatelessWidget {
  final List<Map<String, dynamic>> calls;

  const CallsPage({super.key, required this.calls});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: calls.length,

      itemBuilder: (context, index) {
        final call = calls[index];

        return ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 5,
          ),

          leading: CircleAvatar(
            radius: 27,

            backgroundColor: call['color'],

            backgroundImage: AssetImage(call['avatar']),
          ),

          title: Text(
            call['name'],

            style: TextStyle(
              fontWeight: FontWeight.bold,

              color: call['missed'] == true ? Colors.red : null,
            ),
          ),

          subtitle: Row(
            children: [
              Icon(
                call['icon'],

                size: 17,

                color: call['missed'] == true ? Colors.red : Colors.green,
              ),

              const SizedBox(width: 5),

              Text(call['type']),
            ],
          ),

          trailing: Text(
            call['time'],

            style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
          ),

          onTap: () {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Звонок: ${call['name']}')));
          },
        );
      },
    );
  }
}

// контакты

class ContactsPage extends StatelessWidget {
  final List<Map<String, dynamic>> contacts;

  const ContactsPage({super.key, required this.contacts});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: contacts.length + 1,

      itemBuilder: (context, index) {
        // Кнопка добавления контакта
        if (index == 0) {
          return ListTile(
            leading: const CircleAvatar(
              backgroundColor: Color(0xFF2AABEE),

              child: Icon(Icons.person_add, color: Colors.white),
            ),

            title: const Text(
              'Добавить контакт',

              style: TextStyle(
                color: Color(0xFF2AABEE),
                fontWeight: FontWeight.bold,
              ),
            ),

            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Добавление контакта')),
              );
            },
          );
        }

        final contact = contacts[index - 1];

        return ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 5,
          ),

          leading: CircleAvatar(
            radius: 27,

            backgroundColor: contact['color'],

            backgroundImage: AssetImage(contact['avatar']),
          ),

          title: Text(
            contact['name'],

            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),

          subtitle: Text(contact['phone']),

          onTap: () {
            Navigator.push(
              context,

              MaterialPageRoute(
                builder: (_) => ChatPage(
                  name: contact['name'],
                  phone: contact['phone'],
                  avatar: contact['avatar'],
                  color: contact['color'],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class AppDrawer extends StatelessWidget {
  final bool isDarkTheme;
  final Function(bool) onThemeChanged;

  final VoidCallback onChatsPressed;
  final VoidCallback onCallsPressed;
  final VoidCallback onContactsPressed;

  const AppDrawer({
    super.key,
    required this.isDarkTheme,
    required this.onThemeChanged,
    required this.onChatsPressed,
    required this.onCallsPressed,
    required this.onContactsPressed,
  });

  @override
  Widget build(BuildContext context) {
    const telegramBlue = Color(0xFF2AABEE);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,

        children: [
          // мой профиль :D

          Container(
            height: 190,

            padding: const EdgeInsets.all(16),

            decoration: const BoxDecoration(color: telegramBlue),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              mainAxisAlignment: MainAxisAlignment.end,

              children: const [
                CircleAvatar(
                  radius: 32,

                  backgroundImage: AssetImage('images/Kaykong.jpg'),
                ),

                SizedBox(height: 12),

                Text(
                  'Бакыт',

                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text('+996 500 332 628', style: TextStyle(color: Colors.white)),
              ],
            ),
          ),

          ListTile(
            leading: const Icon(Icons.chat),

            title: const Text('Чаты'),

            onTap: onChatsPressed,
          ),

          ListTile(
            leading: const Icon(Icons.call),

            title: const Text('Звонки'),

            onTap: onCallsPressed,
          ),

          ListTile(
            leading: const Icon(Icons.contacts),

            title: const Text('Контакты'),

            onTap: onContactsPressed,
          ),

          const Divider(),

          SwitchListTile(
            secondary: Icon(isDarkTheme ? Icons.dark_mode : Icons.light_mode),

            title: Text(isDarkTheme ? 'Тёмная тема' : 'Светлая тема'),

            value: isDarkTheme,

            onChanged: onThemeChanged,
          ),

          ListTile(
            leading: const Icon(Icons.settings),

            title: const Text('Настройки'),

            onTap: () {
              Navigator.pop(context);

              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text('Настройки')));
            },
          ),
        ],
      ),
    );
  }
}

// СТРАНИЦА ЧАТА

class ChatPage extends StatefulWidget {
  final String name;
  final String phone;
  final String avatar;
  final Color color;

  const ChatPage({
    super.key,
    required this.name,
    required this.phone,
    required this.avatar,
    required this.color,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController messageController = TextEditingController();

  final List<Map<String, dynamic>> messages = [
    {'text': 'Хай', 'me': false},
    {'text': 'Хай', 'me': true},
    {'text': 'Че каво?', 'me': false},
    {'text': 'Нормас', 'me': true},
  ];

  void sendMessage() {
    final text = messageController.text.trim();

    if (text.isEmpty) {
      return;
    }

    setState(() {
      messages.add({'text': text, 'me': true});
    });

    messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,

        title: Row(
          children: [
            CircleAvatar(
              radius: 20,

              backgroundColor: widget.color,

              backgroundImage: AssetImage(widget.avatar),
            ),

            const SizedBox(width: 10),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  widget.name,

                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text(
                  'был(а) недавно',

                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
              ],
            ),
          ],
        ),

        actions: [
          IconButton(
            icon: const Icon(Icons.call),

            onPressed: () {
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text('Звонок')));
            },
          ),

          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),

      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),

              itemCount: messages.length,

              itemBuilder: (context, index) {
                final message = messages[index];

                return MessageBubble(
                  text: message['text'],
                  isMe: message['me'],
                );
              },
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),

            color: Theme.of(context).scaffoldBackgroundColor,

            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.attach_file, color: Colors.grey),

                  onPressed: () {},
                ),

                Expanded(
                  child: TextField(
                    controller: messageController,

                    textInputAction: TextInputAction.send,

                    onSubmitted: (_) {
                      sendMessage();
                    },

                    decoration: InputDecoration(
                      hintText: 'Сообщение',

                      filled: true,

                      fillColor: Theme.of(context).colorScheme.surface,

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),

                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 5),

                CircleAvatar(
                  backgroundColor: const Color(0xFF2AABEE),

                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white, size: 20),

                    onPressed: sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// сообщение в чате

class MessageBubble extends StatelessWidget {
  final String text;
  final bool isMe;

  const MessageBubble({super.key, required this.text, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,

      child: Container(
        margin: const EdgeInsets.only(bottom: 8),

        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),

        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),

        decoration: BoxDecoration(
          color: isMe
              ? const Color(0xFFDCF8C6)
              : Theme.of(context).colorScheme.surfaceContainerHighest,

          borderRadius: BorderRadius.circular(18),
        ),

        child: Text(text, style: const TextStyle(fontSize: 15)),
      ),
    );
  }
}

// Тут добавлен поисковик

class ChatSearchDelegate extends SearchDelegate<Map<String, dynamic>> {
  final List<Map<String, dynamic>> chats;

  ChatSearchDelegate(this.chats);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),

        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),

      onPressed: () {
        close(context, {});
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSearchList();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildSearchList();
  }

  Widget buildSearchList() {
    final results = chats.where((chat) {
      final name = chat['name'].toString().toLowerCase();

      return name.contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: results.length,

      itemBuilder: (context, index) {
        final chat = results[index];

        return ListTile(
          leading: CircleAvatar(
            backgroundColor: chat['color'],

            backgroundImage: AssetImage(chat['avatar']),
          ),

          title: Text(chat['name']),

          subtitle: Text(chat['message']),

          onTap: () {
            close(context, chat);
          },
        );
      },
    );
  }
}
