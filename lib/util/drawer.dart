import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DrawerDelegado extends StatelessWidget {
  VoidCallback onVaciar;

  DrawerDelegado({required this.onVaciar});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: [
        Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
              color: Color(
                  int.parse('#f4ecdc'.substring(1, 7), radix: 16) + 0xFF000000),
              shape: BoxShape.circle,
              image:
                  DecorationImage(image: AssetImage('./assets/Lorelei.webp'))),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          'Lorelei',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          '202122525',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        SizedBox(
          height: 40,
        ),
        Text(
          '"La democracia es el peor sistema de gobierno diseñado por el hombre. Con excepción de todos los demás"',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        SizedBox(
          height: 130,
        ),
        GestureDetector(
            onTap: onVaciar,
            child: ListTile(
              leading: Icon(Icons.delete),
              title: Text('Vaciar Registro de Eventos'),
            ))
      ],
    ));
  }
}
