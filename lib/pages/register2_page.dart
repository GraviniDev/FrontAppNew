import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:gravini/providers/registro_form_provider.dart';
import 'package:gravini/theme/app_theme.dart';
import 'package:gravini/widgets/boton_azulShort.dart';

import 'package:gravini/widgets/logo.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Register2Page extends StatefulWidget {
  @override
  State<Register2Page> createState() => _Register2PageState();
}

class _Register2PageState extends State<Register2Page> {
  int defaultChoiceIndex = 0;
  bool valor = false;
  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    final Map<String, String> formValues = {'anioIngreso': ''};
    int index = 0;
    bool visible = false;
    final datosRegistro = Provider.of<RegistroFormProvider>(context);
    String anioIngreso;
    if (datosRegistro.datosget?.anioIngreso == null) {
      anioIngreso = "";
    } else {
      anioIngreso = datosRegistro.datosget!.anioIngreso.toString();
    }
    visible = (datosRegistro.datosget?.esEgresado ?? false);

    defaultChoiceIndex =
        datosRegistro.datosget!.campusVilla == "Chalco" ? 0 : 1;
    datosRegistro.datosget!.campusVilla ??= "Guadalajara";
    final GlobalKey<FormState> myFormKey = GlobalKey<FormState>();
    List<String> choicesList = ['Chalco', 'Guadalajara'];
    return Scaffold(
        backgroundColor: const Color(0xffF2F2F2),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Logo(
                      titulo: 'REGISTRO',
                      width: 200,
                      radio: 150,
                      top: 10,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
                      child: Form(
                        key: myFormKey,
                        child: Column(
                          children: <Widget>[
                            SwitchListTile(
                              value: datosRegistro.datosget!.esEgresado ??=
                                  false,
                              onChanged: (bool value) {
                                setState(() {
                                  datosRegistro.datosget!.esEgresado = value;
                                });
                              },
                              title:
                                  const Text('¿Eres egresado de Villa de los Niños?'),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Visibility(
                              visible: !visible,
                              child: const Text(
                                "**Al no ser egresado de Villa de los niños el registro a la app debera pasar por una aprovación por parte de los administradores, esto puede tardar mas de 48 horas.",
                                style: TextStyle(
                                    fontWeight: FontWeight.w200,
                                    fontSize: 15,
                                    fontStyle: FontStyle.italic),
                              ),
                            ),
                            Visibility(
                              visible: visible,
                              child: Column(children: <Widget>[
                                TextFormField(
                                  initialValue: anioIngreso,
                                  textCapitalization: TextCapitalization.words,
                                  onChanged: (value) {
                                    datosRegistro.datosget?.anioIngreso =
                                        int.parse(value);
                                    anioIngreso = datosRegistro
                                        .datosget!.anioIngreso
                                        .toString();
                                    formValues['anioIngreso'] = value;
                                  },
                                  validator: (value) {
                                    if (value == null) {
                                      if (visible == true) {
                                        return 'Ingrese el año de ingreso';
                                      }
                                      return null;
                                    }
                                    return value.length < 4
                                        ? 'Ingrese el año de ingreso'
                                        : null;
                                  },
                                  onTap: () async {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                    var datePicked =
                                        await DatePicker.showSimpleDatePicker(
                                            context,
                                            initialDate: DateTime(1992, 08, 15),
                                            firstDate: DateTime(1992),
                                            lastDate: DateTime.now(),
                                            dateFormat: "yyyy",
                                            locale: DateTimePickerLocale.es,
                                            looping: true,
                                            titleText: "Año de ingreso",
                                            textColor: AppTheme.primary);
                                    anioIngreso = datePicked == null
                                        ? ""
                                        : DateFormat('yyyy').format(datePicked);
                                    datosRegistro.datosget?.anioIngreso =
                                        int.parse(anioIngreso == ""
                                            ? "0"
                                            : anioIngreso);

                                    setState(() {});
                                  },
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  decoration: const InputDecoration(
                                      hintText:
                                          'Ingrese el año en que ingreso a Villa',
                                      labelText: 'Año de ingreso',
                                      prefixStyle: TextStyle(height: 300)),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text('Campus de Villa de los niños'),
                                Wrap(
                                    spacing: 8,
                                    children: List.generate(choicesList.length,
                                        (index) {
                                      return ChoiceChip(
                                        label: Text(choicesList[index],
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2!
                                                .copyWith(
                                                    color: Colors.white,
                                                    fontSize: 14)),
                                        selected: defaultChoiceIndex == index,
                                        selectedColor: Colors.blue,
                                        onSelected: (value) {
                                          setState(() {
                                            defaultChoiceIndex = value
                                                ? index
                                                : defaultChoiceIndex;
                                            datosRegistro
                                                    .datosget!.campusVilla =
                                                index == 1
                                                    ? "Guadalajara"
                                                    : "Chalco";
                                          });
                                        },
                                        elevation: 1,
                                      );
                                    }))
                              ]),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Wrap(
                              children: [
                                BotonAzulShort(
                                    texto: 'Atrás',
                                    colorBtn: Colors.grey,
                                    onPressr: () {
                                      Navigator.pushReplacementNamed(
                                          context, 'register');
                                    }),
                                const SizedBox(
                                  width: 40,
                                ),
                                BotonAzulShort(
                                    texto: 'Siguiente',
                                    onPressr: () {
                                      if (!myFormKey.currentState!.validate()) {
                                        print('Formulario no valido');
                                        return;
                                      } else {
                                        if (visible == false) {
                                          datosRegistro.datosget?.anioIngreso =
                                              0;
                                          datosRegistro.datosget?.campusVilla =
                                              "";
                                        }
                                        Navigator.pushReplacementNamed(
                                            context, 'register3');
                                      }
                                    }),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    const Text(
                      'Terminos y condiciones de uso',
                      style: TextStyle(fontWeight: FontWeight.w200),
                    )
                  ]),
            ),
          ),
        ));
  }
}

// class _Form extends StatefulWidget {
//   @override
//   State<_Form> createState() => __FormState();
// }

// class __FormState extends State<_Form> {
//   final nameCtrl = TextEditingController();
//   final aPaternoCtrl = TextEditingController();
//   final aMaternoCtrl = TextEditingController();
//   final dateCtrl = TextEditingController();
//   int defaultChoiceIndex = 0;
//   bool valor = false;
//   String? dropdownValue;

//   TextStyle textStyle = TextStyle(color: Colors.white, fontSize: 16.0);
//   final ButtonStyle style = ElevatedButton.styleFrom(
//     // Foreground color
//     onPrimary: Colors.blue,
//     // Background color
//     primary: Colors.black,
//   ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0));

//   @override
//   Widget build(BuildContext context) {
//     final datosRegistro = Provider.of<RegistroFormProvider>(context);
//     String _anioIngreso;
//     if (datosRegistro.datosget?.anioIngreso == null) {
//       _anioIngreso = "";
//     } else {
//       _anioIngreso = datosRegistro.datosget!.anioIngreso.toString();
//     }

//     List<String> _choicesList = ['Chalco', 'Guadalajara'];
//     return Container(
//       margin: EdgeInsets.only(top: 40),
//       padding: EdgeInsets.symmetric(horizontal: 50),
//       child: Column(
//         children: <Widget>[
//           SwitchListTile(
//             value: valor == null ? false : valor,
//             onChanged: (bool value) {
//               setState(() {
//                 valor = value;
//               });
//             },
//             title: Text('¿Eres egresado de Villa de los Niños?'),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           TextFormField(
//             initialValue: _anioIngreso,
//             textCapitalization: TextCapitalization.words,
//             onChanged: (value) {
//               datosRegistro.datosget?.anioIngreso = int.parse(value);
//             },
//             validator: (value) {
//               if (value == null) {
//                 return 'Este campo es requerido';
//               }
//               return null;
//             },
//             onTap: () async {
//               FocusScope.of(context).requestFocus(FocusNode());
//               var datePicked = await DatePicker.showSimpleDatePicker(
//                 context,
//                 initialDate: DateTime(1992, 08, 15),
//                 firstDate: DateTime(1992),
//                 lastDate: DateTime.now(),
//                 dateFormat: "yyyy",
//                 locale: DateTimePickerLocale.es,
//                 looping: true,
//               );
//               _anioIngreso = datePicked == null
//                   ? ""
//                   : DateFormat('yyyy').format(datePicked);
//               datosRegistro.datosget?.anioIngreso = int.parse(_anioIngreso);

//               setState(() {});
//             },
//             autovalidateMode: AutovalidateMode.onUserInteraction,
//             decoration: const InputDecoration(
//                 hintText: 'Ingrese el año en que ingreso a Villa',
//                 labelText: 'Año de ingreso',
//                 prefixStyle: TextStyle(height: 300)),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Text('Campus de Villa de los niños'),
//           Wrap(
//               spacing: 8,
//               children: List.generate(_choicesList.length, (index) {
//                 return ChoiceChip(
//                   label: Text(_choicesList[index],
//                       style: Theme.of(context)
//                           .textTheme
//                           .bodyText2!
//                           .copyWith(color: Colors.white, fontSize: 14)),
//                   selected: defaultChoiceIndex == index,
//                   selectedColor: Colors.blue,
//                   onSelected: (value) {
//                     setState(() {
//                       defaultChoiceIndex = value ? index : defaultChoiceIndex;
//                     });
//                   },
//                   elevation: 1,
//                 );
//               })),
//           SizedBox(
//             height: 40,
//           ),
//           Wrap(
//             children: [
//               BotonAzulShort(
//                   texto: 'Atrás',
//                   colorBtn: Colors.grey,
//                   onPressr: () {
//                     Navigator.pushReplacementNamed(context, 'register');
//                   }),
//               SizedBox(
//                 width: 40,
//               ),
//               BotonAzulShort(
//                   texto: 'Siguiente',
//                   onPressr: () {
//                     print(nameCtrl.text);
//                     print(aPaternoCtrl.text);
//                     print(aMaternoCtrl.text);
//                     print(dateCtrl.text);
//                     print(dropdownValue);
//                     Navigator.pushReplacementNamed(context, 'register3');
//                   }),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
