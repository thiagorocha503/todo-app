import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/generated/l10n.dart';
import 'package:todo/home/cubit/home_cubit.dart';
import 'package:todo/home/cubit/home_state.dart';
import 'package:todo/home/model/home_tab.dart';
import 'package:todo/home/ui/widget/browse_page.dart';
import 'package:todo/home/ui/widget/inbox_page.dart';
import 'package:todo/home/ui/widget/search_page.dart';
import 'package:todo/home/ui/widget/today_tab.dart';
import 'package:todo/shared/extension/string_extension.dart';

class PersistentTabItem {
  final Widget tab;
  final GlobalKey<NavigatorState>? navigatorkey;

  PersistentTabItem({required this.tab, required this.navigatorkey});
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (context) => HomeCubit(
        const HomeState(tab: HomeTab.today),
      ),
      child: const HomePageView(),
    );
  }
}

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  late List<PersistentTabItem> tabs;

  @override
  void initState() {
    super.initState();
    tabs = [
      PersistentTabItem(
        tab: const TodayPage(),
        navigatorkey: GlobalKey<NavigatorState>(),
      ),
      PersistentTabItem(
        tab: const InboxPage(),
        navigatorkey: GlobalKey<NavigatorState>(),
      ),
      PersistentTabItem(
        tab: const SearchPage(),
        navigatorkey: GlobalKey<NavigatorState>(),
      ),
      PersistentTabItem(
        tab: const BrowsePage(),
        navigatorkey: GlobalKey<NavigatorState>(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }
        int selectedTab = context.read<HomeCubit>().state.tab.index;
        if (tabs[selectedTab].navigatorkey?.currentState?.canPop() ?? false) {
          tabs[selectedTab].navigatorkey?.currentState?.pop();
          return;
        }
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      },
      child: Scaffold(
        body: BlocBuilder<HomeCubit, HomeState>(
          buildWhen: (previous, current) {
            return previous.tab != current.tab;
          },
          builder: (context, state) {
            return IndexedStack(
                index: state.tab.index,
                children: tabs.map(
                  (e) {
                    return Navigator(
                      key: e.navigatorkey,
                      onGenerateInitialRoutes: (navigator, initialRoute) => [
                        MaterialPageRoute(
                          builder: (context) => e.tab,
                        )
                      ],
                    );
                  },
                ).toList());
          },
        ),
        bottomNavigationBar: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) => Visibility(
            visible: state.show,
            child: NavigationBar(
              selectedIndex: state.tab.index,
              onDestinationSelected: (int index) {
                int selectedTab = context.read<HomeCubit>().state.tab.index;
                if (index == selectedTab) {
                  tabs[index]
                      .navigatorkey
                      ?.currentState
                      ?.popUntil((route) => route.isFirst);
                } else {
                  context
                      .read<HomeCubit>()
                      .changeDestinationSelected(HomeTab.values[index]);
                }
              },
              destinations: [
                NavigationDestination(
                  icon: const Icon(Icons.calendar_today_outlined),
                  selectedIcon: const Icon(Icons.calendar_today),
                  label: AppLocalizations.of(context).today.capitalize(),
                ),
                NavigationDestination(
                  icon: const Icon(Icons.inbox_outlined),
                  selectedIcon: const Icon(Icons.inbox),
                  label: AppLocalizations.of(context).inboxLabel.capitalize(),
                ),
                NavigationDestination(
                  icon: const Icon(Icons.search),
                  label: AppLocalizations.of(context).search.capitalize(),
                ),
                NavigationDestination(
                  icon: const Icon(Icons.menu_outlined),
                  selectedIcon: const Icon(Icons.menu),
                  label: AppLocalizations.of(context).browse.capitalize(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
