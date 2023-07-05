import 'package:dropdown_search/dropdown_search.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:lucio/app/screens/employee/employee_page.dart';
import 'package:lucio/app/screens/type_of_production/type_of_production_page.dart';
import 'package:lucio/app/widgets/calculator.dart';
import 'package:lucio/app/widgets/dropdowns.dart';
import 'package:lucio/data/const.dart';
import 'package:lucio/data/repositories/employe/employe_provider.dart';
import 'package:lucio/data/repositories/options_provider.dart';
import 'package:lucio/data/repositories/production/work_production_provider.dart';
import 'package:lucio/data/repositories/type_of_production/type_of_production_provider.dart';
import 'package:lucio/device/helpers/biometric/fingerprint.dart';
import 'package:lucio/domain/scheme/employe/employe_model.dart';
import 'package:lucio/domain/scheme/production/production_model.dart';

class WorkProductionForm extends ConsumerStatefulWidget {
  final WorkProductionModel? model;
  final Map<String, dynamic>? initial;

  const WorkProductionForm({Key? key, this.model, this.initial}) : super(key: key);

  @override
  ConsumerState<WorkProductionForm> createState() => _WorkProductionFormState();
}

class _WorkProductionFormState extends ConsumerState<WorkProductionForm> {
  final GlobalKey<FormState> _key = GlobalKey();
  ProductionTypeModel? productionTypeModel;
  EmployeModel? employeModel;
  DateTime dateTime = DateTime.now();
  late TextEditingController _quantity;
  late TextEditingController _breaks;

  @override
  void initState() {
    final Map<String, dynamic> initialData = widget.initial ?? {};
    _quantity = TextEditingController(text: widget.model?.quantity.toString() ?? initialData['quantity'] ?? "");
    _breaks = TextEditingController(text: widget.model?.breaks.toString() ?? initialData['breaks'] ?? "0");
    dateTime = widget.model?.datetime ?? initialData['dateTimeParam'] ?? dateTime;
    productionTypeModel = widget.model?.type.value ?? initialData['type'];
    employeModel = widget.model?.employee.value ?? initialData['employee'];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final options = ref.watch(optionsP);
    final employees = ref.watch(employeeProvider);
    final typeProductions = ref.watch(productionTypeModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          title: Text(widget.model == null ? "home.production.form.new".tr() : "home.production.form.update".tr()),
          subtitle: Text(DateFormat(dateFormat).format(dateTime)),
        ),
        actions: [
          IconButton(
            onPressed: () {
              checkAuth(
                ref,
                message: "home.production.form.change_date".tr(),
                onSuccess: () async {
                  DateTime? result = await showDatePicker(
                    context: context,
                    initialDate: dateTime,
                    firstDate: DateTime.now().subtract(Duration(days: options.daysOfRangeDateProduction)),
                    lastDate: DateTime.now(),
                  );
                  setState(
                    () {
                      result = result ?? DateTime.now();
                      TimeOfDay selectedTime = TimeOfDay.now();
                      dateTime = DateTime(
                        result!.year,
                        result!.month,
                        result!.day,
                        selectedTime.hour,
                        selectedTime.minute,
                      );
                    },
                  );
                },
              );
            },
            icon: const Icon(Icons.date_range_sharp),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _key,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kDefaultRefNumber, vertical: kDefaultRefNumber / 2),
                child: DropdownSearch<EmployeModel>(
                  validator: (EmployeModel? value) {
                    if (value == null) {
                      return "home.production.form.fields.employee.mistakes.required".tr();
                    }
                    return null;
                  },
                  clearButtonProps: ClearButtonProps(
                    isVisible: true,
                    onPressed: () {
                      setState(() {
                        employeModel = null;
                      });
                    },
                    icon: const Icon(Icons.clear),
                  ),
                  items: employees,
                  selectedItem: employeModel,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  popupProps: popUpsProps<EmployeModel>(context, onPressed: () => EmployeePage.fireForm(context), title: "home.production.form.fields.employee.title".tr()),
                  itemAsString: (EmployeModel u) => u.name,
                  onChanged: (EmployeModel? data) => setState(() => employeModel = data),
                  dropdownDecoratorProps: DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(labelText: "home.production.form.fields.employee.title".tr()),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kDefaultRefNumber, vertical: kDefaultRefNumber / 2),
                child: DropdownSearch<ProductionTypeModel>(
                  validator: (ProductionTypeModel? value) {
                    if (value == null) {
                      return "home.production.form.fields.production_type.mistakes.required".tr();
                    }




                    return null;
                  },
                  selectedItem: productionTypeModel,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  popupProps: popUpsProps<ProductionTypeModel>(context,
                      onPressed: () => TypeOfProductionPage.fireForm(context), title: "home.production.form.fields.production_type.title".tr()),
                  asyncItems: (String filter) => Future.value(typeProductions),
                  itemAsString: (ProductionTypeModel u) => "${u.name} ${u.unit.value == null ? "" : "(${u.unit.value?.key ?? ""})"}",
                  onChanged: (ProductionTypeModel? data) => setState(() => productionTypeModel = data),
                  dropdownDecoratorProps: DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(labelText: "home.production.form.fields.production_type.title".tr()),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kDefaultRefNumber, vertical: kDefaultRefNumber / 2),
                child: TextFormField(
                  controller: _quantity,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    labelText: "home.production.form.fields.quantity.title".tr(),
                    prefixIcon: CalculatorIcon(
                      controller: _quantity,
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "home.production.form.fields.quantity.mistakes.required".tr();
                    }
                    if (double.tryParse(value ?? "-") == null) {
                      return "home.production.form.fields.quantity.mistakes.number".tr();
                    }
                    if ((double.tryParse(value ?? '0') ?? 0) == 0) {
                      return "home.production.form.fields.quantity.mistakes.zero".tr();
                    }



                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kDefaultRefNumber, vertical: kDefaultRefNumber / 2),
                child: TextFormField(
                  controller: _breaks,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    labelText: "home.production.form.fields.break.title".tr(),
                    prefixIcon: CalculatorIcon(
                      controller: _breaks,
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "home.production.form.fields.break.mistakes.required".tr();
                    }
                    if (double.tryParse(value ?? "-") == null) {
                      return "home.production.form.fields.break.mistakes.number".tr();
                    }

                    return null;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text(DateFormat(dateFormat).format(dateTime)),
        onPressed: () async {
          if (_key.currentState?.validate() ?? false) {








            if (widget.model == null) {
              await ref.read(workProductionProvider.notifier).insert(
                    employee: employeModel!,
                    type: productionTypeModel!,
                    quantity: double.tryParse(_quantity.text) ?? 0,
                    dateTimeParam: dateTime,
                    breaks: double.tryParse(_breaks.text) ?? 0,
                  );
            } else {
              await ref.read(workProductionProvider.notifier).update(widget.model!, values: {
                "employee": employeModel!,
                "type": productionTypeModel!,
                "dateTimeParam": dateTime,
                "quantity": double.tryParse(_quantity.text) ?? 0,
                "breaks": double.tryParse(_breaks.text) ?? 0,
              });
            }
            if (context.mounted) Navigator.pop(context);
          }
        },
        icon: Icon(widget.model == null ? Icons.save : Icons.update),
      ),
    );
  }
}
