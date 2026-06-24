import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/notifications/notification_cubit.dart';
import 'cubit/notifications/notification_state.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("الإشعارات"),
        actions: [
          IconButton(
            icon: const Icon(Icons.done_all),
            onPressed: () {
              context.read<NotificationCubit>().markAllAsRead();
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: () {
              context.read<NotificationCubit>().deleteAll();
            },
          ),
        ],
      ),
      body: BlocBuilder<NotificationCubit, NotificationState>(
        builder: (context, state) {
          if (state is NotificationLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NotificationLoaded) {
            if (state.notifications.isEmpty) {
              return const Center(child: Text("لا توجد إشعارات"));
            }

            return ListView.builder(
              itemCount: state.notifications.length,
              itemBuilder: (context, index) {
                final n = state.notifications[index];

                // ✅ تنسيق المبلغ
                String formattedAmount = n.amount % 1 == 0
                    ? n.amount.toInt().toString()
                    : n.amount.toStringAsFixed(2);

                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Container(

                              child: Text(
                                n.title,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),

                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                context.read<NotificationCubit>().deleteById(n.id);
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        // ✅ عرض النص الأساسي
                        n.amount > 0.0
                            ? Container(
                          padding: EdgeInsets.only(left: 80),
                              child: Text(
                                                        "تم التبرع بمبلغ $formattedAmount\$إلى ${n.targetName}",
                                                        style: const TextStyle(
                                fontSize: 16, color: Colors.black87),
                                                      ),
                            )
                            : Text(
                          n.body,
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black87),
                        ),

                        const SizedBox(height: 8),
                        n.submittedAt.isNotEmpty
                            ? Container(
                          padding: EdgeInsets.only(left: 80),
                              child: Text(
                                                        "تاريخ الاشعار : ${n.submittedAt}",
                                                        style: const TextStyle(
                                fontSize: 16, color: Colors.black),
                                                      ),
                            )
                            : const SizedBox.shrink(),
                        n.status.isNotEmpty
                            ? Text(
                          "${n.status}: حالة الطلب",
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black),
                          textAlign: TextAlign.right,
                        )
                            : const SizedBox.shrink(),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is NotificationError) {
            return Center(child: Text(state.message));
          }

          return Container();
        },
      ),
    );
  }
}
