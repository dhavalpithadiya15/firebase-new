import 'package:country_picker/country_picker.dart';
import 'package:firebase_demo_app/main_screen/discovery/discovery_cubit.dart';
import 'package:firebase_demo_app/main_screen/discovery/discovery_state.dart';
import 'package:firebase_demo_app/main_screen/form/form_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DiscoveryView extends StatelessWidget {
  const DiscoveryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(37.42796133580664, -122.085749655962),
      zoom: 14.4746,
    );
    return Scaffold(
      body: BlocBuilder<DiscoveryCubit, DiscoveryState>(
        builder: (context, state) {
          return Stack(
            children: [
              GoogleMap(
                onMapCreated: (GoogleMapController controller) {
                  print("=========${controller}");
                  BlocProvider.of<DiscoveryCubit>(context).initController(controller);
                  print("==${state.googleMapController}");
                },
                markers: state.markers,
                buildingsEnabled: true,
                compassEnabled: true,
                initialCameraPosition: _kGooglePlex,
                onTap: (argument) {
                  BlocProvider.of<DiscoveryCubit>(context).onAddMarkerButtonPressed(argument);
                },
                indoorViewEnabled: true,
              ),
              Positioned(
                right: 15,
                top: 15,
                child: InkWell(
                  onTap: () {
                    showDialog(
                      barrierDismissible: false ,
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          actionsPadding: const EdgeInsets.all(10),
                          insetPadding: const EdgeInsets.symmetric(horizontal: 15),
                          title: Row(
                            children: [
                              Expanded(
                                child: Container(),
                              ),
                              const Expanded(
                                flex: 5,
                                child: Text(
                                  "Change Map Theme",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                              Expanded(
                                child: CloseButton(onPressed: () {
                                  BlocProvider.of<DiscoveryCubit>(context).onCloseDialog(state.isSelected,context);
                                }),
                              ),
                            ],
                          ),
                          alignment: Alignment.center,
                          contentPadding: const EdgeInsets.all(10),
                          titlePadding: const EdgeInsets.all(10),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                          content: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              runAlignment: WrapAlignment.center,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              direction: Axis.horizontal,
                              children: List.generate(state.listOfMapTheme.length, (index) {
                                return InkWell(
                                  onTap: () {
                                    BlocProvider.of<DiscoveryCubit>(context).onChangeTheme(index);
                                  },
                                  child: Container(
                                    height: 100,
                                    width: (MediaQuery.of(context).size.width - 70) / 3,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage(state.listOfMapTheme[index].image),
                                      ),
                                    ),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        BlocBuilder<DiscoveryCubit, DiscoveryState>(
                                          builder: (context, state) {
                                            return Positioned(
                                              top: 10,
                                              left: 10,
                                                child: state.isSelected==index
                                                    ? const Icon(
                                                        Icons.check_circle,
                                                        color: Colors.blue,
                                                        size: 18,
                                                      )
                                                    : const Icon(
                                                        Icons.circle_outlined,
                                                        size: 18,
                                                        color: Colors.white70,
                                                      ),
                                            );
                                          },
                                        ),
                                        Positioned(
                                          bottom: 0,
                                          child: Text(
                                            state.listOfMapTheme[index].name,
                                            style: const TextStyle(
                                                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 13),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                          actions: [
                            Center(
                              child: InkWell(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.blue,
                                  ),
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(10),
                                  width: MediaQuery.of(context).size.width * 0.32,
                                  child: const Text("Save",
                                      style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500)),
                                ),
                                onTap: () {

                                  BlocProvider.of<DiscoveryCubit>(context).onSaveTheme(context);
                                },
                              ),
                            )
                          ],
                        );
                      },
                    );
                  },
                  child: const CircleAvatar(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
