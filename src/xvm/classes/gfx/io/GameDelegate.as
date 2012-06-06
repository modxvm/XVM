intrinsic class gfx.io.GameDelegate
{
  private static var callBackHash:Object;

  static function call(methodName, params, scope, callBack);
  public static function addCallBack(methodName:String, scope:Object, callBack:String);
}