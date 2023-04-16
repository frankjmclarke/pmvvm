import 'package:pmvvm/pmvvm.dart';
import 'package:flutter/material.dart';

import 'counter_page.vm.dart';

class MyWidgetProps {
  MyWidgetProps({required this.name});

  final String name;
}

class CounterPage extends StatelessWidget {
  CounterPage({Key? key, required String name})
      : props = MyWidgetProps(name: name),
        super(key: key);
  final MyWidgetProps props;

  @override
  Widget build(context) {
    return Provider.value(
      value: props,
      child: MVVM<CounterPageVM>(
        view: () => _CounterPageView(name: 'My Name',),
        viewModel: CounterPageVM(),
      ),
    );
  }
}

class _CounterPageView extends StatelessView<CounterPageVM> {
  /// Set [reactive] to [false] if you don't want the view to listen to the ViewModel.
  /// It's [true] by default.
   _CounterPageView({Key? key,required String name}) : props = MyWidgetProps(name: name),
        super(key: key, reactive: true);

  final MyWidgetProps props;

  @override
  Widget render(context, page) {
    return Scaffold(
      appBar: AppBar(title: Text(page.title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // If you don't want the viewModel to refresh the whole page, you
            // can set super(key: key, reactive: false) and use the Selector

            /* Selector<CounterPageVM, int>(
              selector: (_, page) => page.counter,
              builder: (_, data, __) {
                return Text(
                  data.toString(),
                  style: Theme.of(context).textTheme.headline4,
                );
              },
            ), */

            Text(
              page.counter.value.toString(),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: page.increase,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
