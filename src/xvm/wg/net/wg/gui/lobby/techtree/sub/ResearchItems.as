package net.wg.gui.lobby.techtree.sub 
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.geom.*;
    import flash.utils.*;
    import net.wg.gui.lobby.techtree.*;
    import net.wg.gui.lobby.techtree.constants.*;
    import net.wg.gui.lobby.techtree.controls.*;
    import net.wg.gui.lobby.techtree.data.*;
    import net.wg.gui.lobby.techtree.data.vo.*;
    import net.wg.gui.lobby.techtree.helpers.*;
    import net.wg.gui.lobby.techtree.interfaces.*;
    import net.wg.gui.lobby.techtree.math.*;
    import net.wg.gui.lobby.techtree.nodes.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.core.*;
    
    public class ResearchItems extends scaleform.clik.core.UIComponent implements net.wg.gui.lobby.techtree.interfaces.IResearchContainer
    {
        public function ResearchItems()
        {
            super();
            return;
        }

        internal function createItemRenderer(arg1:uint):net.wg.gui.lobby.techtree.interfaces.IRenderer
        {
            var loc1:*=null;
            var loc2:*=arg1;
            switch (loc2) 
            {
                case net.wg.gui.lobby.techtree.constants.NodeEntityType.TOP_VEHICLE:
                case net.wg.gui.lobby.techtree.constants.NodeEntityType.NEXT_VEHICLE:
                    loc1 = new this._vehicleNodeClass();
                    this.setupVehicleRenderer(loc1);
                    break;
                case net.wg.gui.lobby.techtree.constants.NodeEntityType.RESEARCH_ITEM:
                    loc1 = new this._itemNodeClass();
                    this.setupItemRenderer(loc1);
                    break;
                case net.wg.gui.lobby.techtree.constants.NodeEntityType.UNDEFINED:
                    loc1 = new this._fakeNodeClass();
                    break;
            }
            return loc1;
        }

        internal function setupItemRenderer(arg1:net.wg.gui.lobby.techtree.interfaces.IRenderer):void
        {
            if (arg1 == null) 
                return;
            arg1.container = this;
            arg1.addEventListener(net.wg.gui.lobby.techtree.TechTreeEvent.CLICK_2_UNLOCK, this.handleUnlockItem, false, 0, true);
            arg1.addEventListener(net.wg.gui.lobby.techtree.TechTreeEvent.CLICK_2_BUY, this.handleBuyItem, false, 0, true);
            arg1.addEventListener(net.wg.gui.lobby.techtree.TechTreeEvent.CLICK_2_SELL, this.handleSellItem, false, 0, true);
            arg1.addEventListener(net.wg.gui.lobby.techtree.TechTreeEvent.CLICK_2_INSTALL, this.handleInstallItem, false, 0, true);
            arg1.addEventListener(net.wg.gui.lobby.techtree.TechTreeEvent.CLICK_2_MODULE_INFO, this.handleRequestModuleInfo, false, 0, true);
            return;
        }

        internal function setupVehicleRenderer(arg1:net.wg.gui.lobby.techtree.interfaces.IRenderer, arg2:Boolean=false):void
        {
            if (arg1 == null) 
                return;
            arg1.container = this;
            arg1.addEventListener(net.wg.gui.lobby.techtree.TechTreeEvent.CLICK_2_UNLOCK, this.handleUnlockItem, false, 0, true);
            arg1.addEventListener(net.wg.gui.lobby.techtree.TechTreeEvent.CLICK_2_BUY, this.handleBuyItem, false, 0, true);
            arg1.addEventListener(net.wg.gui.lobby.techtree.TechTreeEvent.CLICK_2_SELL, this.handleSellItem, false, 0, true);
            arg1.addEventListener(net.wg.gui.lobby.techtree.TechTreeEvent.CLICK_2_VEHICLE_INFO, this.handleRequestVehicleInfo, false, 0, true);
            if (!arg2) 
                arg1.addEventListener(net.wg.gui.lobby.techtree.TechTreeEvent.CLICK_2_OPEN, this.handleOpenVehicle, false, 0, true);
            return;
        }

        internal function removeItemRenderers():void
        {
            var loc1:*=null;
            while (this.topRenderers.length > 0) 
                this.cleanUpRenderer(this.topRenderers.pop());
            while (this.renderers.length > 0) 
            {
                loc1 = this.renderers.pop();
                while (loc1.length > 0) 
                    this.cleanUpRenderer(loc1.pop());
            }
            if (this.rGraphics != null) 
                this.rGraphics.clearUp();
            this.positionByID = {};
            return;
        }

        internal function updateTopRenderers():void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            var loc1:*=this._dataProvider.topLength;
            var loc5:*=false;
            while (this.topRenderers.length > loc1) 
            {
                loc2 = this.topRenderers.pop();
                this.cleanUpRenderer(loc2);
                if (this.rGraphics == null) 
                    continue;
                this.rGraphics.removeRenderer(loc2);
            }
            var loc6:*=0;
            while (loc6 < loc1) 
            {
                if (loc6 < this.topRenderers.length) 
                {
                    loc5 = false;
                    loc2 = this.topRenderers[loc6];
                    if (this.rGraphics != null) 
                    {
                        this.rGraphics.clearUpRenderer(loc2);
                        this.rGraphics.clearLinesAndArrows(loc2);
                    }
                }
                else 
                {
                    loc5 = true;
                    loc2 = this.createItemRenderer(net.wg.gui.lobby.techtree.constants.NodeEntityType.TOP_VEHICLE);
                }
                if (loc2 != null) 
                {
                    loc3 = new net.wg.gui.lobby.techtree.math.MatrixPosition(loc6, -1);
                    loc4 = this._dataProvider.getTopLevelAt(loc6);
                    this.positionByID[loc4.id] = loc3;
                    loc2.setup(loc6, loc4, net.wg.gui.lobby.techtree.constants.NodeEntityType.TOP_VEHICLE, loc3);
                    loc2.validateNow();
                    if (loc5) 
                    {
                        this.topRenderers.push(loc2);
                        this.rGraphics.addChild(flash.display.DisplayObject(loc2));
                    }
                }
                ++loc6;
            }
            return;
        }

        internal function updateRenderers(arg1:RenderersOnScene):void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            var loc6:*=null;
            var loc9:*=NaN;
            var loc10:*=NaN;
            var loc11:*=NaN;
            var loc13:*=0;
            var loc14:*=null;
            var loc15:*=null;
            var loc16:*=null;
            var loc17:*=null;
            var loc18:*=null;
            var loc19:*=null;
            var loc20:*=null;
            var loc5:*=this._levelsBuilder.nodesByLevel;
            var loc7:*=new Vector.<net.wg.gui.lobby.techtree.nodes.FakeNode>();
            var loc8:*=loc5.length;
            var loc12:*=false;
            loc10 = 1;
            while (loc10 < loc8) 
            {
                loc9 = (loc6 = loc5[loc10]).length;
                loc11 = 0;
                while (loc11 < loc9) 
                {
                    if ((loc3 = loc6[loc11]) != null) 
                    {
                        loc4 = null;
                        loc12 = false;
                        if (-1 < loc3.index && loc3.index < this._dataProvider.length) 
                            loc4 = this._dataProvider.getItemAt(loc3.index);
                        loc13 = this._dataProvider.resolveEntityType(loc4);
                        loc2 = new net.wg.gui.lobby.techtree.math.MatrixPosition(loc10, loc11);
                        loc1 = arg1.getRenderer(loc13);
                        if (loc1 == null) 
                        {
                            loc12 = true;
                            loc1 = this.createItemRenderer(loc13);
                        }
                        if (loc1 != null) 
                        {
                            this.renderers[loc10][loc11] = loc1;
                            if (loc4 != null) 
                                this.positionByID[loc4.id] = loc2;
                            loc1.setup(loc3.index, loc4, loc13, loc2);
                            if (loc1.isFake()) 
                                loc7.push(loc1 as net.wg.gui.lobby.techtree.nodes.FakeNode);
                            if (loc12) 
                            {
                                loc1.validateNowEx();
                                this.rGraphics.addChild(flash.display.DisplayObject(loc1));
                            }
                        }
                    }
                    ++loc11;
                }
                ++loc10;
            }
            arg1.clearUp(this);
            loc8 = loc7.length;
            loc10 = 0;
            while (loc10 < loc8) 
            {
                loc18 = loc7[loc10];
                loc14 = new Vector.<net.wg.gui.lobby.techtree.interfaces.IRenderer>();
                loc16 = this._levelsBuilder.getChildrenLevelIdxs(loc18.index);
                loc11 = 0;
                while (loc11 < loc16.length) 
                {
                    if ((loc19 = this.renderers[loc18.matrixPosition.row + 1][loc16[loc11]]) != null) 
                        loc14.push(loc19);
                    ++loc11;
                }
                loc18.setChildren(loc14);
                loc15 = new Vector.<net.wg.gui.lobby.techtree.interfaces.IRenderer>();
                loc17 = this._levelsBuilder.getParentLevelIdxs(loc18.index);
                loc11 = 0;
                while (loc11 < loc17.length) 
                {
                    if ((loc20 = this.renderers[(loc18.matrixPosition.row - 1)][loc17[loc11]]) != null) 
                        loc15.push(loc20);
                    ++loc11;
                }
                loc18.setParents(loc15);
                ++loc10;
            }
            return;
        }

        internal function drawRenderers():Boolean
        {
            if (this._levelsBuilder == null || this.rGraphics == null) 
                return false;
            var loc1:*=false;
            var loc2:*=this.flushRenderersOnScene();
            this.renderers = this.createRenderersMatrix();
            this.positionByID = {};
            if (this.updateRootData()) 
            {
                this.updateTopRenderers();
                this.updateRenderers(loc2);
                this.drawLayout();
                loc1 = true;
            }
            return loc1;
        }

        internal function drawLayout():void
        {
            var loc5:*=NaN;
            var loc6:*=NaN;
            var loc7:*=null;
            var loc10:*=null;
            var loc11:*=null;
            var loc14:*=null;
            var loc15:*=NaN;
            var loc1:*=this._levelsBuilder.levelDimension;
            var loc2:*=this.rootRenderer.getY();
            var loc3:*=this.rootRenderer.getOutX();
            var loc4:*=(this.topRenderers.length - 1) * this.yRatio;
            loc5 = 0;
            loc6 = loc2 - (loc4 >> 1);
            while (loc5 < this.topRenderers.length) 
            {
                (loc7 = this.topRenderers[loc5]).x = this.topLevelX;
                loc7.y = loc6 - (loc7.getY() - loc7.y);
                ++loc5;
                loc6 = loc6 + this.yRatio;
            }
            var loc8:*=new Array(loc1.column);
            loc4 = (loc1.column - 1) * this.yRatio;
            loc8[0] = loc2 - (loc4 >> 1);
            var loc9:*=1;
            while (loc9 < loc1.column) 
            {
                loc8[loc9] = loc8[(loc9 - 1)] + this.yRatio;
                ++loc9;
            }
            var loc12:*=loc3 + this.xRatio;
            var loc13:*=0;
            loc5 = 1;
            while (loc5 < this.renderers.length) 
            {
                loc10 = this.renderers[loc5];
                loc15 = 0;
                while (loc15 < loc10.length) 
                {
                    if ((loc7 = loc10[loc15]) != null) 
                    {
                        if (!((loc14 = loc7.getDisplayInfo() as net.wg.gui.lobby.techtree.data.vo.ResearchDisplayInfo) == null) && loc14.isDrawVehicle()) 
                            loc11 = new flash.geom.Point(this.nextLevelX, loc8[loc15] - loc7.getRatioY());
                        else 
                        {
                            loc11 = new flash.geom.Point(loc12, loc8[loc15] - loc7.getRatioY());
                            loc13 = Math.max(loc7.getActualWidth(), loc13);
                        }
                        loc7.setPosition(loc11);
                    }
                    ++loc15;
                }
                loc12 = loc12 + (this.xRatio + loc13);
                ++loc5;
            }
            return;
        }

        public function isParentUnlocked(arg1:Number, arg2:Number):Boolean
        {
            var loc1:*=0;
            var loc2:*;
            if ((loc2 = this._dataProvider.getIndexByID(arg1)) > -1 && this._dataProvider.length > loc2) 
                loc1 = this._dataProvider.getItemAt(loc2).state;
            else if ((loc2 = this._dataProvider.getTopLevelIndexByID(arg1)) > -1 && this._dataProvider.topLength > loc2) 
                loc1 = this._dataProvider.getTopLevelAt(loc2).state;
            return (loc1 & net.wg.gui.lobby.techtree.constants.NodeState.UNLOCKED) > 0;
        }

        internal function drawLines():void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc4:*=null;
            var loc5:*=NaN;
            var loc6:*=null;
            var loc8:*=NaN;
            var loc3:*=this.isRootUnlocked();
            this.rGraphics.drawTopLevelLines(this.rootRenderer, this.topRenderers, false);
            var loc7:*=0;
            while (loc7 < (this.renderers.length - 1)) 
            {
                loc2 = this.renderers[loc7];
                loc8 = 0;
                while (loc8 < loc2.length) 
                {
                    loc1 = loc2[loc8];
                    if (loc1 != null) 
                    {
                        loc5 = loc1.matrixPosition.row + 1;
                        loc4 = new net.wg.gui.lobby.techtree.helpers.NodeIndexFilter(this._levelsBuilder.getChildrenLevelIdxs(loc1.index));
                        loc6 = Vector.<net.wg.gui.lobby.techtree.interfaces.IRenderer>(this.renderers[loc5].filter(loc4.doFilter, loc4));
                        this.rGraphics.drawOutgoingLines(loc1, loc6, false, loc3);
                    }
                    ++loc8;
                }
                ++loc7;
            }
            return;
        }

        internal function getNodeDataByEvent(arg1:net.wg.gui.lobby.techtree.TechTreeEvent):net.wg.gui.lobby.techtree.data.vo.NodeData
        {
            var loc1:*=null;
            if (arg1.entityType != net.wg.gui.lobby.techtree.constants.NodeEntityType.TOP_VEHICLE) 
                loc1 = this._dataProvider.getItemAt(arg1.index);
            else 
                loc1 = this._dataProvider.getTopLevelAt(arg1.index);
            App.utils.asserter.assertNotNull(loc1, "Data of node not found by event = " + arg1);
            return loc1;
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

        internal function handleReturn2TechTree(arg1:net.wg.gui.lobby.techtree.TechTreeEvent):void
        {
            if (this.view != null) 
                this.view.goToTechTreeS(this._dataProvider.nation);
            return;
        }

        internal function handleRequestModuleInfo(arg1:net.wg.gui.lobby.techtree.TechTreeEvent):void
        {
            if (this.view != null) 
            {
                App.utils.asserter.assert(net.wg.gui.lobby.techtree.constants.NodeEntityType.isModuleType(arg1.entityType), "Node is not module");
                this.view.requestModuleInfoS(this.getNodeDataByEvent(arg1).pickleDump);
            }
            return;
        }

        internal function handleRequestVehicleInfo(arg1:net.wg.gui.lobby.techtree.TechTreeEvent):void
        {
            if (this.view != null) 
            {
                App.utils.asserter.assert(net.wg.gui.lobby.techtree.constants.NodeEntityType.isVehicleType(arg1.entityType), "Node is not vehicle");
                this.view.requestVehicleInfoS(this.getNodeDataByEvent(arg1).pickleDump);
            }
            return;
        }

        internal function handleOpenVehicle(arg1:net.wg.gui.lobby.techtree.TechTreeEvent):void
        {
            if (this.view != null) 
            {
                App.utils.asserter.assert(net.wg.gui.lobby.techtree.constants.NodeEntityType.isVehicleType(arg1.entityType), "Node is not vehicle");
                this.invalidateNodesData(this._dataProvider.nation, this.view.getResearchItemsDataS(this.getNodeDataByEvent(arg1).id, true));
            }
            return;
        }

        internal function handleUnlockItem(arg1:net.wg.gui.lobby.techtree.TechTreeEvent):void
        {
            var loc1:*=null;
            var loc2:*=null;
            if (!this.requestInCoolDown && !(this.view == null)) 
            {
                loc1 = this.getNodeDataByEvent(arg1);
                loc2 = loc1.unlockProps;
                App.utils.asserter.assertNotNull(loc2, "Unlock information is not defined for node = " + arg1.target);
                this.view.request4UnlockS(loc1.id, loc2.parentID, loc2.unlockIdx, loc2.xpCost);
                this.activateCoolDown();
            }
            return;
        }

        internal function handleBuyItem(arg1:net.wg.gui.lobby.techtree.TechTreeEvent):void
        {
            if (!this.requestInCoolDown && !(this.view == null)) 
            {
                this.view.request4BuyS(this.getNodeDataByEvent(arg1).id);
                this.activateCoolDown();
            }
            return;
        }

        internal function handleSellItem(arg1:net.wg.gui.lobby.techtree.TechTreeEvent):void
        {
            if (!this.requestInCoolDown && !(this.view == null)) 
            {
                this.view.request4SellS(this.getNodeDataByEvent(arg1).id);
                this.activateCoolDown();
            }
            return;
        }

        internal function handleInstallItem(arg1:Object):void
        {
            var loc1:*=null;
            if (!this.requestInCoolDown && !(this.view == null)) 
            {
                App.utils.asserter.assert(net.wg.gui.lobby.techtree.constants.NodeEntityType.isModuleType(arg1.entityType), "Node is not module");
                loc1 = this._dataProvider.getItemAt(arg1.index);
                App.utils.asserter.assertNotNull(loc1, "Data of node not found by event = " + arg1);
                this.view.request4InstallS(loc1.id);
                this.activateCoolDown();
            }
            return;
        }

        internal static function getNodeDefinitionByName(arg1:String):Class
        {
            var name:String;
            var classRef:Class;

            var loc1:*;
            name = arg1;
            if (name == "") 
                return null;
            classRef = null;
            try 
                classRef = flash.utils.getDefinitionByName(name) as Class;
            catch (error:*)
            {
                trace("error", error.message);
                throw new Error("The class " + name + " cannot be found in your library. Please ensure it exists.");
            }
            return classRef;
        }

        public function set vehicleNodeName(arg1:String):void
        {
            var loc1:*=getNodeDefinitionByName(arg1);
            if (loc1 != null) 
            {
                this._vehicleNodeClass = loc1;
                invalidate();
            }
            return;
        }

        public function set itemNodeName(arg1:String):void
        {
            var loc1:*=getNodeDefinitionByName(arg1);
            if (loc1 != null) 
            {
                this._itemNodeClass = loc1;
                invalidate();
            }
            return;
        }

        public function set fakeNodeName(arg1:String):void
        {
            var loc1:*=getNodeDefinitionByName(arg1);
            if (loc1 != null) 
            {
                this._fakeNodeClass = loc1;
                invalidate();
            }
            return;
        }

        public function get rootRenderer():net.wg.gui.lobby.techtree.nodes.ResearchRoot
        {
            return this.rGraphics == null ? null : this.rGraphics.rootRenderer;
        }

        public function get xpInfo():net.wg.gui.lobby.techtree.controls.ExperienceInformation
        {
            return this.rGraphics == null ? null : this.rGraphics.xpInfo;
        }

        public function get dataProvider():net.wg.gui.lobby.techtree.interfaces.IResearchDataProvider
        {
            return this._dataProvider;
        }

        public function set dataProvider(arg1:net.wg.gui.lobby.techtree.interfaces.IResearchDataProvider):void
        {
            if (this._dataProvider != null) 
                this._dataProvider.removeEventListener(net.wg.gui.lobby.techtree.TechTreeEvent.DATA_BUILD_COMPLETE, this.handleDataComplete);
            this._dataProvider = arg1;
            if (this._dataProvider != null) 
                this._dataProvider.addEventListener(net.wg.gui.lobby.techtree.TechTreeEvent.DATA_BUILD_COMPLETE, this.handleDataComplete, false, 0, true);
            return;
        }

        public override function dispose():void
        {
            visible = false;
            this.removeItemRenderers();
            this.view = null;
            net.wg.gui.lobby.techtree.data.vo.NodeData.setDisplayInfoClass(null);
            if (this.titleAppearance != null) 
            {
                this.titleAppearance.clearUp();
                this.titleAppearance = null;
            }
            if (this.rGraphics != null) 
                this.rGraphics.removeReferences();
            if (this.premiumLayout != null) 
                this.premiumLayout.dispose();
            if (this.titleBar != null) 
            {
                this.titleBar.removeEventListener(net.wg.gui.lobby.techtree.TechTreeEvent.RETURN_2_TECHTREE, this.handleReturn2TechTree);
                this.titleBar.dispose();
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

        public function invalidateNodesData(arg1:String, arg2:Object):void
        {
            this.drawEnabled = false;
            this._dataProvider.invalidate(arg1, arg2);
            return;
        }

        public function setNodesStates(arg1:Number, arg2:Array, arg3:String=null):void
        {
            var loc2:*=null;
            var loc3:*=false;
            var loc4:*=null;
            var loc5:*=NaN;
            var loc6:*=NaN;
            var loc1:*=arg2.length;
            var loc7:*=0;
            while (loc7 < loc1) 
            {
                loc5 = (loc2 = arg2[loc7])[0];
                loc4 = null;
                loc3 = false;
                if ((loc6 = this._dataProvider.getIndexByID(loc5)) > -1 && this._dataProvider.length > loc6) 
                {
                    if (arg3 != null) 
                        this._dataProvider.setItemField(arg3, loc6, loc2[2]);
                    loc3 = this._dataProvider.setState(loc6, arg1, loc2[1]);
                    loc4 = this.getNodeByID(loc5);
                }
                else if ((loc6 = this._dataProvider.getTopLevelIndexByID(loc5)) > -1 && this._dataProvider.topLength > loc6) 
                {
                    if (arg3 != null) 
                        this._dataProvider.setTopLevelField(arg3, loc6, loc2[2]);
                    loc3 = this._dataProvider.setTopLevelState(loc6, arg1, loc2[1]);
                    loc4 = this.getNodeByID(loc5);
                }
                if (loc3 && !(loc4 == null)) 
                    loc4.invalidateNodeState(arg1);
                ++loc7;
            }
            return;
        }

        public function setVehicleTypeXP(arg1:Array):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=NaN;
            var loc5:*=NaN;
            var loc1:*=arg1.length;
            var loc6:*=0;
            while (loc6 < loc1) 
            {
                loc2 = arg1[loc6];
                loc4 = loc2[0];
                loc3 = null;
                if ((loc5 = this._dataProvider.getIndexByID(loc4)) > -1 && this._dataProvider.length > loc5) 
                {
                    this._dataProvider.setEarnedXP(loc5, loc2[1]);
                    loc3 = this.getNodeByID(loc4);
                }
                else if ((loc5 = this._dataProvider.getTopLevelIndexByID(loc4)) > -1 && this._dataProvider.topLength > loc5) 
                {
                    this._dataProvider.setTopLevelXP(loc5, loc2[1]);
                    loc3 = this.getNodeByID(loc4);
                }
                if (loc3 != null) 
                    loc3.invalidateNodeState(0);
                ++loc6;
            }
            return;
        }

        public function setFreeXP(arg1:Number):void
        {
            if (this.xpInfo != null) 
                this.xpInfo.setFreeXP(arg1);
            return;
        }

        public function getRootState():Number
        {
            return this._dataProvider.length > 0 ? this._dataProvider.getItemAt(0).state : 0;
        }

        public function getRootNode():net.wg.gui.lobby.techtree.interfaces.IRenderer
        {
            return this.rootRenderer;
        }

        public function hasUnlockedParent(arg1:Number, arg2:Number):Boolean
        {
            var loc2:*=null;
            var loc1:*=this._levelsBuilder.getParentLevelIdxs(arg2);
            var loc3:*=0;
            while (loc3 < loc1.length) 
            {
                if (!((loc2 = this.renderers[arg1][loc1[loc3]]) == null) && loc2.isUnlocked()) 
                    return true;
                ++loc3;
            }
            return false;
        }

        internal function handleDataComplete(arg1:net.wg.gui.lobby.techtree.TechTreeEvent):void
        {
            this._levelsBuilder = new net.wg.gui.lobby.techtree.math.ADG_ItemLevelsBuilder(this._dataProvider.length, this.maxNodesOnLevel);
            this._dataProvider.populate(this._levelsBuilder);
            this._levelsBuilder.process();
            if (this._levelsBuilder.hasCyclicReference()) 
            {
                trace("ERROR: Has cyclic reference.");
                this.titleBar.setTitle("");
                if (this.view != null) 
                {
                    if (App.utils != null) 
                        this.view.showSystemMessageS("Error", App.utils.locale.makeString(SYSTEM_MESSAGES.UNLOCKS_DRAWFAILED));
                    this.view.onResearchItemsDrawnS();
                }
                return;
            }
            this.drawEnabled = true;
            invalidateData();
            return;
        }

        public function getNation():String
        {
            return this._dataProvider.nation;
        }

        public function canInstallItems():Boolean
        {
            return this.rootRenderer.inInventory() && this._dataProvider.getGlobalStats().enableInstallItems;
        }

        public function getNodeByID(arg1:Number):net.wg.gui.lobby.techtree.interfaces.IRenderer
        {
            var loc1:*=this.positionByID[arg1];
            var loc2:*=null;
            if (loc1.column != -1) 
                loc2 = this.renderers[loc1.row][loc1.column];
            else 
                loc2 = this.topRenderers[loc1.row];
            return loc2;
        }

        public function getTopLevel():__AS3__.vec.Vector.<net.wg.gui.lobby.techtree.interfaces.IRenderer>
        {
            return this.topRenderers;
        }

        public function getChildren(arg1:net.wg.gui.lobby.techtree.interfaces.IRenderer):__AS3__.vec.Vector.<net.wg.gui.lobby.techtree.interfaces.IRenderer>
        {
            var loc1:*=null;
            var loc3:*=null;
            var loc2:*=arg1.matrixPosition.row + 1;
            if (loc2 < this.renderers.length) 
            {
                loc3 = new net.wg.gui.lobby.techtree.helpers.NodeIndexFilter(this._levelsBuilder.getChildrenLevelIdxs(arg1.index));
                loc1 = Vector.<net.wg.gui.lobby.techtree.interfaces.IRenderer>(this.renderers[loc2].filter(loc3.doFilter, loc3));
            }
            else 
                loc1 = new Vector.<net.wg.gui.lobby.techtree.interfaces.IRenderer>();
            return loc1;
        }

        public function getParents(arg1:net.wg.gui.lobby.techtree.interfaces.IRenderer):__AS3__.vec.Vector.<net.wg.gui.lobby.techtree.interfaces.IRenderer>
        {
            var loc1:*=null;
            var loc3:*=null;
            var loc2:*=(arg1.matrixPosition.row - 1);
            if (loc2 > 0 && loc2 < this.renderers.length) 
            {
                loc3 = new net.wg.gui.lobby.techtree.helpers.NodeIndexFilter(this._levelsBuilder.getParentLevelIdxs(arg1.index));
                loc1 = Vector.<net.wg.gui.lobby.techtree.interfaces.IRenderer>(this.renderers[loc2].filter(loc3.doFilter, loc3));
            }
            else 
                loc1 = new Vector.<net.wg.gui.lobby.techtree.interfaces.IRenderer>();
            return loc1;
        }

        public function isRootUnlocked():Boolean
        {
            return this.rootRenderer == null ? false : this.rootRenderer.isUnlocked();
        }

        public function cleanUpRenderer(arg1:net.wg.gui.lobby.techtree.interfaces.IRenderer):void
        {
            if (arg1 == null) 
                return;
            arg1.cleanUp();
            arg1.removeEventListener(net.wg.gui.lobby.techtree.TechTreeEvent.CLICK_2_UNLOCK, this.handleUnlockItem);
            arg1.removeEventListener(net.wg.gui.lobby.techtree.TechTreeEvent.CLICK_2_BUY, this.handleBuyItem);
            arg1.removeEventListener(net.wg.gui.lobby.techtree.TechTreeEvent.CLICK_2_SELL, this.handleSellItem);
            arg1.removeEventListener(net.wg.gui.lobby.techtree.TechTreeEvent.CLICK_2_OPEN, this.handleOpenVehicle);
            arg1.removeEventListener(net.wg.gui.lobby.techtree.TechTreeEvent.CLICK_2_INSTALL, this.handleInstallItem);
            arg1.removeEventListener(net.wg.gui.lobby.techtree.TechTreeEvent.CLICK_2_VEHICLE_INFO, this.handleRequestVehicleInfo);
            arg1.removeEventListener(net.wg.gui.lobby.techtree.TechTreeEvent.CLICK_2_MODULE_INFO, this.handleRequestModuleInfo);
            return;
        }

        protected override function initialize():void
        {
            super.initialize();
            this._dataProvider = new net.wg.gui.lobby.techtree.data.ResearchVODataProvider();
            this._dataProvider.addEventListener(net.wg.gui.lobby.techtree.TechTreeEvent.DATA_BUILD_COMPLETE, this.handleDataComplete, false, 0, true);
            this._levelsBuilder = null;
            this.renderers = new Vector.<Vector.<net.wg.gui.lobby.techtree.interfaces.IRenderer>>();
            this.topRenderers = new Vector.<net.wg.gui.lobby.techtree.interfaces.IRenderer>();
            this.positionByID = {};
            if (this.rGraphics != null) 
                this.rGraphics.container = this;
            return;
        }

        protected override function configUI():void
        {
            this.titleAppearance = new net.wg.gui.lobby.techtree.helpers.TitleAppearance(this.titleBar);
            this.setupVehicleRenderer(this.rootRenderer, true);
            if (this.titleBar != null) 
                this.titleBar.addEventListener(net.wg.gui.lobby.techtree.TechTreeEvent.RETURN_2_TECHTREE, this.handleReturn2TechTree, false, 0, true);
            if (this.rGraphics != null) 
                this.rGraphics.xRatio = this.xRatio >> 1;
            super.configUI();
            return;
        }

        protected override function draw():void
        {
            if (isInvalid(scaleform.clik.constants.InvalidationType.SIZE)) 
                this.updateLayouts();
            if (!this.drawEnabled) 
                return;
            super.draw();
            if (isInvalid(scaleform.clik.constants.InvalidationType.DATA)) 
            {
                if (this.rGraphics != null) 
                    this.rGraphics.setup();
                if (this.drawRenderers()) 
                    this.drawLines();
                this.drawEnabled = false;
                if (this.view != null) 
                    this.view.onResearchItemsDrawnS();
            }
            return;
        }

        protected function updateLayouts():void
        {
            if (this.titleAppearance != null) 
                this.titleAppearance.updateInResearch(_width, App.appHeight, this.titleDefaultY);
            if (this.rGraphics != null) 
                this.rGraphics.y = (this.titleDefaultY - 1) + (_height >> 1);
            if (this.premiumLayout != null) 
                this.premiumLayout.height = _height;
            if (this.background != null) 
                this.background.height = _height;
            return;
        }

        internal function updateRootData():Boolean
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=null;
            var loc6:*=false;
            var loc1:*=false;
            if (this._levelsBuilder.nodesByLevel[0][1] == null) 
                if (this.rootRenderer) 
                {
                    trace("Sets root data.");
                    loc1 = true;
                    loc2 = this._dataProvider.getRootItem();
                    loc3 = this._dataProvider.getGlobalStats();
                    loc4 = this._dataProvider.nation;
                    loc5 = new net.wg.gui.lobby.techtree.math.MatrixPosition(0, 0);
                    this.renderers[0][0] = this.rootRenderer;
                    this.positionByID[loc2.id] = new net.wg.gui.lobby.techtree.math.MatrixPosition(0, 0);
                    this.rootRenderer.setup(0, loc2, 0, loc5);
                    this.rootRenderer.setupEx(loc3.statusString);
                    this.rootRenderer.validateNow();
                    loc6 = this.rootRenderer.isPremium();
                    if (this.titleBar != null) 
                    {
                        this.titleBar.setNation(loc3.hasNationTree ? loc4 : "");
                        this.titleBar.setTitle(loc6 ? "" : loc2.longName);
                    }
                    if (this.xpInfo != null) 
                        this.xpInfo.setFreeXP(loc3.freeXP);
                    if (loc6) 
                        if (!this.premiumLayout) 
                            this.premiumLayout = net.wg.gui.lobby.techtree.controls.PremiumLayout.show(this);
                    else 
                        this.premiumLayout = null;
                }
                else 
                    trace("ERROR: Root renderer must be on display list.");
            else 
                trace("ERROR: In zero level must has one node only.");
            return loc1;
        }

        internal function createRenderersMatrix():__AS3__.vec.Vector.<__AS3__.vec.Vector.<net.wg.gui.lobby.techtree.interfaces.IRenderer>>
        {
            var loc1:*=this._levelsBuilder.levelDimension;
            var loc2:*=new Vector.<Vector.<net.wg.gui.lobby.techtree.interfaces.IRenderer>>(loc1.row);
            var loc3:*=0;
            while (loc3 < loc1.row) 
            {
                loc2[loc3] = new Vector.<net.wg.gui.lobby.techtree.interfaces.IRenderer>(loc1.column);
                ++loc3;
            }
            return loc2;
        }

        internal function flushRenderersOnScene():RenderersOnScene
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc5:*=NaN;
            var loc3:*=new RenderersOnScene();
            var loc4:*=1;
            while (loc4 < this.renderers.length) 
            {
                loc1 = this.renderers[loc4];
                loc5 = 0;
                while (loc5 < loc1.length) 
                {
                    loc2 = loc1[loc5];
                    if (loc2 != null) 
                    {
                        this.rGraphics.clearUpRenderer(loc2);
                        this.rGraphics.clearLinesAndArrows(loc2);
                        loc3.addRenderer(loc2);
                    }
                    ++loc5;
                }
                ++loc4;
            }
            return loc3;
        }

        internal var titleAppearance:net.wg.gui.lobby.techtree.helpers.TitleAppearance=null;

        internal var drawEnabled:Boolean=false;

        internal var requestInCoolDown:Boolean=false;

        internal var _vehicleNodeClass:Class=null;

        internal var _itemNodeClass:Class=null;

        internal var _fakeNodeClass:Class=null;

        internal var _dataProvider:net.wg.gui.lobby.techtree.interfaces.IResearchDataProvider;

        internal var _levelsBuilder:net.wg.gui.lobby.techtree.math.ADG_ItemLevelsBuilder;

        internal var renderers:__AS3__.vec.Vector.<__AS3__.vec.Vector.<net.wg.gui.lobby.techtree.interfaces.IRenderer>>;

        internal var topRenderers:__AS3__.vec.Vector.<net.wg.gui.lobby.techtree.interfaces.IRenderer>;

        public var yRatio:Number=90;

        public var xRatio:Number=90;

        public var topLevelX:Number=10;

        public var nextLevelX:Number=800;

        public var maxNodesOnLevel:Number=10;

        public var titleDefaultY:Number=0;

        public var view:net.wg.gui.lobby.techtree.interfaces.IResearchPage;

        public var titleBar:net.wg.gui.lobby.techtree.controls.ResearchTitleBar;

        public var rGraphics:net.wg.gui.lobby.techtree.helpers.ResearchGraphics;

        public var premiumLayout:net.wg.gui.lobby.techtree.controls.PremiumLayout;

        public var background:flash.display.Sprite;

        internal var positionByID:Object;
    }
}

import __AS3__.vec.*;
import net.wg.gui.lobby.techtree.constants.*;
import net.wg.gui.lobby.techtree.interfaces.*;


class RenderersOnScene extends Object
{
    public function RenderersOnScene()
    {
        super();
        this.items = new Vector.<net.wg.gui.lobby.techtree.interfaces.IRenderer>();
        this.vehicles = new Vector.<net.wg.gui.lobby.techtree.interfaces.IRenderer>();
        this.fakes = new Vector.<net.wg.gui.lobby.techtree.interfaces.IRenderer>();
        return;
    }

    public function addRenderer(arg1:net.wg.gui.lobby.techtree.interfaces.IRenderer):void
    {
        var loc1:*=arg1.getEntityType();
        switch (loc1) 
        {
            case net.wg.gui.lobby.techtree.constants.NodeEntityType.NEXT_VEHICLE:
                this.vehicles.push(arg1);
                break;
            case net.wg.gui.lobby.techtree.constants.NodeEntityType.RESEARCH_ITEM:
                this.items.push(arg1);
                break;
            case net.wg.gui.lobby.techtree.constants.NodeEntityType.UNDEFINED:
                this.fakes.push(arg1);
                break;
        }
        return;
    }

    public function getRenderer(arg1:uint):net.wg.gui.lobby.techtree.interfaces.IRenderer
    {
        var loc1:*=null;
        var loc2:*=arg1;
        switch (loc2) 
        {
            case net.wg.gui.lobby.techtree.constants.NodeEntityType.NEXT_VEHICLE:
                if (this.vehicles.length > 0) 
                    loc1 = this.vehicles.pop();
                break;
            case net.wg.gui.lobby.techtree.constants.NodeEntityType.RESEARCH_ITEM:
                if (this.items.length > 0) 
                    loc1 = this.items.pop();
                break;
            case net.wg.gui.lobby.techtree.constants.NodeEntityType.UNDEFINED:
                if (this.fakes.length > 0) 
                    loc1 = this.fakes.pop();
        }
        return loc1;
    }

    public function clearUp(arg1:net.wg.gui.lobby.techtree.sub.ResearchItems):void
    {
        this.clearVector(arg1, this.items);
        this.clearVector(arg1, this.vehicles);
        this.clearVector(arg1, this.fakes);
        return;
    }

    internal function clearVector(arg1:net.wg.gui.lobby.techtree.sub.ResearchItems, arg2:__AS3__.vec.Vector.<net.wg.gui.lobby.techtree.interfaces.IRenderer>):void
    {
        var loc1:*=null;
        while (arg2.length > 0) 
        {
            loc1 = arg2.pop();
            arg1.cleanUpRenderer(loc1);
            arg1.rGraphics.removeRenderer(loc1);
        }
        return;
    }

    internal var items:__AS3__.vec.Vector.<net.wg.gui.lobby.techtree.interfaces.IRenderer>;

    internal var vehicles:__AS3__.vec.Vector.<net.wg.gui.lobby.techtree.interfaces.IRenderer>;

    internal var fakes:__AS3__.vec.Vector.<net.wg.gui.lobby.techtree.interfaces.IRenderer>;
}