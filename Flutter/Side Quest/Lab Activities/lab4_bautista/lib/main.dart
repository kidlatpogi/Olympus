import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  static const List<String> _labels = ['Home', 'Search', 'Settings'];
  final List<String> _outlineButtons = ['NU Quest', 'NUIS', 'NU Bills'];
  final List<String> _cardLabels = [
    'Card 1',
    'Card 2',
    'Card 3',
    'Card 4',
    'Card 5',
    'Card 6',
  ];
  
  // National University campus photo URLs
  final List<String> _nuCampusPhotos = [
    'https://images.unsplash.com/photo-1562774053-701939374585?w=800&q=80', // Campus building 1
    'https://images.unsplash.com/photo-1541339907198-e08756dedf3f?w=800&q=80', // Campus building 2
    'https://images.unsplash.com/photo-1498243691581-b145c3f54a5a?w=800&q=80', // Campus building 3
    'https://images.unsplash.com/photo-1576495199011-eb94736d05d6?w=800&q=80', // Campus building 4 (updated)
    'https://images.unsplash.com/photo-1564981797816-1043664bf78d?w=800&q=80', // Campus building 5
    'https://images.unsplash.com/photo-1607237138185-eedd9c632b0b?w=800&q=80', // Campus building 6
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Layout Widgets - Zeus Bautista')),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      child: const Text(
                        'Dashboard',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.notifications_outlined),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _outlineButtonsRow(),
                const SizedBox(height: 18),
                Container(
                  width: double.infinity,
                  height: 180,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey[700],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(
                          'https://tse1.mm.bing.net/th/id/OIP.HXNNBYOwv1TWzkgPmL5LcAHaE7?rs=1&pid=ImgDetMain&o=7&rm=3',
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return const Center(child: CircularProgressIndicator());
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(
                              child: Icon(
                                Icons.broken_image,
                                color: Colors.white70,
                              ),
                            );
                          },
                        ),
                        // Text overlay
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withOpacity(0.3),
                                Colors.black.withOpacity(0.6),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: 20,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: Text(
                              'National University',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    offset: Offset(2, 2),
                                    blurRadius: 4,
                                    color: Colors.black.withOpacity(0.8),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                ..._buildCardRows(),
                const SizedBox(height: 12),
                // Bottom Navigation Bar
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (idx) => setState(() => _selectedIndex = idx),
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.black54,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }

  // build outline buttons row
  Widget _outlineButtonsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(_outlineButtons.length * 2 - 1, (index) {
        if (index.isEven) {
          final i = index ~/ 2;
          return _roundedOutlineButton(_outlineButtons[i]);
        }
        return const SizedBox(width: 12);
      }),
    );
  }

  // build card rows (pairs)
  List<Widget> _buildCardRows() {
    final rows = <Widget>[];
    for (var i = 0; i < _cardLabels.length; i += 2) {
      final left = _cardLabels[i];
      final right = (i + 1) < _cardLabels.length ? _cardLabels[i + 1] : '';
      rows.add(
        Row(
          children: [
            _buildCard(
              left,
              Colors.lightBlue[50]!,
              const EdgeInsets.only(right: 8, bottom: 16), // same bottom
            ),
            if (right.isNotEmpty)
              _buildCard(
                right,
                Colors.lightBlue[300]!,
                const EdgeInsets.only(left: 8, bottom: 16), // same bottom
              )
            else
              const Expanded(child: SizedBox()),
          ],
        ),
      );
    }
    return rows;
  }

  Widget _roundedOutlineButton(String label) {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Colors.grey),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      ),
      child: Text(label, style: const TextStyle(color: Colors.black87)),
    );
  }

  // Helper to build a card as an Expanded widget with NetworkImage
  Expanded _buildCard(String label, Color bgColor, EdgeInsets margin) {
    // Extract card number from label (e.g., "Card 1" -> 0)
    final cardIndex = int.tryParse(label.replaceAll('Card ', ''));
    final photoUrl = (cardIndex != null && cardIndex > 0 && cardIndex <= _nuCampusPhotos.length)
        ? _nuCampusPhotos[cardIndex - 1]
        : null;

    return Expanded(
      child: Container(
        height: 140,
        margin: margin,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: photoUrl != null
              ? Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      photoUrl,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Center(
                          child: Icon(
                            Icons.broken_image,
                            color: Colors.grey[400],
                          ),
                        );
                      },
                    ),
                    // Semi-transparent overlay for better text visibility
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.4),
                          ],
                        ),
                      ),
                    ),
                    // Label text
                    Positioned(
                      bottom: 8,
                      left: 8,
                      child: Text(
                        label,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              offset: Offset(1, 1),
                              blurRadius: 3,
                              color: Colors.black.withOpacity(0.7),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              : Center(
                  child: Text(
                    label,
                    style: TextStyle(
                      color: bgColor.computeLuminance() > 0.5
                          ? Colors.black87
                          : Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
