import 'package:flutter/material.dart';

class Detallecard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Container(
        margin: EdgeInsets.only(top: 30, bottom: 50),
        width: double.infinity,
        height: 400,
        decoration: _cardBorders(),
        child: Stack(
          children: [
         //   _Backimagen()
         _idDetalle(),
         _totalDetalle()
          ],
        ),
        //color: Colors.red,
      ),
    );
  }

  BoxDecoration _cardBorders() => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow:[
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 5),
            blurRadius: 10
          )
        ] 
      );
}

class _totalDetalle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class _idDetalle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 40),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        width: double.infinity,
        height: 70,
        decoration: _buildDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text('ID del mantenimiento',style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),
          maxLines: 1,),
          Text('Numero:',style: TextStyle(fontSize: 15,color: Colors.white),
          )
        ]),
      ),
    );
  }

  BoxDecoration _buildDecoration() => BoxDecoration(
    color: Colors.grey[500],
    borderRadius: BorderRadius.only(bottomRight: Radius.circular(25),topLeft: Radius.circular(25))
  );
}

// este de aqui es para poner una imagen de fondo con un gif mas de carga 
// no solo implemente para ver que tal quedaba nomas 
class _Backimagen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 400,
      child: FadeInImage(
        placeholder: AssetImage('??'),
        image:NetworkImage ('https://via.placeholder.com/400x300/f6f6f6'),
      ),
    );
  }
}
