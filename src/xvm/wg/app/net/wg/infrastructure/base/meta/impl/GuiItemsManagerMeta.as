package net.wg.infrastructure.base.meta.impl
{
   import net.wg.infrastructure.base.BaseDAAPIModule;
   import net.wg.data.constants.Errors;
   
   public class GuiItemsManagerMeta extends BaseDAAPIModule
   {
      
      public function GuiItemsManagerMeta() {
         super();
      }
      
      public var _getItemAttribute:Function = null;
      
      public var _callItemMethod:Function = null;
      
      public function _getItemAttributeS(param1:int, param2:Object, param3:String) : Object {
         App.utils.asserter.assertNotNull(this._getItemAttribute,"_getItemAttribute" + Errors.CANT_NULL);
         return this._getItemAttribute(param1,param2,param3);
      }
      
      public function _callItemMethodS(param1:int, param2:Object, param3:String, param4:Array) : Object {
         App.utils.asserter.assertNotNull(this._callItemMethod,"_callItemMethod" + Errors.CANT_NULL);
         return this._callItemMethod(param1,param2,param3,param4);
      }
   }
}
