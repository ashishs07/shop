import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product_model.dart';
import '../providers/products_provider.dart';

class ProductEditScreen extends StatefulWidget {
  static const routeName = '/edit';

  @override
  _ProductEditScreenState createState() => _ProductEditScreenState();
}

class _ProductEditScreenState extends State<ProductEditScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();

  var _editedProduct = Product(
    id: '',
    title: '',
    description: '',
    imageUrl: '',
    price: 0,
  );

  var _initState = true;
  var _productId;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_initState) {
      final productId = ModalRoute.of(context).settings.arguments as String;
      _productId = productId;
      if (_productId != null) {
        final existingProduct =
            Provider.of<ProductsProvider>(context).findById(_productId);
        _editedProduct = Product(
          id: existingProduct.id,
          title: existingProduct.title,
          description: existingProduct.description,
          imageUrl: existingProduct.imageUrl,
          price: existingProduct.price,
          isFavourite: existingProduct.isFavourite,
        );
      }
    }
    _initState = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    final productData = Provider.of<ProductsProvider>(context, listen: false);
    if (_form.currentState.validate()) {
      _form.currentState.save();
      setState(() {
        _isLoading = true;
      });
      if (_productId != null) {
        //Edit Product
        try {
          await productData.updateProduct(_editedProduct.id, _editedProduct);
          setState(() {
            _isLoading = false;
          });
          Navigator.of(context).pop();
        } catch (error) {
          setState(() {
            _isLoading = false;
          });
          await showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text('An Error Occured!'),
              content: Text('Updation unsuccessful!'),
              actions: <Widget>[
                FlatButton(
                  child: Text('Okay'),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                )
              ],
            ),
          );
        }
      } else {
        //Add Product
        try {
          await productData.addProduct(_editedProduct);
          setState(() {
            _isLoading = false;
          });
          Navigator.of(context).pop();
        } catch (error) {
          setState(() {
            _isLoading = false;
          });
          await showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text('An Error Occured!'),
              content: Text('Could not Add'),
              actions: <Widget>[
                FlatButton(
                  child: Text('Okay'),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                )
              ],
            ),
          );
        }
      }
    }
  }

  Widget _buildAppBar() {
    // APPBAR
    return AppBar(
      title: Text('New Product'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.save),
          onPressed: _submitForm,
        )
      ],
    );
  }

  Widget _buildForm() {
    // MAIN FORM
    return Form(
      key: _form,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _buildTitleTFF(),
            _buildPriceTTF(),
            _buildDescriptionTTF(),
            _buildImageTTF(),
            RaisedButton.icon(
              icon: Icon(Icons.save),
              label: Text('Save'),
              onPressed: _submitForm,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTitleTFF() {
    // TITLE TextField
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Title',
      ),
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      initialValue: _editedProduct.title,
      onFieldSubmitted: (_) {
        FocusScope.of(context).requestFocus(_priceFocusNode);
      },
      validator: (value) {
        if (value.isEmpty) {
          return 'Enter a Title.';
        }
        return null;
      },
      onSaved: (value) {
        _editedProduct = Product(
          id: _editedProduct.id,
          title: value,
          description: _editedProduct.description,
          imageUrl: _editedProduct.imageUrl,
          price: _editedProduct.price,
          isFavourite: _editedProduct.isFavourite,
        );
      },
    );
  }

  Widget _buildPriceTTF() {
    // PRICE TextField
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Price',
      ),
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      focusNode: _priceFocusNode,
      initialValue: _editedProduct.price.toString(),
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
        _editedProduct = Product(
          id: _editedProduct.id,
          title: _editedProduct.title,
          description: _editedProduct.description,
          imageUrl: _editedProduct.imageUrl,
          price: double.parse(value),
          isFavourite: _editedProduct.isFavourite,
        );
      },
    );
  }

  Widget _buildDescriptionTTF() {
    // DESCRIPTION TextField
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Description',
      ),
      keyboardType: TextInputType.multiline,
      maxLines: 3,
      focusNode: _descriptionFocusNode,
      initialValue: _editedProduct.description,
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
        _editedProduct = Product(
          id: _editedProduct.id,
          title: _editedProduct.title,
          description: value,
          imageUrl: _editedProduct.imageUrl,
          price: _editedProduct.price,
          isFavourite: _editedProduct.isFavourite,
        );
      },
    );
  }

  Widget _buildImageTTF() {
    // IMAGE TextField
    return TextFormField(
      decoration: InputDecoration(labelText: 'Image Url'),
      keyboardType: TextInputType.url,
      initialValue: _editedProduct.imageUrl,
      textInputAction: TextInputAction.done,
      validator: (value) {
        if (value.isEmpty) {
          return 'Enter an imageUrl.';
        }
        return null;
      },
      onSaved: (value) {
        _editedProduct = Product(
          id: _editedProduct.id,
          title: _editedProduct.title,
          description: _editedProduct.description,
          imageUrl: value,
          price: _editedProduct.price,
          isFavourite: _editedProduct.isFavourite,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: _buildForm(),
            ),
    );
  }
}
