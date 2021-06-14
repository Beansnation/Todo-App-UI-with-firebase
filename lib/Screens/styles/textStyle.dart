import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle medium1 = GoogleFonts.poppins(
  fontSize: 14,
  fontWeight: FontWeight.w400,
);
TextStyle bold = GoogleFonts.poppins(
    fontSize: 20, fontWeight: FontWeight.w500, color: Color(0xff00A925));

TextStyle veryBold =
    GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w600);
TextStyle small =
    GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.w400);
TextStyle small2 = GoogleFonts.poppins(
    fontSize: 10, fontWeight: FontWeight.w400, color: Color(0xfffc4820));

TextStyle medium =
    GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400);

TextStyle regular = GoogleFonts.poppins(
  fontSize: 14,
  fontWeight: FontWeight.w300,
);
TextStyle regular2 = GoogleFonts.poppins(
    fontSize: 16, fontWeight: FontWeight.w400, color: Color(0xffff2e00));
TextStyle signIn = GoogleFonts.poppins(
    fontSize: 20, fontWeight: FontWeight.w400, color: Color(0xff00A925));

TextStyle signInn =
    GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w400);

TextStyle hsTodo = GoogleFonts.poppins(
  fontSize: 16,
  fontWeight: FontWeight.w400,
);

ButtonStyle actionButton = ElevatedButton.styleFrom(
    onPrimary: Colors.white,
    primary: Color(0xFFFF2E00),
    minimumSize: Size(380, 60),
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.zero)));

final ButtonStyle actionButton2 = ElevatedButton.styleFrom(
    onPrimary: Colors.white,
    primary: Color(0xFFFF2E00),
    minimumSize: Size(150, 50),
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.zero)));

    final ButtonStyle actionButton3 = ElevatedButton.styleFrom(
    onPrimary: Colors.white,
    primary: Color(0xFFFF2E00),
    minimumSize: Size(100, 32),
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.zero)));

InputDecoration kdecoration(String hintText) {
  InputDecoration kDecoration = InputDecoration(
      hintText: hintText,
      hintStyle: regular,
      filled: true,
      fillColor: Color(0xFF313131),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: Colors.transparent)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: Colors.transparent)));

  return kDecoration;
}

// ListView getTodoListView() {

//   TextStyle titleStyle = Theme.of(context).textTheme.headline6;

//   return ListView.builder(
//     itemCount: count,
//     itemBuilder: (BuildContext context, int position) {
//       return Card(
//         color: Colors.white,
//         elevation: 2.0,
//         child: ListTile(
//           title: Text(this.todoList[position].title, style: titleStyle,),

//           subtitle: Text(this.todoList[position].date),

//           trailing: CircleAvatar(
//             radius: 16,
//             backgroundColor: getPriorityColor(this.todoList[position].priority),
//             child: getPriorityIcon(this.todoList[position].priority),
//           ),
//           onTap: () {
//             debugPrint("ListTile Tapped");
//             navigateToDetail(this.todoList[position],'Edit Todo');
//           },

//         ),
//       );
//     },
//   );
// }
