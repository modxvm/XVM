package net.wg.gui.cyberSport.vo
{
   import net.wg.data.daapi.base.DAAPIDataClass;


   public class CSCommandVO extends DAAPIDataClass
   {
          
      public function CSCommandVO(param1:Object) {
         this.vehicles = [];
         super(param1);
      }

      public var creator:String = "";

      public var vehicles:Array;

      public var cfdUnitID:Number = 0;

      public var unitMgrID:Number = 0;

      public var specialState:String = "";

      public var inBattle:Boolean = false;

      public var commandSize:Number = 7;

      public var playersCount:Number = 0;

      public var rating:Number = 0;

      public var isFreezed:Boolean = false;

      public var isRestricted:Boolean = false;

      public var server:String = "";

      public var navigationConfig:NavigationBlockVO = null;

      override protected function onDataWrite(param1:String, param2:Object) : Boolean {
         if(param1 == "navigationBlock")
         {
            this.navigationConfig = new NavigationBlockVO(param2);
            return false;
         }
         return this.hasOwnProperty(param1);
      }

      public function get isLoadMoreState() : Boolean {
         return !(this.navigationConfig == null);
      }
   }

}