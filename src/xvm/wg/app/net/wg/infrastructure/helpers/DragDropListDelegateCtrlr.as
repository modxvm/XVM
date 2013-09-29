package net.wg.infrastructure.helpers 
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.events.*;
    import net.wg.data.constants.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.exceptions.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.infrastructure.interfaces.entity.*;
    
    public class DragDropListDelegateCtrlr extends Object implements net.wg.infrastructure.interfaces.entity.IDisposable
    {
        public function DragDropListDelegateCtrlr(arg1:__AS3__.vec.Vector.<flash.display.InteractiveObject>, arg2:Class, arg3:String)
        {
            var loc1:*=null;
            var loc2:*=null;
            super();
            if (App.instance) 
            {
                this.assertLinkage(arg3);
                this._delegates = new Vector.<net.wg.infrastructure.interfaces.IDragDropListDelegate>();
                var loc3:*=0;
                var loc4:*=arg1;
                for each (loc1 in loc4) 
                {
                    (loc2 = new arg2(loc1, arg3)).setPairedDropLists(this.getPairedElementsFromVector(loc1, arg1));
                    this._delegates.push(loc2);
                    App.cursor.registerDragging(loc2, net.wg.data.constants.Cursors.DRAG_CLOSE);
                    loc1.addEventListener(net.wg.infrastructure.events.DragDropEvent.BEFORE_DROP, this.onControllerBeforeDropHandler);
                    loc1.addEventListener(net.wg.infrastructure.events.DragDropEvent.START_DROP, this.onControllerStartDropHandler);
                    loc1.addEventListener(net.wg.infrastructure.events.DragDropEvent.AFTER_DROP, this.onControllerAfterDropHandler);
                }
            }
            return;
        }

        public function dispose():void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=0;
            var loc4:*=this._delegates;
            for each (loc1 in loc4) 
            {
                loc2 = loc1.getHitArea();
                loc2.removeEventListener(net.wg.infrastructure.events.DragDropEvent.BEFORE_DROP, this.onControllerBeforeDropHandler);
                loc2.removeEventListener(net.wg.infrastructure.events.DragDropEvent.START_DROP, this.onControllerStartDropHandler);
                loc2.removeEventListener(net.wg.infrastructure.events.DragDropEvent.AFTER_DROP, this.onControllerAfterDropHandler);
                App.cursor.unRegisterDragging(loc1);
                loc1.dispose();
            }
            this._currentDroppedItem = null;
            this._delegates.splice(0, this._delegates.length);
            this._delegates = null;
            return;
        }

        protected function onHighlightHitAreas(arg1:Boolean, arg2:flash.display.InteractiveObject):void
        {
            return;
        }

        protected final function getDelegates():__AS3__.vec.Vector.<net.wg.infrastructure.interfaces.IDragDropListDelegate>
        {
            return this._delegates;
        }

        internal function getPairedElementsFromVector(arg1:flash.display.InteractiveObject, arg2:__AS3__.vec.Vector.<flash.display.InteractiveObject>):__AS3__.vec.Vector.<flash.display.InteractiveObject>
        {
            var pairsFor:flash.display.InteractiveObject;
            var vector:__AS3__.vec.Vector.<flash.display.InteractiveObject>;
            var checker:Function;

            var loc1:*;
            checker = null;
            pairsFor = arg1;
            vector = arg2;
            checker = function (arg1:flash.display.InteractiveObject, arg2:int, arg3:__AS3__.vec.Vector.<flash.display.InteractiveObject>):Boolean
            {
                return !(arg1 == pairsFor);
            }
            return vector.filter(checker, null);
        }

        internal function onControllerBeforeDropHandler(arg1:net.wg.infrastructure.events.DragDropEvent):void
        {
            this._currentDroppedItem = arg1.draggedItem;
            this.onHighlightHitAreas(true, this._currentDroppedItem);
            return;
        }

        internal function onControllerAfterDropHandler(arg1:net.wg.infrastructure.events.DragDropEvent):void
        {
            this.assertNotNull(this._currentDroppedItem, "_currentDroppedItem");
            this.onHighlightHitAreas(false, this._currentDroppedItem);
            this._currentDroppedItem = null;
            return;
        }

        internal function onControllerStartDropHandler(arg1:net.wg.infrastructure.events.DragDropEvent):void
        {
            return;
        }

        internal function assertLinkage(arg1:String):void
        {
            var loc1:*="dropElementLinkage must has correct linkage value!";
            App.utils.asserter.assert(!(arg1 == net.wg.data.constants.Values.EMPTY_STR), loc1, net.wg.infrastructure.exceptions.ArgumentException);
            this.assertNotNull(arg1, "linkage");
            return;
        }

        internal function assertNotNull(arg1:Object, arg2:String):void
        {
            App.utils.asserter.assertNotNull(arg1, arg2 + net.wg.data.constants.Errors.CANT_EMPTY);
            return;
        }

        protected var _delegates:__AS3__.vec.Vector.<net.wg.infrastructure.interfaces.IDragDropListDelegate>=null;

        internal var _currentDroppedItem:flash.display.InteractiveObject=null;
    }
}
