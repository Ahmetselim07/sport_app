import 'package:flutter/material.dart';
class MyButton extends StatefulWidget {
  final String text;
  final Function()? onTap;
  final bool showCheckbox; // Görünürlüğü kontrol etmek için bir değer eklendi
  final bool? isChecked;
  const MyButton({
    Key? key,
    required this.text,
    this.onTap,
    this.showCheckbox = false, // Varsayılan olarak false yapıldı
     this.isChecked,
  }) : super(key: key);

  @override
  _MyButtonState createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
   // Checkbox durumu
   late bool isChecked;

   @override
   void initState() {
     super.initState();
   }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.onTap != null) {
          widget.onTap!();
        }
      },
      child: Container(
        height: 75,
        width: 400,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.all(25),
        margin: EdgeInsets.symmetric(horizontal: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.text, style: TextStyle(fontSize: 15)),
            if (widget.showCheckbox) // Görünürlük kontrolü
              Checkbox(
                value: widget.isChecked ?? true,
                activeColor: Colors.lightGreen,
                onChanged: (value) {
                  setState(() {
                    isChecked = value!;
                  });
                },
              ),
          ],
        ),
      ),
    );
  }
}
