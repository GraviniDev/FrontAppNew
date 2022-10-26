import 'package:flutter/material.dart';

List<DropdownMenuItem<String>> get dropdownItems {
  List<DropdownMenuItem<String>> menuItems = const [
    // DropdownMenuItem(
    //     child: Text("Lugar de residencia"), value: "Lugar de residencia"),
    DropdownMenuItem(value: "Extranjero", child: Text("Extranjero")),
    DropdownMenuItem(value: "Aguascalientes", child: Text("Aguascalientes")),
    DropdownMenuItem(value: "Baja California", child: Text("Baja California")),
    DropdownMenuItem(
        value: "Baja California Sur",
        child: Text("Baja California Sur ")),
    DropdownMenuItem(value: "Campeche", child: Text("Campeche ")),
    DropdownMenuItem(value: "Chiapas", child: Text("Chiapas ")),
    DropdownMenuItem(value: "Chihuahua", child: Text("Chihuahua ")),
    DropdownMenuItem(value: "Coahuila", child: Text("Coahuila ")),
    DropdownMenuItem(value: "Colima", child: Text("Colima ")),
    DropdownMenuItem(
        value: "Ciudad de México",
        child: Text("Ciudad de México ")),
    DropdownMenuItem(
        value: "Estado de México",
        child: Text("Estado de México ")),
    DropdownMenuItem(value: "Durango", child: Text("Durango ")),
    DropdownMenuItem(value: "Guanajuato", child: Text("Guanajuato ")),
    DropdownMenuItem(value: "Guerrero", child: Text("Guerrero ")),
    DropdownMenuItem(value: "Hidalgo", child: Text("Hidalgo ")),
    DropdownMenuItem(value: "Jalisco", child: Text("Jalisco ")),
    DropdownMenuItem(value: "Michoacán", child: Text("Michoacán ")),
    DropdownMenuItem(value: "Morelos", child: Text("Morelos ")),
    DropdownMenuItem(value: "Nayarit", child: Text("Nayarit ")),
    DropdownMenuItem(value: "Nuevo León", child: Text("Nuevo León ")),
    DropdownMenuItem(value: "Oaxaca", child: Text("Oaxaca ")),
    DropdownMenuItem(value: "Puebla", child: Text("Puebla ")),
    DropdownMenuItem(value: "Querétaro", child: Text("Querétaro ")),
    DropdownMenuItem(value: "Quintana Roo", child: Text("Quintana Roo ")),
    DropdownMenuItem(value: "San Luis Potosí", child: Text("San Luis Potosí ")),
    DropdownMenuItem(value: "Sinaloa", child: Text("Sinaloa ")),
    DropdownMenuItem(value: "Sonora", child: Text("Sonora ")),
    DropdownMenuItem(value: "Tabasco", child: Text("Tabasco ")),
    DropdownMenuItem(value: "Tamaulipas", child: Text("Tamaulipas ")),
    DropdownMenuItem(value: "Tlaxcala", child: Text("Tlaxcala ")),
    DropdownMenuItem(value: "Veracruz", child: Text("Veracruz ")),
    DropdownMenuItem(value: "Yucatán", child: Text("Yucatán ")),
    DropdownMenuItem(value: "Zacatecas", child: Text("Zacatecas"))
  ];
  return menuItems;
}
