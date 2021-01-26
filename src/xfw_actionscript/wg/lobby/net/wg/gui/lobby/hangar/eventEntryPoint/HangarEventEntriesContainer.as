package net.wg.gui.lobby.hangar.eventEntryPoint
{
    import net.wg.infrastructure.base.meta.impl.EventEntryPointsContainerMeta;
    import net.wg.infrastructure.base.meta.IEventEntryPointsContainerMeta;
    import net.wg.utils.helpLayout.IHelpLayoutComponent;
    import flash.geom.Rectangle;
    import flash.utils.Dictionary;
    import net.wg.gui.lobby.hangar.eventEntryPoint.data.EntryPointVO;
    import flash.events.Event;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.utils.helpLayout.HelpLayoutVO;
    import net.wg.infrastructure.events.LifeCycleEvent;
    import flash.display.DisplayObject;

    public class HangarEventEntriesContainer extends EventEntryPointsContainerMeta implements IEventEntryPointsContainerMeta, IHelpLayoutComponent
    {

        private static const EVENT_ENTRY_POINT_GAP_SMALL:int = 10;

        private static const EVENT_ENTRY_POINT_GAP_BIG:int = 20;

        private static const SMALL_MARGINS:Rectangle = new Rectangle(0,5,5,10);

        private static const BIG_MARGINS:Rectangle = new Rectangle(0,5,30,30);

        private var _entryByLinkageMap:Dictionary;

        private var _data:Vector.<EntryPointVO> = null;

        private var _isSmall:Boolean = false;

        private var _isActive:Boolean = false;

        public function HangarEventEntriesContainer()
        {
            this._entryByLinkageMap = new Dictionary();
            super();
            mouseEnabled = false;
            visible = false;
        }

        override public function setSize(param1:Number, param2:Number) : void
        {
            var _loc3_:Boolean = param1 != _width || param2 != _height;
            super.setSize(param1,param2);
            if(_loc3_)
            {
                dispatchEvent(new Event(Event.RESIZE));
            }
        }

        override protected function onDispose() : void
        {
            var _loc1_:String = null;
            for each(_loc1_ in this._entryByLinkageMap)
            {
                this.removeEntry(_loc1_);
            }
            App.utils.data.cleanupDynamicObject(this._entryByLinkageMap);
            this._entryByLinkageMap = null;
            this._data = null;
            super.onDispose();
        }

        override protected function draw() : void
        {
            super.draw();
            if(this._data)
            {
                if(isInvalid(InvalidationType.DATA))
                {
                    this.updateData();
                }
                if(isInvalid(InvalidationType.LAYOUT))
                {
                    this.updateLayout();
                }
            }
        }

        override protected function updateEntries(param1:Vector.<EntryPointVO>) : void
        {
            this._data = param1;
            invalidateData();
            if(param1.length == 0)
            {
                validateNow();
            }
        }

        private function updateData() : void
        {
            var _loc1_:EntryPoint = null;
            var _loc2_:EntryPointVO = null;
            var _loc3_:Vector.<String> = null;
            var _loc4_:String = null;
            this.removeEntriesFromContainer();
            for each(_loc2_ in this._data)
            {
                _loc1_ = this._entryByLinkageMap[_loc2_.entryLinkage];
                if(_loc1_ == null)
                {
                    this.createEntry(_loc2_);
                }
                else if(_loc1_.entryPointDO != null)
                {
                    addChildAt(_loc1_.entryPointDO,0);
                }
            }
            _loc3_ = new Vector.<String>(0);
            for each(_loc1_ in this._entryByLinkageMap)
            {
                if(_loc1_.entryPointDO && _loc1_.entryPointDO.parent == null)
                {
                    _loc3_.push(_loc1_.linkage);
                }
            }
            for each(_loc4_ in _loc3_)
            {
                this.removeEntry(_loc4_);
            }
            invalidateLayout();
        }

        private function updateLayout() : void
        {
            var _loc1_:EntryPoint = null;
            var _loc2_:IEventEntryPoint = null;
            var _loc3_:int = this._data.length;
            var _loc4_:int = this._isSmall?EntryPointSize.SMALL:EntryPointSize.BIG;
            if(_loc3_ <= 1)
            {
                _loc4_ = _loc4_ | EntryPointSize.WIDE_MASK;
            }
            for each(_loc1_ in this._entryByLinkageMap)
            {
                _loc2_ = _loc1_.entryPoint;
                if(_loc2_ != null)
                {
                    _loc2_.size = _loc4_;
                    _loc2_.validateNow();
                }
            }
            this.layoutEntries();
            if(this._isActive)
            {
                visible = true;
            }
            else
            {
                this.setSize(0,0);
                visible = false;
            }
        }

        public function getLayoutProperties() : Vector.<HelpLayoutVO>
        {
            return undefined;
        }

        private function removeEntriesFromContainer() : void
        {
            var _loc1_:EntryPoint = null;
            for each(_loc1_ in this._entryByLinkageMap)
            {
                if(_loc1_.entryPointDO)
                {
                    removeChild(_loc1_.entryPointDO);
                }
            }
        }

        private function createEntry(param1:EntryPointVO) : EntryPoint
        {
            var _loc2_:EntryPoint = new EntryPoint(param1);
            this._entryByLinkageMap[param1.entryLinkage] = _loc2_;
            _loc2_.addEventListener(Event.COMPLETE,this.onEntryCompleteHandler);
            _loc2_.init();
            return _loc2_;
        }

        private function removeEntry(param1:String) : void
        {
            var _loc2_:EntryPoint = this._entryByLinkageMap[param1];
            if(_loc2_)
            {
                _loc2_.removeEventListener(Event.COMPLETE,this.onEntryCompleteHandler);
                _loc2_.entryPoint.removeEventListener(LifeCycleEvent.ON_BEFORE_DISPOSE,this.onEntryPointOnBeforeDisposeHandler);
                unregisterFlashComponentS(_loc2_.linkage);
                removeChild(_loc2_.entryPointDO);
            }
            delete this._entryByLinkageMap[param1];
            invalidateLayout();
        }

        private function layoutEntries() : void
        {
            var _loc2_:EntryPoint = null;
            var _loc3_:IEventEntryPoint = null;
            var _loc4_:Rectangle = null;
            var _loc5_:* = 0;
            var _loc6_:* = 0;
            var _loc7_:* = 0;
            var _loc1_:* = 0;
            for each(_loc2_ in this._entryByLinkageMap)
            {
                _loc3_ = _loc2_.entryPoint;
                if(_loc3_ && _loc3_.visible)
                {
                    this._isActive = true;
                    _loc1_ = Math.max(_loc1_,_loc3_.height + _loc3_.margin.top + _loc3_.margin.height);
                }
            }
            _loc5_ = 0;
            _loc6_ = this._data.length;
            _loc7_ = 0;
            while(_loc7_ < _loc6_)
            {
                _loc2_ = this._entryByLinkageMap[this._data[_loc7_].entryLinkage];
                _loc3_ = _loc2_.entryPoint;
                if(_loc3_)
                {
                    _loc4_ = _loc3_.margin;
                    _loc5_ = _loc5_ + _loc4_.left;
                    _loc3_.x = _loc5_;
                    _loc3_.y = _loc1_ - (_loc3_.height + _loc4_.top);
                    _loc5_ = _loc5_ + (_loc3_.width + _loc4_.width);
                    if(_loc7_ < _loc6_ - 1)
                    {
                        _loc5_ = _loc5_ + this.gap;
                    }
                }
                _loc7_++;
            }
            this.setSize(_loc5_,_loc1_);
        }

        private function removeFromData(param1:String) : void
        {
            var _loc2_:EntryPointVO = null;
            var _loc3_:int = this._data.length;
            var _loc4_:* = 0;
            while(_loc3_)
            {
                _loc2_ = this._data[_loc4_];
                if(_loc2_.entryLinkage == param1)
                {
                    this._data.splice(_loc4_,1);
                    break;
                }
                _loc4_++;
            }
        }

        public function get margin() : Rectangle
        {
            return this._isSmall?SMALL_MARGINS:BIG_MARGINS;
        }

        public function get gap() : int
        {
            return this._isSmall?EVENT_ENTRY_POINT_GAP_SMALL:EVENT_ENTRY_POINT_GAP_BIG;
        }

        public function set isSmall(param1:Boolean) : void
        {
            if(this._isSmall != param1)
            {
                this._isSmall = param1;
                invalidateLayout();
            }
        }

        public function get isActive() : Boolean
        {
            return this._isActive;
        }

        private function onEntryCompleteHandler(param1:Event) : void
        {
            var _loc2_:EntryPoint = EntryPoint(param1.currentTarget);
            _loc2_.entryPoint.addEventListener(LifeCycleEvent.ON_BEFORE_DISPOSE,this.onEntryPointOnBeforeDisposeHandler);
            addChildAt(_loc2_.entryPointDO,0);
            registerFlashComponentS(_loc2_.entryPoint,_loc2_.linkage);
            invalidateLayout();
        }

        private function onEntryPointOnBeforeDisposeHandler(param1:LifeCycleEvent) : void
        {
            var _loc3_:String = null;
            var _loc2_:DisplayObject = DisplayObject(param1.currentTarget);
            for(_loc3_ in this._entryByLinkageMap)
            {
                if(this._entryByLinkageMap[_loc3_].entryPoint == _loc2_)
                {
                    this.removeEntry(_loc3_);
                    this.removeFromData(_loc3_);
                    break;
                }
            }
        }
    }
}
