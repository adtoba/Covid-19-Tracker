import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:covid19/bloc/viewmodels/stats.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatefulWidget {
  MapScreen({
    @required this.statsViewModel
  });
  final StatsViewModel statsViewModel;
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  // StatsViewModel statsViewModel;
  // 1
  Completer<GoogleMapController> _controller = Completer();
// 2
  static final CameraPosition _myLocation =
      CameraPosition(target: LatLng(41.87191, 12.5674), zoom: 5.0);

  Set<Marker> values = {};
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  static List<Marker> locations = [];

  void addLocations() {
    // statsViewModel = Provider.of<StatsViewModel>(context, listen: false);
    for (var i = 0; i < widget.statsViewModel.confirmedCases.length; i++) {
      values.add(Marker(
          markerId: MarkerId('${widget.statsViewModel.confirmedCases[i].long}'),
          position: LatLng(widget.statsViewModel.confirmedCases[i].lat,
              widget.statsViewModel.confirmedCases[i].long)));
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Future.microtask(() {
      addLocations();
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: GoogleMap(
            markers: values,
            initialCameraPosition: _myLocation,
            mapType: MapType.normal,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
        ),
      ],
    );
  }

  Future<BitmapDescriptor> createCustomMarkerBitmap(
      String confirmedCases) async {
    PictureRecorder recorder = new PictureRecorder();
    Canvas c = new Canvas(recorder);

    /* Do your painting of the custom icon here, including drawing text, shapes, etc. */

    TextSpan span = new TextSpan(
        style: new TextStyle(
          color: Colors.black,
          fontSize: 35.0,
          fontWeight: FontWeight.bold,
        ),
        text: '$confirmedCases');

    TextPainter tp = new TextPainter(
      text: span,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    tp.paint(c, new Offset(20.0, 10.0));

    Picture p = recorder.endRecording();
    ByteData pngBytes =
        await (await p.toImage(tp.width.toInt() + 40, tp.height.toInt() + 20))
            .toByteData(format: ImageByteFormat.png);

    Uint8List data = Uint8List.view(pngBytes.buffer);

    return BitmapDescriptor.fromBytes(data);
  }
}
