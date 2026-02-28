import 'package:rxdart/rxdart.dart';

import '../features/auth/data/rx_post_login/rx.dart';
import '../features/auth/data/rx_post_signup/rx.dart';

// Auth
PostLoginRx postLoginRxObj =
    PostLoginRx(empty: {}, dataFetcher: BehaviorSubject<Map>());

PostSignUpRx postSignUpRxObj =
    PostSignUpRx(empty: {}, dataFetcher: BehaviorSubject<Map>());