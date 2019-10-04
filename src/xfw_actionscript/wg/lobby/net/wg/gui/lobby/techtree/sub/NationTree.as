package net.wg.gui.lobby.techtree.sub
{
    import net.wg.infrastructure.base.UIComponentEx;
    import net.wg.gui.lobby.techtree.interfaces.INodesContainer;
    import net.wg.infrastructure.interfaces.entity.IDraggable;
    import net.wg.infrastructure.interfaces.ITutorialCustomComponent;
    import net.wg.gui.components.controls.ScrollBar;
    import net.wg.gui.lobby.techtree.helpers.NTGraphics;
    import net.wg.gui.interfaces.ISoundButtonEx;
    import flash.display.Sprite;
    import net.wg.gui.lobby.techtree.interfaces.IRenderer;
    import net.wg.gui.lobby.techtree.interfaces.INationTreeDataProvider;
    import net.wg.gui.lobby.techtree.interfaces.ITechTreePage;
    import net.wg.utils.IAssertable;
    import net.wg.gui.lobby.techtree.data.NationVODataProvider;
    import net.wg.gui.lobby.techtree.TechTreeEvent;
    import net.wg.gui.lobby.techtree.data.vo.NodeData;
    import flash.events.MouseEvent;
    import flash.events.Event;
    import scaleform.clik.events.ButtonEvent;
    import net.wg.data.constants.Cursors;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.data.constants.DragType;
    import flash.display.InteractiveObject;
    import net.wg.gui.lobby.techtree.constants.NodeEntityType;
    import flash.display.DisplayObject;
    import net.wg.gui.lobby.techtree.helpers.Distance;
    import net.wg.data.constants.Values;
    import net.wg.data.constants.Errors;

    public class NationTree extends UIComponentEx implements INodesContainer, IDraggable, ITutorialCustomComponent
    {

        public static const CONTAINER_HEIGHT:int = 610;

        private static const NODE_WIDTH:int = 130;

        private static const SCROLL_STEP_FACTOR:int = 64;

        private static const SCROLLBAR_BOOTOM_OFFSET:int = 2;

        private static const SCROLLBAR_RIGHT_OFFSET:int = 9;

        private static const NT_TREE_MIN_POSITION_Y:Number = 34;

        private static const TREE_NODE_SELECTOR_X_SHIFT:int = 40;

        private static const TREE_NODE_SELECTOR_Y_SHIFT:int = -25;

        private static const DEF_ACTIVATE_COOLDOWN:int = 250;

        private static const MIN_RIGHT_MARGIN:int = 26;

        private static const MAX_LEVELS:int = 10;

        private static const TUTORIAL_DESCR_SEPARATOR:String = ":";

        public var scrollBar:ScrollBar = null;

        public var ntGraphics:NTGraphics = null;

        public var treeNodeSelector:ISoundButtonEx = null;

        public var bounds:Sprite = null;

        private var _blueprintModeOn:Boolean = false;

        private var _renderers:Vector.<IRenderer> = null;

        private var _dataProvider:INationTreeDataProvider = null;

        private var _positionByNation:Object = null;

        private var _totalWidth:Number = 0;

        private var _isDragging:Boolean = false;

        private var _dragOffset:Number = 0;

        private var _itemRendererName:String = "";

        private var _itemRendererClass:Class = null;

        private var _view:ITechTreePage = null;

        private var _requestInCoolDown:Boolean = false;

        private var _curRend:IRenderer = null;

        private var _asserter:IAssertable = null;

        public function NationTree()
        {
            super();
            App.tutorialMgr.addListenersToCustomTutorialComponent(this);
            this._asserter = App.utils.asserter;
            this._positionByNation = {};
        }

        override protected function initialize() : void
        {
            super.initialize();
            this._dataProvider = new NationVODataProvider();
            this._dataProvider.addEventListener(TechTreeEvent.DATA_BUILD_COMPLETE,this.onDataProviderDataBuildCompleteHandler,false,0,true);
            this._renderers = new Vector.<IRenderer>();
            this.ntGraphics.container = this;
        }

        override protected function onDispose() : void
        {
            App.tutorialMgr.removeListenersFromCustomTutorialComponent(this);
            visible = false;
            App.utils.scheduler.cancelTask(this.deactivateCoolDown);
            this.removeItemRenderers();
            this.view = null;
            NodeData.setDisplayInfoClass(null);
            this.ntGraphics.removeEventListener(MouseEvent.MOUSE_MOVE,this.onNtGraphicsMouseMoveHandler);
            this.ntGraphics.dispose();
            this.ntGraphics = null;
            if(this.scrollBar != null)
            {
                this.scrollBar.removeEventListener(Event.SCROLL,this.onScrollBarScrollHandler);
                this.scrollBar.dispose();
                this.scrollBar = null;
            }
            removeEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheelHandler);
            if(App.cursor != null)
            {
                App.cursor.unRegisterDragging(this);
            }
            if(this._dataProvider != null)
            {
                this._dataProvider.removeEventListener(TechTreeEvent.DATA_BUILD_COMPLETE,this.onDataProviderDataBuildCompleteHandler);
                this._dataProvider.dispose();
                this._dataProvider = null;
            }
            this._renderers = null;
            this._positionByNation = null;
            this._itemRendererClass = null;
            this._view = null;
            this._curRend = null;
            this._asserter = null;
            this.treeNodeSelector.removeEventListener(MouseEvent.ROLL_OUT,this.onTreeNodeSelectorRollOutHandler);
            this.treeNodeSelector.removeEventListener(ButtonEvent.CLICK,this.onTreeNodeSelectorClickHandler);
            this.treeNodeSelector.dispose();
            this.treeNodeSelector = null;
            this.bounds = null;
            super.onDispose();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this._totalWidth = _width;
            if(this.scrollBar != null)
            {
                this.scrollBar.addEventListener(Event.SCROLL,this.onScrollBarScrollHandler,false,0,true);
                this.scrollBar.focusTarget = this;
                this.scrollBar.tabEnabled = false;
                this.scrollBar.isSmooth = true;
            }
            addEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheelHandler,false,0,true);
            if(App.cursor != null)
            {
                App.cursor.registerDragging(this,Cursors.MOVE);
            }
            this.ntGraphics.mouseEnabled = false;
            this.ntGraphics.addEventListener(MouseEvent.MOUSE_MOVE,this.onNtGraphicsMouseMoveHandler,false,0,true);
            this.treeNodeSelector.tooltip = VEH_COMPARE.TECHTREE_TOOLTIPS_ADDTOCOMPARE;
            this.treeNodeSelector.addEventListener(MouseEvent.ROLL_OUT,this.onTreeNodeSelectorRollOutHandler,false,0,true);
            this.treeNodeSelector.addEventListener(ButtonEvent.CLICK,this.onTreeNodeSelectorClickHandler,false,0,true);
            this.updateTreeNodeSelector();
        }

        override protected function draw() : void
        {
            super.draw();
            if(this._dataProvider && isInvalid(InvalidationType.DATA))
            {
                this.ntGraphics.setup();
                this.itemRendererName = this._dataProvider.getDisplaySettings().nodeRendererName;
                this.drawRenderers();
                if(this._renderers.length > 0)
                {
                    this.drawLines();
                    this.drawLevelDelimeters();
                }
                if(!this._positionByNation.hasOwnProperty(this.dataProvider.nation))
                {
                    this.scrollToIndex(this.dataProvider.getScrollIndex());
                }
                else
                {
                    this.updateScrollPosition(this._positionByNation[this.dataProvider.nation]);
                }
                this.ntGraphics.show();
                App.tutorialMgr.dispatchEventForCustomComponent(this);
            }
            if(isInvalid(InvalidationType.SIZE))
            {
                this.updateLayouts();
            }
        }

        public function generatedUnstoppableEvents() : Boolean
        {
            return true;
        }

        public function getDragType() : String
        {
            return DragType.SOFT;
        }

        public function getHitArea() : InteractiveObject
        {
            return this.bounds;
        }

        public function getNation() : String
        {
            return this._dataProvider.nation;
        }

        public function getNodeByID(param1:Number) : IRenderer
        {
            return this._renderers[this._dataProvider.getIndexByID(param1)];
        }

        public function getTutorialDescriptionName() : String
        {
            return name + TUTORIAL_DESCR_SEPARATOR + this._itemRendererName;
        }

        public function invalidateNodesData(param1:String, param2:Object) : void
        {
            this.ntGraphics.hide();
            this._positionByNation[this.dataProvider.nation] = this.scrollPosition;
            this._dataProvider.invalidate(param1,param2);
        }

        public function needPreventInnerEvents() : Boolean
        {
            return true;
        }

        public function onDragging(param1:Number, param2:Number) : void
        {
            this.updateScrollPosition(this.scrollPosition - (stage.mouseX - this._dragOffset) / SCROLL_STEP_FACTOR);
            this._dragOffset = stage.mouseX;
        }

        public function onEndDrag() : void
        {
            this._isDragging = false;
            this.ntGraphics.mouseChildren = true;
        }

        public function onStartDrag() : void
        {
            this._isDragging = true;
            this._dragOffset = stage.mouseX;
            this.ntGraphics.mouseChildren = false;
        }

        public function setItemsField(param1:Array, param2:String) : void
        {
            var _loc4_:* = NaN;
            var _loc5_:Array = null;
            var _loc6_:IRenderer = null;
            var _loc3_:Number = param1.length;
            var _loc7_:Number = 0;
            while(_loc7_ < _loc3_)
            {
                _loc5_ = param1[_loc7_];
                _loc4_ = this._dataProvider.getIndexByID(_loc5_[0]);
                if(_loc4_ > -1 && this._dataProvider.length > _loc4_)
                {
                    this._dataProvider.setItemField(param2,_loc4_,_loc5_[1]);
                    _loc6_ = this._renderers[_loc4_];
                    _loc6_.invalidateNodeState();
                }
                _loc7_++;
            }
            if(param2 == NodeData.VEH_COMPARE_TREE_NODE_DATA)
            {
                this.updateTreeNodeSelector();
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
                    if(this._dataProvider.setState(_loc5_,param1,_loc6_[1]) || _loc7_)
                    {
                        this._renderers[_loc5_].invalidateNodeState();
                    }
                }
                _loc8_++;
            }
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
                    this._renderers[_loc3_].invalidateNodeState();
                }
                _loc5_++;
            }
        }

        private function scrollToIndex(param1:Number) : void
        {
            var _loc2_:IRenderer = null;
            if(-1 < param1 && param1 < this._renderers.length)
            {
                _loc2_ = this._renderers[param1];
                if(_loc2_ != null)
                {
                    this.updateScrollPosition((_loc2_.x + (NODE_WIDTH - width >> 1)) / SCROLL_STEP_FACTOR);
                }
            }
        }

        private function updateLayouts() : void
        {
            this.bounds.width = _width;
            this.bounds.height = _height;
            this.ntGraphics.y = Math.max(_height - CONTAINER_HEIGHT >> 1,NT_TREE_MIN_POSITION_Y);
            if(this.scrollBar != null)
            {
                this.scrollBar.y = height - SCROLLBAR_BOOTOM_OFFSET;
                this.scrollBar.width = _width - SCROLLBAR_RIGHT_OFFSET;
                this.scrollBar.validateNow();
            }
            this.updateScrollPosition(this.scrollPosition);
        }

        private function activateCoolDown() : void
        {
            this._requestInCoolDown = true;
            App.utils.scheduler.scheduleTask(this.deactivateCoolDown,DEF_ACTIVATE_COOLDOWN);
        }

        private function deactivateCoolDown() : void
        {
            this._requestInCoolDown = false;
        }

        private function createItemRenderer() : IRenderer
        {
            return new this._itemRendererClass();
        }

        private function setupItemRenderer(param1:IRenderer, param2:Number, param3:NodeData, param4:uint = 1) : void
        {
            param1.container = this;
            param1.setup(param2,param3,param4);
            param1.addEventListener(TechTreeEvent.CLICK_2_OPEN,this.onRendererClick2OpenHandler,false,0,true);
            param1.addEventListener(TechTreeEvent.CLICK_2_UNLOCK,this.onRendererClick2UnlockHandler,false,0,true);
            param1.addEventListener(TechTreeEvent.CLICK_2_BUY,this.onRendererClick2BuyHandler,false,0,true);
            param1.addEventListener(MouseEvent.ROLL_OVER,this.onRendRollOverHandler,false,0,true);
            param1.addEventListener(MouseEvent.ROLL_OUT,this.onRendRollOutHandler,false,0,true);
            param1.addEventListener(TechTreeEvent.RESTORE_VEHICLE,this.onRendererRestoreVehicleHandler,false,0,true);
        }

        private function removeItemRenderer(param1:IRenderer) : void
        {
            param1.removeEventListener(TechTreeEvent.CLICK_2_OPEN,this.onRendererClick2OpenHandler);
            param1.removeEventListener(TechTreeEvent.CLICK_2_UNLOCK,this.onRendererClick2UnlockHandler);
            param1.removeEventListener(TechTreeEvent.CLICK_2_BUY,this.onRendererClick2BuyHandler);
            param1.removeEventListener(MouseEvent.ROLL_OVER,this.onRendRollOverHandler);
            param1.removeEventListener(MouseEvent.ROLL_OUT,this.onRendRollOutHandler);
            param1.removeEventListener(TechTreeEvent.RESTORE_VEHICLE,this.onRendererRestoreVehicleHandler);
            this.ntGraphics.removeRenderer(param1);
            param1.dispose();
        }

        private function removeItemRenderers() : void
        {
            while(this._renderers.length > 0)
            {
                this.removeItemRenderer(this._renderers.pop());
            }
        }

        private function drawRenderers() : void
        {
            var _loc2_:IRenderer = null;
            var _loc3_:NodeData = null;
            if(this._itemRendererClass == null)
            {
                return;
            }
            this.ntGraphics.clearCache();
            var _loc1_:Number = this._dataProvider.length;
            while(this._renderers.length > _loc1_)
            {
                this.removeItemRenderer(this._renderers.pop());
            }
            var _loc4_:uint = this._blueprintModeOn?NodeEntityType.BLUEPRINT_TREE:NodeEntityType.NATION_TREE;
            var _loc5_:* = false;
            var _loc6_:Number = 0;
            while(_loc6_ < _loc1_)
            {
                if(_loc6_ < this._renderers.length)
                {
                    _loc5_ = false;
                    _loc2_ = this._renderers[_loc6_];
                    this.ntGraphics.clearUpRenderer(_loc2_);
                    this.ntGraphics.clearLinesAndArrows(_loc2_);
                    _loc3_ = this._dataProvider.getItemAt(_loc6_);
                    this.setupItemRenderer(_loc2_,_loc6_,_loc3_,_loc4_);
                }
                else
                {
                    _loc5_ = true;
                    _loc2_ = this.createItemRenderer();
                }
                if(_loc5_ && _loc2_ != null)
                {
                    _loc3_ = this._dataProvider.getItemAt(_loc6_);
                    this.setupItemRenderer(_loc2_,_loc6_,_loc3_,_loc4_);
                    this.ntGraphics.addChild(DisplayObject(_loc2_));
                    this._renderers.push(_loc2_);
                }
                _loc6_++;
            }
        }

        private function drawLines() : void
        {
            var _loc1_:Number = this._renderers.length;
            if(_loc1_ > 0)
            {
                this.ntGraphics.drawTopLines(this._renderers[0],false);
            }
            var _loc2_:Number = 1;
            while(_loc2_ < _loc1_)
            {
                this.ntGraphics.drawNodeLines(this._renderers[_loc2_],false);
                _loc2_++;
            }
        }

        private function drawLevelDelimeters() : void
        {
            var _loc6_:IRenderer = null;
            var _loc7_:* = NaN;
            var _loc1_:Vector.<Distance> = new Vector.<Distance>(MAX_LEVELS);
            var _loc2_:* = 0;
            var _loc3_:Boolean = this._dataProvider.getDisplaySettings().isLevelDisplayed;
            var _loc4_:Distance = null;
            var _loc5_:Number = 0;
            for each(_loc6_ in this._renderers)
            {
                _loc5_ = Math.max(_loc5_,_loc6_.getInX() + NODE_WIDTH);
                if(_loc3_)
                {
                    _loc2_ = _loc6_.getLevel() - 1;
                    if(_loc2_ >= 0)
                    {
                        if(_loc1_[_loc2_] != null)
                        {
                            _loc4_ = _loc1_[_loc2_];
                            _loc4_.start = Math.min(_loc4_.start,_loc6_.getInX());
                            _loc4_.end = Math.max(_loc4_.end,_loc6_.getInX());
                        }
                        else
                        {
                            _loc1_[_loc2_] = new Distance(_loc6_.getInX(),_loc6_.getInX());
                        }
                    }
                }
            }
            _loc7_ = this.ntGraphics.drawLevelsDelimiters(_loc1_,CONTAINER_HEIGHT - (this.scrollBar != null?this.scrollBar.height:0),NODE_WIDTH);
            this._totalWidth = _loc5_ + Math.max(_loc7_,MIN_RIGHT_MARGIN);
        }

        private function updateTreeNodeSelector() : void
        {
            var _loc1_:NodeData = null;
            if(this._curRend != null && !this._blueprintModeOn && !this._isDragging)
            {
                _loc1_ = this.dataProvider.getItemByID(this._curRend.getID());
                if(_loc1_ != null && _loc1_.isCompareModeAvailable && !_loc1_.isCompareBasketFull)
                {
                    this.treeNodeSelector.x = this._curRend.x + this.ntGraphics.x + TREE_NODE_SELECTOR_X_SHIFT;
                    this.treeNodeSelector.y = this._curRend.y + this.ntGraphics.y + TREE_NODE_SELECTOR_Y_SHIFT;
                    this.treeNodeSelector.visible = true;
                    return;
                }
            }
            this.treeNodeSelector.visible = false;
        }

        private function updateScrollPosition(param1:Number) : void
        {
            var param1:Number = Math.max(0,Math.min(this.maxScroll,param1));
            if(this.scrollBar != null)
            {
                this.scrollBar.setScrollProperties(this.scrollPageSize,0,this.maxScroll);
                this.scrollBar.position = param1;
                this.scrollBar.visible = this.maxScroll > 0;
            }
            this.ntGraphics.x = -param1 * SCROLL_STEP_FACTOR | 0;
        }

        public function get rootRenderer() : IRenderer
        {
            return this._renderers[0];
        }

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
            var _loc2_:ScrollBar = null;
            if(this._view != null)
            {
                _loc2_ = this._view.getScrollBar();
                _loc2_.isSmooth = true;
            }
            this.scrollBar = _loc2_;
        }

        public function get dataProvider() : INationTreeDataProvider
        {
            return this._dataProvider;
        }

        public function set dataProvider(param1:INationTreeDataProvider) : void
        {
            if(this._dataProvider != null)
            {
                this._dataProvider.removeEventListener(TechTreeEvent.DATA_BUILD_COMPLETE,this.onDataProviderDataBuildCompleteHandler);
            }
            this._dataProvider = param1;
            if(this._dataProvider != null)
            {
                this._dataProvider.addEventListener(TechTreeEvent.DATA_BUILD_COMPLETE,this.onDataProviderDataBuildCompleteHandler,false,0,true);
            }
        }

        public function get blueprintModeOn() : Boolean
        {
            return this._blueprintModeOn;
        }

        public function set blueprintModeOn(param1:Boolean) : void
        {
            var _loc3_:IRenderer = null;
            if(this._blueprintModeOn == param1)
            {
                return;
            }
            this._blueprintModeOn = param1;
            this.updateTreeNodeSelector();
            var _loc2_:uint = this._blueprintModeOn?NodeEntityType.BLUEPRINT_TREE:NodeEntityType.NATION_TREE;
            for each(_loc3_ in this._renderers)
            {
                _loc3_.entityType = _loc2_;
            }
        }

        private function set itemRendererName(param1:String) : void
        {
            if(param1 == Values.EMPTY_STR || this._itemRendererName == param1)
            {
                return;
            }
            this._itemRendererName = param1;
            var _loc2_:Class = App.utils.classFactory.getClass(this._itemRendererName);
            this._asserter.assertNotNull(_loc2_,Errors.BAD_LINKAGE + this._itemRendererName);
            this._itemRendererClass = _loc2_;
            this.removeItemRenderers();
        }

        private function get scrollPosition() : Number
        {
            return this.scrollBar.position;
        }

        private function get maxScroll() : Number
        {
            return (this._totalWidth - width) / SCROLL_STEP_FACTOR;
        }

        private function get scrollPageSize() : Number
        {
            return width / SCROLL_STEP_FACTOR;
        }

        private function onDataProviderDataBuildCompleteHandler(param1:TechTreeEvent) : void
        {
            invalidateData();
        }

        private function onScrollBarScrollHandler(param1:Event) : void
        {
            var _loc2_:Number = param1.target.position;
            if(isNaN(_loc2_))
            {
                return;
            }
            this.updateScrollPosition(_loc2_);
            App.contextMenuMgr.hide();
        }

        private function onMouseWheelHandler(param1:MouseEvent) : void
        {
            var _loc2_:Number = this.scrollPosition - (param1.delta > 0?1:-1);
            this.updateScrollPosition(_loc2_);
            this.updateTreeNodeSelector();
        }

        private function onRendererClick2OpenHandler(param1:TechTreeEvent) : void
        {
            if(this.view == null)
            {
                return;
            }
            this.view.goToNextVehicleS(this.dataProvider.getItemAt(param1.index).id);
        }

        private function onRendererClick2UnlockHandler(param1:TechTreeEvent) : void
        {
            if(!this._requestInCoolDown && this.view != null)
            {
                this.view.request4UnlockS(this.dataProvider.getItemAt(param1.index).id);
                this.activateCoolDown();
            }
        }

        private function onRendererClick2BuyHandler(param1:TechTreeEvent) : void
        {
            if(!this._requestInCoolDown && this.view != null)
            {
                this.view.request4BuyS(this.dataProvider.getItemAt(param1.index).id);
                this.activateCoolDown();
            }
        }

        private function onRendererRestoreVehicleHandler(param1:TechTreeEvent) : void
        {
            var _loc2_:NodeData = null;
            if(!this._requestInCoolDown && this.view != null && param1.index > -1)
            {
                _loc2_ = this._dataProvider.getItemAt(param1.index);
                this.view.request4RestoreS(_loc2_.id);
                this.activateCoolDown();
            }
        }

        private function onTreeNodeSelectorClickHandler(param1:ButtonEvent) : void
        {
            if(!this._requestInCoolDown && this.view != null)
            {
                this.view.request4VehCompareS(this._curRend.getID());
                this.activateCoolDown();
            }
        }

        private function onRendRollOverHandler(param1:MouseEvent) : void
        {
            this._curRend = param1.target as IRenderer;
            this.updateTreeNodeSelector();
        }

        private function onRendRollOutHandler(param1:MouseEvent) : void
        {
            if(!this.treeNodeSelector.hitArea.hitTestPoint(App.stage.mouseX,App.stage.mouseY))
            {
                this._curRend = null;
                this.updateTreeNodeSelector();
            }
        }

        private function onTreeNodeSelectorRollOutHandler(param1:MouseEvent) : void
        {
            if(!this._curRend.hitTestPoint(App.stage.mouseX,App.stage.mouseY))
            {
                this._curRend = null;
                this.updateTreeNodeSelector();
            }
        }

        private function onNtGraphicsMouseMoveHandler(param1:MouseEvent) : void
        {
            if(param1.buttonDown)
            {
                this.getHitArea().dispatchEvent(new MouseEvent(MouseEvent.MOUSE_DOWN));
            }
        }
    }
}
