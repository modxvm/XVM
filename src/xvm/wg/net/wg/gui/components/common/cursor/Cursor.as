package net.wg.gui.components.common.cursor 
{
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import net.wg.data.constants.*;
    import net.wg.gui.components.common.cursor.base.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.infrastructure.interfaces.entity.*;
    
    public class Cursor extends net.wg.gui.components.common.cursor.base.DroppingCursor implements net.wg.infrastructure.interfaces.ICursor
    {
        public function Cursor()
        {
            this._dragObjects = new flash.utils.Dictionary(true);
            super();
            stop();
            return;
        }

        public override function registerDragging(arg1:net.wg.infrastructure.interfaces.entity.IDragDropHitArea, arg2:String=null):void
        {
            if (!(arg1 is net.wg.infrastructure.interfaces.entity.IDraggable) && !(arg1 is net.wg.infrastructure.interfaces.entity.IDroppable)) 
            {
                DebugUtils.LOG_ERROR(CAST_MSG_ERROR);
            }
            else 
            {
                super.registerDragging(arg1, arg2);
                if (arg1 is net.wg.infrastructure.interfaces.entity.IDraggable) 
                {
                    this.registerDrag(net.wg.infrastructure.interfaces.entity.IDraggable(arg1), arg2);
                }
                if (arg1 is net.wg.infrastructure.interfaces.IView) 
                {
                    net.wg.infrastructure.interfaces.IView(arg1).addEventListener(net.wg.infrastructure.events.LifeCycleEvent.ON_AFTER_DISPOSE, this.onAfterDraggableObjDispose);
                }
            }
            return;
        }

        protected override function nextFrameAfterPopulateHandler():void
        {
            return;
        }

        public override function unRegisterDragging(arg1:net.wg.infrastructure.interfaces.entity.IDragDropHitArea):void
        {
            if (!disposed) 
            {
                if (!(arg1 is net.wg.infrastructure.interfaces.entity.IDraggable) && !(arg1 is net.wg.infrastructure.interfaces.entity.IDroppable)) 
                {
                    DebugUtils.LOG_ERROR(CAST_MSG_ERROR);
                }
                else 
                {
                    super.unRegisterDragging(arg1);
                    assertNotNull(arg1, "container");
                    if (arg1 is net.wg.infrastructure.interfaces.entity.IDraggable) 
                    {
                        this.unRegisterDrag(net.wg.infrastructure.interfaces.entity.IDraggable(arg1));
                    }
                    if (arg1 is net.wg.infrastructure.interfaces.IView) 
                    {
                        flash.events.EventDispatcher(arg1).removeEventListener(net.wg.infrastructure.events.LifeCycleEvent.ON_AFTER_DISPOSE, this.onAfterDraggableObjDispose);
                    }
                }
            }
            return;
        }

        public function as_setCursor(arg1:String):void
        {
            setCursor(arg1);
            return;
        }

        protected override function onPopulate():void
        {
            super.onPopulate();
            if (App.instance) 
            {
                x = App.appWidth - width >> 1;
                y = App.appHeight - height >> 1;
            }
            return;
        }

        protected override function onDispose():void
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=this._dragObjects;
            for each (loc1 in loc3) 
            {
                DebugUtils.LOG_DEBUG(loc1.container + net.wg.data.constants.Errors.WASNT_UNREGISTERED);
                this.unRegisterDrag(loc1.container);
            }
            this._dragObjects = null;
            super.onDispose();
            return;
        }

        protected override function cursorIsFree():Boolean
        {
            return super.cursorIsFree() && !this._isOnDragging;
        }

        internal function registerDrag(arg1:net.wg.infrastructure.interfaces.entity.IDraggable, arg2:String=null):void
        {
            var loc1:*=new DragInfo(arg1, arg2);
            assert(this._dragObjects[loc1.hit] == undefined, net.wg.data.constants.Errors.ALREADY_REGISTERED);
            this._dragObjects[loc1.hit] = loc1;
            if (loc1.container.getDragType() != net.wg.data.constants.DragType.NONE) 
            {
                loc1.hit.addEventListener(flash.events.MouseEvent.ROLL_OVER, this.onEnterToDragMode);
                loc1.hit.addEventListener(flash.events.MouseEvent.ROLL_OUT, this.rollOutDragHandler);
                loc1.hit.addEventListener(flash.events.MouseEvent.MOUSE_DOWN, this.mouseDnDragHandler);
            }
            return;
        }

        internal function unRegisterDrag(arg1:net.wg.infrastructure.interfaces.entity.IDraggable):void
        {
            var loc1:*=net.wg.gui.components.common.cursor.base.BaseInfo.getHitFromContainer(arg1);
            assert(!(this._dragObjects[loc1] == undefined), net.wg.data.constants.Errors.MUST_REGISTER);
            var loc2:*=this.getDragInfoByHit(loc1);
            if (loc2.processStarted) 
            {
                loc1.dispatchEvent(new flash.events.MouseEvent(flash.events.MouseEvent.MOUSE_UP, false));
                assert(!loc2.processStarted, "processStarted must be false after dispatching MOUSE_UP");
            }
            loc1.removeEventListener(flash.events.MouseEvent.ROLL_OVER, this.onEnterToDragMode);
            loc1.removeEventListener(flash.events.MouseEvent.ROLL_OUT, this.rollOutDragHandler);
            loc1.removeEventListener(flash.events.MouseEvent.MOUSE_DOWN, this.mouseDnDragHandler);
            delete this._dragObjects[loc1];
            loc2.dispose();
            return;
        }

        internal function getDragInfoByHit(arg1:flash.display.InteractiveObject):DragInfo
        {
            return this._dragObjects[arg1];
        }

        internal function setDragging(arg1:Boolean, arg2:Boolean=false):void
        {
            if (arg1 != this._isOnDragging) 
            {
                this._isOnDragging = arg1;
                if (arg2) 
                {
                    tryToResetCursor();
                }
            }
            return;
        }

        internal function onEnterToDragMode(arg1:flash.events.MouseEvent):void
        {
            if (!this._isOnDragging) 
            {
                forceSetCursor(net.wg.data.constants.Cursors.DRAG_OPEN);
            }
            return;
        }

        internal function draggingHandler(arg1:flash.events.MouseEvent):void
        {
            assertLifeCycle();
            var loc1:*=this.getDragInfoByHit(flash.display.InteractiveObject(arg1.currentTarget));
            if (!loc1.processStarted) 
            {
                loc1.processStarted = true;
                loc1.container.onStartDrag();
            }
            var loc2:*=loc1.container;
            loc2.onDragging(arg1.localX, arg1.localY);
            return;
        }

        internal function rollOutDragHandler(arg1:flash.events.MouseEvent):void
        {
            assertLifeCycle();
            resetCursor();
            return;
        }

        internal function mouseDnDragHandler(arg1:flash.events.MouseEvent):void
        {
            var event:flash.events.MouseEvent;
            var dragInfo:DragInfo;
            var mouseUpLclHdr:Function;
            var mouseReleaseOutsideLclHdr:Function;

            var loc1:*;
            dragInfo = null;
            mouseUpLclHdr = null;
            mouseReleaseOutsideLclHdr = null;
            event = arg1;
            if (isLeftButton(event)) 
            {
                mouseUpLclHdr = function (arg1:flash.events.MouseEvent):void
                {
                    assertLifeCycle();
                    stage.removeEventListener(flash.events.MouseEvent.MOUSE_UP, mouseReleaseOutsideLclHdr);
                    dragInfo.hit.removeEventListener(flash.events.MouseEvent.MOUSE_UP, mouseUpLclHdr);
                    dragInfo.hit.removeEventListener(flash.events.MouseEvent.MOUSE_MOVE, draggingHandler);
                    if (_isOnDragging) 
                    {
                        forceSetCursor(net.wg.data.constants.Cursors.DRAG_OPEN);
                        setDragging(false);
                    }
                    dragInfo.container.onEndDrag();
                    dragInfo.processStarted = false;
                    return;
                }
                mouseReleaseOutsideLclHdr = function (arg1:flash.events.MouseEvent):void
                {
                    setDragging(false, true);
                    mouseUpLclHdr(arg1);
                    return;
                }
                assertLifeCycle();
                dragInfo = this.getDragInfoByHit(flash.display.InteractiveObject(event.currentTarget));
                this.setDragging(true);
                forceSetCursor(dragInfo.cursor);
                dragInfo.hit.addEventListener(flash.events.MouseEvent.MOUSE_MOVE, this.draggingHandler);
                dragInfo.hit.addEventListener(flash.events.MouseEvent.MOUSE_UP, mouseUpLclHdr, false);
                stage.addEventListener(flash.events.MouseEvent.MOUSE_UP, mouseReleaseOutsideLclHdr, false);
            }
            return;
        }

        internal function onAfterDraggableObjDispose(arg1:net.wg.infrastructure.events.LifeCycleEvent):void
        {
            assertLifeCycle();
            var loc1:*=net.wg.infrastructure.interfaces.entity.IDraggable(arg1.target);
            DebugUtils.LOG_DEBUG(loc1 + net.wg.data.constants.Errors.WASNT_UNREGISTERED);
            net.wg.infrastructure.interfaces.IView(loc1).removeEventListener(net.wg.infrastructure.events.LifeCycleEvent.ON_AFTER_DISPOSE, this.onAfterDraggableObjDispose);
            var loc2:*=net.wg.gui.components.common.cursor.base.BaseInfo.getHitFromContainer(loc1);
            if (this._dragObjects[loc2] != undefined) 
            {
                this.unRegisterDragging(loc1);
            }
            return;
        }

        internal static const CAST_MSG_ERROR:String="dragArea for registerDragging must implements IDraggable or IDroppable interfaces.";

        internal var _dragObjects:flash.utils.Dictionary;

        internal var _isOnDragging:Boolean=false;
    }
}

import net.wg.data.constants.*;
import net.wg.gui.components.common.cursor.base.*;
import net.wg.infrastructure.interfaces.entity.*;


class DragInfo extends net.wg.gui.components.common.cursor.base.BaseInfo
{
    public function DragInfo(arg1:net.wg.infrastructure.interfaces.entity.IDraggable, arg2:String)
    {
        super(arg1, arg2, net.wg.data.constants.Cursors.DRAG_CLOSE);
        return;
    }

    public function get container():net.wg.infrastructure.interfaces.entity.IDraggable
    {
        return net.wg.infrastructure.interfaces.entity.IDraggable(getContainer());
    }
}