import 'package:flutter/material.dart';
import '../data/rx_get_products/rx.dart';
import '../widgets/product_card.dart';
import '../models/product_model.dart';
import '../../../../constants/text_font_style.dart';
import '../../../../gen/colors.gen.dart';

import '../../../../gen/assets.gen.dart';

class ProductListingScreen extends StatefulWidget {
  const ProductListingScreen({super.key});

  @override
  State<ProductListingScreen> createState() => _ProductListingScreenState();
}

class _ProductListingScreenState extends State<ProductListingScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _tabs = [
    "All",
    "Electronics",
    "Jewelery",
    "Men's Clothing",
    "More All",
    "More Electronics",
    "More Jewelery",
    "More Men's"
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    getProductsRx.fetchProducts();

    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        getProductsRx.setActiveTab(_tabController.index);
      }
    });

    getProductsRx.activeTab.listen((index) {
      if (_tabController.index != index) {
        _tabController.animateTo(index);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<ProductModel>>(
        stream: getProductsRx.productsStream,
        builder: (context, snapshot) {
          final isLoading =
              snapshot.connectionState == ConnectionState.waiting &&
                  !snapshot.hasData;
          final hasError = snapshot.hasError;
          final products = snapshot.data ?? [];

          return NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverOverlapAbsorber(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: SliverAppBar(
                    expandedHeight: 200.0,
                    collapsedHeight: 60.0,
                    toolbarHeight: 60.0,
                    pinned: true,
                    backgroundColor: AppColors.cDarazOrange,
                    forceElevated: innerBoxIsScrolled,
                    flexibleSpace: LayoutBuilder(
                      builder:
                          (BuildContext context, BoxConstraints constraints) {
                        final double top = constraints.biggest.height;
                        final bool isCollapsed = top <=
                            60 + 48 + MediaQuery.of(context).padding.top + 20;

                        return Container(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                bottom: 48.0 + 10.0, left: 16.0, right: 16.0),
                            child: AnimatedCrossFade(
                              alignment: Alignment.bottomCenter,
                              crossFadeState: isCollapsed
                                  ? CrossFadeState.showSecond
                                  : CrossFadeState.showFirst,
                              duration: const Duration(milliseconds: 250),
                              firstChild: Padding(
                                padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).padding.top + 10,
                                ),
                                child: Center(
                                  child: Image.asset(
                                    Assets.images.logo.path,
                                    color: Colors.white,
                                    fit: BoxFit.contain,
                                    height: 100,
                                  ),
                                ),
                              ),
                              secondChild: SizedBox(
                                height: 40,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText:
                                          'Search for products, brands...',
                                      hintStyle: TextFontStyle
                                          .textStyle14c6B7280Inter400,
                                      prefixIcon: const Icon(Icons.search,
                                          color: AppColors.c6B7280),
                                      border: InputBorder.none,
                                      isDense: true,
                                      contentPadding:
                                          const EdgeInsets.only(top: 8),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    bottom: PreferredSize(
                      preferredSize: const Size.fromHeight(48),
                      child: Container(
                        color: AppColors.cFFFFFF,
                        width: double.infinity,
                        child: TabBar(
                          controller: _tabController,
                          isScrollable: true,
                          labelColor: AppColors.cDarazOrange,
                          unselectedLabelColor: AppColors.c4B5563,
                          indicatorColor: AppColors.cDarazOrange,
                          labelStyle: TextFontStyle.textStyle14c0A192FInter600
                              .copyWith(color: AppColors.cDarazOrange),
                          unselectedLabelStyle:
                              TextFontStyle.textStyle14c4B5563Inter400,
                          onTap: (index) {
                            getProductsRx.setActiveTab(index);
                          },
                          tabs: _tabs.map((t) => Tab(text: t)).toList(),
                        ),
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: isLoading
                ? const Center(child: CircularProgressIndicator())
                : hasError
                    ? const Center(child: Text('Error loading products.'))
                    : TabBarView(
                        controller: _tabController,
                        children: _tabs.asMap().entries.map((entry) {
                          int idx = entry.key;

                          List<ProductModel> filtered = [];
                          if (idx % 4 == 0) {
                            filtered = products;
                          } else if (idx % 4 == 1) {
                            filtered = products
                                .where((p) => p.category == 'electronics')
                                .toList();
                          } else if (idx % 4 == 2) {
                            filtered = products
                                .where((p) => p.category == 'jewelery')
                                .toList();
                          } else if (idx % 4 == 3) {
                            filtered = products
                                .where((p) => p.category == "men's clothing")
                                .toList();
                          }

                          return SafeArea(
                            top: false,
                            bottom: true,
                            child: Builder(
                              builder: (BuildContext context) {
                                return RefreshIndicator(
                                  edgeOffset: 60 +
                                      48 +
                                      MediaQuery.of(context).padding.top,
                                  onRefresh: () async {
                                    await getProductsRx.fetchProducts(
                                        forceRefresh: true);
                                  },
                                  child: CustomScrollView(
                                    key: PageStorageKey<String>('tab_$idx'),
                                    physics:
                                        const AlwaysScrollableScrollPhysics(),
                                    slivers: [
                                      SliverOverlapInjector(
                                        handle: NestedScrollView
                                            .sliverOverlapAbsorberHandleFor(
                                                context),
                                      ),
                                      if (filtered.isEmpty)
                                        const SliverFillRemaining(
                                          child: Center(
                                            child: Text('No products found.'),
                                          ),
                                        )
                                      else
                                        SliverPadding(
                                          padding: const EdgeInsets.all(8.0),
                                          sliver: SliverGrid(
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              childAspectRatio: 0.7,
                                              crossAxisSpacing: 8.0,
                                              mainAxisSpacing: 8.0,
                                            ),
                                            delegate:
                                                SliverChildBuilderDelegate(
                                              (context, index) {
                                                return ProductCard(
                                                    product: filtered[index]);
                                              },
                                              childCount: filtered.length,
                                            ),
                                          ),
                                        ),
                                      const SliverToBoxAdapter(
                                        child: SizedBox(height: 120),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          );
                        }).toList(),
                      ),
          );
        },
      ),
    );
  }
}
