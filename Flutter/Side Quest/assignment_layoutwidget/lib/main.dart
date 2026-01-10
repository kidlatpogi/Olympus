import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Teams',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const TeamsPage(),
    );
  }
}

class TeamsPage extends StatelessWidget {
  const TeamsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Left Sidebar Navigation
          Container(
            width: 68,
            color: Color(0xFFF3F2F1),
            child: Column(
              children: [
                SizedBox(height: 8),
                // Teams Icon (Active)
                Container(
                  margin: EdgeInsets.symmetric(vertical: 4),
                  child: Material(
                    color: Color(0xFF6264A7),
                    borderRadius: BorderRadius.circular(4),
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        width: 52,
                        height: 52,
                        child: Icon(Icons.grid_view, size: 24, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                // Chat Icon
                Container(
                  margin: EdgeInsets.symmetric(vertical: 4),
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      width: 52,
                      height: 52,
                      child: Icon(Icons.chat_bubble_outline, size: 24, color: Colors.grey),
                    ),
                  ),
                ),
                // People Icon
                Container(
                  margin: EdgeInsets.symmetric(vertical: 4),
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      width: 52,
                      height: 52,
                      child: Icon(Icons.people_outline, size: 24, color: Colors.grey),
                    ),
                  ),
                ),
                // Calendar Icon
                Container(
                  margin: EdgeInsets.symmetric(vertical: 4),
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      width: 52,
                      height: 52,
                      child: Icon(Icons.calendar_today_outlined, size: 24, color: Colors.grey),
                    ),
                  ),
                ),
                // Phone Icon
                Container(
                  margin: EdgeInsets.symmetric(vertical: 4),
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      width: 52,
                      height: 52,
                      child: Icon(Icons.phone_outlined, size: 24, color: Colors.grey),
                    ),
                  ),
                ),
                // Files Icon
                Container(
                  margin: EdgeInsets.symmetric(vertical: 4),
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      width: 52,
                      height: 52,
                      child: Icon(Icons.folder_outlined, size: 24, color: Colors.grey),
                    ),
                  ),
                ),
                Divider(height: 1),
                // Apps Icon
                Container(
                  margin: EdgeInsets.symmetric(vertical: 4),
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      width: 52,
                      height: 52,
                      child: Icon(Icons.apps, size: 24, color: Colors.grey),
                    ),
                  ),
                ),
                Spacer(),
                // Help Icon
                Container(
                  margin: EdgeInsets.symmetric(vertical: 4),
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      width: 52,
                      height: 52,
                      child: Icon(Icons.help_outline, size: 24, color: Colors.grey),
                    ),
                  ),
                ),
                // Settings Icon
                Container(
                  margin: EdgeInsets.symmetric(vertical: 4),
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      width: 52,
                      height: 52,
                      child: Icon(Icons.settings_outlined, size: 24, color: Colors.grey),
                    ),
                  ),
                ),
                SizedBox(height: 8),
              ],
            ),
          ),
          
          // Main Content Area
          Expanded(
            child: Column(
              children: [
                // Top Header Bar
                Container(
                  height: 60,
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom: BorderSide(color: Colors.grey.shade300, width: 1),
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Teams',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        icon: Icon(Icons.more_horiz, size: 20),
                        onPressed: () {},
                        color: Colors.black54,
                      ),
                      SizedBox(width: 8),
                      OutlinedButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.people_outline, size: 18),
                        label: Text('Join or create team'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.black87,
                          side: BorderSide(color: Colors.grey.shade400),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Content Section
                Expanded(
                  child: Container(
                    color: Color(0xFFFAF9F8),
                    padding: EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Classes Header
                        Row(
                          children: [
                            Icon(Icons.keyboard_arrow_down, size: 20, color: Colors.grey.shade700),
                            SizedBox(width: 4),
                            Text(
                              'Classes',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.shade800,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        
                        // Grid of Class Cards
                        Expanded(
                          child: GridView.count(
                            crossAxisCount: 3,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 1.8,
                            children: [
                              // Card 1
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(color: Colors.grey.shade300, width: 1),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(12),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color: Color(0xFF5B5FC7),
                                              borderRadius: BorderRadius.circular(4),
                                            ),
                                            child: Icon(
                                              Icons.description,
                                              color: Colors.white,
                                              size: 24,
                                            ),
                                          ),
                                          SizedBox(width: 8),
                                          Flexible(
                                            child: Text(
                                              'JCB_CTMOBPGL_INF223',
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black87,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          SizedBox(width: 4),
                                          IconButton(
                                            icon: Icon(Icons.more_horiz, size: 18),
                                            onPressed: () {},
                                            color: Colors.grey.shade600,
                                            padding: EdgeInsets.zero,
                                            constraints: BoxConstraints(),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Spacer(),
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                      child: Row(
                                        children: [
                                          Icon(Icons.toc_sharp, size: 18, color: Colors.grey.shade600),
                                          SizedBox(width: 12),
                                          Icon(Icons.backpack_outlined, size: 18, color: Colors.grey.shade600),
                                          SizedBox(width: 12),
                                          Icon(Icons.menu_book_outlined, size: 18, color: Colors.grey.shade600),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              
                              // Card 2
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(color: Colors.grey.shade300, width: 1),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(12),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color: Color(0xFF5B5FC7),
                                              borderRadius: BorderRadius.circular(4),
                                            ),
                                            child: Icon(
                                              Icons.description,
                                              color: Colors.white,
                                              size: 24,
                                            ),
                                          ),
                                          SizedBox(width: 8),
                                          Flexible(
                                            child: Text(
                                              'JCB_CTMOBPGL_INF223',
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black87,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          SizedBox(width: 4),
                                          IconButton(
                                            icon: Icon(Icons.more_horiz, size: 18),
                                            onPressed: () {},
                                            color: Colors.grey.shade600,
                                            padding: EdgeInsets.zero,
                                            constraints: BoxConstraints(),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Spacer(),
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                      child: Row(
                                        children: [
                                          Icon(Icons.toc_sharp, size: 18, color: Colors.grey.shade600),
                                          SizedBox(width: 12),
                                          Icon(Icons.backpack_outlined, size: 18, color: Colors.grey.shade600),
                                          SizedBox(width: 12),
                                          Icon(Icons.menu_book_outlined, size: 18, color: Colors.grey.shade600),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              
                              // Card 3
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(color: Colors.grey.shade300, width: 1),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(12),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color: Color(0xFF5B5FC7),
                                              borderRadius: BorderRadius.circular(4),
                                            ),
                                            child: Icon(
                                              Icons.description,
                                              color: Colors.white,
                                              size: 24,
                                            ),
                                          ),
                                          SizedBox(width: 8),
                                          Flexible(
                                            child: Text(
                                              'JCB_CTSYSINI_INF223',
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black87,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          SizedBox(width: 4),
                                          IconButton(
                                            icon: Icon(Icons.more_horiz, size: 18),
                                            onPressed: () {},
                                            color: Colors.grey.shade600,
                                            padding: EdgeInsets.zero,
                                            constraints: BoxConstraints(),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Spacer(),
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                      child: Row(
                                        children: [
                                          Icon(Icons.toc_sharp, size: 18, color: Colors.grey.shade600),
                                          SizedBox(width: 12),
                                          Icon(Icons.backpack_outlined, size: 18, color: Colors.grey.shade600),
                                          SizedBox(width: 12),
                                          Icon(Icons.menu_book_outlined, size: 18, color: Colors.grey.shade600),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              
                              // Card 4
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(color: Colors.grey.shade300, width: 1),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(12),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color: Color(0xFF5B5FC7),
                                              borderRadius: BorderRadius.circular(4),
                                            ),
                                            child: Icon(
                                              Icons.description,
                                              color: Colors.white,
                                              size: 24,
                                            ),
                                          ),
                                          SizedBox(width: 8),
                                          Flexible(
                                            child: Text(
                                              'JCB_CCPRBGL1_CDAM2',
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black87,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          SizedBox(width: 4),
                                          IconButton(
                                            icon: Icon(Icons.more_horiz, size: 18),
                                            onPressed: () {},
                                            color: Colors.grey.shade600,
                                            padding: EdgeInsets.zero,
                                            constraints: BoxConstraints(),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Spacer(),
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                      child: Row(
                                        children: [
                                          Icon(Icons.toc_sharp, size: 18, color: Colors.grey.shade600),
                                          SizedBox(width: 12),
                                          Icon(Icons.backpack_outlined, size: 18, color: Colors.grey.shade600),
                                          SizedBox(width: 12),
                                          Icon(Icons.menu_book_outlined, size: 18, color: Colors.grey.shade600),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              
                              // Card 5
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(color: Colors.grey.shade300, width: 1),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(12),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color: Color(0xFF5B5FC7),
                                              borderRadius: BorderRadius.circular(4),
                                            ),
                                            child: Icon(
                                              Icons.description,
                                              color: Colors.white,
                                              size: 24,
                                            ),
                                          ),
                                          SizedBox(width: 8),
                                          Flexible(
                                            child: Text(
                                              'JCB_CTMOBPGL_INF222',
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black87,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          SizedBox(width: 4),
                                          IconButton(
                                            icon: Icon(Icons.more_horiz, size: 18),
                                            onPressed: () {},
                                            color: Colors.grey.shade600,
                                            padding: EdgeInsets.zero,
                                            constraints: BoxConstraints(),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Spacer(),
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                      child: Row(
                                        children: [
                                          Icon(Icons.toc_sharp, size: 18, color: Colors.grey.shade600),
                                          SizedBox(width: 12),
                                          Icon(Icons.backpack_outlined, size: 18, color: Colors.grey.shade600),
                                          SizedBox(width: 12),
                                          Icon(Icons.menu_book_outlined, size: 18, color: Colors.grey.shade600),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        SizedBox(height: 16),
                        
                        // Teams Section
                        Row(
                          children: [
                            Icon(Icons.keyboard_arrow_right, size: 20, color: Colors.grey.shade700),
                            SizedBox(width: 4),
                            Text(
                              'Teams',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.shade800,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
