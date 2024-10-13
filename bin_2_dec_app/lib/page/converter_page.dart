import 'package:bin_2_dec_app/page/widgets/based_button.dart';
import 'package:bin_2_dec_app/page/widgets/based_text_form.dart';
import 'package:bin_2_dec_app/page/widgets/besed_text.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class ConverterPage extends StatefulWidget {
  const ConverterPage({super.key});

  @override
  State<ConverterPage> createState() => _ConverterPageState();
}

class _ConverterPageState extends State<ConverterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final binaryTextController = TextEditingController();
  final decimalTextController = TextEditingController();
  String textConverted = '';
  String? _errorText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              titleInformation(),
              const SizedBox(height: 30),
              inputInformation('Binary:', binaryTextController, 1),
              const SizedBox(height: 20),
              bottomButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget titleInformation() {
    return const Column(
      children: [
        BesedText(
          text: 'Binary-To-Decimal',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
        SizedBox(height: 10),
        BesedText(
          text: 'App converter de binário para decimal',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  Widget bottomButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        BasedButton(
          style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.red),
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))))),
          child: const BesedText(
            text: 'Convert',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),
          ),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              int decimal = binaryToDecimal(binaryTextController.text);
              setState(() {
                textConverted = decimal.toString();
              });
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Digite um valor válido!', style: TextStyle(color: Colors.white, fontSize: 25),),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
        ),
        const SizedBox(width: 10),
        BasedButton(
          onPressed: () {
            binaryTextController.clear();
            setState(() {
              textConverted = '';
            });
          },
          style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.blue),
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))))),
          child: const BesedText(
            text: 'Clear',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget inputInformation(
      String title, TextEditingController textController, int maxLines) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BesedText(
          text: title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 10),
        Form(
          key: _formKey,
          child: BasedTextForm(
            controller: textController,
            maxLines: maxLines,
            maxLength: 8,
            decoration: InputDecoration(
              hintText: '00000000',
              errorText: _errorText,
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
            onChanged: (value) {
              if (value.isEmpty) {
                setState(() {
                  _errorText = null;
                });
              } else if (!RegExp(r'^[01]+$').hasMatch(value)) {
                setState(() {
                  _errorText = 'Por favor, insira apenas 0 ou 1';
                });
              } else {
                setState(() {
                  _errorText = null;
                });
              }
            },
            validator: (value) {
              if (value!.isEmpty) {
                return 'Por favor, insira um valor';
              }
              return null;
            },
          ),
        ),
        const SizedBox(height: 10),
        const BesedText(
          text: 'Decimal:',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: BesedText(
              text: textConverted.isEmpty ? '0' : textConverted,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );
  }

  int binaryToDecimal(String binary) {
    int decimal = 0;
    for (int i = 0; i < binary.length; i++) {
      int digit = int.parse(binary[i]);
      decimal += digit * pow(2, binary.length - 1 - i).toInt();
    }
    return decimal;
  }
}
