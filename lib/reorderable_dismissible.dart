import 'package:flutter/material.dart';
import '../model/movie.dart'; // ใช้ Movie model และข้อมูลหนัง 50 เรื่องของคุณ

class ReorderableDismissibleList extends StatefulWidget {
  const ReorderableDismissibleList({super.key});

  @override
  State<ReorderableDismissibleList> createState() => _ReorderableDismissibleListState();
}

class _ReorderableDismissibleListState extends State<ReorderableDismissibleList> {
  
  // ใช้ข้อมูลหนัง 6 เรื่องเดิมของคุณ
  // *ข้อสังเกต: หากคุณต้องการ 50 เรื่อง ให้เพิ่มข้อมูลต่อจาก m6 ในโครงสร้างนี้
  final List<Movie> _movies = [
    Movie(
      id: 'm1',
      title: 'The Shawshank Redemption',
      posterUrl: 'https://blog-static.kkday.com/th/blog/wp-content/uploads/Screen-Shot-2565-09-23-at-10.47.02.jpg',
      year: '1994', // ปีจะถูกใช้แทนชื่อศิลปิน
      rating: 9.3,
    ),
    Movie(
      id: 'm2',
      title: 'The Godfather',
      posterUrl: 'https://cdn.britannica.com/55/188355-050-D5E49258-v2.jpg',
      year: '1972',
      rating: 9.2,
    ),
    Movie(
      id: 'm3',
      title: 'The Dark Knight',
      posterUrl: 'https://upload.wikimedia.org/wikipedia/en/1/1c/The_Dark_Knight_%282008_film%29.jpg',
      year: '2008',
      rating: 9.0,
    ),
    Movie(
      id: 'm4',
      title: 'Pulp Fiction',
      posterUrl: 'https://upload.wikimedia.org/wikipedia/en/3/3b/Pulp_Fiction_%281994%29_poster.jpg',
      year: '1994',
      rating: 8.9,
    ),
    Movie(
      id: 'm5',
      title: 'Schindler\'s List',
      posterUrl: 'https://cdn11.bigcommerce.com/s-gjd9kmzlkz/images/stencil/1280x1280/products/23950/23716/9780671880316__65698.1607045821.jpg?c=1',
      year: '1993',
      rating: 8.9,
    ),
    Movie(
      id: 'm6',
      title: 'The Lord of the Rings: The Return of the King',
      posterUrl: 'https://files.thaiware.site/movie/2025-05/images-poster/250520120440phY.jpg',
      year: '2003',
      rating: 8.9,
    ), ];

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) newIndex -= 1;
      final movie = _movies.removeAt(oldIndex);
      _movies.insert(newIndex, movie);
    });
  }

  void _onDismissed(int index) {
    final movie = _movies[index];
    setState(() {
      _movies.removeAt(index);
    });
    // แสดง SnackBar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Removed ${movie.title} from list'),
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: () {
            setState(() {
              _movies.insert(index, movie);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // ปรับ AppBar ให้คล้ายภาพตัวอย่างมากขึ้น
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {},
        ),
        title: const Text('Open Dancing Music', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.download, color: Colors.blue),
            onPressed: () {},
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                // Tabs
                TextButton(
                  onPressed: () {},
                  child: const Text('Songs (50)', style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold)),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Questions (128)', style: TextStyle(color: Colors.grey)),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Notes', style: TextStyle(color: Colors.grey)),
                ),
              ],
            ),
          ),
        ),
      ),
      // ปุ่มลอยด้านขวาล่าง
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: "btn1",
            mini: true,
            backgroundColor: Colors.white,
            foregroundColor: Colors.red,
            onPressed: () {},
            child: const Icon(Icons.delete),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: "btn2",
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            onPressed: () {},
            child: const Icon(Icons.add),
          ),
        ],
      ),
      body: ReorderableListView.builder(
        padding: const EdgeInsets.only(top: 10, bottom: 80, left: 0, right: 16),
        buildDefaultDragHandles: false,
        itemCount: _movies.length, 
        onReorder: _onReorder,
        
        itemBuilder: (context, index) {
          final movie = _movies[index];
          
          // ปรับ Dismissible Background ให้ตรงกับภาพ (สีแดงที่ด้านขวา)
          return Dismissible(
            key: ValueKey(movie.id), 
            direction: DismissDirection.endToStart,
            
            background: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20),
              color: Colors.red.shade700,
              child: const Icon(Icons.delete_forever, color: Colors.white),
            ),
            
            onDismissed: (_) => _onDismissed(index),
            
            // ใช้ Padding แทน Container เพื่อให้รายการดูเป็นธรรมชาติ
            child: Padding(
              key: ValueKey(movie.id), // Key ต้องอยู่ที่นี่ด้วยเพื่อให้ ReorderableListView ทำงาน
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Reorder Icon (ซ้ายสุด)
                  ReorderableDragStartListener(
                    index: index,
                    child: const Padding(
                      padding: EdgeInsets.only(left: 16, right: 10, top: 12),
                      child: Icon(Icons.cached, color: Colors.purple), // ใช้ Icon ที่คล้ายกับ Reorder/Sync
                    ),
                  ),

                  // 2. ลำดับที่ (ตรงกลางซ้าย)
                  Container(
                    width: 30,
                    alignment: Alignment.topRight,
                    padding: const EdgeInsets.only(right: 4, top: 16),
                    child: Text(
                      '${index + 1}',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ),

                  // 3. เนื้อหาหลัก: รูปภาพและข้อความ
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // รูปภาพ (คล้ายกับ Leading)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5.0),
                          child: Image.network(
                            movie.posterUrl,
                            width: 50, 
                            height: 70,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => 
                                const SizedBox(
                                  width: 50, 
                                  height: 70,
                                  child: Icon(Icons.movie, size: 30, color: Colors.grey)
                                ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        
                        // ชื่อเพลง (Title) & ศิลปิน (Subtitle)
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  movie.title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.black,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  // ใช้ Year เป็น Subtitle แทนชื่อศิลปิน
                                  'Year: ${movie.year}', 
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // 4. Action Icon (หัวใจ/ถังขยะ) - ขวาสุด
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 10, right: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.favorite, 
                          color: (index % 2 == 0) ? Colors.red : Colors.red, // หัวใจ
                          size: 20,
                        ),
                        const SizedBox(height: 3),
                        Text(
                          '${movie.rating.toInt()}', // ใช้ rating เป็นตัวเลขหัวใจ
                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}