import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../common/widgets/elevated_button_widget.dart';
import '../../provider/is_dark_theme.dart';
import '../../router/app_routes.dart';

class ReservationSuccessView extends ConsumerStatefulWidget {
  const ReservationSuccessView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ReservationSuccessViewState();
}

class _ReservationSuccessViewState
    extends ConsumerState<ReservationSuccessView> {
  SizedBox gap = const SizedBox(height: 16);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Success'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                ref.watch(isDarkThemeProvider)
                    ? 'assets/images/white_beer.png'
                    : 'assets/images/black_beer.png',
              ))),
            ),
            gap,
            Text(
              'Thank you for your reservation.',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            gap,
            Text(
              'Your reservation has been confirmed for at .You have reserved table for  people at.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelLarge,
            ),
            gap,
            const ElevatedButtonWidget(
                buttonLabel: 'Food Order', onPress: null),
            gap,
            ElevatedButtonWidget(
              buttonLabel: 'Skip',
              onPress: () =>
                  Navigator.pushNamed(context, AppRoutes.navigationRoute),
            ),
            gap,
          ],
        ),
      ),
    );
  }
}
