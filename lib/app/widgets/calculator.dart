import 'package:animate_do/animate_do.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lucio/data/const.dart';
import 'package:lucio/device/device.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorIcon extends StatelessWidget {
  final TextEditingController controller;

  const CalculatorIcon({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (_) => CalculatorPage(controller: controller),
        );
      },
      child: const Icon(FontAwesomeIcons.calculator),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  final TextEditingController controller;

  const CalculatorPage({Key? key, required this.controller}) : super(key: key);

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String exp = '';

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            child: Row(
              children: [
                IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back)),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: _getTexts(),
                  ),
                ),
                if (exp.isNotEmpty && widget.controller.text.isEmpty)
                  FadeInRightBig(
                    from: 20,
                    duration: const Duration(milliseconds: 400),
                    child: InkWell(
                      onTap: () => Calculate('DE'),
                      child: SizedBox(
                        height: double.maxFinite,
                        width: size.width * 0.1,
                        child: const Icon(Icons.backspace),
                      ),
                    ),
                  )
              ],
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              child: Column(
                children: [
                  _getButtons('C', '(', ')', '/'),
                  _getButtons('7', '8', '9', 'x'),
                  _getButtons('4', '5', '6', '-'),
                  _getButtons('1', '2', '3', '+'),
                  _getButtons('0', '00', '.', '='),
                ],
              )),
        ),
      ],
    );
  }

  Widget _getTexts() {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AutoSizeText(
            exp,
            minFontSize: 18.0,
            maxFontSize: widget.controller.text.isEmpty ? 35.0 : 18,
            maxLines: 2,
            textAlign: TextAlign.end,
            style: const TextStyle(
              fontWeight: FontWeight.w200,
              decoration: TextDecoration.none,
              fontSize: 35.0,
            ),
          ),
          const SizedBox(
            height: kDefaultRefNumber,
          ),
          SizedBox(
            child: widget.controller.text.isEmpty
                ? null
                : FadeInRightBig(
                    from: 30,
                    duration: const Duration(milliseconds: 400),
                    child: Text(
                      widget.controller.text,
                      textAlign: TextAlign.end,
                      style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                  ),
          )
        ],
      ),
    );
  }

  Widget _buttom(String key) => Padding(
        padding: const EdgeInsets.all(10),
        child: TextButton(
          onPressed: () => Calculate(key),
          style: TextButton.styleFrom(
            primary: getTextColor(key),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(26),
            ),
            backgroundColor: getTextColor(key, back: true),
            textStyle: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          child: Text(
            key ?? "",
          ),
        ),
      );

  Widget _getButtons(String? t1, String? t2, String? t3, String? t4) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (t1 != null) ...[
            Expanded(
              child: _buttom(t1),
            ),
            if (t2 != null)
              Expanded(
                child: _buttom(t2),
              ),
          ],
          if (t1 == null) ...[
            if (t2 != null)
              Expanded(
                flex: 2,
                child: _buttom(t2),
              )
          ],
          if (t3 != null)
            Expanded(
              child: _buttom(t3),
            ),
          if (t4 != null)
            Expanded(
              child: _buttom(t4),
            ),
        ],
      ),
    );
  }

  Color getTextColor(String x, {bool back = false}) {
    List<String> numbers = [
      '0',
      '00',
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
      '.',
      '(',
      ')',
    ];
    List<String> operatos = ['/', 'x', '+', '-'];
    List<String> clears = ['C', 'DE'];
    List<String> equals = ['='];

    if (numbers.contains(x) && back) {
      return Theme.of(context).cardColor;
    } else if (operatos.contains(x) && back) {
      return Colors.orange;
    } else if (clears.contains(x)) {
      if (back) {
        return Colors.red.withOpacity(0.3);
      }
      return Colors.red;
    } else if (equals.contains(x) && back) {
      return Colors.green;
    }

    return Theme.of(context).colorScheme.onBackground;
  }

  void Calculate(String x) {
    setState(() {
      List<String> clearsResult = ['C', 'DE', '='];

      if (!clearsResult.contains(x) && widget.controller.text != '') {
        exp = widget.controller.text;
        widget.controller.text = '';
        exp += x;
      } else if (!clearsResult.contains(x)) {
        exp += x;
      } else if (x == 'DE') {
        exp = exp.substring(0, exp.length - 1);
      } else if (x == 'C') {
        exp = '';
        widget.controller.text = '';
      } else {
        Parser parser = Parser();
        try {
          Expression e = parser.parse(exp.replaceAll('x', '*'));
          ContextModel cm = ContextModel();
          widget.controller.text = e.evaluate(EvaluationType.REAL, cm).toString();

          Future.delayed(const Duration(milliseconds: 100),
              () => _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration: const Duration(milliseconds: 300), curve: Curves.linear));
        } catch (e) {
          if (exp.isNotEmpty) {
            Utils.showSnack(context, title: "Calculation", message: "Error in the expression", type: FlashType.error);
          }
        }
      }
    });
  }
}
