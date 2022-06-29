import 'package:flutter/material.dart';
import 'main.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/calendar/v3.dart' as googleAPI;
import 'package:http/io_client.dart';
import 'package:http/http.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Camp App Calendar Page'),
      ),
      body: FutureBuilder(
        future: getGoogleEventsData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
              child: Stack(
            children: [
              Container(
                child: SfCalendar(
                  view: CalendarView.week,
                  dataSource: GoogleDataSource(events: snapshot.data),
                  monthViewSettings: MonthViewSettings(
                      appointmentDisplayMode:
                          MonthAppointmentDisplayMode.appointment),
                ),
              ),
              snapshot.data != null
                  ? Container()
                  : Center(
                      child: CircularProgressIndicator(),
                    )
            ],
          ));
        },
      ),
    );
  }

  Future<List<googleAPI.Event>> getGoogleEventsData() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    final GoogleAPIClient httpClient =
        GoogleAPIClient(await googleUser!.authHeaders);
    final googleAPI.CalendarApi calendarAPI = googleAPI.CalendarApi(httpClient);
    final googleAPI.Events calEvents = await calendarAPI.events.list(
      "primary",
    );
    final List<googleAPI.Event> appointments = <googleAPI.Event>[];
    if (calEvents.items != null) {
      for (int i = 0; i < calEvents.items!.length; i++) {
        final googleAPI.Event event = calEvents.items![i];
        if (event.start == null) {
          continue;
        }
        appointments.add(event);
      }
    }
    return appointments;
  }
}

class GoogleDataSource extends CalendarDataSource {
  GoogleDataSource({required List<googleAPI.Event> events}) {
    this.appointments = events;
  }
  @override
  DateTime getStartTime(int index) {
    final googleAPI.Event event = appointments![index];
    return event.start!.date ?? event.start!.dateTime!.toLocal();
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].start.date != null;
  }

  @override
  DateTime getEndTime(int index) {
    final googleAPI.Event event = appointments![index];
    DateTime? rtndt = event.start!.dateTime!.toLocal();
    if (event.end != null) {
      rtndt = event.end!.dateTime!.toLocal();
    }
    return rtndt;

    // rtndt ??= event.start!.dateTime!.toLocal();

    // return (event.endTimeUnspecified != null && event.endTimeUnspecified)
    //     ? (event.start!.date ?? event.start!.dateTime!.toLocal())
    //     : (event.end!.date != null
    //         ? event.end!.date!.add(Duration(days: -1))
    //         : event.end!.dateTime!.toLocal());
  }

  @override
  String getLocation(int index) {
    return appointments![index].location;
  }

  @override
  String getNotes(int index) {
    return appointments![index].description;
  }

  @override
  String getSubject(int index) {
    final googleAPI.Event event = appointments![index];
    String? rtn = event.summary;
    rtn ??= 'No Title';
    return rtn;
  }
}

class GoogleAPIClient extends IOClient {
  // ignore: prefer_final_fields
  Map<String, String> _headers;
  GoogleAPIClient(this._headers) : super();
  @override
  Future<IOStreamedResponse> send(BaseRequest request) =>
      super.send(request..headers.addAll(_headers));
  @override
  Future<Response> head(Object url, {Map<String, String>? headers}) => super
      .head(Uri.parse(url.toString()), headers: headers!..addAll(_headers));
}

final GoogleSignIn _googleSignIn = GoogleSignIn(
  clientId: 'OAuth Client ID',
  scopes: <String>[googleAPI.CalendarApi.calendarEventsReadonlyScope],
);
