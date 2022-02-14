import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FieldCadastro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: null,
          keyboardType: TextInputType.phone,
          style: GoogleFonts.anton(
            textStyle: TextStyle(color: Colors.red),
          ),
          decoration: InputDecoration(
            labelText: 'Digite seu Peso',
            labelStyle: TextStyle(color: Colors.red),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
                width: 3.0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
                width: 3.0,
              ),
            ),
          ),
          validator: (value) {
            if (value.isEmpty) {
              return 'Informe seu Peso';
            } else {
              return null;
            }
          },
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
      controller: null,
      keyboardType: TextInputType.number,
      style: GoogleFonts.anton(
        textStyle: TextStyle(color: Colors.red),
      ),
      decoration: InputDecoration(
        labelText: 'Digite sua idade',
        labelStyle: TextStyle(color: Colors.red),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
            width: 3.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
            width: 3.0,
          ),
        ),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Informe sua idade';
        } else {
          return null;
        }
      },
    ),
    SizedBox(
          height: 10,
        ),
    TextFormField(
      controller: null,
      keyboardType: TextInputType.phone,
      style: GoogleFonts.anton(
        textStyle: TextStyle(color: Colors.red),
      ),
      decoration: InputDecoration(
        labelText: 'Informe sua altura',
        labelStyle: TextStyle(color: Colors.red),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
            width: 3.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
            width: 3.0,
          ),
        ),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Informe sua altura';
        } else {
          return null;
        }
      },
    ),
      ],
    );
  }
}
