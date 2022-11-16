import 'package:flutter/material.dart';

class TvDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail-tv';

  final int id;
  const TvDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  State<TvDetailPage> createState() => _TvDetailPageState();
}

class _TvDetailPageState extends State<TvDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
