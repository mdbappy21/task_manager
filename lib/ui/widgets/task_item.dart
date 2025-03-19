import 'package:flutter/material.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0,
      child: ListTile(
        title: Text('Title'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Description'),
            Text(
              'Date : 21/2/2025',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  label: Text('New'),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: EdgeInsets.symmetric(
                      horizontal: 8, vertical: 2),
                  // backgroundColor: Colors.teal,
                ),
                OverflowBar(
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.delete)),
                    IconButton(
                        onPressed: () {}, icon: Icon(Icons.edit))
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}