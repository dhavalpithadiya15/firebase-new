import 'package:equatable/equatable.dart';
import 'package:firebase_demo_app/modal/map_theme_modal.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DiscoveryState extends Equatable {
  final Set<Marker> markers;
  final GoogleMapController? googleMapController;
  final List<MapThemeModal> listOfMapTheme;
  final String selectedValue;
  final int isSelected;

  @override
  List<Object?> get props => [markers, googleMapController, listOfMapTheme,selectedValue,isSelected];

  const DiscoveryState({
    this.listOfMapTheme = const [],
    this.markers = const {},
    this.googleMapController,
    this.selectedValue="STANDARD",
    this.isSelected=0,
  });

  DiscoveryState copyWith({
    Set<Marker>? markers,
    GoogleMapController? googleMapController,
    List<MapThemeModal>? listOfMapTheme,
    String? selectedValue,
    int? isSelected,
  }) {
    return DiscoveryState(
      markers: markers ?? this.markers,
      googleMapController: googleMapController ?? this.googleMapController,
      listOfMapTheme: listOfMapTheme ?? this.listOfMapTheme,
      selectedValue: selectedValue ?? this.selectedValue,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
