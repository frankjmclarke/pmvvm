import 'package:flutter/cupertino.dart';
import 'package:pmvvm/pmvvm.dart';

import 'counter_page.view.dart';

class CounterPageVM extends ViewModel {
  var title = 'Counter';
  late MyWidgetProps props;//access your widget properties

  // final counter = Observable.initialized(0);
  final counter = 0.observable('MyCounter');//'MyCounter' comes handy in logging
  final _counter2 = 0.observable('MyCounter2');
  //final counter = 0.reactive('MyCounter');//? can use unobserve

  // Optional
  @override
  void init() {
    observe([counter]);
    props = context.fetch<MyWidgetProps>();
  }
  int getCounter2(){
    return _counter2.value;
   }
  // Optional
  @override
  void onBuild() {
    // A callback when the `build` method of the view is called.
  }

  void increase() {
    counter.setValue(counter.value + 1, action: 'INCREASE');
  }

  void increase2() {
    _counter2.setValue(_counter2.value+1, action: 'INCREASE');
    notifyListeners();
    int prev= counter.prevValue ?? 0;
    var stream = counter.stream;
    var height = MediaQuery.of(context).size.height;
  }

/*
  /// A callback when the view disposed.
  void onDispose() {}

  @override
  void onPause() {}
  /// A callback when the application is visible and responding to user input.
  @override
  void onResume() {}
  /// - A callback when the application is in an inactive state and is not receiving user input.
  /// - For [IOS] only.
  @override
  void onInactive() {}
  /// - A callback when the application is still hosted on a flutter engine but
  ///   is detached from any host views.
  /// - For [Android] only.
  @override
  void onDetach() {}
  @override
  void onUnmount() {}
  @override
  void onMount() {}
  @override
  void onDependenciesChange() {}
  */

}
