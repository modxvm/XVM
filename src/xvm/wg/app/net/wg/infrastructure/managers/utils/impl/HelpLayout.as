package net.wg.infrastructure.managers.utils.impl 
{
    import flash.display.*;
    import net.wg.data.constants.*;
    import net.wg.utils.*;
    
    public class HelpLayout extends Object implements net.wg.utils.IHelpLayout
    {
        public function HelpLayout()
        {
            super();
            return;
        }

        public function create(arg1:flash.display.DisplayObject, arg2:Object, arg3:flash.display.DisplayObjectContainer):flash.display.DisplayObject
        {
            var loc1:*;
            var loc2:*;
            (loc2 = (loc1 = App.utils).asserter).assertNotNull(arg2.text, "initproperties.text" + net.wg.data.constants.Errors.CANT_NULL);
            loc2.assert(arg2.text.length > 0, "text in initproperties can`t empty!");
            var loc3:*;
            var loc4:*=(loc3 = loc1.popupMgr).create(HL_MAIN_SOURCE, arg2, arg3);
            loc3.show(loc4, arg2.x, arg2.y, arg3);
            return loc4;
        }

        public function createBackground():void
        {
            this.destroyBackground();
            this._modalBackground = App.utils.popupMgr.create(net.wg.data.constants.Linkages.POPUP_MODAL, {"x":0, "y":0, "alpha":0.5});
            var loc1:*=App.instance.stage;
            if (this._modalBackground != null) 
            {
                this._modalBackground.width = loc1.width;
                this._modalBackground.height = loc1.height;
            }
            return;
        }

        public function destroyBackground():void
        {
            if (this._modalBackground != null) 
            {
                if (this._modalBackground.parent) 
                {
                    App.utils.popupMgr.remove(this._modalBackground);
                }
                this._modalBackground = null;
            }
            return;
        }

        public function isShowed():Boolean
        {
            return this._modalBackground == null;
        }

        public function destroy(arg1:flash.display.DisplayObject):void
        {
            var loc1:*=App.utils;
            var loc2:*=loc1.asserter.assertNotNull;
            loc2(arg1, "helpLayoutControl" + net.wg.data.constants.Errors.CANT_NULL);
            if (arg1.parent) 
            {
                loc1.popupMgr.remove(arg1);
            }
            return;
        }

        public function dispose():void
        {
            this.destroyBackground();
            return;
        }

        public function getProps(arg1:Number, arg2:Number, arg3:String, arg4:String, arg5:Number, arg6:Number):Object
        {
            return {"borderWidth":arg1, "borderHeight":arg2, "direction":arg3, "text":arg4, "x":arg5, "y":arg6};
        }

        internal static const HL_MAIN_SOURCE:String="HelpLayout";

        internal var _modalBackground:flash.display.DisplayObject=null;
    }
}
