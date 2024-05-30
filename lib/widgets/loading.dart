import 'package:doctor_appointment_app/util/appthem.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SpinKit {
  static final loadSpinkit = SpinKitWave(
    color: Apptheme.primary,
    size: 50.0,
  );
}
//  obj.isloading
//                         ? Container(
//                             height: height,
//                             width: width,
//                             color: AppTheme.primary.withOpacity(0.5),
//                             child: Center(
//                               child: SizedBox(
//                                 height: height * 0.1,
//                                 width: width * 0.2,
//                                 child: SpinKit.loadSpinkit,
//                               ),
//                             ),
//                           )
//                         : const SizedBox(),