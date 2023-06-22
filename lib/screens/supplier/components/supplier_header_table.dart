
import 'package:admin/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants.dart';
class SupplierHeaderTable extends StatelessWidget {
  const SupplierHeaderTable({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Danh sách các nhà cung cấp",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.lightBlue,
                fontSize: 22
              ),
            ),
            ElevatedButton.icon(
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: defaultPadding * 1.5,
                  vertical:
                      defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                ),
              ),
              onPressed: () {
             showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: bgColor,
                    shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                    scrollable: true,
                    title: Center(
                      child: Text('TẠO MỚI NHÀ CUNG CẤP',
                            style:  TextStyle(fontSize: 16, 
                                color: Colors.white)
                      ),
                    ),
                    content: Container(
                      width: 700,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Form(
                          
                          child: Container(
                            width: 500,
                            color: secondaryColor,
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Container(
                                    width: 400,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        border:  OutlineInputBorder(),                                  
                                        labelText: 'Email',
                                        icon: Icon(Icons.email),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                 padding: EdgeInsets.all(10.0),
                                  child: Container(
                                    width: 400,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        border:  OutlineInputBorder(),
                                        labelText: 'Supplier Name',
                                        icon: Icon(Icons.message),
                                      ),
                                    ),
                                  ),
                                ),
                                
                                Padding(
                                 padding: EdgeInsets.all(10.0),
                                  child: Container(
                                    width: 400,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        border:  OutlineInputBorder(),                                  
                                        labelText: 'Address',
                                        icon: Icon(Icons.home),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                 padding: EdgeInsets.all(10.0),                                
                                  child: Container(
                                    width: 400,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                       contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                                        border:  OutlineInputBorder(),
                                        labelText: 'Phone Number',
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                      actions: [
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('Cancel',
                          style: TextStyle(color: Colors.white),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                          // var email = emailController.text;
                          // var message = messageController.text;
                          Navigator.pop(context);
                                  },
                        child: Text('Send',
                          style: TextStyle(color: Colors.white),                        
                        ),
          ),
                    ],
                  );
                });
                },
              icon: Icon(Icons.add),
              label: Text("Tạo mới nhà cung cấp"),
            ),
          ],
        ),
      ],
    );
  }
}


