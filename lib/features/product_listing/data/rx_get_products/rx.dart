import 'package:rxdart/rxdart.dart';
import '../../../../networks/rx_base.dart';
import '../../models/product_model.dart';
import 'api.dart';

final class GetProductsRx extends RxResponseInt<List<ProductModel>> {
  final api = GetProductsApi.instance;

  GetProductsRx({required super.empty, required super.dataFetcher});

  ValueStream<List<ProductModel>> get productsStream => dataFetcher.stream;

  // Additional stream to track active tab without rebuilding entire screen
  final BehaviorSubject<int> activeTab = BehaviorSubject<int>.seeded(0);

  Future<bool> fetchProducts({bool forceRefresh = false}) async {
    try {
      if (!forceRefresh &&
          dataFetcher.hasValue &&
          dataFetcher.value.isNotEmpty) {
        return true;
      }
      List data = await api.getProducts();
      List<ProductModel> products =
          data.map((e) => ProductModel.fromJson(e)).toList();

      // Duplicating the products lists multiple times artificially so there is
      // always enough content to scroll vertically and collapse the header
      List<ProductModel> duplicatedProducts = [];
      for (int i = 0; i < 5; i++) {
        duplicatedProducts.addAll(products);
      }
      return handleSuccessWithReturn(duplicatedProducts);
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }

  void setActiveTab(int index) {
    if (activeTab.value != index) {
      activeTab.sink.add(index);
    }
  }

  @override
  handleSuccessWithReturn(data) {
    dataFetcher.sink.add(data);
    return true;
  }

  @override
  handleErrorWithReturn(error) {
    super.handleErrorWithReturn(error);
    return false;
  }

  @override
  void dispose() {
    activeTab.close();
    super.dispose();
  }
}

// Global instance of the Rx layer
final GetProductsRx getProductsRx = GetProductsRx(
  empty: [],
  dataFetcher: BehaviorSubject<List<ProductModel>>(),
);
