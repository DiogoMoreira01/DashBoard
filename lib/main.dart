import 'dart:developer';
import 'package:flutter/rendering.dart';
import 'package:timelines/timelines.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: PieChartPage(),
  ));
}

class PieChartPage extends StatefulWidget {
  const PieChartPage({Key? key}) : super(key: key);

  @override
  _PieChartPageState createState() => _PieChartPageState();
}

class _PieChartPageState extends State<PieChartPage> {
  late List<GPData> _chartData;
  late TooltipBehavior _tooltipBehavior;

  TextEditingController _eventController = TextEditingController();

  String _resposta = "";

  //formatação data da agenda
  late final DateTime _data = DateTime.now();
  late final DateFormat _DataFormatada = DateFormat('dd/MM/yyyy');
  late final String _formatada = _DataFormatada.format(_data);

  //formataçao dta do cabeçalho
  late final DateFormat _FormataDataCabecalho = DateFormat('MM/yyyy');
  late final String _dataCabecalho = _FormataDataCabecalho.format(_data);

  @override
  void initState() {
    _chartData = getCharData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double _widght = size.width;
    double _height = size.height;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Dashboard"),
        backgroundColor: const Color(0xff1F1F62),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: <Widget>[
                  IconButton(
                      onPressed: () {}, icon: const Icon(Icons.arrow_back)),
                  Column(
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.fromLTRB(14, 14, 14, 0),
                        child: Text(
                          "Gráficos de Serviços",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff1F1F62)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
                        child: Text(
                          _dataCabecalho,
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff1F1F62)),
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                      onPressed: () {}, icon: const Icon(Icons.arrow_forward)),
                ],
              ),
              Container(
                height: _height * 0.30,
                padding: const EdgeInsets.only(right: 18),
                child: SfCircularChart(
                  centerY: "45%",
                  //borderColor: Color(0xff000000),
                  palette: const <Color>[
                    Color(0xff00c689),
                    Color(0xffFFD858),
                    Color(0xff0095B6),
                    Color(0xffFE645A),
                  ],

                  legend: Legend(
                    title: LegendTitle(text: 'Serviços em %'),
                    //padding: 0,
                    alignment: ChartAlignment.center,
                    isVisible: true,
                    itemPadding: 10,
                    isResponsive: true,
                    position: LegendPosition.auto,
                  ),
                  tooltipBehavior: _tooltipBehavior,
                  series: <CircularSeries>[
                    DoughnutSeries<GPData, String>(
                      enableTooltip: true,
                      dataSource: _chartData,
                      xValueMapper: (GPData data, _) => data.status,
                      yValueMapper: (GPData data, _) => data.servicos,
                      dataLabelSettings:
                          const DataLabelSettings(isVisible: true),
                      radius: '60',
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.all(14),
                    child: Text(
                      "Serviços",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff262D30)),
                    ),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Padding(
                          padding: EdgeInsets.fromLTRB(0, 14, 0, 14),
                          child: Text(
                            "Ver Todos",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(0),
                          child: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.keyboard_arrow_right)),
                        ),
                      ])
                ],
              ),
              Column(
                children: <Widget>[
                  SizedBox(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: 3,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          elevation: 4,
                          child: ListTile(
                            leading: Container(
                                height: 60,
                                width: 5,
                                color: const Color(0xffffdb58)),
                            title: Text(
                              _resposta,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            subtitle: const Text(
                                'Solicitar o desmonte de 10 pallets'),
                            trailing: const Text("09:30"),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.all(14.0),
                    child: Text(
                      "Agenda",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff262D30)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(14),
                    child: Text(
                      _formatada,
                      style: const TextStyle(
                        color: Color(0xFF1F1F62),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    // color: Color(0xFFE1E1E1),
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 3,
                        itemBuilder: (context, i) {
                          return Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(40),
                                child: Row(
                                  children: [
                                    SizedBox(width: size.width * 0.1),
                                    SizedBox(
                                      child: ClipPath(
                                        clipper: OvalLeftBorderClipper(),
                                        child: Container(
                                          height: _height * 0.08,
                                          width: _widght * 0.65,
                                          color: Color(0xFFE1E1E1),
                                          child: Center(
                                              child: Text(
                                            _resposta,
                                            style: const TextStyle(
                                              color: Color(0xFF1F1F62),
                                              fontSize: 11,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          )),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Positioned(
                                left: 50,
                                child: Container(
                                  height: size.height * 0.7,
                                  width: 1.0,
                                  color: const Color(0xffC4C4C4),
                                ),
                              ),
                              Positioned(
                                bottom: 5,
                                child: Padding(
                                  padding: const EdgeInsets.all(40.0),
                                  child: Container(
                                    height: 20.0,
                                    width: 20.0,
                                    decoration: BoxDecoration(
                                      color: const Color(0xffC4C4C4),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                  ),
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0, 14, 0, 14),
                      child: Text(
                        "Ver Todos",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(0),
                      child: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.keyboard_arrow_right)),
                    ),
                  ]),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text("Adicionar evento"),
                  content: TextFormField(
                    controller: _eventController,
                  ),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Cancelar")),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context, _eventController.text);
                          _eventController.clear();
                          setState(() {});
                          return;
                        },
                        child: const Text("Ok"))
                  ],
                )).then((value) {
          setState(() {
            _resposta = value;
          });
        }),
        //label: Text(''),
        backgroundColor: const Color(0xff1F1F62),
        child: const Icon(Icons.add),
      ),
    );
  }

  // ignore: dead_code
  List<GPData> getCharData() {
    final List<GPData> chartData = [
      GPData("Finalizado", 20),
      GPData("Agendado", 40),
      GPData("Aguardando", 30),
      GPData("Não Finalizados", 10),
    ];
    return chartData;
  }
}

class GPData {
  GPData(this.status, this.servicos);
  final String status;
  final int servicos;
}
