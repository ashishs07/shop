import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/products_provider.dart';
import '../../models/product.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit';

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();

  final _form = GlobalKey<FormState>();

  final _titleCont = TextEditingController();
  final _descCont = TextEditingController();
  final _priceCont = TextEditingController();
  final _imageCont = TextEditingController();

  @override
  void dispose() {
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    super.dispose();
  }

  bool _isPressed = false;
  Future<void> submitProduct() async {
    if (!_form.currentState.validate()) return;
    _form.currentState.save();
    setState(() {
      _isPressed = true;
    });
    final oldProduct = ModalRoute.of(context).settings.arguments as Product;
    if (oldProduct != null) {
      final newProduct = Product(
        id: oldProduct.id,
        title: _titleCont.text,
        description: _descCont.text,
        imageUrl: _imageCont.text,
        price: _priceCont.text,
      );

      await Provider.of<ProductsProvider>(context, listen: false)
          .updateProduct(newProduct);
    } else {
      final newProduct = Product(
        id: DateTime.now().toIso8601String(),
        title: _titleCont.text,
        description: _descCont.text,
        imageUrl: _imageCont.text,
        price: _priceCont.text,
      );
      await Provider.of<ProductsProvider>(context, listen: false)
          .addProduct(newProduct);
    }

    setState(() {
      _isPressed = false;
    });
  }

  bool _once = false;
  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context).settings.arguments as Product;
    if (product != null && !_once) {
      _titleCont.text = product.title;
      _descCont.text = product.description;
      _priceCont.text = product.price;
      _imageCont.text = product.imageUrl;
      _once = true;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('New Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _form,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _buildTitleTFF(),
                _buildPriceTTF(),
                _buildDescriptionTTF(),
                _buildImageTTF(),
                _buildSubmitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitleTFF() {
    return TextFormField(
      controller: _titleCont,
      enabled: !_isPressed,
      decoration: InputDecoration(labelText: 'Title'),
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      autofocus: true,
      onFieldSubmitted: (_) =>
          FocusScope.of(context).requestFocus(_priceFocusNode),
      validator: (value) {
        if (value.isEmpty) {
          return 'Enter a Title.';
        }
        return null;
      },
    );
  }

  Widget _buildPriceTTF() {
    return TextFormField(
      controller: _priceCont,
      enabled: !_isPressed,
      decoration: InputDecoration(labelText: 'Price'),
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      focusNode: _priceFocusNode,
      onFieldSubmitted: (_) {
        FocusScope.of(context).requestFocus(_descriptionFocusNode);
      },
      validator: (value) {
        if (value.isEmpty) {
          return 'Enter a Price.';
        }
        if (double.tryParse(value) == null) {
          return 'Enter a Valid Number.';
        }
        if (double.parse(value) <= 0) {
          return 'Enter value greater than zero.';
        }
        return null;
      },
      onSaved: (value) {
        _priceCont.text = value;
      },
    );
  }

  Widget _buildDescriptionTTF() {
    return TextFormField(
      controller: _descCont,
      enabled: !_isPressed,
      decoration: InputDecoration(labelText: 'Description'),
      keyboardType: TextInputType.multiline,
      minLines: 1,
      maxLines: 3,
      focusNode: _descriptionFocusNode,
      validator: (value) {
        if (value.isEmpty) {
          return 'Enter a Description.';
        }
        if (value.length < 10) {
          return 'Enter description greater than 10.';
        }
        return null;
      },
      onSaved: (value) {
        _descCont.text = value;
      },
    );
  }

  Widget _buildImageTTF() {
    return TextFormField(
      controller: _imageCont,
      enabled: !_isPressed,
      decoration: InputDecoration(labelText: 'Image Url'),
      keyboardType: TextInputType.url,
      textInputAction: TextInputAction.done,
      validator: (value) {
        if (value.isEmpty) {
          return 'Enter an imageUrl.';
        }
        return null;
      },
      onSaved: (value) {
        _imageCont.text = value;
      },
    );
  }

  Widget _buildSubmitButton() {
    return _isPressed
        ? CircularProgressIndicator()
        : RaisedButton.icon(
            icon: Icon(Icons.save),
            label: Text('Save'),
            onPressed: submitProduct,
          );
  }
}
