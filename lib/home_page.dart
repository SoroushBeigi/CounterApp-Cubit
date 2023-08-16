import 'package:counter_cubit/bloc/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            //You can use BlocConsumer, which is a combination of BlocListener and BlocBuilder.
            //Calling a function like showSnackBar won't work here, because we can't call it in the middle of our widget trees
            //And Flutter will produce errors because the function call has happened while it was rendering widgets.
            //So a better way is to use BlocListener to call the function, and when we are using BlocBuilder even a better way
            //Would be replacing it with a BlocConsumer.

            BlocConsumer<CounterCubit, int>(

              //Only show snackbar in -10 to 10 range!
              listenWhen: (previous, current) => previous<10 && previous>-10,

              listener: (context, state) =>
                  ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('New Value: ${state.toString()}'),
                  duration: const Duration(microseconds: 500),
                ),
              ),

              //Limiting the counter to -15 to 15 range!
              buildWhen: (previous, current) => previous<15 && previous>-15,
              builder: (context, state) => Text(
                state.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 25,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () =>
                      BlocProvider.of<CounterCubit>(context).decrease(),
                  child: const Text('-'),
                ),
                const SizedBox(width: 20,),
                ElevatedButton(
                  onPressed: () =>
                      BlocProvider.of<CounterCubit>(context).increase(),
                  child: const Text('+'),
                ),
              ],
            ),
          ],
        ),
      ),
      //
    );
  }
}
