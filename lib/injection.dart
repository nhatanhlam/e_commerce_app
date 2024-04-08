import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/app/constants/collections_name.dart';
import 'package:e_commerce_app/core/repositories/account_repository_impl.dart';
import 'package:e_commerce_app/core/repositories/address_repository_impl.dart';
import 'package:e_commerce_app/core/repositories/auth_repository_impl.dart';
import 'package:e_commerce_app/core/repositories/cart_repository_impl.dart';
import 'package:e_commerce_app/core/repositories/checkout_repository_impl.dart';
import 'package:e_commerce_app/core/repositories/payment_method_repository_impl.dart';
import 'package:e_commerce_app/core/repositories/product_repository_impl.dart';
import 'package:e_commerce_app/core/repositories/transaction_repository_impl.dart';
import 'package:e_commerce_app/core/repositories/wishlist_repository_impl.dart';
import 'package:e_commerce_app/core/domain/repositories/account_repository.dart';
import 'package:e_commerce_app/core/domain/repositories/address_repository.dart';
import 'package:e_commerce_app/core/domain/repositories/auth_repository.dart';
import 'package:e_commerce_app/core/domain/repositories/cart_repository.dart';
import 'package:e_commerce_app/core/domain/repositories/checkout_repository.dart';
import 'package:e_commerce_app/core/domain/repositories/payment_method_repository.dart';
import 'package:e_commerce_app/core/domain/repositories/product_repository.dart';
import 'package:e_commerce_app/core/domain/repositories/transaction_repository.dart';
import 'package:e_commerce_app/core/domain/repositories/wishlist_repository.dart';
import 'package:e_commerce_app/core/domain/usecases/account/ban_account.dart';
import 'package:e_commerce_app/core/domain/usecases/account/get_account_profile.dart';
import 'package:e_commerce_app/core/domain/usecases/account/get_all_account.dart';
import 'package:e_commerce_app/core/domain/usecases/account/update_account.dart';
import 'package:e_commerce_app/core/domain/usecases/address/add_address.dart';
import 'package:e_commerce_app/core/domain/usecases/address/get_account_address.dart';
import 'package:e_commerce_app/core/domain/usecases/address/update_address.dart';
import 'package:e_commerce_app/core/domain/usecases/auth/login_account.dart';
import 'package:e_commerce_app/core/domain/usecases/auth/register_account.dart';
import 'package:e_commerce_app/core/domain/usecases/cart/add_account_cart.dart';
import 'package:e_commerce_app/core/domain/usecases/cart/delete_account_cart.dart';
import 'package:e_commerce_app/core/domain/usecases/cart/get_account_cart.dart';
import 'package:e_commerce_app/core/domain/usecases/cart/update_account_cart.dart';
import 'package:e_commerce_app/core/domain/usecases/checkout/pay.dart';
import 'package:e_commerce_app/core/domain/usecases/checkout/start_checkout.dart';
import 'package:e_commerce_app/core/domain/usecases/payment_method/add_payment_method.dart';
import 'package:e_commerce_app/core/domain/usecases/payment_method/delete_payment_method.dart';
import 'package:e_commerce_app/core/domain/usecases/payment_method/get_account_payment_method.dart';
import 'package:e_commerce_app/core/domain/usecases/payment_method/update_payment_method.dart';
import 'package:e_commerce_app/core/domain/usecases/product/add_product.dart';
import 'package:e_commerce_app/core/domain/usecases/product/delete_product.dart';
import 'package:e_commerce_app/core/domain/usecases/product/get_list_product.dart';
import 'package:e_commerce_app/core/domain/usecases/product/get_product.dart';
import 'package:e_commerce_app/core/domain/usecases/product/get_product_review.dart';
import 'package:e_commerce_app/core/domain/usecases/product/update_product.dart';
import 'package:e_commerce_app/core/domain/usecases/transaction/accept_transaction.dart';
import 'package:e_commerce_app/core/domain/usecases/transaction/add_review.dart';
import 'package:e_commerce_app/core/domain/usecases/transaction/change_transaction_status.dart';
import 'package:e_commerce_app/core/domain/usecases/transaction/get_account_transaction.dart';
import 'package:e_commerce_app/core/domain/usecases/transaction/get_all_transaction.dart';
import 'package:e_commerce_app/core/domain/usecases/transaction/get_transaction.dart';
import 'package:e_commerce_app/core/domain/usecases/wishlist/add_account_wishlist.dart';
import 'package:e_commerce_app/core/domain/usecases/wishlist/delete_account_wishlist.dart';
import 'package:e_commerce_app/core/domain/usecases/wishlist/get_account_wishlist.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

// Firestore Top Collection Reference
final accountCollection = FirebaseFirestore.instance.collection(CollectionsName.kACCOUNT);
final productCollection = FirebaseFirestore.instance.collection(CollectionsName.kPRODUCT);
final transactionCollection = FirebaseFirestore.instance.collection(CollectionsName.kTRANSACTION);

void setup() {
  // Repositories
  getIt.registerLazySingleton<AccountRepository>(
    () => AccountRepositoryImpl(collectionReference: accountCollection),
  );

  getIt.registerLazySingleton<AddressRepository>(
    () => AddressRepositoryImpl(collectionReference: accountCollection),
  );

  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(auth: FirebaseAuth.instance, collectionReference: accountCollection),
  );

  getIt.registerLazySingleton<CartRepository>(
    () => CartRepositoryImpl(collectionReference: accountCollection),
  );

  getIt.registerLazySingleton<CheckoutRepository>(
    () => CheckoutRepositoryImpl(collectionReference: transactionCollection),
  );

  getIt.registerLazySingleton<PaymentMethodRepository>(
    () => PaymentMethodRepositoryImpl(collectionReference: accountCollection),
  );

  getIt.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(collectionReference: productCollection),
  );

  getIt.registerLazySingleton<TransactionRepository>(
    () => TransactionRepositoryImpl(collectionReference: transactionCollection),
  );

  getIt.registerLazySingleton<WishlistRepository>(
    () => WishlistRepositoryImpl(collectionReference: accountCollection),
  );
  // END

  // Use Cases

  // Account Use Cases
  getIt.registerLazySingleton<BanAccount>(
    () => BanAccount(getIt<AccountRepository>()),
  );
  getIt.registerLazySingleton<GetAccountProfile>(
    () => GetAccountProfile(getIt<AccountRepository>()),
  );
  getIt.registerLazySingleton<GetAccountProfile>(
    () => GetAccountProfile(getIt<AccountRepository>()),
  );
  getIt.registerLazySingleton<GetAllAccount>(
    () => GetAllAccount(getIt<AccountRepository>()),
  );
  getIt.registerLazySingleton<UpdateAccount>(
    () => UpdateAccount(getIt<AccountRepository>()),
  );

  // Address Use Cases
  getIt.registerLazySingleton<AddAddress>(
    () => AddAddress(getIt<AddressRepository>()),
  );
  getIt.registerLazySingleton<GetAccountAddress>(
    () => GetAccountAddress(getIt<AddressRepository>()),
  );
  getIt.registerLazySingleton<UpdateAddress>(
    () => UpdateAddress(getIt<AddressRepository>()),
  );

  // Auth Use Cases
  getIt.registerLazySingleton<LoginAccount>(
    () => LoginAccount(getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<RegisterAccount>(
    () => RegisterAccount(getIt<AuthRepository>()),
  );

  // Cart Use Cases
  getIt.registerLazySingleton<AddAccountCart>(
    () => AddAccountCart(getIt<CartRepository>()),
  );
  getIt.registerLazySingleton<DeleteAccountCart>(
    () => DeleteAccountCart(getIt<CartRepository>()),
  );
  getIt.registerLazySingleton<GetAccountCart>(
    () => GetAccountCart(getIt<CartRepository>()),
  );
  getIt.registerLazySingleton<UpdateAccountCart>(
    () => UpdateAccountCart(getIt<CartRepository>()),
  );

  // Checkout Use Cases
  getIt.registerLazySingleton<Pay>(
    () => Pay(getIt<CheckoutRepository>()),
  );
  getIt.registerLazySingleton<StartCheckout>(
    () => StartCheckout(getIt<CheckoutRepository>()),
  );

  // Payment Method Use Cases
  getIt.registerLazySingleton<AddPaymentMethod>(
    () => AddPaymentMethod(getIt<PaymentMethodRepository>()),
  );
  getIt.registerLazySingleton<DeletePaymentMethod>(
    () => DeletePaymentMethod(getIt<PaymentMethodRepository>()),
  );
  getIt.registerLazySingleton<GetAccountPaymentMethod>(
    () => GetAccountPaymentMethod(getIt<PaymentMethodRepository>()),
  );
  getIt.registerLazySingleton<UpdatePaymentMethod>(
    () => UpdatePaymentMethod(getIt<PaymentMethodRepository>()),
  );

  // Product Use Cases
  getIt.registerLazySingleton<AddProduct>(
    () => AddProduct(getIt<ProductRepository>()),
  );
  getIt.registerLazySingleton<DeleteProduct>(
    () => DeleteProduct(getIt<ProductRepository>()),
  );
  getIt.registerLazySingleton<GetListProduct>(
    () => GetListProduct(getIt<ProductRepository>()),
  );
  getIt.registerLazySingleton<GetProductReview>(
    () => GetProductReview(getIt<ProductRepository>()),
  );
  getIt.registerLazySingleton<GetProduct>(
    () => GetProduct(getIt<ProductRepository>()),
  );
  getIt.registerLazySingleton<UpdateProduct>(
    () => UpdateProduct(getIt<ProductRepository>()),
  );

  // Transaction Use Cases
  getIt.registerLazySingleton<AcceptTransaction>(
    () => AcceptTransaction(getIt<TransactionRepository>()),
  );
  getIt.registerLazySingleton<AddReview>(
    () => AddReview(getIt<TransactionRepository>()),
  );
  getIt.registerLazySingleton<ChangeTransactionStatus>(
    () => ChangeTransactionStatus(getIt<TransactionRepository>()),
  );
  getIt.registerLazySingleton<GetAccountTransaction>(
    () => GetAccountTransaction(getIt<TransactionRepository>()),
  );
  getIt.registerLazySingleton<GetAllTransaction>(
    () => GetAllTransaction(getIt<TransactionRepository>()),
  );
  getIt.registerLazySingleton<GetTransaction>(
    () => GetTransaction(getIt<TransactionRepository>()),
  );

  // Wishlist Use Cases
  getIt.registerLazySingleton<AddAccountWishlist>(
    () => AddAccountWishlist(getIt<WishlistRepository>()),
  );
  getIt.registerLazySingleton<DeleteAccountWishlist>(
    () => DeleteAccountWishlist(getIt<WishlistRepository>()),
  );
  getIt.registerLazySingleton<GetAccountWishlist>(
    () => GetAccountWishlist(getIt<WishlistRepository>()),
  );
}
