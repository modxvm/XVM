package net.wg.gui.lobby.customization.data
{


   public class CamouflagesDataProvider extends DAAPIItemsDataProvider
   {
          
      public function CamouflagesDataProvider(param1:Array=null) {
         super(param1);
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
            "isNew":false,
            "current":false
         }
         ;
      }

      public var setGroupCurrentItemId:Function;

      public var getDefaultHintText:Function;

      public var getDefaultDescription:Function;
   }

}