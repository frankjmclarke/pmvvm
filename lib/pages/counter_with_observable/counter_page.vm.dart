import 'package:flutter/cupertino.dart';
import 'package:pmvvm/pmvvm.dart';

import 'counter_page.view.dart';

class CounterPageVM extends ViewModel {
  var title = 'Counter';
  late MyWidgetProps props;

  // final counter = Observable.initialized(0);
  final counter = 0.observable('MyCounter');
  //final counter = 0.reactive('MyCounter');//? can use unobserve

  // Optional
  @override
  void init() {
    observe([counter]);
    props = context.fetch<MyWidgetProps>();
  }

  // Optional
  @override
  void onBuild() {
    // A callback when the `build` method of the view is called.
  }

  void increase() {
    counter.setValue(counter.value + 1, action: 'INCREASE');
    int prev= counter.prevValue ?? 0;
    var stream = counter.stream;
    var height = MediaQuery.of(context).size.height;
  }
}
