package net.wg.data.VO
{
   import net.wg.data.daapi.base.DAAPIDataClass;


   public class UserVO extends DAAPIDataClass
   {
          
      public function UserVO(param1:Object) {
         super(param1);
      }

      public var accID:Number = 0;

      public var uid:Number = 0;

      public var fullName:String = "";

      public var userName:String = "";

      public var clanAbbrev:String = "";

      public var region:String = "";

      public var igrType:int = 0;
   }

}