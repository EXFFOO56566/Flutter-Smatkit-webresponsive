import 'package:flutter/material.dart';
import 'package:smartkit/FullApp/Grobag/Helper/GrobagAppbar.dart';
import 'package:smartkit/FullApp/Grobag/Helper/GrobagColor.dart';

import 'GrobagMyOrderTablet.dart';

class GrobagTrackOrderTablet extends StatefulWidget {
  final int index;

  const GrobagTrackOrderTablet({Key key, this.index}) : super(key: key);

  @override
  _GrobagTrackOrderTabletState createState() => _GrobagTrackOrderTabletState();
}

class _GrobagTrackOrderTabletState extends State<GrobagTrackOrderTablet> {

  String pDate, prDate, sDate, dDate, cDate, rDate;
 String PLACED = 'received';
 String SHIPED = 'shipped';
 String PROCESSED = 'processed';
 String DELIVERD = 'delivered';
 String CANCLED = 'cancelled';
 String RETURNED = 'returned';

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("status***${orderList[widget.index]["status"]}");
  List<String> lStatus = [];
     List<String> lDate = [];
     var allSttus = (orderList[widget.index]["status"]);
    for (var curStatus in allSttus) {
      lStatus.add(curStatus[0]);
        lDate.add(curStatus[1]);
    }
      if (lStatus.contains(PLACED)) {
      pDate = lDate[lStatus.indexOf(PLACED)];

    }
    if (lStatus.contains(PROCESSED)) {
      prDate = lDate[lStatus.indexOf(PROCESSED)];
     
    }
    if (lStatus.contains(SHIPED)) {
      sDate = lDate[lStatus.indexOf(SHIPED)];
    
    }
    if (lStatus.contains(DELIVERD)) {
      dDate = lDate[lStatus.indexOf(DELIVERD)];
      
    }
    if (lStatus.contains(CANCLED)) {
      cDate = lDate[lStatus.indexOf(CANCLED)];
    
    }
    if (lStatus.contains(RETURNED)) {
      rDate = lDate[lStatus.indexOf(RETURNED)];
     
    }
setState(() {
  
});

  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GrobagAppbar(
        title: 'Track Order',
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Order #${orderList[widget.index]["id"]}'),
                     Text('Amount : \$${orderList[widget.index]["price"]}',style: TextStyle(color: fontLight),),
            
                  ],
                ),
                    FlatButton(
               
                  child: Text('Cancel Order',style: TextStyle(color: primary),),
                  onPressed: () {},
                  color: primary.withOpacity(0.2),
                )
              ],
            ),
           
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: lightBack,
                  ),
                  borderRadius: BorderRadius.circular(5)),
              child: Column(
                children: [
                  Row(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.access_time,size: 15,color: fontLight,),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left:5.0,right:10),
                                child: Text(orderList[widget.index]["delivery_date"]+" "+orderList[widget.index]["delivery_time"],style: TextStyle(color: fontLight),),
                              ),
                            ),
                          ],
                        ),
                      ),
                     
                      InkWell(
                        child: Text(
                          'Change Time',
                          style: TextStyle(color: primary),
                        ),
                        onTap: () {},
                      )
                    ],
                  ),
                  Row(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.location_on_outlined,size: 15,color: fontLight,),
                            Expanded(child: Padding(
                              padding: const EdgeInsets.only(left:5.0,right: 10),
                              child: Text(orderList[widget.index]["address"],style: TextStyle(color: fontLight),),
                            )),
                          ],
                        ),
                      ),
                      InkWell(
                        child: Text(
                          'Edit',
                          style: TextStyle(color: primary),
                        ),
                        onTap: () {},
                      )
                    ],
                  ),
                  Divider(),
                  TextButton(
                    child: Text('Write Instructions (Optional)'),
                    onPressed: () {},
                  )
                ],
              ),
            ),
      pDate!=null?      Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        getPlaced(pDate),
                        getProcessed(prDate, cDate),
                        getShipped(sDate, cDate),
                        getDelivered(dDate, cDate),
                        getCanceled(cDate),
                        getReturned( rDate),
                      ],
                    ),
                  ):Container(),
          ],
        ),
      ),
    );
  }

  getPlaced(String pDate) {
    return Row(crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Icon(
          Icons.circle,
          color: secondary,
          size: 15,
        ),
        Container(
          margin: const EdgeInsetsDirectional.only(start: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Order Placed',
              
              ),
              Text(
                pDate,
                style: TextStyle(fontSize: 8),
              ),
            ],
          ),
        ),
      ],
    );
  }

  getProcessed(String prDate, String cDate) {
    return cDate == null
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                children: [
                  Container(
                      height: 40,
                      child: VerticalDivider(
                        thickness: 2,
                        color: prDate == null
                            ? Colors.grey
                            : secondary.withOpacity(0.2),
                      )),
                  Icon(
                    Icons.circle,
                    color: prDate == null ? Colors.grey : secondary,
                    size: 15,
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsetsDirectional.only(start: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order Processed',
                    
                    ),
                    Text(
                      prDate ?? " ",
                      style: TextStyle(fontSize: 8),
                    ),
                  ],
                ),
              ),
            ],
          )
        : prDate == null
            ? Container()
            : Column(
                children: [
                  Container(
                    height: 40,
                    child: VerticalDivider(
                      thickness: 2,
                      color: secondary.withOpacity(0.2),
                    ),
                  ),
                  Text(
                    'Order Processed',
                  
                  ),
                  Icon(
                    Icons.circle,
                    color: secondary,
                    size: 15,
                  ),
                ],
              );
  }

  getShipped(String sDate, String cDate) {
    return cDate == null
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                children: [
                  Container(
                    height: 40,
                    child: VerticalDivider(
                      thickness: 2,
                      color: sDate == null
                          ? Colors.grey
                          : secondary.withOpacity(0.2),
                    ),
                  ),
                  Icon(
                    Icons.circle,
                    color: sDate == null ? Colors.grey : secondary,
                    size: 15,
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsetsDirectional.only(start: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order Shipped',
                   
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      sDate ?? " ",
                      style: TextStyle(fontSize: 8),
                    ),
                  ],
                ),
              ),
            ],
          )
        : sDate == null
            ? Container()
            : Column(
                children: [
                  Container(
                    height: 40,
                    child: VerticalDivider(
                      thickness: 2,
                    ),
                  ),
                  Text(
                    'Order Shipped',
                  
                    textAlign: TextAlign.center,
                  ),
                  Icon(
                    Icons.circle,
                    color: secondary,
                    size: 15,
                  ),
                ],
              );
  }

  getDelivered(String dDate, String cDate) {
    return cDate == null
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                children: [
                  Container(
                    height: 40,
                    child: VerticalDivider(
                      thickness: 2,
                      color: dDate == null
                          ? Colors.grey
                          : secondary.withOpacity(0.2),
                    ),
                  ),
                  Icon(
                    Icons.circle,
                    color: dDate == null ? Colors.grey : secondary,
                    size: 15,
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsetsDirectional.only(start: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order Delivered',
                  
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      dDate ?? " ",
                      style: TextStyle(fontSize: 8),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          )
        : Container();
  }

  getCanceled(String cDate) {
    return cDate != null
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                children: [
                  Container(
                    height: 40,
                    child: VerticalDivider(
                      thickness: 2,
                      color: secondary.withOpacity(0.2),
                    ),
                  ),
                  Icon(
                    Icons.cancel_rounded,
                    color: secondary,
                    size: 15,
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsetsDirectional.only(start: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order Cancelled',
                   
                    ),
                    Text(
                      cDate ?? "",
                      style: TextStyle(fontSize: 8),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          )
        : Container();
  }

  getReturned( String rDate) {
 return
 rDate != null
        ?  Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                children: [
                  Container(
                    height: 40,
                    child: VerticalDivider(
                      thickness: 2,
                      color: secondary.withOpacity(0.2),
                    ),
                  ),
                  Icon(
                    Icons.cancel_rounded,
                    color: secondary,
                    size: 15,
                  ),
                ],
              ),
              Container(
                  margin: const EdgeInsetsDirectional.only(start: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                       'Order Returned',
                      
                      ),
                      Text(
                        rDate ?? " ",
                        style: TextStyle(fontSize: 8),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )),
            ],
          ):Container()
        ;
  }

}
