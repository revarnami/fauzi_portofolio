import 'package:fauzi_portofolio/core/utils/size_config.dart';
import 'package:fauzi_portofolio/src/profile/presentation/cubit/profile_cubit.dart';
import 'package:fauzi_portofolio/core/general_widget/triangle_component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void getProfile() {
    context.read<ProfileCubit>().getProfiles();
  }

  @override
  void initState() {
    super.initState();
    getProfile();
  }

  double sizeAvatar = 150;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                DiagonalHalfRectangle(
                  size: SizeConfig.screenWidth * 3 / 4,
                  color: Colors.blueAccent,
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        const Expanded(
                            child: SizedBox(
                          width: 8,
                        )),
                        Container(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                          width: sizeAvatar,
                          height: sizeAvatar,
                          child: state is GettingProfile
                              ? Shimmer.fromColors(
                                  baseColor: Colors.grey.shade300,
                                  highlightColor: Colors.grey.shade100,
                                  child: SizedBox(
                                    width: sizeAvatar,
                                    height: sizeAvatar,
                                  ),
                                )
                              : state is ProfileLoaded
                                  ? CircleAvatar(
                                      radius: 48,
                                      backgroundImage: NetworkImage(
                                        state.profiles.first.avatar,
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                        ),
                        const Expanded(
                            child: SizedBox(
                          width: 8,
                        )),
                      ],
                    ),
                    if (state is GettingProfile)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: Text(
                            'Getting data email',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                      ),
                    if (state is ProfileLoaded)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                        child: Text(
                          state.profiles.first.name,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      )
                    else
                      const SizedBox.shrink(),
                    if (state is ProfileLoaded)
                      Text(
                        state.profiles.first.email,
                        style: Theme.of(context).textTheme.bodyMedium,
                      )
                    else
                      const SizedBox.shrink(),
                    if (state is ProfileLoaded)
                      Text(
                        state.profiles.first.phoneNumber,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
