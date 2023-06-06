
import 'package:ditonton/presentation/bloc/tv/airing_today_bloc/airing_today_bloc.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AiringTodayPage extends StatefulWidget {
  static const ROUTE_NAME = '/airing-today';

  @override
  _AiringTodayPageState createState() => _AiringTodayPageState();
}

class _AiringTodayPageState extends State<AiringTodayPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<AiringTodayBloc>().add(LoadAiringToday()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Airing Today TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<AiringTodayBloc, AiringTodayState>(
          builder: (context, state) {
            if (state is AiringTodayLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is AiringTodayHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.data[index];
                  return TvCard(tv);
                },
                itemCount: state.data.length,
              );
            } else if (state is AiringTodayError) {
              return Center(
                key: Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: Text('Failed'),
              );
            }
          },
        ),
      ),
    );
  }
}
