package net.wg.gui.lobby.battleResults
{
    import scaleform.clik.core.UIComponent;
    import net.wg.data.constants.Values;
    import scaleform.clik.interfaces.IDataProvider;
    import flash.display.MovieClip;
    import scaleform.clik.data.DataProvider;
    import scaleform.clik.constants.InvalidationType;
    import flash.filters.ColorMatrixFilter;
    import flash.filters.DropShadowFilter;
    import flash.events.Event;
    import flash.display.DisplayObject;
    import scaleform.clik.interfaces.IListItemRenderer;
    import flash.utils.getDefinitionByName;
    import scaleform.clik.events.ButtonEvent;
    import flash.events.MouseEvent;
    import scaleform.clik.events.ListEvent;
    import scaleform.gfx.MouseEventEx;
    import net.wg.data.constants.Tooltips;
    
    public class MedalsList extends UIComponent
    {
        
        public function MedalsList() {
            super();
            this.renderers = [];
            this.stripes = [];
            this.stripesArea = new MovieClip();
            addChild(this.stripesArea);
            this.contentArea = new MovieClip();
            addChild(this.contentArea);
        }
        
        private static var ALIGN_LEFT:String = "left";
        
        private static var ALIGN_RIGHT:String = "right";
        
        private static var ALIGN_CENTER:String = "center";
        
        private static var INVALIDATE_FILTERS:String = "invFilt";
        
        private static function isDisplaySpecial(param1:Object) : Boolean {
            var _loc2_:* = "isEpic";
            var _loc3_:Boolean = _loc2_ in param1 && (param1[_loc2_]);
            var _loc4_:* = "specialIcon";
            var _loc5_:Boolean = _loc4_ in param1 && !(param1[_loc4_] == Values.EMPTY_STR);
            return (_loc3_) || (_loc5_);
        }
        
        public var _itemRenderer:String = "";
        
        public var _stripeRenderer:String = "";
        
        public var _align:String = "left";
        
        public var _gap:Number = 0;
        
        public var _colorDodgeMulty:Number = 1.3;
        
        protected var _dataProvider:IDataProvider;
        
        private var renderers:Array;
        
        private var stripes:Array;
        
        public var contentArea:MovieClip;
        
        public var stripesArea:MovieClip;
        
        override protected function initialize() : void {
            this.dataProvider = new DataProvider();
            super.initialize();
        }
        
        public function invalidateFilters() : void {
            invalidate(INVALIDATE_FILTERS);
            invalidate(InvalidationType.DATA);
        }
        
        public function updateFilters() : void {
            var _loc1_:Array = [];
            _loc1_ = _loc1_.concat([this._colorDodgeMulty,0,0,0,0]);
            _loc1_ = _loc1_.concat([0,this._colorDodgeMulty,0,0,0]);
            _loc1_ = _loc1_.concat([0,0,this._colorDodgeMulty,0,0]);
            _loc1_ = _loc1_.concat([0,0,0,1,0]);
            var _loc2_:ColorMatrixFilter = new ColorMatrixFilter();
            _loc2_.matrix = _loc1_;
            var _loc3_:DropShadowFilter = new DropShadowFilter(2,90,0,0.75,4,4);
            this.contentArea.filters = [];
            this.contentArea.filters = [_loc2_,_loc3_];
            this.stripesArea.filters = [];
            this.stripesArea.filters = [new DropShadowFilter(2,90,0,0.75,4,4)];
        }
        
        public function get dataProvider() : IDataProvider {
            return this._dataProvider;
        }
        
        public function set dataProvider(param1:IDataProvider) : void {
            if(this._dataProvider == param1)
            {
                return;
            }
            if(this._dataProvider != null)
            {
                this._dataProvider.removeEventListener(Event.CHANGE,this.onDataChange,false);
            }
            this._dataProvider = param1;
            if(this._dataProvider == null)
            {
                return;
            }
            this._dataProvider.addEventListener(Event.CHANGE,this.onDataChange,false,0,true);
            invalidateData();
        }
        
        public function clear() : void {
            while(this.renderers.length)
            {
                this.renderers.pop().removeMovieClip();
            }
            while(this.stripes.length)
            {
                this.stripes.pop().removeMovieClip();
            }
        }
        
        override protected function configUI() : void {
            super.configUI();
            initSize();
            this.contentArea.height = height;
            this.contentArea.width = width;
            this.contentArea.scaleX = this.contentArea.scaleY = 1;
            this.stripesArea.height = height;
            this.stripesArea.width = width;
            this.stripesArea.scaleX = this.stripesArea.scaleY = 1;
            invalidate(INVALIDATE_FILTERS);
        }
        
        override protected function draw() : void {
            if(this._dataProvider)
            {
                this.drawRenderers(this._dataProvider.length);
                if(isInvalid(InvalidationType.DATA))
                {
                    this._dataProvider.requestItemRange(0,this._dataProvider.length - 1,this.populateData);
                }
                if(this.renderers.length)
                {
                    this.drawLayout();
                }
            }
            if(isInvalid(INVALIDATE_FILTERS))
            {
                this.updateFilters();
            }
        }
        
        private function drawRenderers(param1:Number) : void {
            var _loc2_:Object = null;
            while(this.renderers.length)
            {
                this.contentArea.removeChild(this.renderers.pop());
            }
            while(this.stripes.length)
            {
                _loc2_ = this.stripes.pop();
                if(_loc2_)
                {
                    this.stripesArea.removeChild(_loc2_ as DisplayObject);
                }
            }
            while(this.renderers.length < param1)
            {
                this.renderers.push(this.createItemRenderer());
            }
        }
        
        private function drawLayout() : void {
            var _loc8_:MovieClip = null;
            var _loc1_:Number = this.renderers.length;
            var _loc2_:MovieClip = null;
            var _loc3_:Number = Math.round(this.renderers[0].width);
            var _loc4_:Number = (_loc3_ + this._gap) * _loc1_;
            if(_loc4_ > width)
            {
                this._gap = Math.round((width - _loc3_ * _loc1_) / (_loc1_ - 1));
            }
            var _loc5_:Number = Math.round(this._gap + _loc3_ + 2);
            var _loc6_:Number = 0;
            if(this._align == ALIGN_RIGHT)
            {
                _loc6_ = Math.round(width - _loc5_);
            }
            else if(this._align == ALIGN_CENTER)
            {
                _loc6_ = Math.round((width - _loc5_ * _loc1_) / 2);
            }
            
            var _loc7_:Number = 0;
            while(_loc1_ > _loc7_)
            {
                _loc2_ = MovieClip(this.renderers[_loc7_]);
                if(this._align == ALIGN_LEFT || this._align == ALIGN_CENTER)
                {
                    _loc2_.x = Math.round(_loc6_ + Math.round(_loc5_ * _loc7_));
                }
                else if(this._align == ALIGN_RIGHT)
                {
                    _loc2_.x = Math.round(_loc6_ - Math.round(_loc5_ * _loc7_));
                }
                
                _loc2_.y = Math.round((height - _loc2_.height) / 2);
                _loc2_.index = _loc7_;
                if(!(this._stripeRenderer == "") && (isDisplaySpecial(_loc2_.data)))
                {
                    _loc8_ = this.stripes[_loc7_];
                    if(_loc8_)
                    {
                        _loc8_.x = _loc2_.x - Math.round((_loc8_.width - _loc2_.width) / 2);
                        _loc8_.y = _loc2_.y - Math.round((_loc8_.height - _loc2_.height) / 2);
                        _loc8_.visible = true;
                    }
                }
                _loc2_.visible = true;
                _loc7_++;
            }
        }
        
        private function createItemRenderer() : IListItemRenderer {
            var _loc1_:Class = getDefinitionByName(this._itemRenderer) as Class;
            var _loc2_:IListItemRenderer = new _loc1_() as IListItemRenderer;
            if(_loc2_ == null)
            {
                DebugUtils.LOG_DEBUG("Renderer class could not be created.");
                return null;
            }
            this.contentArea.addChild(_loc2_ as DisplayObject);
            (_loc2_ as DisplayObject).visible = false;
            _loc2_.focusTarget = this;
            this.setupRenderer(_loc2_);
            return _loc2_;
        }
        
        protected function setupRenderer(param1:IListItemRenderer) : void {
            param1.owner = this;
            param1.focusTarget = this;
            param1.tabEnabled = false;
            param1.doubleClickEnabled = true;
            param1.addEventListener(ButtonEvent.PRESS,this.dispatchItemEvent,false,0,true);
            param1.addEventListener(ButtonEvent.CLICK,this.handleItemClick,false,0,true);
            param1.addEventListener(MouseEvent.DOUBLE_CLICK,this.dispatchItemEvent,false,0,true);
            param1.addEventListener(MouseEvent.ROLL_OVER,this.dispatchItemEvent,false,0,true);
            param1.addEventListener(MouseEvent.ROLL_OUT,this.dispatchItemEvent,false,0,true);
        }
        
        protected function dispatchItemEvent(param1:Event) : Boolean {
            var _loc2_:String = null;
            var _loc8_:Object = null;
            var _loc9_:String = null;
            switch(param1.type)
            {
                case ButtonEvent.PRESS:
                    _loc2_ = ListEvent.ITEM_PRESS;
                    break;
                case ButtonEvent.CLICK:
                    _loc2_ = ListEvent.ITEM_CLICK;
                    break;
                case MouseEvent.ROLL_OVER:
                    _loc2_ = ListEvent.ITEM_ROLL_OVER;
                    break;
                case MouseEvent.ROLL_OUT:
                    _loc2_ = ListEvent.ITEM_ROLL_OUT;
                    break;
                case MouseEvent.DOUBLE_CLICK:
                    _loc2_ = ListEvent.ITEM_DOUBLE_CLICK;
                    break;
                default:
                    return true;
            }
            var _loc3_:IListItemRenderer = param1.currentTarget as IListItemRenderer;
            var _loc4_:uint = 0;
            if(param1 is ButtonEvent)
            {
                _loc4_ = (param1 as ButtonEvent).controllerIdx;
            }
            else if(param1 is MouseEventEx)
            {
                _loc4_ = (param1 as MouseEventEx).mouseIdx;
            }
            
            var _loc5_:uint = 0;
            if(param1 is ButtonEvent)
            {
                _loc5_ = (param1 as ButtonEvent).buttonIdx;
            }
            else if(param1 is MouseEventEx)
            {
                _loc5_ = (param1 as MouseEventEx).buttonIdx;
            }
            
            var _loc6_:* = false;
            if(param1 is ButtonEvent)
            {
                _loc6_ = (param1 as ButtonEvent).isKeyboard;
            }
            var _loc7_:ListEvent = new ListEvent(_loc2_,false,true,_loc3_.index,0,_loc3_.index,_loc3_,this.dataProvider[_loc3_.index],_loc4_,_loc5_,_loc6_);
            if(_loc2_ == ListEvent.ITEM_ROLL_OVER)
            {
                _loc8_ = this.dataProvider[_loc3_.index];
                if(_loc8_.type == "markOfMastery")
                {
                    _loc9_ = Tooltips.TANK_CLASS;
                }
                else if(_loc8_.type == "marksOnGun")
                {
                    _loc9_ = Tooltips.BATTLE_STATS_MARKS_ON_GUN_ACHIEVEMENT;
                }
                else
                {
                    _loc9_ = Tooltips.BATTLE_STATS_ACHIEVS;
                }
                
                this.showToolTip(_loc9_,_loc8_);
            }
            else if(_loc2_ == ListEvent.ITEM_ROLL_OUT)
            {
                this.hideTooltip();
            }
            
            return dispatchEvent(_loc7_);
        }
        
        protected function showToolTip(param1:String, param2:Object) : void {
            App.toolTipMgr.showSpecial(param1,null,param2.block,param2.type,param2.rank,param2.customData);
        }
        
        protected function hideTooltip() : void {
            App.toolTipMgr.hide();
        }
        
        private function handleItemClick(param1:Event) : void {
            var _loc2_:Number = param1.target.index;
            if(isNaN(_loc2_))
            {
                return;
            }
            this.dispatchItemEvent(param1);
        }
        
        private function populateData(param1:Array) : void {
            var _loc3_:MovieClip = null;
            var _loc4_:Object = null;
            var _loc5_:Class = null;
            var _loc6_:SpecialAchievement = null;
            var _loc2_:Number = 0;
            while(_loc2_ < this.renderers.length)
            {
                _loc3_ = this.renderers[_loc2_];
                _loc4_ = param1[_loc2_];
                _loc3_.setData(_loc4_);
                _loc3_.enabled = this.enabled;
                if(this._stripeRenderer != "")
                {
                    if(isDisplaySpecial(_loc4_))
                    {
                        _loc5_ = getDefinitionByName(this._stripeRenderer) as Class;
                        _loc6_ = new _loc5_() as SpecialAchievement;
                        if(_loc6_)
                        {
                            _loc6_.data = _loc4_;
                            this.stripesArea.addChild(_loc6_);
                            this.stripes.push(_loc6_);
                            _loc6_.validateNow();
                            _loc6_.visible = false;
                        }
                    }
                    else
                    {
                        this.stripes.push(null);
                    }
                }
                _loc2_++;
            }
        }
        
        private function onDataChange(param1:Event) : void {
            invalidate();
        }
        
        override protected function onDispose() : void {
            var _loc1_:SpecialAchievement = null;
            while(this.stripes.length > 0)
            {
                _loc1_ = SpecialAchievement(this.stripes.splice(0,1)[0]);
                if(_loc1_)
                {
                    _loc1_.dispose();
                }
            }
            super.onDispose();
        }
    }
}
