package net.wg.gui.lobby.customization.data
{
   import net.wg.data.daapi.base.DAAPIDataProvider;
   import scaleform.clik.data.DataProvider;
   import flash.events.Event;


   public class DAAPIItemsDataProvider extends DAAPIDataProvider
   {
          
      public function DAAPIItemsDataProvider(param1:Array) {
         super();
         this.items = new DataProvider(param1);
      }

      public static function getEmptyItem() : Object {
         return {
            "id":null,
            "texturePath":null,
            "description":"",
            "price":
               {
                  "cost":0,
                  "isGold":false
               }
            ,
            "defPrice":
               {
                  "cost":0,
                  "isGold":false
               }
            ,
            "current":false
         }
         ;
      }

      public var onRequestList:Function;

      public var groupName:String = "";

      private var items:DataProvider;

      public function invalidateRemote(param1:Boolean) : void {
         this.items = new DataProvider(this.onRequestList(this.groupName));
         var _loc2_:Event = new Event(Event.CHANGE);
         dispatchEvent(_loc2_);
      }

      override public function get length() : uint {
         return this.items.length;
      }

      override public function requestItemAt(param1:uint, param2:Function=null) : Object {
         return this.items.requestItemAt(param1,param2);
      }

      override public function requestItemRange(param1:int, param2:int, param3:Function=null) : Array {
         return this.items.requestItemRange(param1,param2,param3);
      }

      override public function indexOf(param1:Object, param2:Function=null) : int {
         return this.items::DataProvider.indexOf(param1,param2);
      }

      override public function cleanUp() : void {
         this.items.cleanUp();
      }

      override public function invalidate(param1:uint=0) : void {
         this.items.invalidate(param1);
      }

      override public function as_populate() : void {
          
      }

      override public function as_dispose() : void {
         this.cleanUp();
         this.groupName = null;
         this.items = null;
      }
   }

}