package net.wg.gui.components.common.cursor.base 
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import net.wg.data.constants.*;
    import net.wg.infrastructure.exceptions.*;
    import net.wg.infrastructure.interfaces.entity.*;
    
    public class DroppingCursor extends net.wg.gui.components.common.cursor.base.ResizingCursor
    {
        public function DroppingCursor()
        {
            this._dropObjects = new flash.utils.Dictionary(true);
            super();
            return;
        }

        public function registerDragging(arg1:net.wg.infrastructure.interfaces.entity.IDragDropHitArea, arg2:String=null):void
        {
            if (arg1 is net.wg.infrastructure.interfaces.entity.IDroppable) 
                this.registerDrop(net.wg.infrastructure.interfaces.entity.IDroppable(arg1), arg2);
            return;
        }

        public function unRegisterDragging(arg1:net.wg.infrastructure.interfaces.entity.IDragDropHitArea):void
        {
            if (arg1) 
                if (arg1 is net.wg.infrastructure.interfaces.entity.IDroppable) 
                    this.unRegisterDrop(net.wg.infrastructure.interfaces.entity.IDroppable(arg1));
            return;
        }

        protected override function onDispose():void
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=this._dropObjects;
            for each (loc1 in loc3) 
            {
                DebugUtils.LOG_DEBUG(loc1.container + net.wg.data.constants.Errors.WASNT_UNREGISTERED);
                this.unRegisterDrop(loc1.container);
            }
            this._dropObjects = null;
            this._dropSenderInfo = null;
            this._dropItem = null;
            super.onDispose();
            return;
        }

        protected override function cursorIsFree():Boolean
        {
            return super.cursorIsFree() && !this._isOnDropping;
        }

        internal function onEnterToDropMode(arg1:flash.events.MouseEvent):void
        {
            if (arg1.target is net.wg.infrastructure.interfaces.entity.IDropItem) 
                if (this._isOnDropping) 
                    setCursor(net.wg.data.constants.Cursors.DRAG_OPEN);
                else 
                    forceSetCursor(net.wg.data.constants.Cursors.DRAG_OPEN);
            return;
        }

        internal function rollOutDropHandler(arg1:flash.events.MouseEvent):void
        {
            assertLifeCycle();
            if (!this._isOnDropping) 
                resetCursor();
            return;
        }

        internal function onDropHandler(arg1:flash.events.MouseEvent):void
        {
            assertNotNull(this._dropSenderInfo, "_dropSenderInfo");
            assertNotNull(this._dropItem, "_dropItem");
            var loc1:*=flash.display.InteractiveObject(arg1.currentTarget);
            var loc2:*=this.getDropInfoBySlot(loc1);
            var loc3:*=this._dropSenderInfo.container.getHitArea();
            loc2.container.onEndDrop(loc3, loc1, this._dropItem);
            return;
        }

        internal function mouseDnDropHandler(arg1:flash.events.MouseEvent):void
        {
            var loc1:*=null;
            var loc2:*=null;
            if (isLeftButton(arg1)) 
            {
                assertLifeCycle();
                loc1 = this.getDropInfoByHit(flash.display.InteractiveObject(arg1.currentTarget));
                this.setDropping(true);
                forceSetCursor(loc1.cursor);
                assertNull(this._dropSenderInfo, "_dropSenderInfo");
                assertNull(this._dropItem, "_dropItem");
                this._dropSenderInfo = loc1;
                this._dropItem = flash.display.InteractiveObject(arg1.target);
                loc2 = this._dropSenderInfo.container.getHitArea();
                loc1.container.onBeforeDrop(loc2, this._dropItem);
                loc1.hit.addEventListener(flash.events.MouseEvent.MOUSE_MOVE, this.droppingHandler);
                this.addAfterDropUpHandlers(this.mouseUpHdlr);
            }
            return;
        }

        internal function mouseUpDropHdlr(arg1:flash.events.MouseEvent):void
        {
            assertLifeCycle();
            this._dropSenderInfo.hit.removeEventListener(flash.events.MouseEvent.MOUSE_MOVE, this.droppingHandler);
            var loc1:*=this._dropSenderInfo.container.getHitArea();
            if (this._dropItem is net.wg.infrastructure.interfaces.entity.IDropItem) 
                this.removeDropListeners(this._dropSenderInfo);
            assertNotNull(this._dropItem, "_dropItem");
            this.removeAfterDropUpHandlers(this.mouseUpDropHdlr);
            this.onAfterDrop();
            return;
        }

        internal function mouseUpHdlr(arg1:flash.events.MouseEvent):void
        {
            this._dropSenderInfo.hit.removeEventListener(flash.events.MouseEvent.MOUSE_MOVE, this.droppingHandler);
            this.removeAfterDropUpHandlers(this.mouseUpHdlr);
            this.onAfterDrop();
            return;
        }

        internal function removeAfterDropUpHandlers(arg1:Function):void
        {
            assertNotNull(this._dropSenderInfo, "_dropSenderInfo");
            assert(this._afterDropHandlersAdded, "must be added for removing.");
            this._afterDropHandlersAdded = false;
            stage.removeEventListener(flash.events.MouseEvent.MOUSE_UP, arg1);
            this._dropSenderInfo.hit.removeEventListener(flash.events.MouseEvent.MOUSE_UP, arg1);
            return;
        }

        internal function addAfterDropUpHandlers(arg1:Function):void
        {
            assertNotNull(this._dropSenderInfo, "_dropSenderInfo");
            assert(!this._afterDropHandlersAdded, "must be removed for adding.");
            this._afterDropHandlersAdded = true;
            this._dropSenderInfo.hit.addEventListener(flash.events.MouseEvent.MOUSE_UP, arg1, false, AFTER_DROP_PRIORITY);
            stage.addEventListener(flash.events.MouseEvent.MOUSE_UP, arg1, false, AFTER_DROP_PRIORITY);
            return;
        }

        internal function onAfterDrop():void
        {
            forceSetCursor(net.wg.data.constants.Cursors.DRAG_OPEN);
            this.setDropping(false);
            var loc1:*=this._dropSenderInfo.container.getHitArea();
            this._dropSenderInfo.container.onAfterDrop(loc1, this._dropItem);
            this._dropSenderInfo.processStarted = false;
            this._dropSenderInfo = null;
            this._dropItem = null;
            return;
        }

        internal function droppingHandler(arg1:flash.events.MouseEvent):void
        {
            var loc2:*=null;
            assertLifeCycle();
            assertNotNull(this._dropSenderInfo, "_dropSenderInfo");
            var loc1:*=this.getDropInfoByHit(flash.display.InteractiveObject(arg1.currentTarget));
            if (!loc1.processStarted) 
            {
                loc1.processStarted = true;
                if (arg1.target is net.wg.infrastructure.interfaces.entity.IDropItem) 
                {
                    loc2 = flash.display.InteractiveObject(this._dropSenderInfo.container.getHitArea());
                    loc1.container.onStartDrop(loc2, this._dropItem, arg1.localX, arg1.localY);
                    this.addDropListeners(loc1);
                    this.removeAfterDropUpHandlers(this.mouseUpHdlr);
                    this.addAfterDropUpHandlers(this.mouseUpDropHdlr);
                }
            }
            return;
        }

        internal function registerDrop(arg1:net.wg.infrastructure.interfaces.entity.IDroppable, arg2:String=null):void
        {
            var loc1:*=new DropInfo(arg1, arg2);
            assert(this._dropObjects[loc1.hit] == undefined, net.wg.data.constants.Errors.ALREADY_REGISTERED);
            this._dropObjects[loc1.hit] = loc1;
            loc1.hit.addEventListener(flash.events.MouseEvent.ROLL_OVER, this.onEnterToDropMode, true);
            loc1.hit.addEventListener(flash.events.MouseEvent.ROLL_OUT, this.rollOutDropHandler, true);
            loc1.hit.addEventListener(flash.events.MouseEvent.MOUSE_DOWN, this.mouseDnDropHandler);
            return;
        }

        internal function unRegisterDrop(arg1:net.wg.infrastructure.interfaces.entity.IDroppable):void
        {
            var loc1:*=net.wg.gui.components.common.cursor.base.BaseInfo.getHitFromContainer(arg1);
            assert(!(this._dropObjects[loc1] == undefined), net.wg.data.constants.Errors.MUST_REGISTER);
            var loc2:*=this.getDropInfoByHit(loc1);
            loc1.removeEventListener(flash.events.MouseEvent.ROLL_OVER, this.onEnterToDropMode, true);
            loc1.removeEventListener(flash.events.MouseEvent.ROLL_OUT, this.rollOutDropHandler, true);
            loc1.removeEventListener(flash.events.MouseEvent.MOUSE_DOWN, this.mouseDnDropHandler);
            delete this._dropObjects[loc1];
            loc2.dispose();
            return;
        }

        internal function addDropListeners(arg1:DropInfo):void
        {
            var loc2:*=null;
            var loc1:*=arg1.container.getDropGroup();
            if (loc1 != null) 
            {
                var loc3:*=0;
                var loc4:*=loc1;
                for each (loc2 in loc4) 
                    loc2.addEventListener(flash.events.MouseEvent.MOUSE_UP, this.onDropHandler, true, END_DROP_PRIORITY);
            }
            return;
        }

        internal function removeDropListeners(arg1:DropInfo):void
        {
            var loc2:*=null;
            var loc1:*=arg1.container.getDropGroup();
            if (loc1 != null) 
            {
                var loc3:*=0;
                var loc4:*=loc1;
                for each (loc2 in loc4) 
                    loc2.removeEventListener(flash.events.MouseEvent.MOUSE_UP, this.onDropHandler, true);
            }
            return;
        }

        internal function getDropInfoBySlot(arg1:flash.display.InteractiveObject):DropInfo
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=0;
            var loc4:*=this._dropObjects;
            for each (loc1 in loc4) 
            {
                loc2 = loc1.container.getDropGroup();
                if (loc2.indexOf(arg1) == -1) 
                    continue;
                return loc1;
            }
            throw new net.wg.infrastructure.exceptions.ArgumentException("Unknown slot: " + arg1);
        }

        internal function setDropping(arg1:Boolean):void
        {
            if (arg1 != this._isOnDropping) 
            {
                this._isOnDropping = arg1;
                tryToResetCursor();
            }
            return;
        }

        internal function getDropInfoByHit(arg1:flash.display.InteractiveObject):DropInfo
        {
            return this._dropObjects[arg1];
        }

        internal static const END_DROP_PRIORITY:uint=1;

        internal static const AFTER_DROP_PRIORITY:uint=0;

        internal var _dropObjects:flash.utils.Dictionary;

        internal var _dropSenderInfo:DropInfo=null;

        internal var _dropItem:flash.display.InteractiveObject=null;

        internal var _isOnDropping:Boolean=false;

        internal var _afterDropHandlersAdded:Boolean=false;
    }
}

import net.wg.data.constants.*;
import net.wg.infrastructure.interfaces.entity.*;


class DropInfo extends net.wg.gui.components.common.cursor.base.BaseInfo
{
    public function DropInfo(arg1:net.wg.infrastructure.interfaces.entity.IDroppable, arg2:String)
    {
        super(arg1, arg2, net.wg.data.constants.Cursors.DRAG_CLOSE);
        return;
    }

    public function get container():net.wg.infrastructure.interfaces.entity.IDroppable
    {
        return net.wg.infrastructure.interfaces.entity.IDroppable(getContainer());
    }
}