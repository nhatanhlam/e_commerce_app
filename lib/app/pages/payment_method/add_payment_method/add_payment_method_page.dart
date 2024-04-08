import 'package:e_commerce_app/app/constants/validation_type.dart';
import 'package:e_commerce_app/app/providers/payment_method_provider.dart';
import 'package:e_commerce_app/app/widgets/error_banner.dart';
import 'package:e_commerce_app/core/domain/entities/payment_method/payment_method.dart';

import 'package:e_commerce_app/utils/card_expiration_formatter.dart';
import 'package:e_commerce_app/utils/card_number_formatter.dart';
import 'package:e_commerce_app/utils/extension.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AddPaymentMethodPage extends StatefulWidget {
  const AddPaymentMethodPage({super.key});

  @override
  State<AddPaymentMethodPage> createState() => _AddPaymentMethodPageState();
}

class _AddPaymentMethodPageState extends State<AddPaymentMethodPage> {
  // Form Key (For validation)
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // TextEditingController
  final TextEditingController _txtCardNumber = TextEditingController();
  final TextEditingController _txtCardholderName = TextEditingController();
  final TextEditingController _txtExpiryDate = TextEditingController();
  final TextEditingController _txtCVV = TextEditingController();

  // FocusNode
  final FocusNode _fnCardNumber = FocusNode();
  final FocusNode _fnCardholderName = FocusNode();
  final FocusNode _fnExpiryDate = FocusNode();
  final FocusNode _fnCVV = FocusNode();

  // Validation
  ValidationType validation = ValidationType.instance;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _txtCardNumber.dispose();
    _txtCardholderName.dispose();
    _txtExpiryDate.dispose();
    _txtCVV.dispose();

    _fnCardNumber.dispose();
    _fnCardholderName.dispose();
    _fnExpiryDate.dispose();
    _fnCVV.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Payment Method'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Form
          Expanded(
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Input Card Number
                    TextFormField(
                      controller: _txtCardNumber,
                      focusNode: _fnCardNumber,
                      validator: validation.emptyValidation,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        CardNumberFormatter(),
                        LengthLimitingTextInputFormatter(19),
                      ],
                      onFieldSubmitted: (value) => FocusScope.of(context).requestFocus(_fnCardholderName),
                      decoration: const InputDecoration(
                        hintText: 'Type your card number',
                        labelText: 'Card Number',
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Input Cardholder Name
                    TextFormField(
                      controller: _txtCardholderName,
                      focusNode: _fnCardholderName,
                      textCapitalization: TextCapitalization.words,
                      validator: validation.emptyValidation,
                      keyboardType: TextInputType.name,
                      onFieldSubmitted: (value) => FocusScope.of(context).requestFocus(_fnExpiryDate),
                      decoration: const InputDecoration(
                        hintText: 'Type your Cardholder Name',
                        labelText: 'Cardholder Name',
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Input Expiry Date
                    TextFormField(
                      controller: _txtExpiryDate,
                      focusNode: _fnExpiryDate,
                      validator: validation.emptyValidation,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        CardExpirationFormatter(),
                        LengthLimitingTextInputFormatter(7),
                      ],
                      onFieldSubmitted: (value) => FocusScope.of(context).requestFocus(_fnCVV),
                      decoration: const InputDecoration(
                        hintText: 'MM/YY',
                        labelText: 'Expiry Date',
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Input CVV
                    TextFormField(
                      controller: _txtCVV,
                      focusNode: _fnCVV,
                      validator: validation.cvvValidation,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(4),
                      ],
                      onFieldSubmitted: (value) => FocusScope.of(context).unfocus(),
                      decoration: const InputDecoration(
                        hintText: 'Type your card CVV',
                        labelText: 'CVV',
                      ),
                    ),

                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),

          // Add Product Button
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),
            child: Consumer<PaymentMethodProvider>(
              builder: (context, value, child) {
                if (_isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return ElevatedButton(
                  child: const Text('Add Payment Method'),
                  onPressed: () async {
                    FocusScope.of(context).unfocus();

                    if (_formKey.currentState!.validate() && !_isLoading) {
                      try {
                        setState(() {
                          _isLoading = true;
                        });

                        ScaffoldMessenger.of(context).removeCurrentMaterialBanner();

                        PaymentMethod data = PaymentMethod(
                          paymentMethodId: ''.generateUID(),
                          cardNumber: _txtCardNumber.text,
                          cardholderName: _txtCardholderName.text,
                          expiryDate: _txtExpiryDate.text,
                          cvv: _txtCVV.text,
                          createdAt: DateTime.now(),
                          updatedAt: DateTime.now(),
                        );

                        String accountId = FirebaseAuth.instance.currentUser!.uid;

                        await value.add(accountId: accountId, data: data).whenComplete(() {
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Payment Method Added Successfully'),
                            ),
                          );
                        });
                      } catch (e) {
                        if (mounted) {
                          ScaffoldMessenger.of(context).removeCurrentMaterialBanner();
                          ScaffoldMessenger.of(context).showMaterialBanner(
                            errorBanner(context: context, msg: e.toString()),
                          );
                        }
                        setState(() {
                          _isLoading = false;
                        });
                      }
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
