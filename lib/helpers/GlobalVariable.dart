import 'package:get/get.dart';

class GlobalVariable {
  static RxBool isPurchasedMonthly = false.obs;
  static RxBool isPurchasedYearly = false.obs;
  static RxBool isPurchasedLifeTime = false.obs;
  static String monthlyId = "MONTHLY_ID";
  static String yearlyId = "YEARLY_ID";
  static String lifeTimeId = "com.mapsdirection.removeads";
  static Set<String> IAP_IDs = {lifeTimeId};
}
