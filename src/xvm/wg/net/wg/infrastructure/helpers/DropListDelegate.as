package net.wg.infrastructure.helpers 
{
    import __AS3__.vec.*;
    import flash.display.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.infrastructure.interfaces.entity.*;
    
    public class DropListDelegate extends flash.display.MovieClip implements net.wg.infrastructure.interfaces.IDragDropListDelegate
    {
        public function DropListDelegate(arg1:flash.display.InteractiveObject, arg2:String)
        {
            super();
            this._hitArea = arg1;
            this._dropElementLinkage = arg2;
            return;
        }

        public function dispose():void
        {
            this._pairedScrollLists.splice(0, this._pairedScrollLists.length);
            this._pairedScrollLists = null;
            this._hitArea = null;
            this._dropElementLinkage = null;
            return;
        }

        public function onBeforeDrop(arg1:flash.display.InteractiveObject, arg2:flash.display.InteractiveObject):void
        {
            this.dispatchDragEvent(net.wg.infrastructure.events.DragDropEvent.BEFORE_DROP, arg1, null, arg2);
            return;
        }

        public function onAfterDrop(arg1:flash.display.InteractiveObject, arg2:flash.display.InteractiveObject):void
        {
            this.dispatchDragEvent(net.wg.infrastructure.events.DragDropEvent.AFTER_DROP, arg1, null, arg2);
            if (App.cursor.getAttachedSprite() != null) 
            {
                if (App.cursor.getAttachedSprite() is net.wg.infrastructure.interfaces.entity.IDisposable) 
                    net.wg.infrastructure.interfaces.entity.IDisposable(App.cursor.getAttachedSprite()).dispose();
                App.cursor.detachFromCursor();
            }
            return;
        }

        public function onStartDrop(arg1:flash.display.InteractiveObject, arg2:flash.display.InteractiveObject, arg3:Number, arg4:Number):void
        {
            var loc1:*=null;
            if (App.instance) 
            {
                loc1 = App.utils.classFactory.getComponent(this._dropElementLinkage, flash.display.Sprite);
                App.cursor.attachToCursor(loc1, -arg3, -arg4);
            }
            this.dispatchDragEvent(net.wg.infrastructure.events.DragDropEvent.START_DROP, arg1, null, arg2);
            return;
        }

        public function onEndDrop(arg1:flash.display.InteractiveObject, arg2:flash.display.InteractiveObject, arg3:flash.display.InteractiveObject):void
        {
            this.dispatchDragEvent(net.wg.infrastructure.events.DragDropEvent.END_DROP, arg1, arg2, arg3);
            return;
        }

        public function getDropGroup():__AS3__.vec.Vector.<flash.display.InteractiveObject>
        {
            return Vector.<flash.display.InteractiveObject>(this._pairedScrollLists);
        }

        public function getHitArea():flash.display.InteractiveObject
        {
            return this._hitArea;
        }

        public function setPairedDropLists(arg1:__AS3__.vec.Vector.<flash.display.InteractiveObject>):void
        {
            this._pairedScrollLists = arg1;
            return;
        }

        internal function dispatchDragEvent(arg1:String, arg2:flash.display.InteractiveObject, arg3:flash.display.InteractiveObject, arg4:flash.display.InteractiveObject):void
        {
            this._hitArea.dispatchEvent(new net.wg.infrastructure.events.DragDropEvent(arg1, arg2, arg3, arg4));
            return;
        }

        internal var _pairedScrollLists:__AS3__.vec.Vector.<flash.display.InteractiveObject>=null;

        internal var _hitArea:flash.display.InteractiveObject=null;

        internal var _dropElementLinkage:String=null;
    }
}
