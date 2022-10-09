import 'package:flutter/material.dart';
import 'package:places/UI/screens/add_sight_screen.dart';
import 'package:places/UI/screens/components/custom_elevated_button.dart';
import 'package:places/domain/sight.dart';
import 'package:places/helpers/app_colors.dart';
import 'package:places/helpers/app_strings.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screens/components/custom_app_bar.dart';
import 'package:places/ui/screens/components/custom_bottom_navigation_bar.dart';
import 'package:places/ui/screens/sight_card.dart';

/// Экран списка достопримечательностей.
class SightListScreen extends StatefulWidget {
  const SightListScreen({Key? key}) : super(key: key);

  @override
  State<SightListScreen> createState() => _SightListScreenState();
}

/// Состояние экрана списка достопримечательстей.
///
/// Обновляет список при добавлении нового места.
class _SightListScreenState extends State<SightListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppStrings.sightListAppBarTitle,
        titleTextStyle: Theme.of(context).textTheme.headline4,
        toolbarHeight: 128,
        padding: const EdgeInsets.only(
          top: 40,
          bottom: 16,
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
      body: const _SightListBody(),
      floatingActionButton: _AddNewPlaceButton(
        onPressed: () => openAddSightScreen(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  /// Открывает экран добавления достопримечательности.
  ///
  /// Если была создана новая достопримечательность, добавляет её в список моковых достопримечательностей и обновляет экран.
  Future<void> openAddSightScreen(BuildContext context) async {
    final newSight = await Navigator.push(
      context,
      MaterialPageRoute<Sight?>(
        builder: (context) => const AddSightScreen(),
      ),
    );

    if (newSight != null) {
      mocks.add(newSight);
      setState(() {});
    }
  }
}

/// Отображает список достопримечательностей.
class _SightListBody extends StatelessWidget {
  const _SightListBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(
          right: 16,
          left: 16,
        ),
        child: Column(
          children: mocks.map(SightCard.new).toList(),
        ),
      ),
    );
  }
}

/// Кнопка добавления нового места.
class _AddNewPlaceButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const _AddNewPlaceButton({
    Key? key,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorSchemeOnBackgroundColor = theme.colorScheme.onBackground;

    return CustomElevatedButton(
      AppStrings.newPlace,
      width: 177,
      height: 48,
      buttonLabel: Icon(
        Icons.add,
        size: 20,
        color: colorSchemeOnBackgroundColor,
      ),
      borderRadius: BorderRadius.circular(24),
      textStyle: theme.textTheme.bodyText2?.copyWith(
        color: colorSchemeOnBackgroundColor,
        fontWeight: FontWeight.w700,
      ),
      gradient: const LinearGradient(
        colors: [AppColors.brightSun, AppColors.fruitSalad],
      ),
      onPressed: onPressed,
    );
  }
}
