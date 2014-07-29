package net.wg.gui.components.common.cursor.base
{
    import flash.utils.Dictionary;
    import flash.display.InteractiveObject;
    import net.wg.infrastructure.interfaces.entity.IDragDropHitArea;
    import net.wg.infrastructure.interfaces.entity.IDroppable;
    import net.wg.data.constants.Errors;
    import flash.events.MouseEvent;
    import net.wg.data.constants.Cursors;
    import net.wg.infrastructure.exceptions.ArgumentException;
    import net.wg.infrastructure.interfaces.entity.IDropItem;
    
    public class DroppingCursor extends ResizingCursor
    {
        
        public function DroppingCursor()
        {
            this._dropObjects = new Dictionary(true);
            super();
        }
        
        private static var END_DROP_PRIORITY:uint = 1;
        
        private static var AFTER_DROP_PRIORITY:uint = 0;
        
        private var _dropObjects:Dictionary;
        
        private var _dropSenderInfo:DropInfo = null;
        
        private var _dropItem:InteractiveObject = null;
        
        private var _isOnDropping:Boolean = false;
        
        private var _afterDropHandlersAdded:Boolean = false;
        
        public function registerDragging(param1:IDragDropHitArea, param2:String = null) : void
        {
            if(param1 is IDroppable)
            {
                this.registerDrop(IDroppable(param1),param2);
            }
        }
        
        public function unRegisterDragging(param1:IDragDropHitArea) : void
        {
            if(param1)
            {
                if(param1 is IDroppable)
                {
                    this.unRegisterDrop(IDroppable(param1));
                }
            }
        }
        
        override protected function onDispose() : void
        {
            var _loc1_:DropInfo = null;
            for each(_loc1_ in this._dropObjects)
            {
                DebugUtils.LOG_DEBUG(_loc1_.container + Errors.WASNT_UNREGISTERED);
                this.unRegisterDrop(_loc1_.container);
            }
            this._dropObjects = null;
            this._dropSenderInfo = null;
            this._dropItem = null;
            super.onDispose();
        }
        
        override protected function cursorIsFree() : Boolean
        {
            return (super.cursorIsFree()) && !this._isOnDropping;
        }
        
        private function removeAfterDropUpHandlers(param1:Function) : void
        {
            assertNotNull(this._dropSenderInfo,"_dropSenderInfo");
            assert(this._afterDropHandlersAdded,"must be added for removing.");
            this._afterDropHandlersAdded = false;
            stage.removeEventListener(MouseEvent.MOUSE_UP,param1);
            this._dropSenderInfo.hit.removeEventListener(MouseEvent.MOUSE_UP,param1);
        }
        
        private function addAfterDropUpHandlers(param1:Function) : void
        {
            assertNotNull(this._dropSenderInfo,"_dropSenderInfo");
            assert(!this._afterDropHandlersAdded,"must be removed for adding.");
            this._afterDropHandlersAdded = true;
            this._dropSenderInfo.hit.addEventListener(MouseEvent.MOUSE_UP,param1,false,AFTER_DROP_PRIORITY);
            stage.addEventListener(MouseEvent.MOUSE_UP,param1,false,AFTER_DROP_PRIORITY);
        }
        
        private function onAfterDrop() : void
        {
            forceSetCursor(Cursors.DRAG_OPEN);
            this.setDropping(false);
            var _loc1_:InteractiveObject = this._dropSenderInfo.container.getHitArea();
            this._dropSenderInfo.container.onAfterDrop(_loc1_,this._dropItem);
            this._dropSenderInfo.state = BaseInfo.STATE_NONE;
            this._dropSenderInfo = null;
            this._dropItem = null;
        }
        
        private function registerDrop(param1:IDroppable, param2:String = null) : void
        {
            var _loc3_:DropInfo = new DropInfo(param1,param2);
            assert(this._dropObjects[_loc3_.hit] == undefined,Errors.ALREADY_REGISTERED);
            this._dropObjects[_loc3_.hit] = _loc3_;
            _loc3_.hit.addEventListener(MouseEvent.ROLL_OVER,this.onEnterToDropMode,true);
            _loc3_.hit.addEventListener(MouseEvent.ROLL_OUT,this.rollOutDropHandler,true);
            _loc3_.hit.addEventListener(MouseEvent.MOUSE_DOWN,this.mouseDnDropHandler);
        }
        
        private function unRegisterDrop(param1:IDroppable) : void
        {
            if(this._dropSenderInfo)
            {
                if(this._dropSenderInfo.container == param1)
                {
                    forceSetCursor(Cursors.DRAG_OPEN);
                    this.setDropping(false);
                    this.removeAfterDropUpHandlers(this.mouseUpDropHdlr);
                    this._dropSenderInfo.state = BaseInfo.STATE_NONE;
                    this._dropSenderInfo = null;
                    this._dropItem = null;
                }
            }
            var _loc2_:InteractiveObject = BaseInfo.getHitFromContainer(param1);
            assert(!(this._dropObjects[_loc2_] == undefined),Errors.MUST_REGISTER);
            var _loc3_:DropInfo = this.getDropInfoByHit(_loc2_);
            _loc2_.removeEventListener(MouseEvent.ROLL_OVER,this.onEnterToDropMode,true);
            _loc2_.removeEventListener(MouseEvent.ROLL_OUT,this.rollOutDropHandler,true);
            _loc2_.removeEventListener(MouseEvent.MOUSE_DOWN,this.mouseDnDropHandler);
            delete this._dropObjects[_loc2_];
            true;
            _loc3_.dispose();
        }
        
        private function addDropListeners(param1:DropInfo) : void
        {
            var _loc3_:InteractiveObject = null;
            var _loc2_:Vector.<InteractiveObject> = param1.container.getDropGroup();
            if(_loc2_ != null)
            {
                for each(_loc3_ in _loc2_)
                {
                    _loc3_.addEventListener(MouseEvent.MOUSE_UP,this.onDropHandler,true,END_DROP_PRIORITY);
                }
            }
        }
        
        private function removeDropListeners(param1:DropInfo) : void
        {
            var _loc3_:InteractiveObject = null;
            var _loc2_:Vector.<InteractiveObject> = param1.container.getDropGroup();
            if(_loc2_ != null)
            {
                for each(_loc3_ in _loc2_)
                {
                    _loc3_.removeEventListener(MouseEvent.MOUSE_UP,this.onDropHandler,true);
                }
            }
        }
        
        private function getDropInfoBySlot(param1:InteractiveObject) : DropInfo
        {
            var _loc2_:DropInfo = null;
            var _loc3_:Vector.<InteractiveObject> = null;
            for each(_loc2_ in this._dropObjects)
            {
                _loc3_ = _loc2_.container.getDropGroup();
                if(_loc3_.indexOf(param1) != -1)
                {
                    return _loc2_;
                }
            }
            throw new ArgumentException("Unknown slot: " + param1);
        }
        
        private function setDropping(param1:Boolean) : void
        {
            if(param1 != this._isOnDropping)
            {
                this._isOnDropping = param1;
                tryToResetCursor();
            }
        }
        
        private function getDropInfoByHit(param1:InteractiveObject) : DropInfo
        {
            return this._dropObjects[param1];
        }
        
        private function onEnterToDropMode(param1:MouseEvent) : void
        {
            if(param1.target is IDropItem)
            {
                setCursor(Cursors.DRAG_OPEN);
            }
        }
        
        private function rollOutDropHandler(param1:MouseEvent) : void
        {
            assertLifeCycle();
            if(!this._isOnDropping)
            {
                resetCursor();
            }
        }
        
        private function onDropHandler(param1:MouseEvent) : void
        {
            assertNotNull(this._dropSenderInfo,"_dropSenderInfo");
            assertNotNull(this._dropItem,"_dropItem");
            var _loc2_:InteractiveObject = InteractiveObject(param1.currentTarget);
            var _loc3_:InteractiveObject = InteractiveObject(param1.target);
            var _loc4_:DropInfo = this.getDropInfoBySlot(_loc2_);
            var _loc5_:InteractiveObject = this._dropSenderInfo.container.getHitArea();
            this.removeDropListeners(_loc4_);
            _loc4_.container.onEndDrop(_loc5_,_loc2_,this._dropItem,_loc3_);
        }
        
        private function mouseDnDropHandler(param1:MouseEvent) : void
        {
            var _loc2_:DropInfo = null;
            var _loc3_:InteractiveObject = null;
            var _loc4_:InteractiveObject = null;
            var _loc5_:* = false;
            if(isLeftButton(param1))
            {
                assertLifeCycle();
                _loc2_ = this.getDropInfoByHit(InteractiveObject(param1.currentTarget));
                _loc3_ = InteractiveObject(param1.target);
                _loc4_ = _loc2_.container.getHitArea();
                _loc5_ = _loc2_.container.onBeforeDrop(_loc4_,_loc3_);
                if(_loc5_)
                {
                    this.setDropping(true);
                    forceSetCursor(_loc2_.cursor);
                    assertNull(this._dropSenderInfo,"_dropSenderInfo");
                    assertNull(this._dropItem,"_dropItem");
                    this._dropSenderInfo = _loc2_;
                    this._dropItem = _loc3_;
                    _loc2_.hit.addEventListener(MouseEvent.MOUSE_MOVE,this.droppingHandler);
                    this.addAfterDropUpHandlers(this.mouseUpHdlr);
                }
            }
        }
        
        private function mouseUpDropHdlr(param1:MouseEvent) : void
        {
            assertLifeCycle();
            this._dropSenderInfo.hit.removeEventListener(MouseEvent.MOUSE_MOVE,this.droppingHandler);
            var _loc2_:InteractiveObject = this._dropSenderInfo.container.getHitArea();
            if(this._dropItem is IDropItem)
            {
                this.removeDropListeners(this._dropSenderInfo);
            }
            assertNotNull(this._dropItem,"_dropItem");
            this.removeAfterDropUpHandlers(this.mouseUpDropHdlr);
            this.onAfterDrop();
        }
        
        private function mouseUpHdlr(param1:MouseEvent) : void
        {
            this._dropSenderInfo.hit.removeEventListener(MouseEvent.MOUSE_MOVE,this.droppingHandler);
            this.removeAfterDropUpHandlers(this.mouseUpHdlr);
            this.onAfterDrop();
        }
        
        private function droppingHandler(param1:MouseEvent) : void
        {
            var _loc3_:InteractiveObject = null;
            var _loc4_:* = false;
            assertLifeCycle();
            assertNotNull(this._dropSenderInfo,"_dropSenderInfo");
            var _loc2_:DropInfo = this.getDropInfoByHit(InteractiveObject(param1.currentTarget));
            if(_loc2_.state != BaseInfo.STATE_STARTED)
            {
                _loc2_.state = BaseInfo.STATE_STARTED;
                if(param1.target is IDropItem)
                {
                    _loc3_ = InteractiveObject(this._dropSenderInfo.container.getHitArea());
                    _loc4_ = _loc2_.container.onStartDrop(_loc3_,this._dropItem,param1.localX,param1.localY);
                    if(_loc4_)
                    {
                        this.addDropListeners(_loc2_);
                        this.removeAfterDropUpHandlers(this.mouseUpHdlr);
                        this.addAfterDropUpHandlers(this.mouseUpDropHdlr);
                    }
                }
            }
        }
    }
}
import net.wg.gui.components.common.cursor.base.BaseInfo;
import net.wg.infrastructure.interfaces.entity.IDroppable;
import net.wg.data.constants.Cursors;

class DropInfo extends BaseInfo
{
    
    function DropInfo(param1:IDroppable, param2:String)
    {
        super(param1,param2,Cursors.DRAG_CLOSE);
    }
    
    public function get container() : IDroppable
    {
        return IDroppable(getContainer());
    }
}
