package net.wg.gui.lobby.techtree.sub 
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import net.wg.data.constants.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.lobby.techtree.*;
    import net.wg.gui.lobby.techtree.data.*;
    import net.wg.gui.lobby.techtree.data.vo.*;
    import net.wg.gui.lobby.techtree.helpers.*;
    import net.wg.gui.lobby.techtree.interfaces.*;
    import net.wg.infrastructure.interfaces.entity.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.core.*;
    
    public class NationTree extends scaleform.clik.core.UIComponent implements net.wg.gui.lobby.techtree.interfaces.INodesContainer, net.wg.infrastructure.interfaces.entity.IDraggable
    {
        public function NationTree()
        {
            super();
            this.positionByNation = {};
            return;
        }

        public function setItemsField(arg1:Array, arg2:String):void
        {
            var loc2:*=NaN;
            var loc3:*=null;
            var loc1:*=arg1.length;
            var loc4:*=0;
            while (loc4 < loc1) 
            {
                loc3 = arg1[loc4];
                if ((loc2 = this._dataProvider.getIndexByID(loc3[0])) > -1 && this._dataProvider.length > loc2) 
                {
                    this._dataProvider.setItemField(arg2, loc2, loc3[1]);
                    this.renderers[loc2].invalidateNodeState(0);
                }
                ++loc4;
            }
            return;
        }

        public function setNodesStates(arg1:Number, arg2:Array, arg3:String=null):void
        {
            var loc2:*=NaN;
            var loc3:*=null;
            var loc4:*=false;
            var loc1:*=arg2.length;
            var loc5:*=0;
            while (loc5 < loc1) 
            {
                loc3 = arg2[loc5];
                if ((loc2 = this._dataProvider.getIndexByID(loc3[0])) > -1 && this._dataProvider.length > loc2) 
                {
                    if (arg3 == null) 
                    {
                        loc4 = false;
                    }
                    else 
                    {
                        loc4 = this._dataProvider.setItemField(arg3, loc2, loc3[2]);
                    }
                    if (this._dataProvider.setState(loc2, arg1, loc3[1]) || loc4) 
                    {
                        this.renderers[loc2].invalidateNodeState(arg1);
                    }
                }
                ++loc5;
            }
            return;
        }

        protected override function initialize():void
        {
            super.initialize();
            this._dataProvider = new net.wg.gui.lobby.techtree.data.NationVODataProvider();
            this._dataProvider.addEventListener(net.wg.gui.lobby.techtree.TechTreeEvent.DATA_BUILD_COMPLETE, this.handleDataComplete, false, 0, true);
            this.renderers = new Vector.<net.wg.gui.lobby.techtree.interfaces.IRenderer>();
            if (this.ntGraphics != null) 
            {
                this.ntGraphics.container = this;
            }
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this._totalWidth = _width;
            if (this.scrollBar != null) 
            {
                this.scrollBar.addEventListener(flash.events.Event.SCROLL, this.handleMouseScroll, false, 0, true);
                this.scrollBar.focusTarget = this;
                this.scrollBar.tabEnabled = false;
            }
            addEventListener(flash.events.MouseEvent.MOUSE_WHEEL, this.handleMouseWheel, false, 0, true);
            if (App.cursor != null) 
            {
                App.cursor.registerDragging(this, net.wg.data.constants.Cursors.MOVE);
            }
            return;
        }

        protected override function draw():void
        {
            if (isInvalid(scaleform.clik.constants.InvalidationType.SIZE)) 
            {
                this.updateLayouts();
            }
            if (!this.drawTreeEnabled) 
            {
                return;
            }
            super.draw();
            if (isInvalid(scaleform.clik.constants.InvalidationType.DATA)) 
            {
                if (this.ntGraphics != null) 
                {
                    this.ntGraphics.mouseEnabled = false;
                    this.ntGraphics.setup();
                }
                this.itemRendererName = this._dataProvider.displaySettings.nodeRendererName;
                this.drawRenderers();
                this.updateScrollBar();
                if (this.scrollToNode && this._dataProvider.scrollIndex > -1) 
                {
                    this.scrollToIndex(this._dataProvider.scrollIndex);
                }
                else if (this.scrollToPosition >= 0) 
                {
                    this.scrollPosition = this.scrollToPosition;
                    this.scrollToPosition = -1;
                }
                this.scrollToNode = false;
                if (this.renderers.length > 0) 
                {
                    this.drawLines();
                }
                this.ntGraphics.show();
                this.drawTreeEnabled = false;
            }
            return;
        }

        protected function updateLayouts():void
        {
            if (this.background != null) 
            {
                this.background.width = _width;
                this.background.height = _height;
            }
            this.ntGraphics.y = _height - this.containerHeight >> 1;
            this.scrollPosition = this._scrollPosition;
            this.drawScrollBar();
            this.updateScrollBar();
            return;
        }

        internal function updateScrollBar():void
        {
            if (this.scrollBar != null) 
            {
                this.scrollBar.setScrollProperties(this.scrollPageSize, 0, this.maxScroll);
                this.scrollBar.position = this.scrollPosition;
            }
            return;
        }

        public function set dataProvider(arg1:net.wg.gui.lobby.techtree.interfaces.INationTreeDataProvider):void
        {
            if (this._dataProvider != null) 
            {
                this._dataProvider.removeEventListener(net.wg.gui.lobby.techtree.TechTreeEvent.DATA_BUILD_COMPLETE, this.handleDataComplete);
            }
            this._dataProvider = arg1;
            if (this._dataProvider != null) 
            {
                this._dataProvider.addEventListener(net.wg.gui.lobby.techtree.TechTreeEvent.DATA_BUILD_COMPLETE, this.handleDataComplete, false, 0, true);
            }
            return;
        }

        internal function handleDataComplete(arg1:net.wg.gui.lobby.techtree.TechTreeEvent):void
        {
            this.drawTreeEnabled = true;
            invalidateData();
            return;
        }

        internal function handleMouseScroll(arg1:flash.events.Event):void
        {
            var loc1:*=arg1.target.position;
            if (isNaN(loc1)) 
            {
                return;
            }
            this.scrollPosition = loc1;
            net.wg.gui.lobby.techtree.MenuHandler.getInstance().hideMenu();
            return;
        }

        internal function handleMouseWheel(arg1:flash.events.MouseEvent):void
        {
            this.scrollPosition = this.scrollPosition - (arg1.delta > 0 ? 1 : -1);
            return;
        }

        internal function handleClickNode(arg1:net.wg.gui.lobby.techtree.TechTreeEvent):void
        {
            var loc1:*=null;
            if (!(this.view == null) && arg1.index > -1) 
            {
                loc1 = this._dataProvider.getItemAt(arg1.index);
                this.view.goToNextVehicleS(loc1.id);
            }
            return;
        }

        internal function handleUnlockNode(arg1:net.wg.gui.lobby.techtree.TechTreeEvent):void
        {
            var loc1:*=null;
            var loc2:*=null;
            if (!this.requestInCoolDown && !(this.view == null) && arg1.index > -1) 
            {
                loc1 = this._dataProvider.getItemAt(arg1.index);
                loc2 = loc1.unlockProps;
                if (loc2 != null) 
                {
                    this.view.request4UnlockS(loc1.id, loc2.parentID, loc2.unlockIdx, loc2.xpCost);
                    this.activateCoolDown();
                }
            }
            return;
        }

        internal function handleBuyNode(arg1:net.wg.gui.lobby.techtree.TechTreeEvent):void
        {
            var loc1:*=null;
            if (!this.requestInCoolDown && !(this.view == null) && arg1.index > -1) 
            {
                loc1 = this._dataProvider.getItemAt(arg1.index);
                this.view.request4BuyS(loc1.id);
                this.activateCoolDown();
            }
            return;
        }

        internal function handleSellNode(arg1:net.wg.gui.lobby.techtree.TechTreeEvent):void
        {
            var loc1:*=null;
            if (!this.requestInCoolDown && !(this.view == null) && arg1.index > -1) 
            {
                loc1 = this._dataProvider.getItemAt(arg1.index);
                this.view.request4SellS(loc1.id);
                this.activateCoolDown();
            }
            return;
        }

        internal function activateCoolDown():void
        {
            this.requestInCoolDown = true;
            App.utils.scheduler.scheduleTask(this.deactivateCoolDown, 250);
            return;
        }

        internal function deactivateCoolDown():void
        {
            this.requestInCoolDown = false;
            return;
        }

        internal function createItemRenderer(arg1:Number, arg2:net.wg.gui.lobby.techtree.data.vo.NodeData):net.wg.gui.lobby.techtree.interfaces.IRenderer
        {
            var loc1:*=new this._itemRendererClass();
            loc1.container = this;
            loc1.setup(arg1, arg2);
            loc1.addEventListener(net.wg.gui.lobby.techtree.TechTreeEvent.CLICK_2_OPEN, this.handleClickNode, false, 0, true);
            loc1.addEventListener(net.wg.gui.lobby.techtree.TechTreeEvent.CLICK_2_UNLOCK, this.handleUnlockNode, false, 0, true);
            loc1.addEventListener(net.wg.gui.lobby.techtree.TechTreeEvent.CLICK_2_BUY, this.handleBuyNode, false, 0, true);
            loc1.addEventListener(net.wg.gui.lobby.techtree.TechTreeEvent.CLICK_2_SELL, this.handleSellNode, false, 0, true);
            loc1.addEventListener(net.wg.gui.lobby.techtree.TechTreeEvent.CLICK_2_VEHICLE_INFO, this.handleVehicleInfo, false, 0, true);
            loc1.validateNowEx();
            return loc1;
        }

        internal function cleanUpRenderer(arg1:net.wg.gui.lobby.techtree.interfaces.IRenderer):void
        {
            arg1.cleanUp();
            arg1.removeEventListener(net.wg.gui.lobby.techtree.TechTreeEvent.CLICK_2_OPEN, this.handleClickNode);
            arg1.removeEventListener(net.wg.gui.lobby.techtree.TechTreeEvent.CLICK_2_UNLOCK, this.handleUnlockNode);
            arg1.removeEventListener(net.wg.gui.lobby.techtree.TechTreeEvent.CLICK_2_BUY, this.handleBuyNode);
            arg1.removeEventListener(net.wg.gui.lobby.techtree.TechTreeEvent.CLICK_2_SELL, this.handleSellNode);
            arg1.removeEventListener(net.wg.gui.lobby.techtree.TechTreeEvent.CLICK_2_VEHICLE_INFO, this.handleVehicleInfo);
            return;
        }

        internal function removeItemRenderers():void
        {
            while (this.renderers.length > 0) 
            {
                this.cleanUpRenderer(this.renderers.pop());
            }
            if (this.ntGraphics != null) 
            {
                this.ntGraphics.clearUp();
            }
            return;
        }

        internal function drawRenderers():void
        {
            var loc2:*=null;
            var loc5:*=null;
            var loc6:*=0;
            if (this._itemRendererClass == null) 
            {
                return;
            }
            if (this.ntGraphics != null) 
            {
                this.ntGraphics.clearCache();
            }
            var loc1:*=this._dataProvider.length;
            while (this.renderers.length > loc1) 
            {
                loc2 = this.renderers.pop();
                this.cleanUpRenderer(loc2);
                if (this.ntGraphics == null) 
                {
                    continue;
                }
                this.ntGraphics.removeRenderer(loc2);
            }
            var loc3:*=0;
            var loc4:*=new Vector.<net.wg.gui.lobby.techtree.helpers.Distance>(10);
            var loc7:*=false;
            var loc8:*=this._dataProvider.displaySettings.isLevelDisplayed;
            var loc9:*=0;
            while (loc9 < loc1) 
            {
                if (loc9 < this.renderers.length) 
                {
                    loc7 = false;
                    loc2 = this.renderers[loc9];
                    if (this.ntGraphics != null) 
                    {
                        this.ntGraphics.clearUpRenderer(loc2);
                        this.ntGraphics.clearLinesAndArrows(loc2);
                    }
                    loc2.setup(loc9, this._dataProvider.getItemAt(loc9));
                }
                else 
                {
                    loc7 = true;
                    loc2 = this.createItemRenderer(loc9, this._dataProvider.getItemAt(loc9));
                }
                if (loc7 && !(loc2 == null)) 
                {
                    this.ntGraphics.addChild(flash.display.DisplayObject(loc2));
                    this.renderers.push(loc2);
                }
                if (loc8) 
                {
                    if ((loc6 = (loc2.getLevel() - 1)) > -1) 
                    {
                        if (loc4[loc6] == null) 
                        {
                            loc4[loc6] = new net.wg.gui.lobby.techtree.helpers.Distance(loc2.getInX(), loc2.getInX());
                        }
                        else 
                        {
                            (loc5 = loc4[loc6]).start = Math.min(loc5.start, loc2.getInX());
                            loc5.end = Math.max(loc5.end, loc2.getInX());
                        }
                    }
                }
                loc3 = Math.max(loc3, loc2.getInX() + this.nodeWidth);
                ++loc9;
            }
            var loc10:*=this.ntGraphics.drawLevelsDelimiters(loc4, this.containerHeight - (this.scrollBar == null ? 0 : this.scrollBar.height), this.nodeWidth);
            this._totalWidth = loc3 + loc10;
            this.scrollPosition = this._scrollPosition;
            return;
        }

        internal function drawLines():void
        {
            var loc1:*=this.renderers.length;
            if (loc1 > 0) 
            {
                this.ntGraphics.drawTopLines(this.renderers[0], false);
            }
            var loc2:*=1;
            while (loc2 < loc1) 
            {
                this.ntGraphics.drawNodeLines(this.renderers[loc2], false);
                ++loc2;
            }
            return;
        }

        internal function drawScrollBar():void
        {
            if (this.scrollBar != null) 
            {
                this.scrollBar.y = height - this.scrollBarBottomOffset;
                this.scrollBar.width = _width - this.scrollBarRightOffset;
                this.scrollBar.validateNow();
            }
            return;
        }

        public function get view():net.wg.gui.lobby.techtree.interfaces.ITechTreePage
        {
            return this._view;
        }

        public function set view(arg1:net.wg.gui.lobby.techtree.interfaces.ITechTreePage):void
        {
            if (arg1 == this._view) 
            {
                return;
            }
            this._view = arg1;
            if (this._view == null) 
            {
                this.scrollBar = null;
            }
            else if (arg1["scrollBar"] != null) 
            {
                this.scrollBar = arg1["scrollBar"];
            }
            return;
        }

        public function set itemRendererName(arg1:String):void
        {
            var value:String;
            var classRef:Class;
            var renderer:net.wg.gui.lobby.techtree.interfaces.IRenderer;

            var loc1:*;
            classRef = null;
            renderer = null;
            value = arg1;
            if (value == "" || this._itemRendererName == value) 
            {
                return;
            }
            this._itemRendererName = value;
            try 
            {
                classRef = flash.utils.getDefinitionByName(this._itemRendererName) as Class;
            }
            catch (error:*)
            {
                trace("error", error.message);
                throw new Error("The class " + value + " cannot be found in your library. Please ensure it exists.");
            }
            if (classRef != null) 
            {
                this._itemRendererClass = classRef;
                while (this.renderers.length) 
                {
                    renderer = this.renderers.pop();
                    this.cleanUpRenderer(renderer);
                    if (this.ntGraphics == null) 
                    {
                        continue;
                    }
                    this.ntGraphics.removeRenderer(renderer);
                }
            }
            return;
        }

        public override function dispose():void
        {
            visible = false;
            this.removeItemRenderers();
            this.view = null;
            net.wg.gui.lobby.techtree.data.vo.NodeData.setDisplayInfoClass(null);
            if (this.ntGraphics != null) 
            {
                this.ntGraphics.dispose();
            }
            if (this.scrollBar != null) 
            {
                this.scrollBar.focusTarget = null;
                this.scrollBar.removeEventListener(flash.events.Event.SCROLL, this.handleMouseScroll);
            }
            removeEventListener(flash.events.MouseEvent.MOUSE_WHEEL, this.handleMouseWheel);
            if (App.cursor != null) 
            {
                App.cursor.unRegisterDragging(this);
            }
            if (this._dataProvider != null) 
            {
                this._dataProvider.removeEventListener(net.wg.gui.lobby.techtree.TechTreeEvent.DATA_BUILD_COMPLETE, this.handleDataComplete);
                this._dataProvider.clearUp();
                this._dataProvider = null;
            }
            super.dispose();
            return;
        }

        public function scrollToIndex(arg1:Number):void
        {
            var loc1:*=null;
            if (-1 < arg1 && arg1 < this.renderers.length) 
            {
                loc1 = this.renderers[arg1];
                if (loc1 != null) 
                {
                    this.scrollPosition = Math.round((loc1.x + (this.nodeWidth + x - width >> 1)) / this.scrollStepFactor);
                }
            }
            return;
        }

        public function get scrollPosition():Number
        {
            return this._scrollPosition;
        }

        public function set scrollPosition(arg1:Number):void
        {
            arg1 = Math.max(0, Math.min(this.maxScroll, Math.round(arg1)));
            if (this._scrollPosition == arg1) 
            {
                return;
            }
            this._scrollPosition = arg1;
            this.ntGraphics.x = -Math.min(Math.abs(this._totalWidth - width), this.scrollStepFactor * this._scrollPosition);
            this.updateScrollBar();
            return;
        }

        public function get maxScroll():Number
        {
            return Math.ceil((this._totalWidth - width) / this.scrollStepFactor);
        }

        public function get scrollPageSize():Number
        {
            return Math.ceil(width / this.scrollStepFactor);
        }

        public function storeScrollPosition():void
        {
            if (this._dataProvider != null) 
            {
                this.positionByNation[this._dataProvider.nation] = this._scrollPosition;
            }
            return;
        }

        public function get dataProvider():net.wg.gui.lobby.techtree.interfaces.INationTreeDataProvider
        {
            return this._dataProvider;
        }

        internal function handleVehicleInfo(arg1:net.wg.gui.lobby.techtree.TechTreeEvent):void
        {
            var loc1:*=null;
            if (!(this.view == null) && arg1.index > -1) 
            {
                loc1 = this._dataProvider.getItemAt(arg1.index);
                this.view.requestVehicleInfoS(loc1.pickleDump);
            }
            return;
        }

        public function invalidateNodesData(arg1:String, arg2:Object):void
        {
            this.ntGraphics.hide();
            this.drawTreeEnabled = false;
            this.scrollToPosition = this.positionByNation[arg1] == undefined ? 0 : this.positionByNation[arg1];
            this._dataProvider.invalidate(arg1, arg2);
            return;
        }

        public function getNodeByID(arg1:Number):net.wg.gui.lobby.techtree.interfaces.IRenderer
        {
            return this.renderers[this._dataProvider.getIndexByID(arg1)];
        }

        public function getRootNode():net.wg.gui.lobby.techtree.interfaces.IRenderer
        {
            return this.renderers[0];
        }

        public function isParentUnlocked(arg1:Number, arg2:Number):Boolean
        {
            var loc1:*=this._dataProvider.getItemByID(arg2);
            var loc2:*;
            return !((loc2 = loc1.unlockProps as net.wg.gui.lobby.techtree.data.vo.UnlockProps) == null) && loc2.hasID(arg1);
        }

        public function getNation():String
        {
            return this._dataProvider.nation;
        }

        public function onStartDrag():void
        {
            if (this.isDragging == true) 
            {
                return;
            }
            this.isDragging = true;
            this.dragOffset = stage.mouseX - this.ntGraphics.x;
            return;
        }

        public function onDragging(arg1:Number, arg2:Number):void
        {
            var loc1:*=this.dragOffset - stage.mouseX;
            loc1 = Math.max(0, Math.min(this._totalWidth - width, Math.round(loc1)));
            this._scrollPosition = Math.round(loc1 / this.scrollStepFactor);
            this.ntGraphics.x = -loc1;
            this.updateScrollBar();
            return;
        }

        public function onEndDrag():void
        {
            this.isDragging = false;
            return;
        }

        public function getDragType():String
        {
            return net.wg.data.constants.DragType.SOFT;
        }

        public function getHitArea():flash.display.InteractiveObject
        {
            return this.background;
        }

        public function setVehicleTypeXP(arg1:Array):void
        {
            var loc2:*=NaN;
            var loc3:*=null;
            var loc1:*=arg1.length;
            var loc4:*=0;
            while (loc4 < loc1) 
            {
                loc3 = arg1[loc4];
                loc2 = this._dataProvider.getIndexByID(loc3[0]);
                if (loc2 > -1 && this._dataProvider.length > loc2) 
                {
                    this._dataProvider.setEarnedXP(loc2, loc3[1]);
                    this.renderers[loc2].invalidateNodeState(0);
                }
                ++loc4;
            }
            return;
        }

        internal var _scrollPosition:Number=0;

        internal var renderers:__AS3__.vec.Vector.<net.wg.gui.lobby.techtree.interfaces.IRenderer>;

        internal var _dataProvider:net.wg.gui.lobby.techtree.interfaces.INationTreeDataProvider;

        internal var drawTreeEnabled:Boolean=false;

        internal var scrollToNode:Boolean=true;

        internal var scrollToPosition:Number=-1;

        internal var positionByNation:Object;

        internal var isDragging:Boolean=false;

        internal var dragOffset:Number=0;

        internal var _itemRendererName:String="";

        internal var _itemRendererClass:Class=null;

        internal var _view:net.wg.gui.lobby.techtree.interfaces.ITechTreePage=null;

        internal var requestInCoolDown:Boolean=false;

        public var nodeHeight:Number=56;

        public var nodeWidth:Number=132;

        public var scrollStepFactor:Number=1;

        public var scrollBarBottomOffset:Number=4;

        public var scrollBarRightOffset:Number=9;

        public var containerHeight:Number=610;

        public var scrollBar:net.wg.gui.components.controls.ScrollBar;

        public var ntGraphics:net.wg.gui.lobby.techtree.helpers.NTGraphics;

        public var background:flash.display.Sprite;

        internal var _totalWidth:Number;
    }
}
