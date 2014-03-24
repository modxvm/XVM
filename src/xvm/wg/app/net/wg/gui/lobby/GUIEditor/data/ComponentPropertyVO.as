package net.wg.gui.lobby.GUIEditor.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;


   public class ComponentPropertyVO extends DAAPIDataClass
   {
          
      public function ComponentPropertyVO(param1:Object) {
         this.allowedValues = [];
         super(param1);
      }

      public var name:String = "";

      public var type:String = "string";

      public var allowedValues:Array;

      public var value = null;

      public var canModify:Boolean = true;

      public function clone() : ComponentPropertyVO {
         var _loc1_:ComponentPropertyVO = new ComponentPropertyVO(
            {
               "name":this.name,
               "type":this.type,
               "allowedValues":this.allowedValues,
               "value":this.value,
               "canModify":this.canModify
            }
         );
         return _loc1_;
      }

      public function cloneAndSetValue(param1:*) : ComponentPropertyVO {
         var _loc2_:ComponentPropertyVO = this.clone();
         _loc2_.value = param1;
         return _loc2_;
      }
   }

}