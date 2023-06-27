import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucio/app/screens/employee/employee_page.dart';
import 'package:lucio/app/screens/type_of_production/type_of_production_page.dart';
import 'package:lucio/app/widgets/dropdowns.dart';
import 'package:lucio/data/const.dart';
import 'package:lucio/data/repositories/employe/employe_provider.dart';
import 'package:lucio/data/repositories/employe/employee_plan_provider.dart';
import 'package:lucio/data/repositories/type_of_production/type_of_production_provider.dart';
import 'package:lucio/domain/scheme/employe/employe_model.dart';
import 'package:lucio/domain/scheme/production/production_model.dart';

class PlanForm extends ConsumerStatefulWidget {
  final EmployeePlanModel? model;
  final EmployeModel? employeModelInitial;

  const PlanForm({Key? key, this.model, this.employeModelInitial}) : super(key: key);

  @override
  ConsumerState<PlanForm> createState() => _MaterialFormState();
}

class _MaterialFormState extends ConsumerState<PlanForm> {
  final GlobalKey<FormState> _key = GlobalKey();
  EmployeModel? employeModel;
  ProductionTypeModel? productionTypeModel;

  late TextEditingController _plan;

  @override
  void initState() {
    _plan = TextEditingController(text: widget.model?.plan.toString() ?? "");
    employeModel = widget.model?.employee.value ?? widget.employeModelInitial;
    productionTypeModel = widget.model?.type.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final employees = ref.watch(employeeProvider);
    final productTypes = ref.watch(productionTypeModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.model == null ? "New Plan of Employee" : "Update Plan of ${widget.model?.employee.value?.name ?? "Employee"}"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _key,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kDefaultRefNumber, vertical: kDefaultRefNumber / 2),
                child: DropdownSearch<EmployeModel>(
                  enabled: widget.model == null,
                  validator: (EmployeModel? value) {
                    if (value == null) {
                      return "Employee required";
                    }
                    return null;
                  },
                  selectedItem: employeModel,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  clearButtonProps: ClearButtonProps(
                      onPressed: () {
                        setState(() => productionTypeModel = null);
                      },
                      icon: const Icon(Icons.clear),
                      isVisible: true),
                  popupProps: popUpsProps<EmployeModel>(context, onPressed: () => EmployeePage.fireForm(context), title: "Employee"),
                  asyncItems: (String filter) => Future.value(employees),
                  itemAsString: (EmployeModel u) => u.name,
                  onChanged: (EmployeModel? data) => setState(() => employeModel = data),
                  dropdownDecoratorProps: const DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(labelText: "Employee"),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kDefaultRefNumber, vertical: kDefaultRefNumber / 2),
                child: DropdownSearch<ProductionTypeModel>(
                  enabled: widget.model == null,
                  validator: (ProductionTypeModel? value) {
                    if (value == null) {
                      return "Production Type required";
                    }
                    return null;
                  },
                  selectedItem: productionTypeModel,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  clearButtonProps: ClearButtonProps(
                      onPressed: () {
                        setState(() => productionTypeModel = null);
                      },
                      icon: const Icon(Icons.clear),
                      isVisible: true),
                  popupProps: popUpsProps<ProductionTypeModel>(context, onPressed: () => TypeOfProductionPage.fireForm(context), title: "Production Type"),
                  asyncItems: (String filter) => Future.value(productTypes),
                  itemAsString: (ProductionTypeModel u) => "${u.name} ${u.unit.value == null ? "" : "(${u.unit.value?.key ?? ""})"}",
                  onChanged: (ProductionTypeModel? data) => setState(() => productionTypeModel = data),
                  dropdownDecoratorProps: const DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(labelText: "Production Type"),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kDefaultRefNumber, vertical: kDefaultRefNumber / 2),
                child: TextFormField(
                  controller: _plan,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Plan', hintText: "Plan"),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return null;
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
              await ref.read(employeePlanProvider.notifier).insert(
                    employee: employeModel!,
                    type: productionTypeModel!,
                    plan: double.tryParse(_plan.text) ?? 0,
                  );
            } else {
              await ref.read(employeePlanProvider.notifier).update(widget.model!, values: {
                "employee": employeModel!,
                "type": productionTypeModel!,
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
