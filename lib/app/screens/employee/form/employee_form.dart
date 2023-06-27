import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucio/data/const.dart';
import 'package:lucio/data/repositories/employe/employe_provider.dart';
import 'package:lucio/domain/scheme/employe/employe_model.dart';

class EmployeeForm extends ConsumerStatefulWidget {
  final EmployeModel? model;

  const EmployeeForm({Key? key, this.model}) : super(key: key);

  @override
  ConsumerState<EmployeeForm> createState() => _MaterialFormState();
}

class _MaterialFormState extends ConsumerState<EmployeeForm> {
  final GlobalKey<FormState> _key = GlobalKey();

  late TextEditingController _name;
  late TextEditingController _ci;
  late TextEditingController _plan;

  @override
  void initState() {
    _name = TextEditingController(text: widget.model?.name ?? "");
    _ci = TextEditingController(text: widget.model?.ci ?? "");
    _plan = TextEditingController(text: widget.model?.plan.toString() ?? "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.model == null ? "New Employee" : "Update Employee"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _key,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kDefaultRefNumber, vertical: kDefaultRefNumber / 2),
                child: TextFormField(
                  controller: _name,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(labelText: 'Name', hintText: "Name"),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "Name required";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kDefaultRefNumber, vertical: kDefaultRefNumber / 2),
                child: TextFormField(
                  controller: _ci,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'CI', hintText: "Identity Card"),
                  maxLength: 11,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return null;
                    } else {
                      if (value!.length != 11) {
                        return "Enter valid CI with 11 digits";
                      }
                    }

                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kDefaultRefNumber, vertical: kDefaultRefNumber / 2),
                child: TextFormField(
                  controller: _plan,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(labelText: 'Plan', hintText: "Plan"),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "Plan required";
                    }
                    if (double.tryParse(value ?? "-") == null) {
                      return "write correct number";
                    }

                    return null;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (_key.currentState?.validate() ?? false) {
            if (widget.model == null) {
              await ref.read(employeeProvider.notifier).insert(name: _name.text, ci: _ci.text, plan: double.tryParse(_plan.text) ?? 0);
            } else {
              await ref.read(employeeProvider.notifier).update(widget.model!, values: {
                "name": _name.text,
                "ci": _ci.text,
                "plan": double.tryParse(_plan.text) ?? 0,
              });
            }
            if (context.mounted) Navigator.pop(context);
          }
        },
        child: Icon(widget.model == null ? Icons.save : Icons.update),
      ),
    );
  }
}
