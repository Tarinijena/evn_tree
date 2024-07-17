import 'package:flutter/material.dart';
import 'package:national_wild_animal/ProfilePageDate/ProfilePageData.dart';
import 'package:national_wild_animal/app/app_theme/colors.dart';
import 'package:national_wild_animal/app/app_theme/text_styles.dart';
import 'package:national_wild_animal/app/common_widgets/common_text_field_view.dart';
import 'package:national_wild_animal/app/screens/HomeWidget/CustomAppBar.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

   //bool isSelected=false;

   List<DataLstClass> dataLst = [
    DataLstClass(
      icon: Icons.border_all_rounded,
      nameStr: "All"
    ),
    DataLstClass(
        icon: Icons.music_note_outlined,
        nameStr: "Connect"
    ),
    DataLstClass(
        icon: Icons.theater_comedy_outlined,
        nameStr: "Theatre"
    ),
    DataLstClass(
        icon: Icons.sports,
        nameStr: "Sports"
    ),
    DataLstClass(
        icon: Icons.music_note_outlined,
        nameStr: "Magic Show"
    ),
    DataLstClass(
        icon: Icons.games,
        nameStr: "Circus"
    ),
    DataLstClass(
        icon: Icons.games,
        nameStr: "Circus"
    ),
    DataLstClass(
        icon: Icons.games,
        nameStr: "Circus"
    ),
    DataLstClass(
        icon: Icons.games,
        nameStr: "Circus"
    ),
    DataLstClass(
        icon: Icons.games,
        nameStr: "Circus"
    ),
    DataLstClass(
        icon: Icons.games,
        nameStr: "Circus"
    ),
    DataLstClass(
        icon: Icons.games,
        nameStr: "Circus"
    ),
    DataLstClass(
        icon: Icons.games,
        nameStr: "Circus"
    ),
    DataLstClass(
        icon: Icons.games,
        nameStr: "Circus"
    ),
    DataLstClass(
        icon: Icons.games,
        nameStr: "Circus"
    ),
    DataLstClass(
        icon: Icons.games,
        nameStr: "Circus"
    ),
    DataLstClass(
        icon: Icons.games,
        nameStr: "Circus"
    ),
  ];
  double maxScrollExtent = 0.0;
  ScrollController scrollController = ScrollController();
  int selectedIndex = 0;
  late TextEditingController _textEditingController;
  @override
  void initState() {
    _textEditingController=TextEditingController();
    scrollController.addListener((){
      maxScrollExtent = scrollController.position.maxScrollExtent;
    });

    super.initState();
  }

   @override
  void dispose() {
    _textEditingController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        
          backgroundColor: const Color(0xFF231D32),
             body: DefaultTabController(
              length: 2,
               child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                 child: Column(
                     children: [
                         CustomAppBar(),
                         Padding(
                    padding: const EdgeInsets.only(left: 24.0,top: 12,right: 18),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text("Hello",style: TextStyles(context).googleRubikFontsForButtonText(fontWeight: FontWeight.w400,fontSize: 20),),
                            Text(" Jay",style: TextStyles(context).googleRubikFontsForText2(fontWeight: FontWeight.w400,fontSize: 20)),
                            Text(",",style: TextStyles(context).googleRubikFontsForButtonText(fontWeight: FontWeight.w400,fontSize: 20)),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Let’s explore your fav",style: TextStyles(context).googleRubikFontsForButtonText(fontWeight: FontWeight.w400,fontSize: 20),),
                            Text(" event",style: TextStyles(context).googleRubikFontsForText2(fontWeight: FontWeight.w400,fontSize: 20)),
                            Text(" !",style: TextStyles(context).googleRubikFontsForButtonText(fontWeight: FontWeight.w400,fontSize: 20)),
                          ],
                        ),
                        const SizedBox(
                          height: 17,
                        ),
                        CommonTextFieldView(
                          controller:_textEditingController,
                          // errorText: _errorFName,
                          padding: const EdgeInsets.only(left: 0, right: 0),
                          keyboardType: TextInputType.name,
                          onChanged: (String txt) {},
                          isAllowTopTitleView: false,
                          suffixIcon: Icons.search,
                          suffixIconColor: Colors.white,
                          suffixIconSize: 25,
                          radius: 15.5,
                          height: 35,
                          borderColor: const Color(0xFFC1C1C1),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 60,
                              width: size.width*0.82,
                              child: ListView.builder(
                                  itemCount: dataLst.length,
                                  controller: scrollController,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (BuildContext context,int index){
                                   return GestureDetector(
                                  onTap: (){
                                    selectedIndex = index;
                                    setState(() {
                             
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 19.0),
                                    child: Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(2),
                                            border: Border.all(width: 1,color: const Color(0xFF362B51)),
                                            color: (selectedIndex == index)?const Color(0xFFB74BFF) :const Color(0xFF221D31)
                                          ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(4.0),
                                              child: Icon(dataLst[index].icon,size: 30,color: Colors.white,),
                                            )),
                                        Text(dataLst[index].nameStr??"",style: TextStyles(context).googleRubikFontsForButtonText(fontSize: 9,fontWeight: FontWeight.w600),)
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            ),
                            (dataLst.length > 4)? GestureDetector(
                              onTap: (){
                                double currentOffset = scrollController.offset;
                                double newOffset = currentOffset + 30.0;
                             
                                if(maxScrollExtent == 0){
                                  scrollController.jumpTo(
                                    30,
                                  );
                                }
                             
                                if (newOffset <= maxScrollExtent) {
                                  scrollController.animateTo(
                                    newOffset,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeInOut,
                                  );
                                } else {
                                  // If reached the end, stop scrolling further
                                  scrollController.jumpTo(maxScrollExtent);
                                }
                              },
                              child: Container(
                                color: const Color(0xFF362B51),
                                height: 40,
                                child: const Padding(
                                  padding: EdgeInsets.all(4.0),
                                  child: Icon(Icons.arrow_forward_sharp,size: 18,color: Colors.white,),
                                ),
                              ),
                            ):Container()
                          ],
                        ),
                 
                         Column(
                            children: [
                                SizedBox(height: 10,),    
                               Container(
                                                         height: 33,
                                                         decoration: BoxDecoration(
                                color: Colors.transparent
                                                         ),
                               
                               child: TabBar(
                                
                                 physics: ClampingScrollPhysics(),
                                 
                                 unselectedLabelColor: Color(0xffB74BFF),
                                 indicatorSize: TabBarIndicatorSize.label,
                                  dividerColor: Colors.transparent,
                                 indicator: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Color(0xffB74BFF),
                                    border: Border(
                                      bottom: BorderSide(color: Colors.transparent)
                                    )
                                 ),
                                 tabs: [
                                   Tab(
                                   child: Container(
                                   height: 33,
                                   width: 100,
                                   decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(color: Color(0xffB74BFF),width: 1)
                                   ),
                                   child: Align(
                                      alignment: Alignment.center,
                                      child: Text("Ungoing",style: TextStyle(color: Colors.white),),
                                   ),
                                                                 ),
                                                              ),
                                                              Tab(
                                                                 child: Container(
                                    height: 33,
                                   width: 100,
                                   decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(color: Color(0xffB74BFF),width: 1)
                                   ),
                                   child: Align(
                                      alignment: Alignment.center,
                                      child: Text("Upcomeing",style: TextStyle(color: Colors.white)),),
                                   ),
                                                                 ),
                                                                 
                                                              
                                 ]),
                                                        ),
                                                       
                                   SizedBox(
                                     height: MediaQuery.of(context).size.height*0.8,
                                     child: TabBarView(children: [
                                         SizedBox(
                                           height: MediaQuery.of(context).size.height,
                                           child: ListView.builder(
                                             scrollDirection: Axis.vertical,
                                             
                                             itemCount: festivalData.length,
                                             itemBuilder: (context, index) {
                                                    return Padding(
                                                      padding: const EdgeInsets.only(top: 25),
                                                      child: Container(
                                                       height: 90,
                                                       decoration: BoxDecoration(
                                                         borderRadius: BorderRadius.circular(7),
                                                            color: Color(0xFF2A233D)
                                                        ),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                             children: [
                                                                Row(
                                                                   children: [
                                                                       Container(
                                                                     height: 90,
                                                                     width:90 ,
                                                                     decoration: BoxDecoration(
                                                                        image: DecorationImage(image:AssetImage(festivalData[index].imagePath,),fit: BoxFit.cover )
                                                                     ),
                                                                 ),
                                                                 SizedBox(width: 5,),
                                                                 Column(
                                                                 crossAxisAlignment: CrossAxisAlignment.start,
                                                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                     
                                                                       Expanded(
                                                                         child: Column(
                                                                           children: [
                                                                               Text("Adibasi Mela",style: TextStyle(color: ColorsGroup.whiteColor,fontSize: 15,fontWeight: FontWeight.bold ),),
                                                                               SizedBox(height: 5,),
                                                                               Column(
                                                                                   children: [
                                                                                      Row(
                                                                                        children: [
                                                                                            Icon(Icons.location_on,color: Color(0xFFB74BFF),size: 20,),
                                                                                            SizedBox(width: 3,),
                                                                                            Expanded(child: Text(festivalData[index].festivalLocation,style: TextStyle(fontSize: 10,color: Colors.white,fontWeight: FontWeight.bold),
                                                                                            overflow: TextOverflow.ellipsis,
                                                                                            ))
                                                                                        ],
                                                                                      ),
                                                                                      Row(
                                                                                        children: [
                                                                                            Icon(Icons.date_range,color: Color(0xFFB74BFF),size: 20,),
                                                                                            SizedBox(width: 3,),
                                                                                            Expanded(
                                                                                              child: Text(festivalData[index].festivalLocation,style: TextStyle(fontSize: 10,color: Colors.white,fontWeight: FontWeight.bold),
                                                                                              overflow: TextOverflow.ellipsis,
                                                                                              ),
                                                                                            )
                                                                                        ],
                                                                                      )
                                                                                   ],
                                                                               )
                                                                           ],
                                                                         ),
                                                                       )
                                                                  ],
                                                                                                                                )
                                                                   ],
                                                                ),
             
                                                               Column(
                                                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    SizedBox(height: 8,),
                                                                    Row(
                                                                       children: [
                                                                           Container(
                                                                               height: 20,
                                                                               width: 60,
                                                                               decoration: BoxDecoration(
                                                                                   color: Colors.grey.shade800,
                                                                                   borderRadius: BorderRadius.circular(2)
                                                                               ),
                                                                               child: Center(child: Text(festivalData[index].festival,style: TextStyle(color: ColorsGroup.whiteColor,fontSize: 14,fontWeight: FontWeight.bold),))),
                                                                               SizedBox(width: 8,)
                                                                       ],
                                                                    ) ,

                                                                    IconButton(onPressed: () {
                                                                        //isSelected=true;
                                                                    } ,
                                                                     icon:Icon(Icons.favorite,color:Colors.red ,))  
                                                                  ],
                                                               )
                                                             ],
                                                          ),
                                                      ),
                                                    );
                                           }, ),
                                         ),
                                         Text("Hii")
                                     ]),
                                   )   ,  
                            ],
                         )
                             
                        
                       
                              
                             
                             
                      ],
                    ),
                  ),   
                     ],
                 ),
               ),
             ),
      ),
    );
  }
}
class DataLstClass{
  IconData? icon;
  String? nameStr;
  DataLstClass({this.icon,this.nameStr});
}