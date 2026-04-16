import 'widgets/header.dart';
import 'widgets/search_bar.dart';
import 'widgets/chips.dart';
import 'widgets/nearby_section.dart';
import '../chat/chat_list_page.dart';

class HomePage extends StatefulWidget {  
  const HomePage({super.key});  
  
  @override  
  State<HomePage> createState() => _HomePageState();  
}  
  class _HomePageState extends State<HomePage> {
    List<String> chats = [];
    
      int currentIndex = 0;
    Map<String, List<String>> chatData = {};

    void _goToChat(String name) {
      setState(() {
        if (!chats.contains(name)) {
          chats.add(name);
        }
        currentIndex = 2;
      });
    }

    void addMessage(String name, String message) {
      if (!chatData.containsKey(name)) {
        chatData[name] = [];
      }
      setState(() {
        chatData[name]!.add(message);
      });
    }
  
  @override
  Widget build(BuildContext context) {  
    return Scaffold(  
      backgroundColor: const Color(0xFFF5F6FA),  
      bottomNavigationBar: _bottomNav(),

      body: SafeArea(
        child: _getPage(),
      ),
    );  
  }  
  
  Widget _header() {  
    return const Padding(  
      padding: EdgeInsets.fromLTRB(16, 16, 16, 8),  
      child: Column(  
        crossAxisAlignment: CrossAxisAlignment.start,  
        children: [  
          Text(  
            "Jakarta, Indonesia",  
            style: TextStyle(  
              color: Colors.grey,  
              fontSize: 12,  
            ),  
          ),  
          SizedBox(height: 4),  
          Text(  
            "Hai, Explorer 👋",  
            style: TextStyle(  
              fontSize: 22,  
              fontWeight: FontWeight.bold,  
            ),  
          ),  
        ],  
      ),  
    );  
  }  
    
  Widget _search() {  
    return Padding(  
      padding: const EdgeInsets.symmetric(horizontal: 16),  
      child: Container(  
        height: 50,  
        padding: const EdgeInsets.symmetric(horizontal: 16),  
        decoration: BoxDecoration(  
          color: Colors.white,  
          borderRadius: BorderRadius.circular(25),  
          border: Border.all(  
            color: Colors.grey.withOpacity(0.2),  
          ),  
          boxShadow: [  
            BoxShadow(  
              color: Colors.black.withOpacity(0.05),  
              blurRadius: 10,  
              offset: const Offset(0, 4),  
            ),  
          ],  
        ),  
        child: const Row(  
          children: [  
            Icon(Icons.search, color: Colors.grey),  
            SizedBox(width: 10),  
            Text(  
              "Cari orang atau minat...",  
              style: TextStyle(color: Colors.grey),  
            ),  
          ],  
        ),  
      ),  
    );  
  }  
  
  Widget _chips() {  
    final items = ["Nearby", "Design", "Coding", "Music"];  
  
    return Container(  
      margin: const EdgeInsets.only(top: 16),  
      height: 40,  
      child: ListView.builder(  
        scrollDirection: Axis.horizontal,  
        itemCount: items.length,  
        itemBuilder: (context, index) {  
          final isActive = index == 0;  
          return Container(  
            margin: const EdgeInsets.only(left: 16),  
            padding: const EdgeInsets.symmetric(horizontal: 16),  
            decoration: BoxDecoration(  
              color: isActive ? Colors.black : Colors.white,  
              borderRadius: BorderRadius.circular(20),  
              boxShadow: [  
                BoxShadow(  
                  color: Colors.black.withOpacity(0.05),  
                  blurRadius: 8,  
                  offset: const Offset(0, 3),  
                ),  
              ],  
            ),  
            alignment: Alignment.center,  
            child: Text(  
              items[index],  
              style: TextStyle(  
                color: isActive ? Colors.white : Colors.black,  
              ),  
            ),  
          );  
        },  
      ),  
    );  
  } 

Widget _homePage() {
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        HomeHeader(),
        HomeSearchBar(),
        HomeChips(),
        NearbySection(),
        SizedBox(height: 100),
      ],
    ),
  );
}

    Widget _searchPage() {
      return const Center(child: Text("Search Page"));
    }

Widget _chatPage() {
  if (chats.isEmpty) {
    return const Center(child: Text("Belum ada chat 😴"));
  }

  return ListView.builder(
    itemCount: chats.length,
    itemBuilder: (context, index) {
      final name = chats[index];

      return ListTile(
        onTap: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ChatRoomPage(
                name: name,
                messages: chatData[name] ?? [],
                onSend: (msg) => addMessage(name, msg),
              ),
            ),
          );
          setState(() {});
        },
        leading: const CircleAvatar(
          backgroundColor: Colors.black,
          child: Icon(Icons.person, color: Colors.white),
        ),
        title: Text(name),
        subtitle: const Text("Tap to chat"),
      );
    },
  );
}

    Widget _profilePage() {
      return const Center(child: Text("Profile Page"));
    }
  
    Widget _nearby() {  
      return Column(  
        crossAxisAlignment: CrossAxisAlignment.start,  
        children: [  
          const Padding(  
            padding: EdgeInsets.fromLTRB(16, 20, 16, 10),  
            child: Text(  
              "Nearby Souls ✨",  
              style: TextStyle(  
                fontWeight: FontWeight.bold,  
                fontSize: 16,  
              ),  
            ),  
          ),  
          SizedBox(  
            height: 220,  
            child: ListView.builder(  
              scrollDirection: Axis.horizontal,  
              itemCount: 5,  
              itemBuilder: (context, index) {
                final name = "User $index";
                return SizedBox(  
                  width: 150,  
                  child: GestureDetector(  
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => UserDetailPage(
                            index: index,
                            onConnect: () => _goToChat(name),
                          ),
                        ),
                      );
                    },
                    child: Container(  
                      margin: const EdgeInsets.only(left: 16, bottom: 10),  
                      decoration: BoxDecoration(
                        color: Colors.white,  
                        borderRadius: BorderRadius.circular(20),  
                        boxShadow: [  
                          BoxShadow(  
                            color: Colors.black.withOpacity(0.06),  
                            blurRadius: 12,  
                            offset: const Offset(0, 6),  
                          ),  
                        ],  
                      ),  
                      child: Stack(  
                        children: [  
                          // background  
                          Container(  
                            decoration: BoxDecoration(  
                              borderRadius: BorderRadius.circular(20),  
                              image: DecorationImage(  
                                image: NetworkImage(  
                                  "https://i.pravatar.cc/300?img=${index + 1}",  
                                ),  
                                fit: BoxFit.cover,  
                              ),  
                            ),  
                          ),  
  
                          // overlay  
                          Container(  
                            decoration: BoxDecoration(  
                              borderRadius: BorderRadius.circular(20),  
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,  
                                end: Alignment.topCenter,  
                                colors: [  
                                  Colors.black.withOpacity(0.6), 
                                  Colors.transparent,  
                                ],  
                              ),  
                            ),  
                          ),  
                          // badge  
                          Positioned(  
                            top: 10,  
                            left: 10,  
                            child: Container(  
                              padding: const EdgeInsets.symmetric(  
                                horizontal: 8, vertical: 4),  
                              decoration: BoxDecoration(  
                                color: Colors.white.withOpacity(0.2),  
                                borderRadius: BorderRadius.circular(10),  
                              ),  
                              child: const Text(  
                                "Nearby",  
                                style: TextStyle(  
                                  color: Colors.white,  
                                  fontSize: 10,  
                                ),  
                              ),  
                            ),  
                          ),  
   
                          // text  
                          Positioned(  
                            bottom: 12,  
                            left: 12,  
                            right: 12,  
                            child: Column(  
                              crossAxisAlignment: CrossAxisAlignment.start,  
                              children: [
                                Text(
                                  name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Text(
                                  "UI Designer • Bandung",
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                  ),
                                ),
                              ], 
                            ),  
                          ),  
                        ],  
                      ),  
                    ),  
                  ),  
                );  
              },  
            ),  
          ),  
        ],  
      );  
    }
  
    Widget _wipFeed() {  
      return Column(  
        crossAxisAlignment: CrossAxisAlignment.start,  
        children: [  
          const Padding(  
            padding: EdgeInsets.fromLTRB(16, 20, 16, 10),  
            child: Text(  
              "WIP Stories 🚀",  
              style: TextStyle(  
                fontWeight: FontWeight.bold,  
                fontSize: 16,  
              ),  
            ),  
          ),  
  
          _wipCard(  
            image: "https://picsum.photos/400/200",  
            name: "Rina",  
            title: "Belajar Flutter hari ke-3",  
            desc: "Masih bingung layout, tapi mulai ngerti dikit 😭",  
          ),  
  
          _wipCard(  
            image: "https://picsum.photos/401/200",  
            name: "Budi",  
            title: "Logo pertama",  
            desc: "Jelek sih, tapi progress 🔥",  
          ),  
        ],  
      );  
    }  
  
    Widget _wipCard({  
      required String image,  
        required String name,  
          required String title,  
            required String desc,  
      }) {  
      return Container(  
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),  
        decoration: BoxDecoration(  
          color: Colors.white,  
          borderRadius: BorderRadius.circular(20),  
          boxShadow: [  
            BoxShadow(  
              color: Colors.black.withOpacity(0.05),  
              blurRadius: 10,  
              offset: const Offset(0, 5),  
            ),  
          ],  
        ),  
        child: Column(  
          crossAxisAlignment: CrossAxisAlignment.start,  
          children: [  
            ClipRRect(  
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),  
              child: Image.network(
                image,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),  
            Padding(  
              padding: const EdgeInsets.all(12),  
              child: Column(  
                crossAxisAlignment: CrossAxisAlignment.start,  
                children: [  
                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 4),  
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),  
                  Text(  
                    desc,  
                    style: const TextStyle(color: Colors.grey, fontSize: 12),  
                  ),  
                ],  
              ),  
            )  
          ],  
        ),  
      );  
    }  

  Widget _getPage() {
  switch (currentIndex) {
    case 0:
      return _homePage();
    case 1:
      return _searchPage();
    case 2:
    return const ChatListPage();
    case 3:
      return _profilePage();
    default:
      return _homePage();
  }
}
  
  Widget _bottomNav() {  
    return SafeArea(  
      child: Container(  
        margin: const EdgeInsets.all(16),  
        padding: const EdgeInsets.symmetric(horizontal: 20),  
        height: 70,  
        decoration: BoxDecoration(  
          color: Colors.white,        
          borderRadius: BorderRadius.circular(30),  
          boxShadow: [  
            BoxShadow(  
              color: Colors.black.withOpacity(0.08),  
              blurRadius: 20,  
              offset: const Offset(0, 10),  
            ),  
          ],  
        ),  
        child: Row(  
          mainAxisAlignment: MainAxisAlignment.spaceBetween,  
          children: [  
            IconButton(  
              onPressed: () {  
                setState(() => currentIndex = 0);  
              },  
              icon: Icon(  
                Icons.home,  
                color: currentIndex == 0 ? Colors.black : Colors.grey,  
              ),  
            ),  
            IconButton(  
              onPressed: () {  
                setState(() => currentIndex = 1);  
              },  
              icon: Icon(  
                Icons.search,  
                color: currentIndex == 1 ? Colors.black : Colors.grey,  
              ),  
            ),  
            // tombol tengah  
            Container(
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: IconButton(
                onPressed: () {
                  print("Add clicked");
                },
                icon: const Icon(Icons.add, color: Colors.white),
              ),
            ), 
  
            IconButton(  
              onPressed: () {  
                setState(() => currentIndex = 2);  
              },  
              icon: Icon(  
                Icons.chat_bubble_outline,  
                color: currentIndex == 2 ? Colors.black : Colors.grey,  
              ),  
            ),  
            IconButton(  
              onPressed: () {  
                setState(() => currentIndex = 3);  
              },  
              icon: Icon(  
                Icons.person_outline,  
                color: currentIndex == 3 ? Colors.black : Colors.grey,  
              ),  
            ),  
          ],  
        ),  
      ),  
    );  
  }
}