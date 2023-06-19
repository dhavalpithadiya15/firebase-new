import 'package:bloc/bloc.dart';
import 'package:firebase_demo_app/main_screen/discovery/discovery_state.dart';
import 'package:firebase_demo_app/modal/map_theme_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DiscoveryCubit extends Cubit<DiscoveryState> {
  DiscoveryCubit() : super(const DiscoveryState()) {
    addThemeList();
    print("DISCOVERY CUBIT");
  }

  void onAddMarkerButtonPressed(LatLng latLng) {
    var tempSet = List<Marker>.from(state.markers).toSet();
    tempSet.add(
      Marker(markerId: const MarkerId(""), position: latLng, infoWindow: InfoWindow(title: latLng.toString())),
    );
    emit(state.copyWith(markers: tempSet));
  }

  Future<void> initController(GoogleMapController controller) async {
    var tempController = controller;

    emit(state.copyWith(googleMapController: tempController));
  }

  void addThemeList() {
    List<MapThemeModal> tempList = List.from(state.listOfMapTheme);
    tempList = [
      const MapThemeModal(image: "assets/images/standard_map.png", name: "STANDARD"),
      const MapThemeModal(image: "assets/images/silver_map.png", name: "SILVER"),
      const MapThemeModal(image: "assets/images/retro_map.png", name: "RETRO"),
      const MapThemeModal(
        image: "assets/images/night_map.png",
        name: "NIGHT",
      ),
      const MapThemeModal(image: "assets/images/dark_map.png", name: "DARK"),
      const MapThemeModal(image: "assets/images/aubergine_map.png", name: "AUBERGINE"),
    ];
    emit(state.copyWith(listOfMapTheme: tempList));
  }

  void onChangeTheme(int index) {
    emit(state.copyWith(isSelected: index));
    print(index);
  }

  Future<void> onSaveTheme(BuildContext context) async {
    switch (state.isSelected) {
      case 0:
        var standardTheme = await rootBundle.loadString("assets/map_styles/standard.json");
        state.googleMapController?.setMapStyle(standardTheme).then((value) {
          Navigator.pop(context);
        });

        break;
      case 1:
        var silverStyle = await rootBundle.loadString("assets/map_styles/silver.json");
        state.googleMapController?.setMapStyle(silverStyle).then((value) {
          print(state.selectedValue);

          Navigator.pop(context);
        });
        break;
      case 2:
        var retroStyle = await rootBundle.loadString("assets/map_styles/retro.json");
        state.googleMapController?.setMapStyle(retroStyle).then((value) {
          print(state.selectedValue);
          Navigator.pop(context);
        });
        break;
      case 3:
        var nightStyle = await rootBundle.loadString("assets/map_styles/night.json");
        state.googleMapController?.setMapStyle(nightStyle).then((value) {
          Navigator.pop(context);
        });
        break;
      case 4:
        var darkStyle = await rootBundle.loadString("assets/map_styles/dark.json");
        state.googleMapController?.setMapStyle(darkStyle).then((value) {
          print(state.selectedValue);
          Navigator.pop(context);
        });
        break;
      case 5:
        var aubergineStyle = await rootBundle.loadString("assets/map_styles/aubergine.json");
        state.googleMapController?.setMapStyle(aubergineStyle).then((value) {
          print(state.selectedValue);
          Navigator.pop(context);
        });
        break;
      default:
        var standardStyle = await rootBundle.loadString("assets/map_styles/standard.json");
        state.googleMapController?.setMapStyle(standardStyle).then((value) {
          print(state.selectedValue);
          Navigator.pop(context);
        });
    }
  }

  void onCloseDialog(int index,BuildContext context) {
    print(index);
    emit(state.copyWith(isSelected: index));
    Navigator.pop(context);
  }
}
