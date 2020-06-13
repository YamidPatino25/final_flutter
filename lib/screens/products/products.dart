import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:final_flutter/models/product.dart';
import 'package:final_flutter/shared/constants.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  Product selectedProduct;
  final qtyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de productos'),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              listOfProducts(),
              selectedProduct != null
                  ? Text(
                      'Selección',
                    )
                  : SizedBox(),
              selectedProduct != null
                  ? productCard(selectedProduct)
                  : SizedBox(),
              selectedProduct != null
                  ? Text(
                      'Cantidad',
                    )
                  : SizedBox(),
              quantityField(),
              addButton(),
              SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget listOfProducts() {
    List<Product> products = [
      Product(name: 'Tomato', price: 1.0),
      Product(name: 'Pizza', price: 10.0),
      Product(name: 'Cheese', price: 3.0),
      Product(name: 'Apple', price: 1.0),
    ];

    return Container(
        height: 340.0,
        child: ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, position) {
            var product = products[position];
            return productCard(product);
          },
        ));
  }

  Widget productCard(Product product) {
    return Card(
        child: Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: ListTile(
        leading: Icon(Icons.fastfood, size: 30.0),
        title: Row(
          children: <Widget>[
            Text(product.name, style: TextStyle(fontWeight: FontWeight.w500)),
            Container(
              margin: EdgeInsets.only(left: 10.0),
              child: Card(
                color: Colors.green,
                child: Container(
                    padding: const EdgeInsets.all(5.0),
                    child: Text('Price: \$${product.price.toString()}',
                        style: TextStyle(color: Colors.white))),
              ),
            )
          ],
        ),
        onTap: () {
          setState(() {
            selectedProduct = product;
          });
        },
      ),
    ));
  }

  Widget quantityField() {
    return selectedProduct != null
        ? TextField(
            controller: qtyController,
            decoration: InputDecoration(labelText: 'Ingrese una cantidad'),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              WhitelistingTextInputFormatter.digitsOnly
            ],
          )
        : SizedBox();
  }

  Widget addButton() {
    return selectedProduct != null
        ? RaisedButton(
            child: Text('Agregar'),
            onPressed: () {
              Navigator.of(context).pop(SelectedProduct(
                  product: selectedProduct,
                  quantity: int.parse(qtyController.text)));
            },
          )
        : SizedBox();
  }
}
