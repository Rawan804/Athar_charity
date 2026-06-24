// import 'package:Athar_Charity/voulnteer.dart';
// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter/material.dart';
//
// import '../cubit/BottomBar Cubit/bottomba_cubit.dart';
// import '../cubit/BottomBar Cubit/bottombar_state.dart';
// import '../cubit/CartCubit/cart_cubit.dart';
// import '../cubit/Emergency/Emergency_cubite.dart';
// import '../cubit/voulnteerCubit/voulnteer_cubit.dart';
//
//
// class Bottombar extends StatelessWidget {
//   const Bottombar({super.key});
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return BlocConsumer<BottomNavigationCubit, BottomNavigationState>(
//       builder: (context, state) {
//         final items = <Widget>[
//           const Icon(Icons.person, size: 30, color: Colors.white),
//           const Icon(Icons.diversity_1, size: 30, color: Colors.white),
//           const Icon(Icons.home, size: 30, color: Colors.white),
//           const Icon(Icons.shopping_cart_outlined, size: 30, color: Colors.white),
//           const Icon(Icons.volunteer_activism_outlined, size: 30, color: Colors.white),
//         ];
//         return CurvedNavigationBar(
//           color: theme.bottomNavigationBarTheme.backgroundColor ?? theme.primaryColor,
//        //   buttonBackgroundColor: theme.primaryColor,
//           backgroundColor: theme.scaffoldBackgroundColor,
//           items: items,
//           height: 50,
//           index: state.index,
//           onTap: (index) {
//             context.read<BottomNavigationCubit>().changeIndex(index);
//           },
//         );
//       },
//       listener: (context, state) {
//         switch (state.index) {
//           case 1:
//             Navigator.pushReplacementNamed(context, "volunteer");
//             context.read<VolunteerCubit>().loadVolunteer();
//            // context.read<VoulnteerC>().loadVoulnteer();
//             break;
//           case 2:
//             Navigator.pushReplacementNamed(context, "home");
//             break;
//
//     case 3:
//     final cartCubit = context.read<CartCubit>();
//     if (cartCubit.currentCartId==0) {
//     Navigator.pushReplacementNamed(context, "empty_cart");
//     } else {
//     Navigator.pushReplacementNamed(context, "cart");
//     }
//     break;
//           case 0:
//             Navigator.pushReplacementNamed(context, "setting");
//           case 4:
//             Navigator.pushReplacementNamed(context, "emergency");
//             context.read<EmergencyCubite>().loadEmergency();
//             break;
//         }
//       },
//     );
//   }
// }
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../cubit/BottomBar Cubit/bottomba_cubit.dart';
import '../cubit/BottomBar Cubit/bottombar_state.dart';
import '../cubit/CartCubit/cart_cubit.dart';
import '../cubit/Emergency/Emergency_cubite.dart';
import '../cubit/voulnteerCubit/voulnteer_cubit.dart';




class Bottombar extends StatelessWidget {
  const Bottombar({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final lang = context.locale.languageCode;

    return BlocConsumer<BottomNavigationCubit, BottomNavigationState>(
      builder: (context, state) {
        final items = <Widget>[
          const Icon(Icons.person, size: 30, color: Colors.white),
          const Icon(Icons.diversity_1, size: 30, color: Colors.white),
          const Icon(Icons.home, size: 30, color: Colors.white),
          const Icon(Icons.shopping_cart_outlined, size: 30, color: Colors.white),
          const Icon(Icons.volunteer_activism_outlined, size: 30, color: Colors.white),
        ];
        return CurvedNavigationBar(
          color: theme.bottomNavigationBarTheme.backgroundColor ?? theme.primaryColor,
          //   buttonBackgroundColor: theme.primaryColor,
          backgroundColor: theme.scaffoldBackgroundColor,
          items: items,
          height: 50,
          index: state.index,
          onTap: (index) {
            context.read<BottomNavigationCubit>().changeIndex(index);
          },
        );
      },
      listener: (context, state) {
        switch (state.index) {
          case 1:
            Navigator.pushReplacementNamed(context, "volunteer");
            context.read<VolunteerCubit>().loadVolunteer(lang);
            // context.read<VoulnteerC>().loadVoulnteer();
            break;
          case 2:
            Navigator.pushReplacementNamed(context, "home");
            break;

          case 3:
            final cartCubit = context.read<CartCubit>();
            if (cartCubit.currentCartId==0) {
              Navigator.pushReplacementNamed(context, "empty_cart");
            } else {
              Navigator.pushReplacementNamed(context, "cart");
            }
            break;
          case 0:
            Navigator.pushReplacementNamed(context, "setting");
          case 4:
            Navigator.pushReplacementNamed(context, "emergency");
            context.read<EmergencyCubite>().loadEmergency(lang);
            break;
        }
      },
    );
  }
}