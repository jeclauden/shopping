import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/providers/products_provider.dart';
import 'package:shopping/widgets/app_utility.dart';

import '../providers/product_provider.dart';

class _NewProduct {
  String id = 'undefined';
  String title = '';
  double price = 0.0;
  String imageUrl = '';
  String description = '';
  bool isFavorite = false;

  _NewProduct();
}

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({super.key});
  static const String routeName = '/edit-product';

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  final _product = _NewProduct();
  static const _chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

  var _isInit = true;
  var _initValues = {
    'title': '',
    'price': '',
    'description': '',
    'imageUrl': '',
  };

  // Must dispose of the instantiated objects to clear the memory when
  // this screen if disposed of
  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context)!.settings.arguments;

      if (productId != null) {
        final product = Provider.of<ProductsProvider>(
          context,
          listen: false,
        ).findProductById(productId as String);

        _product.id = productId;
        _product.title = product.title;
        _product.price = product.price;
        _product.description = product.description;
        _product.imageUrl = product.imageUrl;
        _product.isFavorite = product.isFavorite;

        _initValues = {
          'title': _product.title,
          'price': _product.price.toStringAsFixed(2),
          'description': _product.description,
          'imageUrl': '',
        };

        _imageUrlController.text = _product.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void _updateImageUrl() {
    if (_imageUrlFocusNode.hasFocus == false) {
      setState(() {});
    }
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (_product.id == 'undefined') {
        Provider.of<ProductsProvider>(context, listen: false)
            .addProduct(Product(
          id: AppUtility().createProductId(),
          title: _product.title,
          description: _product.description,
          price: _product.price,
          imageUrl: _product.imageUrl,
        ));
      } else {
        final product = Product(
          id: _product.id,
          title: _product.title,
          description: _product.description,
          price: _product.price,
          imageUrl: _product.imageUrl,
          isFavorite: _product.isFavorite,
        );

        Provider.of<ProductsProvider>(context, listen: false)
            .updateProduct(product);
      }

      Navigator.of(context).pop();
    }
  }

  String? _textValidator(String? value, String error) {
    if (value == null || value.isEmpty) {
      return 'Please enter the $error';
    }

    bool contained = false;

    final chars = value.split('');

    for (var char in chars) {
      if (_chars.contains(char.toUpperCase())) {
        contained = true;
        break;
      }
    }

    if (!contained) {
      return 'Please enter the $error';
    }

    return null;
  }

  String? _priceValidator(String? value, String error) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter the $error';
    } else if (double.tryParse(value) == null) {
      return 'Please enter a valid price';
    } else if (double.tryParse(value)! <= 0) {
      return 'The price should be greater than zero';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Product')),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  initialValue: _initValues['title'],
                  autofocus: true,
                  decoration: const InputDecoration(labelText: 'Title'),
                  textInputAction: TextInputAction.next,
                  // This is not necessary for iOS
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_priceFocusNode);
                  },
                  validator: (value) {
                    return _textValidator(value, 'title');
                  },
                  onSaved: (newValue) {
                    _product.title = newValue!;
                  },
                ),
                TextFormField(
                  initialValue: _initValues['price'],
                  decoration: const InputDecoration(labelText: 'Price'),
                  textInputAction: TextInputAction.next,
                  focusNode: _priceFocusNode,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  validator: (value) {
                    return _priceValidator(value, 'price');
                  },
                  onSaved: (newValue) {
                    _product.price = double.parse(newValue!);
                  },
                ),
                TextFormField(
                  initialValue: _initValues['description'],
                  maxLines: 3,
                  decoration: const InputDecoration(labelText: 'Description'),
                  keyboardType: TextInputType.multiline,
                  validator: (value) {
                    return _textValidator(value, 'description');
                  },
                  onSaved: (newValue) {
                    _product.description = newValue!;
                  },
                ),

                // Row has unconstrainted width
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: 100,
                      height: 100,
                      margin: const EdgeInsets.only(top: 8, right: 10),
                      decoration: BoxDecoration(
                          border: Border.all(
                        width: 1,
                        color: Colors.grey,
                      )),
                      child: _imageUrlController.text.isEmpty
                          ? const Text('Enter a URL')
                          : FittedBox(
                              fit: BoxFit.cover,
                              child: Image.network(
                                _imageUrlController.text,
                              ),
                            ),
                    ),
                    // TextFormField by default takes as much width as possible so it needs to be inside the Expanded
                    // widget to take the available width
                    Expanded(
                      child: TextFormField(
                        decoration:
                            const InputDecoration(labelText: 'Image URL'),
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        controller: _imageUrlController,
                        focusNode: _imageUrlFocusNode,
                        validator: (value) {
                          return _textValidator(value, 'image URL');
                        },
                        onSaved: (newValue) {
                          _product.imageUrl = newValue!;
                        },
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        _saveForm();
                      },
                      child: const Text('SUBMIT')),
                )
              ],
            )),
      ),
    );
  }
}
