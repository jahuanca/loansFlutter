import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loands_flutter/src/loans/domain/entities/loan_entity.dart';
import 'package:loands_flutter/src/loans/ui/pages/loans/loans_controller.dart';
import 'package:loands_flutter/src/utils/core/default_values_of_app.dart';
import 'package:utils/utils.dart';

class LoansPage extends StatelessWidget {
  LoansPage({super.key});

  final LoansController controller = LoansController(
    getLoansUseCase: Get.find(),
  );
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);

    return GetBuilder<LoansController>(
      init: controller,
      id: pageIdGet,
      builder: (controller) => RefreshIndicator(
        onRefresh: controller.getLoans,
        child: Scaffold(
          appBar: _appBar(),
          floatingActionButton: ChildOrElseWidget(
              condition: controller.isSearching.not() && controller.isFromDashboard,
              child: _floatingActionButton()),
          body: _body(size),
        ),
      ),
    );
  }

  PreferredSizeWidget _appBar() {

    return appBarWidget(text: controller.titleOfAppBar, hasArrowBack: true, actions: [
      const IconWidget(
          padding: defaultPadding, iconData: Icons.filter_alt_outlined),
      IconWidget(
          onTap: controller.goToSearchLoan,
          padding: defaultPadding,
          iconData: Icons.search),
    ]);
  }

  Widget _floatingActionButton() {
    return FloatingActionButton(
      onPressed: controller.goToAddLoanInformation,
      child: const Icon(Icons.add),
    );
  }

  Widget _body(Size size) {
    return ChildOrElseWidget(
      condition: controller.loans.isNotEmpty,
      elseWidget: EmptyWidget(),
      child: _list(size),
    );
  }

  Widget _list(Size size) {
    final double heigth = (controller.isFromDashboard)
        ? size.height - kToolbarHeight - kBottomNavigationBarHeight
        : size.height - kToolbarHeight;
    return SizedBox(
      height: heigth,
      width: size.width,
      child: Column(
        children: [
          if(controller.isFromDashboard)
          _searchInput(),
          Expanded(
            child: ListView.builder(
              itemCount: controller.loansToShow.length,
              itemBuilder: (context, index) => _item(
                size: size,
                loan: controller.loansToShow[index],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _item({
    required Size size,
    required LoanEntity loan,
  }) {

    String? subtitle = (controller.isFromDashboard) 
      ? loan.customerEntity?.aliasOrFullName
      : 'Ganancia: S/ ${loan.ganancy.formatDecimals()}';

    return ListTile(
      onTap: () => controller.goToDetail(loan),
      leading: Text('${loan.id}'),
      title: _titleItem(loan),
      subtitle: Text(subtitle.orEmpty()),
      trailing: Text(loan.startDate.formatDMMYYY() ?? emptyString),
    );
  }

  Widget _titleItem(LoanEntity loan) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(loan.formatTitle),
        if (loan.idStateLoan == idOfCompleteLoan) _iconComplete()
      ],
    );
  }

  Widget _iconComplete() => IconWidget(
      padding: const EdgeInsets.only(left: 8.0),
      color: successColor(),
      iconData: Icons.check);

  Widget _searchInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
              onChanged: controller.searchValue,
              controller: searchController,
              decoration: InputDecoration(
                hintText: '¿Qué préstamo desea buscar?',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadius())),
                prefixIcon: const Icon(Icons.search),
                suffixIcon: ChildOrElseWidget(
                  condition: controller.isSearching,
                  child: IconWidget(onTap: _clearSearch, iconData: Icons.close),
                ),
              )),
          Text(
            _textOfResults,
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }

  String get _textOfResults {
    int results = controller.loans.length;
    int resultsOfShow = controller.loansToShow.length;
    return (controller.isSearching.not())
        ? 'Total: $results'
        : 'Total: $results, $resultsOfShow coincidencias.';
  }

  void _clearSearch() {
    searchController.clear();
    controller.clearSearch();
  }
}
