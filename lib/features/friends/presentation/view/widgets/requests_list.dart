import 'package:facebook_clone/core/constants/values.dart';
import 'package:facebook_clone/features/friends/presentation/managers/all_requests_provider.dart';
import 'package:facebook_clone/features/friends/presentation/view/widgets/request_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RequestsList extends ConsumerStatefulWidget {
  const RequestsList({super.key});

  @override
  ConsumerState<RequestsList> createState() => _RequestsListState();
}

class _RequestsListState extends ConsumerState<RequestsList> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    final friendsList = ref.watch(getAllFriendRequests);
    return friendsList.when(
      data: (requests) {
        if (requests.isEmpty) {
          return SliverToBoxAdapter(
            child: SizedBox(
              height: height * .3,
              child: const Center(
                child: Text("there is no requests yet"),
              ),
            ),
          );
        }

        return SliverList.builder(
          itemCount: requests.length,
          itemBuilder: (context, index) {
            final userId = requests.elementAt(index);
            return Padding(
              padding: Values.defaultPadding,
              child: RequestTile(
                userId: userId,
              ),
            );
          },
        );
      },
      error: (error, stackTrace) {
        return const SliverToBoxAdapter(
            child: Center(child: Icon(Icons.error, size: 40)));
      },
      loading: () {
        return const SliverToBoxAdapter(
          child: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
