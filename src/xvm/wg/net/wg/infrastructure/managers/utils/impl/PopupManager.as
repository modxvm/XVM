package net.wg.infrastructure.managers.utils.impl 
{
    import flash.display.*;
    import net.wg.utils.*;
    import scaleform.clik.managers.*;
    
    public class PopupManager extends Object implements net.wg.utils.IPopUpManager
    {
        public function PopupManager()
        {
            super();
            return;
        }

        public function show(arg1:flash.display.DisplayObject, arg2:Number=0, arg3:Number=0, arg4:flash.display.DisplayObjectContainer=null):void
        {
            scaleform.clik.managers.PopUpManager.show(arg1, arg2, arg3, arg4);
            return;
        }

        public function create(arg1:String, arg2:Object, arg3:flash.display.DisplayObjectContainer=null):flash.display.DisplayObject
        {
            var loc1:*=App.utils.classFactory.getObject(arg1, arg2) as flash.display.DisplayObject;
            App.utils.asserter.assertNotNull(loc1, "object for \'" + arg1 + "\' was not found.");
            this.show(loc1, arg2.x, arg2.y, arg3);
            return loc1;
        }

        public function get popupCanvas():flash.display.DisplayObjectContainer
        {
            return scaleform.clik.managers.PopUpManager.popupCanvas;
        }

        public function remove(arg1:flash.display.DisplayObject):void
        {
            App.utils.asserter.assert(this.contains(arg1), "can\'t remove popup \'" + arg1 + "\' because it\'s not a child of popupCanvas");
            App.utils.commons.releaseReferences(arg1);
            this.popupCanvas.removeChild(arg1);
            return;
        }

        public function removeAll():void
        {
            var loc3:*=null;
            var loc1:*=this.popupCanvas;
            var loc2:*=App.utils;
            while (loc1.numChildren) 
            {
                loc3 = loc1.getChildAt((loc1.numChildren - 1));
                loc2.commons.releaseReferences(loc3);
                loc1.removeChild(loc3);
            }
            return;
        }

        public function contains(arg1:flash.display.DisplayObject):Boolean
        {
            return this.popupCanvas.contains(arg1);
        }
    }
}
