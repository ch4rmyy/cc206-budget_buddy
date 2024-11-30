import 'package:flutter/material.dart';
import 'package:very_good_infinite_list/very_good_infinite_list.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  var _items = <String>[];
  // var _amount = <String>[];
  var _isLoading = false;

void _fetchData() async {
  setState(() {
    _isLoading = true;
  });

  await Future.delayed(const Duration(seconds: 1)); // Simulate a loading delay

  if (!mounted) return;

  setState(() {
    _isLoading = false;
    _items.addAll([
      'Food \$30.00',
      'Transportation \$15.00',
      'Boarding Fees \$50.00',
      'School Fees \$40.00',
      'Others \$20.00',
    ]);
  });
    // setState(() {
    //   _isLoading = false;
    //   _items = List.generate(_items.length + 10, (i) => 'Category $i Amount');
    // });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('History', style: TextStyle(color: Color(0xFFFEFAE0)),),
          backgroundColor: const Color.fromRGBO(40, 54, 24, 1),
          toolbarHeight: 100,
        ),
        body: InfiniteList(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          itemCount: _items.length,
          isLoading: _isLoading,
          onFetchData: _fetchData,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, index) {
            return ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 5),
              leading: const CircleAvatar(
                backgroundColor: Color(0xFF606C38),
                child: Icon(Icons.category, color: Color(0xFFFEFAE0),),
              ),
              dense: true,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_items[index]  , style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                ],
              ),
              subtitle: Text('Date: 2024-11-${index + 20}',
              style: const TextStyle(color: Colors.grey),
              ),
            );
          },
        ),
      ),
    );
  }
}

// /* SCSS RGB */
// $cornsilk: rgba(254, 250, 224, 1) 0xFFFEFAE0;
// $earth-yellow: rgba(221, 161, 94, 1);
// $tigers-eye: rgba(188, 108, 37, 1);
// $dark-moss-green: rgba(96, 108, 56, 1) 0xFF606C38;
// $pakistan-green: rgba(40, 54, 24, 1) 0xFF283618;
