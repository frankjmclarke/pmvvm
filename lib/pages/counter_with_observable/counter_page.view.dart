import 'package:pmvvm/pmvvm.dart';
import 'package:flutter/material.dart';

import 'counter_page.vm.dart';

class MyWidgetProps {
  MyWidgetProps({required this.name});

  final String name;
}
/*
Hooks are a new kind of object that manage the life-cycle of a Widget. They
exist for one reason: increase the code-sharing between widgets by removing
duplicates. it is very difficult to reuse the logic of say initState or dispose
in StatefulWidget. https://github.com/rrousselGit/flutter_hooks#existing-hooks
 */
/*
https://pub.dev/packages/provider
A wrapper around InheritedWidget to make them easier to use and more reusable.
Provider<T>
A Provider that manages the lifecycle of the value it provides by delegating to
a pair of Create and Dispose.
 */
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
  Widget render(context, pageVM) {
     pageVM.counter.stream.listen((value) { });
     return Scaffold(
      appBar: AppBar(title: Text(pageVM.title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: <Widget>[
              Text(pageVM.getCounter2().toString()),
              SizedBox(height: 24),
              TextButton(onPressed: pageVM.increase2, child: Text('Increase')),

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
              pageVM.counter.value.toString(),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: pageVM.increase,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
