// import 'package:eva_icons_flutter/eva_icons_flutter.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:iconsax/iconsax.dart';
//
// import '../../domain/entities/product.dart';
// import '../controllers/tasks_controller.dart';
//
// class ProductView extends ConsumerWidget {
//   final Product task;
//   const ProductView({
//     Key? key,
//     required this.task,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context, ref) {
//     final tasksController = ref.watch(tasksProvider.notifier);
//     return Dismissible(
//       key: UniqueKey(),
//       onDismissed: (direction) {
//         tasksController.removeTask(task);
//       },
//       background: Container(
//         color: Colors.white,
//         child: const Icon(
//           Iconsax.trash,
//           color: Colors.red,
//           size: 20,
//         ),
//       ),
//       child: Container(
//         margin: const EdgeInsets.symmetric(vertical: 5),
//         padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
//         decoration: const BoxDecoration(
//             color: Colors.white,
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black12,
//                 blurRadius: 3,
//                 offset: Offset(0, 1),
//               )
//             ],
//             borderRadius: BorderRadius.all(Radius.circular(10))),
//         child: Row(
//           children: [
//             Expanded(
//               child: Row(
//                 children: [
//                   CheckBox(task: task),
//                   Expanded(
//                     child: Text(
//                       task.name,
//                       style: TextStyle(
//                         decoration: task.price
//                             ? TextDecoration.lineThrough
//                             : TextDecoration.none,
//                         fontSize: 18,
//                         color: task.price ? Colors.grey : Colors.black87,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             PomodoroButton(task: task)
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class CheckBox extends ConsumerWidget {
//   const CheckBox({
//     super.key,
//     required this.task,
//   });
//
//   final Product task;
//
//   @override
//   Widget build(BuildContext context, ref) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 10),
//       child: GestureDetector(
//         onTap: () {
//           ref.read(tasksProvider.notifier).toggle(task);
//         },
//         behavior: HitTestBehavior.opaque,
//         child: Icon(
//           task.price ? EvaIcons.checkmarkSquare2 : EvaIcons.squareOutline,
//           color: task.price ? Colors.black : Colors.grey,
//           size: 28,
//         ),
//       ),
//     );
//   }
// }
//
// class PomodoroButton extends ConsumerWidget {
//   const PomodoroButton({
//     super.key,
//     required this.task,
//   });
//
//   final Product task;
//
//   @override
//   Widget build(BuildContext context, ref) {
//     return GestureDetector(
//       onTap: () {},
//       behavior: HitTestBehavior.opaque,
//       child: const Padding(
//         padding: EdgeInsets.symmetric(horizontal: 10.0),
//         child: Icon(
//           Iconsax.timer_1,
//           color: Colors.grey,
//           size: 20,
//         ),
//       ),
//     );
//   }
// }
