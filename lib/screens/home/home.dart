import 'package:flutter/material.dart';
import 'package:final_flutter/screens/products/products.dart';
import 'package:final_flutter/shared/constants.dart';
import 'package:final_flutter/shared/loading.dart';
import 'package:final_flutter/viewmodels/home_viewmodel.dart';
import 'package:final_flutter/base/model.dart';
import 'package:final_flutter/base/view.dart';
import 'package:final_flutter/models/product.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(
      builder: (context, model, child) {
        return Scaffold(
            key: _scaffoldKey,
            resizeToAvoidBottomPadding: false,
            appBar: AppBar(
              title: Text('Bienvenido'),
              actions: <Widget>[
                IconButton(
                  onPressed: () async {
                    model.logout();
                  },
                  icon:
                      Icon(Icons.exit_to_app, color: Colors.black, size: 24.0),
                )
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
               
                SelectedProduct selectedProduct = await Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Products()));

                model.addProductToCart(selectedProduct);
              },
              child: Icon(Icons.add, color: Colors.black, size: 24.0),
            ),
            body: model.state == ViewState.Busy
                ? Center(
                    child: Loading(),
                  )
                : homeView(model));
      },
    );
  }

  Widget homeView(HomeViewModel model) {
    return SingleChildScrollView(
        child: Column(
      children: <Widget>[
        Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 15.0),
            child: Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Column(children: <Widget>[
                Text(
                  'Mi lista',
                ),
                SizedBox(height: 20.0),
                model.selectedProducts.length > 0
                    ? listaDeProducts(model)
                    : Text(
                        'No hay productos',
                      ),
                model.selectedProducts.length > 0
                    ? Text(
                        'Total',
                      )
                    : SizedBox(),
                model.selectedProducts.length > 0
                    ? Container(
                        margin: EdgeInsets.only(bottom: 15.0),
                        child: totalView(model.selectedProducts))
                    : SizedBox(),
                    
              ]),
            ),
          ),
        ),
      ],
    ));
  }

  Widget totalView(List<SelectedProduct> products) {
    return Card(
      child: Container(
          
          child: Center(
            child: Text(
              '\$${total(products)}',
            ),
          )),
    );
  }

  String total(List<SelectedProduct> products) {
    double total = 0.0;
    products.forEach((p) => total += (p.product.price * p.quantity));
    return total.toString();
  }

  Widget listaDeProducts(HomeViewModel model) {
    return Container(
        height: 455.0,
        child: ListView.builder(
          itemCount: model.selectedProducts.length,
          itemBuilder: (context, position) {
            return prodCard(model.selectedProducts[position].product,
                model.selectedProducts[position].quantity, position, model);
          },
        ));
  }

  Widget prodCard(
      Product product, int quantity, int position, HomeViewModel model) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        model.removeProduct(position);
      },
      child: Card(
          child: Container(
        margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
        child: ListTile(
          leading: Icon(Icons.fastfood, size: 30.0),
          title:
              Text(product.name, style: TextStyle(fontWeight: FontWeight.w500)),
          subtitle: Container(
            margin: EdgeInsets.only(
              top: 5.0,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Card(
                  color: Colors.green,
                  child: Container(
                      padding: const EdgeInsets.all(5.0),
                      child: Text('Price: \$${product.price.toString()}',
                          style: TextStyle(color: Colors.white))),
                ),
                Card(
                  color: Colors.blue,
                  child: Container(
                      padding: const EdgeInsets.all(5.0),
                      child: Text('Quantity: $quantity',
                          style: TextStyle(color: Colors.white))),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
  
}
