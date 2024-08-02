import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class RoundButton extends StatelessWidget {
  final VoidCallback ontap;
  final String name;
  final bool loading;

  RoundButton({super.key, required this.name, required this.ontap, this.loading = false});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;

    return Container(
      width: width * .4,
      child: MaterialButton(
        onPressed: loading ? null : ontap,  // Disable button if loading
        color: Colors.purple,
        textColor: Colors.white,
        child: loading
            ? CircularProgressIndicator(
          strokeWidth: 3,
          color: Colors.purple,
        )
            : Text(name),
        padding: EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}

