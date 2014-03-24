package net.wg.data.VO
{
   import net.wg.data.daapi.base.DAAPIDataClass;


   public class UserVO extends DAAPIDataClass
   {
          
      public function UserVO(param1:Object) {
         super(param1);
      }

      public var accID:Number = 0;

      public var dbID:Number = 0;

      public var fullName:String = "";

      public var userName:String = "";

      public var clanAbbrev:String = "";

      public var region:String = "";

      public var igrType:int = 0;

      public function get uid() : Number {
         return this.dbID;
      }

      public function get kickId() : Number {
         return this.dbID;
      }
   }

}