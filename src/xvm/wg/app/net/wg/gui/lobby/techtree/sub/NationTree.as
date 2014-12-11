package net.wg.gui.lobby.techtree.sub
{
    import scaleform.clik.core.UIComponent;
    import net.wg.gui.lobby.techtree.interfaces.INodesContainer;
    import net.wg.infrastructure.interfaces.entity.IDraggable;
    import net.wg.gui.lobby.techtree.interfaces.IRenderer;
    import net.wg.gui.lobby.techtree.interfaces.INationTreeDataProvider;
    import net.wg.gui.lobby.techtree.interfaces.ITechTreePage;
    import net.wg.gui.components.controls.ScrollBar;
    import net.wg.gui.lobby.techtree.helpers.NTGraphics;
    import flash.display.Sprite;
    import flash.utils.getDefinitionByName;
    import net.wg.gui.lobby.techtree.data.vo.NodeData;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import net.wg.gui.lobby.techtree.TechTreeEvent;
    import net.wg.gui.lobby.techtree.data.vo.UnlockProps;
    import net.wg.data.constants.DragType;
    import flash.display.InteractiveObject;
    import net.wg.gui.lobby.techtree.data.NationVODataProvider;
    import net.wg.data.constants.Cursors;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.gui.lobby.techtree.MenuHandler;
    import net.wg.gui.lobby.techtree.helpers.Distance;
    import flash.display.DisplayObject;
    
    public class NationTree extends UIComponent implements INodesContainer, IDraggable
    {
        
        public function NationTree()
        {
            super();
            this.positionByNation = {};
        }
        
        private var _scrollPosition:Number = 0;
        
        private var renderers:Vector.<IRenderer>;
        
        private var _dataProvider:INationTreeDataProvider;
        
        private var drawTreeEnabled:Boolean = false;
        
        private var scrollToNode:Boolean = true;
        
        private var scrollToPosition:Number = -1;
        
        private var positionByNation:Object;
        
        private var _totalWidth:Number;
        
        private var isDragging:Boolean = false;
        
        private var dragOffset:Number = 0;
        
        private var _itemRendererName:String = "";
        
        private var _itemRendererClass:Class = null;
        
        private var _view:ITechTreePage = null;
        
        private var requestInCoolDown:Boolean = false;
        
        public var nodeHeight:Number = 56;
        
        public var nodeWidth:Number = 132;
        
        public var scrollStepFactor:Number = 1.0;
        
        public var scrollBarBottomOffset:Number = 4;
        
        public var scrollBarRightOffset:Number = 9;
        
        public var containerHeight:Number = 610;
        
        public var scrollBar:ScrollBar;
        
        public var ntGraphics:NTGraphics;
        
        public var background:Sprite;
        
        public function get view() : ITechTreePage
        {
            return this._view;
        }
        
        public function set view(param1:ITechTreePage) : void
        {
            if(param1 == this._view)
            {
                return;
            }
            this._view = param1;
            if(this._view != null)
            {
                if(param1["scrollBar"] != null)
                {
                    this.scrollBar = param1["scrollBar"];
                }
            }
            else
            {
                this.scrollBar = null;
            }
        }
        
        public function set itemRendererName(param1:String) : void
        {
            var classRef:Class = null;
            var renderer:IRenderer = null;
            var value:String = param1;
            if(value == "" || this._itemRendererName == value)
            {
                return;
            }
            this._itemRendererName = value;
            try
            {
                classRef = getDefinitionByName(this._itemRendererName) as Class;
            }
            catch(error:*)
            {
                throw new Error("The class " + value + " cannot be found in your library. Please ensure it exists.");
            }
            if(classRef != null)
            {
                this._itemRendererClass = classRef;
                while(this.renderers.length)
                {
                    renderer = this.renderers.pop();
                    this.cleanUpRenderer(renderer);
                    if(this.ntGraphics != null)
                    {
                        this.ntGraphics.removeRenderer(renderer);
                    }
                }
            }
        }
        
        override protected function onDispose() : void
        {
            visible = false;
            this.removeItemRenderers();
            this.view = null;
            NodeData.setDisplayInfoClass(null);
            if(this.ntGraphics != null)
            {
                this.ntGraphics.dispose();
            }
            if(this.scrollBar != null)
            {
                this.scrollBar.focusTarget = null;
                this.scrollBar.removeEventListener(Event.SCROLL,this.handleMouseScroll);
            }
            removeEventListener(MouseEvent.MOUSE_WHEEL,this.handleMouseWheel);
            if(App.cursor != null)
            {
                App.cursor.unRegisterDragging(this);
            }
            if(this._dataProvider != null)
            {
                this._dataProvider.removeEventListener(TechTreeEvent.DATA_BUILD_COMPLETE,this.handleDataComplete);
                this._dataProvider.clearUp();
                this._dataProvider = null;
            }
            super.onDispose();
        }
        
        public function scrollToIndex(param1:Number) : void
        {
            var _loc2_:IRenderer = null;
            if(-1 < param1 && param1 < this.renderers.length)
            {
                _loc2_ = this.renderers[param1];
                if(_loc2_ != null)
                {
                    this.scrollPosition = Math.round((_loc2_.x + (this.nodeWidth + x - width >> 1)) / this.scrollStepFactor);
                }
            }
        }
        
        public function get scrollPosition() : Number
        {
            return this._scrollPosition;
        }
        
        public function set scrollPosition(param1:Number) : void
        {
            var param1:Number = Math.max(0,Math.min(this.maxScroll,Math.round(param1)));
            if(this._scrollPosition == param1)
            {
                return;
            }
            this._scrollPosition = param1;
            this.ntGraphics.x = -Math.min(Math.abs(this._totalWidth - width),this.scrollStepFactor * this._scrollPosition);
            this.updateScrollBar();
        }
        
        public function get maxScroll() : Number
        {
            return Math.ceil((this._totalWidth - width) / this.scrollStepFactor);
        }
        
        public function get scrollPageSize() : Number
        {
            return Math.ceil(width / this.scrollStepFactor);
        }
        
        public function storeScrollPosition() : void
        {
            if(this._dataProvider != null)
            {
                this.positionByNation[this._dataProvider.nation] = this._scrollPosition;
            }
        }
        
        public function get dataProvider() : INationTreeDataProvider
        {
            return this._dataProvider;
        }
        
        public function set dataProvider(param1:INationTreeDataProvider) : void
        {
            if(this._dataProvider != null)
            {
                this._dataProvider.removeEventListener(TechTreeEvent.DATA_BUILD_COMPLETE,this.handleDataComplete);
            }
            this._dataProvider = param1;
            if(this._dataProvider != null)
            {
                this._dataProvider.addEventListener(TechTreeEvent.DATA_BUILD_COMPLETE,this.handleDataComplete,false,0,true);
            }
        }
        
        public function invalidateNodesData(param1:String, param2:Object) : void
        {
            this.ntGraphics.hide();
            this.drawTreeEnabled = false;
            this.scrollToPosition = this.positionByNation[param1] != undefined?this.positionByNation[param1]:0;
            this._dataProvider.invalidate(param1,param2);
        }
        
        public function getNodeByID(param1:Number) : IRenderer
        {
            return this.renderers[this._dataProvider.getIndexByID(param1)];
        }
        
        public function getRootNode() : IRenderer
        {
            return this.renderers[0];
        }
        
        public function isParentUnlocked(param1:Number, param2:Number) : Boolean
        {
            var _loc3_:Object = this._dataProvider.getItemByID(param2);
            var _loc4_:UnlockProps = _loc3_.unlockProps as UnlockProps;
            return !(_loc4_ == null) && (_loc4_.hasID(param1));
        }
        
        public function getNation() : String
        {
            return this._dataProvider.nation;
        }
        
        public function onStartDrag() : void
        {
            if(this.isDragging == true)
            {
                return;
            }
            this.isDragging = true;
            this.dragOffset = stage.mouseX - this.ntGraphics.x;
        }
        
        public function onDragging(param1:Number, param2:Number) : void
        {
            var _loc3_:Number = this.dragOffset - stage.mouseX;
            _loc3_ = Math.max(0,Math.min(this._totalWidth - width,Math.round(_loc3_)));
            this._scrollPosition = Math.round(_loc3_ / this.scrollStepFactor);
            this.ntGraphics.x = -_loc3_;
            this.updateScrollBar();
        }
        
        public function onEndDrag() : void
        {
            this.isDragging = false;
        }
        
        public function getDragType() : String
        {
            return DragType.SOFT;
        }
        
        public function getHitArea() : InteractiveObject
        {
            return this.background;
        }
        
        public function setVehicleTypeXP(param1:Array) : void
        {
            var _loc3_:* = NaN;
            var _loc4_:Array = null;
            var _loc2_:Number = param1.length;
            var _loc5_:Number = 0;
            while(_loc5_ < _loc2_)
            {
                _loc4_ = param1[_loc5_];
                _loc3_ = this._dataProvider.getIndexByID(_loc4_[0]);
                if(_loc3_ > -1 && this._dataProvider.length > _loc3_)
                {
                    this._dataProvider.setEarnedXP(_loc3_,_loc4_[1]);
                    this.renderers[_loc3_].invalidateNodeState(0);
                }
                _loc5_++;
            }
        }
        
        public function setItemsField(param1:Array, param2:String) : void
        {
            var _loc4_:* = NaN;
            var _loc5_:Array = null;
            var _loc3_:Number = param1.length;
            var _loc6_:Number = 0;
            while(_loc6_ < _loc3_)
            {
                _loc5_ = param1[_loc6_];
                _loc4_ = this._dataProvider.getIndexByID(_loc5_[0]);
                if(_loc4_ > -1 && this._dataProvider.length > _loc4_)
                {
                    this._dataProvider.setItemField(param2,_loc4_,_loc5_[1]);
                    this.renderers[_loc4_].invalidateNodeState(0);
                }
                _loc6_++;
            }
        }
        
        public function setNodesStates(param1:Number, param2:Array, param3:String = null) : void
        {
            var _loc5_:* = NaN;
            var _loc6_:Array = null;
            var _loc7_:* = false;
            var _loc4_:Number = param2.length;
            var _loc8_:Number = 0;
            while(_loc8_ < _loc4_)
            {
                _loc6_ = param2[_loc8_];
                _loc5_ = this._dataProvider.getIndexByID(_loc6_[0]);
                if(_loc5_ > -1 && this._dataProvider.length > _loc5_)
                {
                    if(param3 != null)
                    {
                        _loc7_ = this._dataProvider.setItemField(param3,_loc5_,_loc6_[2]);
                    }
                    else
                    {
                        _loc7_ = false;
                    }
                    if((this._dataProvider.setState(_loc5_,param1,_loc6_[1])) || (_loc7_))
                    {
                        this.renderers[_loc5_].invalidateNodeState(param1);
                    }
                }
                _loc8_++;
            }
        }
        
        override protected function initialize() : void
        {
            super.initialize();
            this._dataProvider = new NationVODataProvider();
            this._dataProvider.addEventListener(TechTreeEvent.DATA_BUILD_COMPLETE,this.handleDataComplete,false,0,true);
            this.renderers = new Vector.<IRenderer>();
            if(this.ntGraphics != null)
            {
                this.ntGraphics.container = this;
            }
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            this._totalWidth = _width;
            if(this.scrollBar != null)
            {
                this.scrollBar.addEventListener(Event.SCROLL,this.handleMouseScroll,false,0,true);
                this.scrollBar.focusTarget = this;
                this.scrollBar.tabEnabled = false;
            }
            addEventListener(MouseEvent.MOUSE_WHEEL,this.handleMouseWheel,false,0,true);
            if(App.cursor != null)
            {
                App.cursor.registerDragging(this,Cursors.MOVE);
            }
        }
        
        override protected function draw() : void
        {
            if(isInvalid(InvalidationType.SIZE))
            {
                this.updateLayouts();
            }
            if(!this.drawTreeEnabled)
            {
                return;
            }
            super.draw();
            if(isInvalid(InvalidationType.DATA))
            {
                if(this.ntGraphics != null)
                {
                    this.ntGraphics.mouseEnabled = false;
                    this.ntGraphics.setup();
                }
                this.itemRendererName = this._dataProvider.displaySettings.nodeRendererName;
                this.drawRenderers();
                this.updateScrollBar();
                if((this.scrollToNode) && this._dataProvider.scrollIndex > -1)
                {
                    this.scrollToIndex(this._dataProvider.scrollIndex);
                }
                else if(this.scrollToPosition >= 0)
                {
                    this.scrollPosition = this.scrollToPosition;
                    this.scrollToPosition = -1;
                }
                
                this.scrollToNode = false;
                if(this.renderers.length > 0)
                {
                    this.drawLines();
                }
                this.ntGraphics.show();
                this.drawTreeEnabled = false;
            }
        }
        
        protected function updateLayouts() : void
        {
            if(this.background != null)
            {
                this.background.width = _width;
                this.background.height = _height;
            }
            this.ntGraphics.y = _height - this.containerHeight >> 1;
            this.scrollPosition = this._scrollPosition;
            this.drawScrollBar();
            this.updateScrollBar();
        }
        
        private function updateScrollBar() : void
        {
            if(this.scrollBar != null)
            {
                this.scrollBar.setScrollProperties(this.scrollPageSize,0,this.maxScroll);
                this.scrollBar.position = this.scrollPosition;
                this.scrollBar.visible = this.maxScroll > 0;
            }
        }
        
        private function handleDataComplete(param1:TechTreeEvent) : void
        {
            this.drawTreeEnabled = true;
            invalidateData();
        }
        
        private function handleMouseScroll(param1:Event) : void
        {
            var _loc2_:Number = param1.target.position;
            if(isNaN(_loc2_))
            {
                return;
            }
            this.scrollPosition = _loc2_;
            MenuHandler.getInstance().hideMenu();
        }
        
        private function handleMouseWheel(param1:MouseEvent) : void
        {
            this.scrollPosition = this.scrollPosition - (param1.delta > 0?1:-1);
        }
        
        private function handleClickNode(param1:TechTreeEvent) : void
        {
            var _loc2_:NodeData = null;
            if(!(this.view == null) && param1.index > -1)
            {
                _loc2_ = this._dataProvider.getItemAt(param1.index);
                this.view.goToNextVehicleS(_loc2_.id);
            }
        }
        
        private function handleUnlockNode(param1:TechTreeEvent) : void
        {
            var _loc2_:NodeData = null;
            var _loc3_:UnlockProps = null;
            if(!this.requestInCoolDown && !(this.view == null) && param1.index > -1)
            {
                _loc2_ = this._dataProvider.getItemAt(param1.index);
                _loc3_ = _loc2_.unlockProps;
                if(_loc3_ != null)
                {
                    this.view.request4UnlockS(_loc2_.id,_loc3_.parentID,_loc3_.unlockIdx,_loc3_.xpCost);
                    this.activateCoolDown();
                }
            }
        }
        
        private function handleBuyNode(param1:TechTreeEvent) : void
        {
            var _loc2_:NodeData = null;
            if(!this.requestInCoolDown && !(this.view == null) && param1.index > -1)
            {
                _loc2_ = this._dataProvider.getItemAt(param1.index);
                this.view.request4BuyS(_loc2_.id);
                this.activateCoolDown();
            }
        }
        
        private function handleSellNode(param1:TechTreeEvent) : void
        {
            var _loc2_:NodeData = null;
            if(!this.requestInCoolDown && !(this.view == null) && param1.index > -1)
            {
                _loc2_ = this._dataProvider.getItemAt(param1.index);
                this.view.request4SellS(_loc2_.id);
                this.activateCoolDown();
            }
        }
        
        private function handleSelectVehicleInHangar(param1:TechTreeEvent) : void
        {
            var _loc2_:NodeData = null;
            if(!this.requestInCoolDown && !(this.view == null) && param1.index > -1)
            {
                _loc2_ = this._dataProvider.getItemAt(param1.index);
                this.view.request4SelectInHangarS(_loc2_.id);
            }
        }
        
        private function handleShowVehicleInStats(param1:TechTreeEvent) : void
        {
            var _loc2_:NodeData = null;
            if(!this.requestInCoolDown && !(this.view == null) && param1.index > -1)
            {
                _loc2_ = this._dataProvider.getItemAt(param1.index);
                this.view.request4ShowVehicleStatisticsS(_loc2_.id);
            }
        }
        
        private function handleVehicleInfo(param1:TechTreeEvent) : void
        {
            var _loc2_:NodeData = null;
            if(!(this.view == null) && param1.index > -1)
            {
                _loc2_ = this._dataProvider.getItemAt(param1.index);
                this.view.requestVehicleInfoS(_loc2_.id);
            }
        }
        
        private function activateCoolDown() : void
        {
            this.requestInCoolDown = true;
            App.utils.scheduler.scheduleTask(this.deactivateCoolDown,250);
        }
        
        private function deactivateCoolDown() : void
        {
            this.requestInCoolDown = false;
        }
        
        private function createItemRenderer(param1:Number, param2:NodeData) : IRenderer
        {
            var _loc3_:IRenderer = new this._itemRendererClass();
            _loc3_.container = this;
            _loc3_.setup(param1,param2);
            _loc3_.addEventListener(TechTreeEvent.CLICK_2_OPEN,this.handleClickNode,false,0,true);
            _loc3_.addEventListener(TechTreeEvent.CLICK_2_UNLOCK,this.handleUnlockNode,false,0,true);
            _loc3_.addEventListener(TechTreeEvent.CLICK_2_BUY,this.handleBuyNode,false,0,true);
            _loc3_.addEventListener(TechTreeEvent.CLICK_2_SELL,this.handleSellNode,false,0,true);
            _loc3_.addEventListener(TechTreeEvent.CLICK_2_SELECT_IN_HANGAR,this.handleSelectVehicleInHangar,false,0,true);
            _loc3_.addEventListener(TechTreeEvent.CLICK_2_SHOW_VEHICLE_STATS,this.handleShowVehicleInStats,false,0,true);
            _loc3_.addEventListener(TechTreeEvent.CLICK_2_VEHICLE_INFO,this.handleVehicleInfo,false,0,true);
            _loc3_.validateNowEx();
            return _loc3_;
        }
        
        private function cleanUpRenderer(param1:IRenderer) : void
        {
            param1.cleanUp();
            param1.removeEventListener(TechTreeEvent.CLICK_2_OPEN,this.handleClickNode);
            param1.removeEventListener(TechTreeEvent.CLICK_2_UNLOCK,this.handleUnlockNode);
            param1.removeEventListener(TechTreeEvent.CLICK_2_BUY,this.handleBuyNode);
            param1.removeEventListener(TechTreeEvent.CLICK_2_SELL,this.handleSellNode);
            param1.removeEventListener(TechTreeEvent.CLICK_2_SELECT_IN_HANGAR,this.handleSelectVehicleInHangar);
            param1.removeEventListener(TechTreeEvent.CLICK_2_SHOW_VEHICLE_STATS,this.handleShowVehicleInStats);
            param1.removeEventListener(TechTreeEvent.CLICK_2_VEHICLE_INFO,this.handleVehicleInfo);
        }
        
        private function removeItemRenderers() : void
        {
            while(this.renderers.length > 0)
            {
                this.cleanUpRenderer(this.renderers.pop());
            }
            if(this.ntGraphics != null)
            {
                this.ntGraphics.clearUp();
            }
        }
        
        private function drawRenderers() : void
        {
            var _loc2_:IRenderer = null;
            var _loc5_:Object = null;
            var _loc6_:* = 0;
            if(this._itemRendererClass == null)
            {
                return;
            }
            if(this.ntGraphics != null)
            {
                this.ntGraphics.clearCache();
            }
            var _loc1_:Number = this._dataProvider.length;
            while(this.renderers.length > _loc1_)
            {
                _loc2_ = this.renderers.pop();
                this.cleanUpRenderer(_loc2_);
                if(this.ntGraphics != null)
                {
                    this.ntGraphics.removeRenderer(_loc2_);
                }
            }
            var _loc3_:Number = 0;
            var _loc4_:Vector.<Distance> = new Vector.<Distance>(10);
            var _loc7_:* = false;
            var _loc8_:Boolean = this._dataProvider.displaySettings.isLevelDisplayed;
            var _loc9_:Number = 0;
            while(_loc9_ < _loc1_)
            {
                if(_loc9_ < this.renderers.length)
                {
                    _loc7_ = false;
                    _loc2_ = this.renderers[_loc9_];
                    if(this.ntGraphics != null)
                    {
                        this.ntGraphics.clearUpRenderer(_loc2_);
                        this.ntGraphics.clearLinesAndArrows(_loc2_);
                    }
                    _loc2_.setup(_loc9_,this._dataProvider.getItemAt(_loc9_));
                }
                else
                {
                    _loc7_ = true;
                    _loc2_ = this.createItemRenderer(_loc9_,this._dataProvider.getItemAt(_loc9_));
                }
                if((_loc7_) && !(_loc2_ == null))
                {
                    this.ntGraphics.addChild(DisplayObject(_loc2_));
                    this.renderers.push(_loc2_);
                }
                if(_loc8_)
                {
                    _loc6_ = _loc2_.getLevel() - 1;
                    if(_loc6_ > -1)
                    {
                        if(_loc4_[_loc6_] != null)
                        {
                            _loc5_ = _loc4_[_loc6_];
                            _loc5_.start = Math.min(_loc5_.start,_loc2_.getInX());
                            _loc5_.end = Math.max(_loc5_.end,_loc2_.getInX());
                        }
                        else
                        {
                            _loc4_[_loc6_] = new Distance(_loc2_.getInX(),_loc2_.getInX());
                        }
                    }
                }
                _loc3_ = Math.max(_loc3_,_loc2_.getInX() + this.nodeWidth);
                _loc9_++;
            }
            var _loc10_:Number = this.ntGraphics.drawLevelsDelimiters(_loc4_,this.containerHeight - (this.scrollBar != null?this.scrollBar.height:0),this.nodeWidth);
            this._totalWidth = _loc3_ + _loc10_;
            this.scrollPosition = this._scrollPosition;
        }
        
        private function drawLines() : void
        {
            var _loc1_:Number = this.renderers.length;
            if(_loc1_ > 0)
            {
                this.ntGraphics.drawTopLines(this.renderers[0],false);
            }
            var _loc2_:Number = 1;
            while(_loc2_ < _loc1_)
            {
                this.ntGraphics.drawNodeLines(this.renderers[_loc2_],false);
                _loc2_++;
            }
        }
        
        private function drawScrollBar() : void
        {
            if(this.scrollBar != null)
            {
                this.scrollBar.y = height - this.scrollBarBottomOffset;
                this.scrollBar.width = _width - this.scrollBarRightOffset;
                this.scrollBar.validateNow();
            }
        }
    }
}
