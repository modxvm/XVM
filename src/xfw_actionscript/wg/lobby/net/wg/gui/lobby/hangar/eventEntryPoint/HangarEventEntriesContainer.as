package net.wg.gui.lobby.hangar.eventEntryPoint
{
    import net.wg.infrastructure.base.UIComponentEx;
    import net.wg.gui.lobby.hangar.Hangar;
    import flash.utils.Dictionary;
    import flash.geom.Rectangle;
    import flash.events.Event;
    import flash.display.DisplayObject;
    import scaleform.clik.constants.InvalidationType;

    public class HangarEventEntriesContainer extends UIComponentEx
    {

        private var _hangar:Hangar = null;

        private var _entryByAlias:Dictionary;

        private var _marginBig:Rectangle;

        private var _marginSmall:Rectangle;

        private var _margin:Rectangle = null;

        private var _gapBig:int = 20;

        private var _gapSmall:int = 10;

        private var _gap:int = -1;

        private var _isSmall:Boolean = false;

        private var _sizeInitialized:Boolean = false;

        private var _isActive:Boolean = false;

        public function HangarEventEntriesContainer(param1:Hangar)
        {
            this._entryByAlias = new Dictionary();
            this._marginBig = new Rectangle();
            this._marginSmall = new Rectangle();
            super();
            this._hangar = param1;
            this._margin = this._marginSmall;
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
            var _loc1_:IEventEntryPoint = null;
            for each(_loc1_ in this._entryByAlias)
            {
                removeChild(DisplayObject(_loc1_));
            }
            App.utils.data.cleanupDynamicObject(this._entryByAlias);
            this._entryByAlias = null;
            this._marginSmall = null;
            this._marginBig = null;
            this._margin = null;
            this._hangar = null;
            super.onDispose();
        }

        override protected function draw() : void
        {
            var _loc1_:* = 0;
            var _loc2_:IEventEntryPoint = null;
            var _loc3_:* = 0;
            super.draw();
            if(isInvalid(InvalidationType.LAYOUT))
            {
                _loc1_ = 0;
                this._isActive = false;
                for each(_loc2_ in this._entryByAlias)
                {
                    if(_loc2_.visible)
                    {
                        this._isActive = true;
                        _loc2_.isSmall = this._isSmall;
                        _loc1_ = Math.max(_loc1_,_loc2_.height);
                    }
                }
                if(this._isActive)
                {
                    _loc3_ = this._margin.left;
                    for each(_loc2_ in this._entryByAlias)
                    {
                        if(_loc2_.visible)
                        {
                            _loc2_.x = _loc3_;
                            _loc2_.y = this._margin.top + _loc1_ - _loc2_.height;
                            _loc3_ = _loc3_ + (_loc2_.width + this._gap);
                        }
                    }
                    this.setSize(_loc3_ - this._gap + this._margin.left + this._margin.right,_loc1_ + this._margin.top + this._margin.bottom);
                    visible = true;
                }
                else
                {
                    this.setSize(0,0);
                    visible = false;
                }
            }
        }

        public function addEntry(param1:IEventEntryPoint, param2:String, param3:Boolean = true) : void
        {
            App.utils.asserter.assertNull(this._entryByAlias[param2],"entry with alias " + param2 + " already added");
            this._entryByAlias[param2] = param1;
            addChild(DisplayObject(param1));
            if(param3)
            {
                this._hangar.registerFlashComponentS(param1,param2);
            }
            invalidate(InvalidationType.LAYOUT);
        }

        public function setGap(param1:int, param2:int) : void
        {
            if(this._gapSmall == param1 && this._gapBig == param2)
            {
                return;
            }
            this._gapSmall = param1;
            this._gapBig = param2;
            invalidate(InvalidationType.LAYOUT);
        }

        public function setMarginBig(param1:int, param2:int, param3:int, param4:int) : void
        {
            if(this._marginBig.left != param1 || this._marginBig.top != param2 || this._marginBig.right != param3 || this._marginBig.bottom != param4)
            {
                this._marginBig.left = param1;
                this._marginBig.top = param2;
                this._marginBig.right = param3;
                this._marginBig.bottom = param4;
                if(this._margin == this._marginBig)
                {
                    invalidate(InvalidationType.LAYOUT);
                }
            }
        }

        public function setMarginSmall(param1:int, param2:int, param3:int, param4:int) : void
        {
            if(this._marginSmall.left != param1 || this._marginSmall.top != param2 || this._marginSmall.right != param3 || this._marginSmall.bottom != param4)
            {
                this._marginSmall.left = param1;
                this._marginSmall.top = param2;
                this._marginSmall.right = param3;
                this._marginSmall.bottom = param4;
                if(this._margin == this._marginSmall)
                {
                    invalidate(InvalidationType.LAYOUT);
                }
            }
        }

        public function updateEntry(param1:String, param2:Boolean) : void
        {
            var _loc3_:IEventEntryPoint = this._entryByAlias[param1];
            if(_loc3_ && _loc3_.visible != param2)
            {
                _loc3_.visible = param2;
                invalidate(InvalidationType.LAYOUT);
            }
        }

        public function set isSmall(param1:Boolean) : void
        {
            if(this._isSmall != param1 || !this._sizeInitialized)
            {
                this._sizeInitialized = true;
                this._isSmall = param1;
                this._margin = param1?this._marginSmall:this._marginBig;
                this._gap = param1?this._gapSmall:this._gapBig;
                invalidate(InvalidationType.LAYOUT);
            }
        }

        public function get isActive() : Boolean
        {
            return this._isActive;
        }
    }
}
