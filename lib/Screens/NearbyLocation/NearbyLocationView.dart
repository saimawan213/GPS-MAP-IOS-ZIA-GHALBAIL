import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lottie/lottie.dart';
import 'package:mapsandnavigationflutter/Screens/Ads/Colors.dart';
import 'package:mapsandnavigationflutter/Screens/Constents/Constent.dart';
import 'package:mapsandnavigationflutter/Screens/NearbyLocation/NearByLocationViewModel.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class NearbyLocationView extends StatelessWidget {
  NearByLocationViewModel  viewModel = Get.put(NearByLocationViewModel());

  @override
  Widget build(BuildContext context) {
    //admob_helper.adaptiveloadAd();

    return Scaffold(
      resizeToAvoidBottomInset : false,
      appBar: AppBar(
        //duplicateItems.addAll(todo_controller.pfaultdata);
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        //backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        backgroundColor: AppColor.primaryColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // Add your back button onPressed logic here
            Navigator.pop(context);
          },
        ),
        title: const Text("Nearby Location",style: TextStyle(color: Colors.white),),
      ),
      body:  Container(
        child: Column(
          children: <Widget>[
            Column(
              children: [
                Container(
                  padding: EdgeInsets.all(16.0),
                  child: TextField(
                    onChanged: (value) {

                        print("call hereee1234 inside");
                        viewModel.filterSearchResults(value);

                      // filterSearchResults(value);
                      // viewModel.filterSearchResults(value);
                      /* todo_controller.items = todo_controller.duplicateItems
                          .where((item) => item.name!.toLowerCase().contains(value.toLowerCase()))
                          .toList();*/
                    },
                    controller: viewModel.editingController,
                    decoration: InputDecoration(
                      labelText: "Search",
                      hintText: "Search",
                      hintStyle: const TextStyle(
                          color: AppColor.primaryColor
                      ),
                      labelStyle: const TextStyle(
                          color: AppColor.primaryColor
                      ),
                      // suffixIcon:Icon(Icons.mic),



                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: AppColor.primaryColor, width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(25.0))
                      ),
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25.0))),

                      focusedBorder:const OutlineInputBorder(
                          borderSide: BorderSide(color: AppColor.primaryColor, width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(25.0))

                      ),

                      prefixIcon: GestureDetector(
                        onTap:(){

                        } ,
                        child: Container(
                          padding: EdgeInsets.all(8.0),
                          /* decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8.0),
                    ),*/
                          child: const Icon(
                            Icons.search,
                          ),
                        ),
                      ),
                     /* suffixIcon: GestureDetector(
                        onTap:(){

                        },
                        child:   Container(
                          padding: EdgeInsets.all(8.0),
                          *//*  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(8.0),
                    ),*//*


                        )
                      ),*/
                    ),
                  ),
                ),

              ],
            ),
            Expanded(
              flex: 14,
              child:
              Container(  child:Obx(() => viewModel.items.isEmpty ? Lottie.asset(
                'assets/nodatafound.json',
                height: 200.0,
                repeat: true,
                reverse: true,
                animate: true,
              ):ListView.builder(
                itemCount: viewModel.items.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () async {
                      viewModel.callgooglemap(viewModel.items[index]);
                      /* print("Called card view:"+viewModel.items[index].name.toString());
                        Get.to(() => Pfault_solution(),
                            arguments: {"obd1":  viewModel.items[index]});*/
                      /* Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Pfault_solution(obd1: viewModel.items[index],),
              ),
            );*/
                    },
                    child:  Container(
                      margin: const EdgeInsets.only(top: 7.0,right: 30.0,left: 30.0),
                      //color: todo_controller.cardBackgroundColor,
                      decoration: BoxDecoration(
                        color: AppColor.primaryColor,
                        borderRadius: BorderRadius.circular(15), // Adjust the radius as needed
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),

                      child: TodoItem(

                        todo: viewModel.items[index],
                      ),



                    ),

                  );
                },
              )

              )),


            ),


            Expanded(
              flex: 2,
              child:  Column(
                children: [
                 /* Expanded(
                      flex: 1,
                      child:Container()),*/
                  Expanded(
                      flex: 10,
                      child: Container(
                          /*margin: EdgeInsets.only(top: 5.0),*/
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(3),
                            border: Border(
                              top: BorderSide(color: Color(0xFFD6D6D6), width: 3),
                              bottom: BorderSide(color: Color(0xFFD6D6D6), width: 3),
                              // You can remove the left and right borders by commenting them out
                              // left: BorderSide(color: Color(0xFFD6D6D6), width: 3),
                              // right: BorderSide(color: Color(0xFFD6D6D6), width: 3),
                            ),
                            //border: Border.all(color: AppColor.borderColor,width: 3),// Adjust the radius as needed
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),child:Container(
                          margin: EdgeInsets.only(bottom: 5.0),
                          child: Obx(()=>
                          (viewModel.admob_helper.isBannerLoaded.value && !Constent.isOpenAppAdShowing.value && !Constent.isInterstialAdShowing.value && !Constent.adspurchase)?
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: SafeArea(
                              child: SizedBox(
                                width:viewModel.admob_helper.anchoredAdaptiveAd!.size.width.toDouble(),
                                height:viewModel.admob_helper.anchoredAdaptiveAd!.size.height.toDouble(),
                                child: AdWidget(ad: viewModel.admob_helper.anchoredAdaptiveAd!),
                              ),
                            ),
                          )
                              :(!Constent.adspurchase)?

                          SizedBox(
                              width:double.infinity,
                              height: 30,
                              child: Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.white,
                                child: Container(
                                  color: Colors.grey,
                                ),
                              )
                          ):SizedBox()
                          )))),
                ],
              ),
            )


           /* Expanded(
              flex: 1,
              child: Obx(
                      ()=> (viewModel.admob_helper.isBannerLoaded.value && viewModel.admob_helper.anchoredAdaptiveAd!=null)?
                  Container(
                    alignment: Alignment.center,
                    width: viewModel.admob_helper.anchoredAdaptiveAd?.size.width.toDouble(),
                    height: viewModel.admob_helper.anchoredAdaptiveAd?.size.height.toDouble(),
                    child: AdWidget(ad: viewModel.admob_helper.anchoredAdaptiveAd!),
                  ):SizedBox()
              ),

            ),*/


          ],
        ),







/*
      Obx(()=>
        ListView.builder(
            itemCount: todomodel.todos.length,
            itemBuilder: (context, index) {
              return TodoItem(
                  todo: todomodel.todos[index],
                  onTodoChanged:(Todo? todo){
                    todo_controller.handleTodoChange(todo);
                  },
                  removeTodo:(Todo? todo){
                    todo_controller.deleteTodo(todo,context);
                  },
                  updateTodo:(Todo? todo)
                  { todo_controller.editDialog(todo,context);
                  }
              );

      }),
  }*/

      ),

      /*  floatingActionButton: FloatingActionButton(
        onPressed: (){
          // throw Exception();
          child: const Text("Throw Test Exception");
          // todo_controller.displayDialog(context);
        },
        tooltip: 'Add a Todo',
        child: const Icon(Icons.add),
      ),*/


    );
  }
}

class TodoItem extends StatelessWidget {
 // final String todomodel = Get.put(String());
  TodoItem({ this.todo})
      : super(key: ObjectKey(todo));

  final String? todo;

  TextStyle? _getTextStyle(bool checked) {
    if (!checked) return null;

    return const TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 45.0, // Adjust the width as needed
        height: 45.0, // Adjust the height as needed
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColor.yellowColor, // Background color for the circular icon
        ),
        alignment: Alignment.center,
        child:Image(
          width: 30,
          height: 30,
          color: Colors.white,
          image: AssetImage("assets/images/"+todo!+".png"), // Replace with the correct asset path
        ), /*Container(
          width: 40.0, // Adjust the width as needed
          height: 40.0,
          decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage("assets/images/"+todo!+".png")
            ),
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            color: Colors.white,
          ),
        ),*/
      ),
     // Icon(Icons.star,color: Colors.blue),
      title: Center(child: Text(todo!,style: const TextStyle(color: Colors.white))),
      /*subtitle: Row(children: <Widget>[
        Expanded(
          child:  Text(todo!, style:const TextStyle(fontSize: 12)),
        )

      ],*/
      //);
      /* onTap: () {
        onTodoChanged!(todo);
      },
*/
      /*  leading: Checkbox(
        checkColor: Colors.greenAccent,
        activeColor: Colors.red,
        value: todo.completed,
        onChanged: (value) {
         *//* onTodoChanged(todo);*//*
        },
      ),*/
      /* title: Row(children: <Widget>[

      Text(todo!.name!, style: _getTextStyle(false)),

        *//*   MaterialButton(
          onPressed: () {},
          color: Colors.blue,
          textColor: Colors.white,
          child: Icon(
            Icons.camera_alt,
            size: 24,
          ),

          shape: CircleBorder(),
        ),*//*
        Expanded(

          child: Text(todo!.value!, style: _getTextStyle(false)),
        ),*/
      /* IconButton(
          iconSize: 30,
          icon: const Icon(
            Icons.update,
            color: Colors.deepPurple,
          ),
          alignment: Alignment.centerRight,
          onPressed: () {
            updateTodo!(todo);
          },
        ),
        IconButton(
          iconSize: 30,
          icon: const Icon(
            Icons.delete,
            color: Colors.deepPurple,
          ),
          alignment: Alignment.centerRight,
          *//*onPressed: () {
            removeTodo!(todo);
          },*//*
        ),*/
      //  ]
      // ),
    );
  }
/*final void Function(Todo? todo) ?onTodoChanged;
  final void Function(Todo? todo) ?removeTodo;
  final void Function(Todo? todo) ?updateTodo;*/
}