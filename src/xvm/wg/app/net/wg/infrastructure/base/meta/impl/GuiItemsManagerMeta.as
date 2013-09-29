package net.wg.infrastructure.base.meta.impl 
{
    import net.wg.data.constants.*;
    import net.wg.infrastructure.base.*;
    
    public class GuiItemsManagerMeta extends net.wg.infrastructure.base.BaseDAAPIModule
    {
        public function GuiItemsManagerMeta()
        {
            super();
            return;
        }

        public function _getItemAttributeS(arg1:int, arg2:Object, arg3:String):Object
        {
            App.utils.asserter.assertNotNull(this._getItemAttribute, "_getItemAttribute" + net.wg.data.constants.Errors.CANT_NULL);
            return this._getItemAttribute(arg1, arg2, arg3);
        }

        public function _callItemMethodS(arg1:int, arg2:Object, arg3:String, arg4:Array):Object
        {
            App.utils.asserter.assertNotNull(this._callItemMethod, "_callItemMethod" + net.wg.data.constants.Errors.CANT_NULL);
            return this._callItemMethod(arg1, arg2, arg3, arg4);
        }

        public var _getItemAttribute:Function=null;

        public var _callItemMethod:Function=null;
    }
}
