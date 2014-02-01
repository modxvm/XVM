package net.wg.gui.lobby.techtree.sub
{
   import scaleform.clik.core.UIComponent;
   import net.wg.gui.lobby.techtree.interfaces.IResearchContainer;
   import net.wg.infrastructure.interfaces.entity.IFocusContainer;
   import flash.utils.getDefinitionByName;
   import net.wg.gui.lobby.techtree.helpers.TitleAppearance;
   import net.wg.gui.lobby.techtree.interfaces.IResearchDataProvider;
   import net.wg.gui.lobby.techtree.math.ADG_ItemLevelsBuilder;
   import __AS3__.vec.Vector;
   import net.wg.gui.lobby.techtree.interfaces.IRenderer;
   import net.wg.gui.lobby.techtree.interfaces.IResearchPage;
   import net.wg.gui.lobby.techtree.controls.ResearchTitleBar;
   import net.wg.gui.lobby.techtree.helpers.ResearchGraphics;
   import net.wg.gui.lobby.techtree.controls.PremiumLayout;
   import flash.display.Sprite;
   import net.wg.gui.lobby.techtree.nodes.ResearchRoot;
   import net.wg.gui.lobby.techtree.controls.ExperienceInformation;
   import net.wg.gui.lobby.techtree.TechTreeEvent;
   import flash.display.InteractiveObject;
   import net.wg.gui.lobby.techtree.data.vo.NodeData;
   import net.wg.gui.lobby.techtree.constants.NodeState;
   import net.wg.gui.lobby.techtree.math.MatrixPosition;
   import net.wg.gui.lobby.techtree.helpers.NodeIndexFilter;
   import net.wg.gui.lobby.techtree.data.ResearchVODataProvider;
   import scaleform.clik.constants.InvalidationType;
   import net.wg.gui.lobby.techtree.data.vo.VehGlobalStats;
   import net.wg.gui.lobby.techtree.constants.NodeEntityType;
   import flash.display.DisplayObject;
   import net.wg.gui.lobby.techtree.nodes.FakeNode;
   import flash.geom.Point;
   import net.wg.gui.lobby.techtree.data.vo.ResearchDisplayInfo;
   import net.wg.infrastructure.events.FocusRequestEvent;
   import net.wg.gui.lobby.techtree.data.vo.UnlockProps;


   public class ResearchItems extends UIComponent implements IResearchContainer, IFocusContainer
   {
          
      public function ResearchItems() {
         super();
      }

      private static function getNodeDefinitionByName(param1:String) : Class {
         var name:String = param1;
         if(name == "")
         {
            return null;
         }
         var classRef:Class = null;
         try
         {
            classRef = getDefinitionByName(name) as Class;
         }
         catch(error:*)
         {
            trace("error",error.message);
            throw new Error("The class " + name + " cannot be found in your library. Please ensure it exists.");
         }
         return classRef;
      }

      private var titleAppearance:TitleAppearance = null;

      private var drawEnabled:Boolean = false;

      private var requestInCoolDown:Boolean = false;

      private var _vehicleNodeClass:Class = null;

      private var _itemNodeClass:Class = null;

      private var _fakeNodeClass:Class = null;

      private var _dataProvider:IResearchDataProvider;

      private var _levelsBuilder:ADG_ItemLevelsBuilder;

      private var positionByID:Object;

      private var renderers:Vector.<Vector.<IRenderer>>;

      private var topRenderers:Vector.<IRenderer>;

      public var yRatio:Number = 90;

      public var xRatio:Number = 90;

      public var topLevelX:Number = 10;

      public var nextLevelX:Number = 800;

      public var maxNodesOnLevel:Number = 10;

      public var titleDefaultY:Number = 0;

      public var view:IResearchPage;

      public var titleBar:ResearchTitleBar;

      public var rGraphics:ResearchGraphics;

      public var premiumLayout:PremiumLayout;

      public var background:Sprite;

      public function set vehicleNodeName(param1:String) : void {
         var _loc2_:Class = getNodeDefinitionByName(param1);
         if(_loc2_ != null)
         {
            this._vehicleNodeClass = _loc2_;
            invalidate();
         }
      }

      public function set itemNodeName(param1:String) : void {
         var _loc2_:Class = getNodeDefinitionByName(param1);
         if(_loc2_ != null)
         {
            this._itemNodeClass = _loc2_;
            invalidate();
         }
      }

      public function set fakeNodeName(param1:String) : void {
         var _loc2_:Class = getNodeDefinitionByName(param1);
         if(_loc2_ != null)
         {
            this._fakeNodeClass = _loc2_;
            invalidate();
         }
      }

      public function get rootRenderer() : ResearchRoot {
         return this.rGraphics != null?this.rGraphics.rootRenderer:null;
      }

      public function get xpInfo() : ExperienceInformation {
         return this.rGraphics != null?this.rGraphics.xpInfo:null;
      }

      public function get dataProvider() : IResearchDataProvider {
         return this._dataProvider;
      }

      public function set dataProvider(param1:IResearchDataProvider) : void {
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

      public function getComponentForFocus() : InteractiveObject {
         return this;
      }

      override protected function onDispose() : void {
         visible = false;
         this.removeItemRenderers();
         this.view = null;
         NodeData.setDisplayInfoClass(null);
         if(this.titleAppearance != null)
         {
            this.titleAppearance.clearUp();
            this.titleAppearance = null;
         }
         if(this.rGraphics != null)
         {
            this.rGraphics.removeReferences();
         }
         if(this.premiumLayout != null)
         {
            this.premiumLayout.dispose();
         }
         if(this.titleBar != null)
         {
            this.titleBar.removeEventListener(TechTreeEvent.RETURN_2_TECHTREE,this.handleReturn2TechTree);
            this.titleBar.dispose();
         }
         if(this._dataProvider != null)
         {
            this._dataProvider.removeEventListener(TechTreeEvent.DATA_BUILD_COMPLETE,this.handleDataComplete);
            this._dataProvider.clearUp();
            this._dataProvider = null;
         }
         super.onDispose();
      }

      public function invalidateNodesData(param1:String, param2:Object) : void {
         this.drawEnabled = false;
         this._dataProvider.invalidate(param1,param2);
      }

      public function setNodesStates(param1:Number, param2:Array, param3:String=null) : void {
         var _loc5_:Array = null;
         var _loc6_:* = false;
         var _loc7_:IRenderer = null;
         var _loc8_:* = NaN;
         var _loc9_:* = NaN;
         var _loc4_:Number = param2.length;
         var _loc10_:Number = 0;
         while(_loc10_ < _loc4_)
         {
            _loc5_ = param2[_loc10_];
            _loc8_ = _loc5_[0];
            _loc7_ = null;
            _loc6_ = false;
            _loc9_ = this._dataProvider.getIndexByID(_loc8_);
            if(_loc9_ > -1 && this._dataProvider.length > _loc9_)
            {
               if(param3 != null)
               {
                  this._dataProvider.setItemField(param3,_loc9_,_loc5_[2]);
               }
               _loc6_ = this._dataProvider.setState(_loc9_,param1,_loc5_[1]);
               _loc7_ = this.getNodeByID(_loc8_);
            }
            else
            {
               _loc9_ = this._dataProvider.getTopLevelIndexByID(_loc8_);
               if(_loc9_ > -1 && this._dataProvider.topLength > _loc9_)
               {
                  if(param3 != null)
                  {
                     this._dataProvider.setTopLevelField(param3,_loc9_,_loc5_[2]);
                  }
                  _loc6_ = this._dataProvider.setTopLevelState(_loc9_,param1,_loc5_[1]);
                  _loc7_ = this.getNodeByID(_loc8_);
               }
            }
            if((_loc6_) && !(_loc7_ == null))
            {
               _loc7_.invalidateNodeState(param1);
            }
            _loc10_++;
         }
      }

      public function setVehicleTypeXP(param1:Array) : void {
         var _loc3_:Array = null;
         var _loc4_:IRenderer = null;
         var _loc5_:* = NaN;
         var _loc6_:* = NaN;
         var _loc2_:Number = param1.length;
         var _loc7_:Number = 0;
         while(_loc7_ < _loc2_)
         {
            _loc3_ = param1[_loc7_];
            _loc5_ = _loc3_[0];
            _loc4_ = null;
            _loc6_ = this._dataProvider.getIndexByID(_loc5_);
            if(_loc6_ > -1 && this._dataProvider.length > _loc6_)
            {
               this._dataProvider.setEarnedXP(_loc6_,_loc3_[1]);
               _loc4_ = this.getNodeByID(_loc5_);
            }
            else
            {
               _loc6_ = this._dataProvider.getTopLevelIndexByID(_loc5_);
               if(_loc6_ > -1 && this._dataProvider.topLength > _loc6_)
               {
                  this._dataProvider.setTopLevelXP(_loc6_,_loc3_[1]);
                  _loc4_ = this.getNodeByID(_loc5_);
               }
            }
            if(_loc4_ != null)
            {
               _loc4_.invalidateNodeState(0);
            }
            _loc7_++;
         }
      }

      public function setFreeXP(param1:Number) : void {
         if(this.xpInfo != null)
         {
            this.xpInfo.setFreeXP(param1);
         }
      }

      public function setWalletStatus() : void {
         if(this.xpInfo != null)
         {
            this.xpInfo.setWalletStatus();
         }
      }

      public function getRootState() : Number {
         return this._dataProvider.length > 0?this._dataProvider.getItemAt(0).state:0;
      }

      public function getRootNode() : IRenderer {
         return this.rootRenderer;
      }

      public function hasUnlockedParent(param1:Number, param2:Number) : Boolean {
         var _loc4_:IRenderer = null;
         var _loc3_:Array = this._levelsBuilder.getParentLevelIdxs(param2);
         var _loc5_:Number = 0;
         while(_loc5_ < _loc3_.length)
         {
            _loc4_ = this.renderers[param1][_loc3_[_loc5_]];
            if(!(_loc4_ == null) && (_loc4_.isUnlocked()))
            {
               return true;
            }
            _loc5_++;
         }
         return false;
      }

      public function isParentUnlocked(param1:Number, param2:Number) : Boolean {
         var _loc3_:Number = 0;
         var _loc4_:Number = this._dataProvider.getIndexByID(param1);
         if(_loc4_ > -1 && this._dataProvider.length > _loc4_)
         {
            _loc3_ = this._dataProvider.getItemAt(_loc4_).state;
         }
         else
         {
            _loc4_ = this._dataProvider.getTopLevelIndexByID(param1);
            if(_loc4_ > -1 && this._dataProvider.topLength > _loc4_)
            {
               _loc3_ = this._dataProvider.getTopLevelAt(_loc4_).state;
            }
         }
         return (_loc3_ & NodeState.UNLOCKED) > 0;
      }

      public function getNation() : String {
         return this._dataProvider.nation;
      }

      public function canInstallItems() : Boolean {
         return (this.rootRenderer.inInventory()) && (this._dataProvider.getGlobalStats().enableInstallItems);
      }

      public function getNodeByID(param1:Number) : IRenderer {
         var _loc2_:MatrixPosition = this.positionByID[param1];
         var _loc3_:IRenderer = null;
         if(_loc2_.column == -1)
         {
            _loc3_ = this.topRenderers[_loc2_.row];
         }
         else
         {
            _loc3_ = this.renderers[_loc2_.row][_loc2_.column];
         }
         return _loc3_;
      }

      public function getTopLevel() : Vector.<IRenderer> {
         return this.topRenderers;
      }

      public function getChildren(param1:IRenderer) : Vector.<IRenderer> {
         var _loc2_:Vector.<IRenderer> = null;
         var _loc4_:NodeIndexFilter = null;
         var _loc3_:Number = param1.matrixPosition.row + 1;
         if(_loc3_ < this.renderers.length)
         {
            _loc4_ = new NodeIndexFilter(this._levelsBuilder.getChildrenLevelIdxs(param1.index));
            _loc2_ = Vector.<IRenderer>(this.renderers[_loc3_].filter(_loc4_.doFilter,_loc4_));
         }
         else
         {
            _loc2_ = new Vector.<IRenderer>();
         }
         return _loc2_;
      }

      public function getParents(param1:IRenderer) : Vector.<IRenderer> {
         var _loc2_:Vector.<IRenderer> = null;
         var _loc4_:NodeIndexFilter = null;
         var _loc3_:Number = param1.matrixPosition.row-1;
         if(_loc3_ > 0 && _loc3_ < this.renderers.length)
         {
            _loc4_ = new NodeIndexFilter(this._levelsBuilder.getParentLevelIdxs(param1.index));
            _loc2_ = Vector.<IRenderer>(this.renderers[_loc3_].filter(_loc4_.doFilter,_loc4_));
         }
         else
         {
            _loc2_ = new Vector.<IRenderer>();
         }
         return _loc2_;
      }

      public function isRootUnlocked() : Boolean {
         return this.rootRenderer != null?this.rootRenderer.isUnlocked():false;
      }

      public function cleanUpRenderer(param1:IRenderer) : void {
         if(param1 == null)
         {
            return;
         }
         param1.cleanUp();
         param1.removeEventListener(TechTreeEvent.CLICK_2_UNLOCK,this.handleUnlockItem);
         param1.removeEventListener(TechTreeEvent.CLICK_2_BUY,this.handleBuyItem);
         param1.removeEventListener(TechTreeEvent.CLICK_2_SELL,this.handleSellItem);
         param1.removeEventListener(TechTreeEvent.CLICK_2_SELECT_IN_HANGAR,this.handleSelectVehicleInHangar);
         param1.removeEventListener(TechTreeEvent.CLICK_2_SHOW_VEHICLE_STATS,this.handleShowVehicleInStats);
         param1.removeEventListener(TechTreeEvent.CLICK_2_OPEN,this.handleOpenVehicle);
         param1.removeEventListener(TechTreeEvent.CLICK_2_INSTALL,this.handleInstallItem);
         param1.removeEventListener(TechTreeEvent.CLICK_2_VEHICLE_INFO,this.handleRequestVehicleInfo);
         param1.removeEventListener(TechTreeEvent.CLICK_2_MODULE_INFO,this.handleRequestModuleInfo);
      }

      override protected function initialize() : void {
         super.initialize();
         this._dataProvider = new ResearchVODataProvider();
         this._dataProvider.addEventListener(TechTreeEvent.DATA_BUILD_COMPLETE,this.handleDataComplete,false,0,true);
         this._levelsBuilder = null;
         this.renderers = new Vector.<Vector.<IRenderer>>();
         this.topRenderers = new Vector.<IRenderer>();
         this.positionByID = {};
         if(this.rGraphics != null)
         {
            this.rGraphics.container = this;
         }
      }

      override protected function configUI() : void {
         this.titleAppearance = new TitleAppearance(this.titleBar);
         this.setupVehicleRenderer(this.rootRenderer,true);
         if(this.titleBar != null)
         {
            this.titleBar.addEventListener(TechTreeEvent.RETURN_2_TECHTREE,this.handleReturn2TechTree,false,0,true);
         }
         if(this.rGraphics != null)
         {
            this.rGraphics.xRatio = this.xRatio >> 1;
         }
         super.configUI();
      }

      override protected function draw() : void {
         if(isInvalid(InvalidationType.SIZE))
         {
            this.updateLayouts();
         }
         if(!this.drawEnabled)
         {
            return;
         }
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            if(this.rGraphics != null)
            {
               this.rGraphics.setup();
            }
            if(this.drawRenderers())
            {
               this.drawLines();
            }
            this.drawEnabled = false;
            if(this.view != null)
            {
               this.view.onResearchItemsDrawnS();
            }
         }
      }

      protected function updateLayouts() : void {
         if(this.titleAppearance != null)
         {
            this.titleAppearance.updateInResearch(_width,App.appHeight,this.titleDefaultY);
         }
         if(this.rGraphics != null)
         {
            this.rGraphics.y = this.titleDefaultY-1 + (_height >> 1);
         }
         if(this.premiumLayout != null)
         {
            this.premiumLayout.height = _height;
         }
         if(this.background != null)
         {
            this.background.height = _height;
         }
      }

      private function updateRootData() : Boolean {
         var _loc2_:NodeData = null;
         var _loc3_:VehGlobalStats = null;
         var _loc4_:String = null;
         var _loc5_:MatrixPosition = null;
         var _loc6_:* = false;
         var _loc1_:* = false;
         if(this._levelsBuilder.nodesByLevel[0][1] != null)
         {
            trace("ERROR: In zero level must has one node only.");
         }
         else
         {
            if(!this.rootRenderer)
            {
               trace("ERROR: Root renderer must be on display list.");
            }
            else
            {
               trace("Sets root data.");
               _loc1_ = true;
               _loc2_ = this._dataProvider.getRootItem();
               _loc3_ = this._dataProvider.getGlobalStats();
               _loc4_ = this._dataProvider.nation;
               _loc5_ = new MatrixPosition(0,0);
               this.renderers[0][0] = this.rootRenderer;
               this.positionByID[_loc2_.id] = new MatrixPosition(0,0);
               this.rootRenderer.setup(0,_loc2_,0,_loc5_);
               this.rootRenderer.setupEx(_loc3_.statusString);
               this.rootRenderer.validateNowEx();
               _loc6_ = this.rootRenderer.isPremium();
               if(this.titleBar != null)
               {
                  this.titleBar.setNation(_loc3_.hasNationTree?_loc4_:"");
                  this.titleBar.setTitle(_loc6_?"":_loc2_.longName);
               }
               if(this.xpInfo != null)
               {
                  this.xpInfo.setFreeXP(_loc3_.freeXP);
               }
               if(_loc6_)
               {
                  if(!this.premiumLayout)
                  {
                     this.premiumLayout = PremiumLayout.show(this);
                  }
               }
               else
               {
                  this.premiumLayout = null;
               }
            }
         }
         return _loc1_;
      }

      private function createRenderersMatrix() : Vector.<Vector.<IRenderer>> {
         var _loc1_:MatrixPosition = this._levelsBuilder.levelDimension;
         var _loc2_:Vector.<Vector.<IRenderer>> = new Vector.<Vector.<IRenderer>>(_loc1_.row);
         var _loc3_:Number = 0;
         while(_loc3_ < _loc1_.row)
         {
            _loc2_[_loc3_] = new Vector.<IRenderer>(_loc1_.column);
            _loc3_++;
         }
         return _loc2_;
      }

      private function flushRenderersOnScene() : RenderersOnScene {
         var _loc1_:Vector.<IRenderer> = null;
         var _loc2_:IRenderer = null;
         var _loc5_:* = NaN;
         var _loc3_:RenderersOnScene = new RenderersOnScene();
         var _loc4_:Number = 1;
         while(_loc4_ < this.renderers.length)
         {
            _loc1_ = this.renderers[_loc4_];
            _loc5_ = 0;
            while(_loc5_ < _loc1_.length)
            {
               _loc2_ = _loc1_[_loc5_];
               if(_loc2_ != null)
               {
                  this.rGraphics.clearUpRenderer(_loc2_);
                  this.rGraphics.clearLinesAndArrows(_loc2_);
                  _loc3_.addRenderer(_loc2_);
               }
               _loc5_++;
            }
            _loc4_++;
         }
         return _loc3_;
      }

      private function createItemRenderer(param1:uint) : IRenderer {
         var _loc2_:IRenderer = null;
         switch(param1)
         {
            case NodeEntityType.TOP_VEHICLE:
            case NodeEntityType.NEXT_VEHICLE:
               _loc2_ = new this._vehicleNodeClass();
               this.setupVehicleRenderer(_loc2_);
               break;
            case NodeEntityType.RESEARCH_ITEM:
               _loc2_ = new this._itemNodeClass();
               this.setupItemRenderer(_loc2_);
               break;
            case NodeEntityType.UNDEFINED:
               _loc2_ = new this._fakeNodeClass();
               break;
         }
         return _loc2_;
      }

      private function setupItemRenderer(param1:IRenderer) : void {
         if(param1 == null)
         {
            return;
         }
         param1.container = this;
         param1.addEventListener(TechTreeEvent.CLICK_2_UNLOCK,this.handleUnlockItem,false,0,true);
         param1.addEventListener(TechTreeEvent.CLICK_2_BUY,this.handleBuyItem,false,0,true);
         param1.addEventListener(TechTreeEvent.CLICK_2_SELL,this.handleSellItem,false,0,true);
         param1.addEventListener(TechTreeEvent.CLICK_2_INSTALL,this.handleInstallItem,false,0,true);
         param1.addEventListener(TechTreeEvent.CLICK_2_MODULE_INFO,this.handleRequestModuleInfo,false,0,true);
      }

      private function setupVehicleRenderer(param1:IRenderer, param2:Boolean=false) : void {
         if(param1 == null)
         {
            return;
         }
         param1.container = this;
         param1.addEventListener(TechTreeEvent.CLICK_2_UNLOCK,this.handleUnlockItem,false,0,true);
         param1.addEventListener(TechTreeEvent.CLICK_2_BUY,this.handleBuyItem,false,0,true);
         param1.addEventListener(TechTreeEvent.CLICK_2_SELL,this.handleSellItem,false,0,true);
         param1.addEventListener(TechTreeEvent.CLICK_2_SELECT_IN_HANGAR,this.handleSelectVehicleInHangar,false,0,true);
         param1.addEventListener(TechTreeEvent.CLICK_2_SHOW_VEHICLE_STATS,this.handleShowVehicleInStats,false,0,true);
         param1.addEventListener(TechTreeEvent.CLICK_2_VEHICLE_INFO,this.handleRequestVehicleInfo,false,0,true);
         if(!param2)
         {
            param1.addEventListener(TechTreeEvent.CLICK_2_OPEN,this.handleOpenVehicle,false,0,true);
         }
      }

      private function removeItemRenderers() : void {
         var _loc1_:Vector.<IRenderer> = null;
         while(this.topRenderers.length > 0)
         {
            this.cleanUpRenderer(this.topRenderers.pop());
         }
         while(this.renderers.length > 0)
         {
            _loc1_ = this.renderers.pop();
            while(_loc1_.length > 0)
            {
               this.cleanUpRenderer(_loc1_.pop());
            }
         }
         if(this.rGraphics != null)
         {
            this.rGraphics.clearUp();
         }
         this.positionByID = {};
      }

      private function updateTopRenderers() : void {
         var _loc2_:IRenderer = null;
         var _loc3_:MatrixPosition = null;
         var _loc4_:NodeData = null;
         var _loc1_:Number = this._dataProvider.topLength;
         var _loc5_:* = false;
         while(this.topRenderers.length > _loc1_)
         {
            _loc2_ = this.topRenderers.pop();
            this.cleanUpRenderer(_loc2_);
            if(this.rGraphics != null)
            {
               this.rGraphics.removeRenderer(_loc2_);
            }
         }
         var _loc6_:Number = 0;
         while(_loc6_ < _loc1_)
         {
            if(_loc6_ < this.topRenderers.length)
            {
               _loc5_ = false;
               _loc2_ = this.topRenderers[_loc6_];
               if(this.rGraphics != null)
               {
                  this.rGraphics.clearUpRenderer(_loc2_);
                  this.rGraphics.clearLinesAndArrows(_loc2_);
               }
            }
            else
            {
               _loc5_ = true;
               _loc2_ = this.createItemRenderer(NodeEntityType.TOP_VEHICLE);
            }
            if(_loc2_ != null)
            {
               _loc3_ = new MatrixPosition(_loc6_,-1);
               _loc4_ = this._dataProvider.getTopLevelAt(_loc6_);
               this.positionByID[_loc4_.id] = _loc3_;
               _loc2_.setup(_loc6_,_loc4_,NodeEntityType.TOP_VEHICLE,_loc3_);
               _loc2_.validateNowEx();
               if(_loc5_)
               {
                  this.topRenderers.push(_loc2_);
                  this.rGraphics.addChild(DisplayObject(_loc2_));
               }
            }
            _loc6_++;
         }
      }

      private function updateRenderers(param1:RenderersOnScene) : void {
         var _loc2_:IRenderer = null;
         var _loc3_:MatrixPosition = null;
         var _loc4_:Object = null;
         var _loc5_:NodeData = null;
         var _loc7_:Array = null;
         var _loc10_:* = NaN;
         var _loc11_:* = NaN;
         var _loc12_:* = NaN;
         var _loc14_:uint = 0;
         var _loc15_:Vector.<IRenderer> = null;
         var _loc16_:Vector.<IRenderer> = null;
         var _loc17_:Object = null;
         var _loc18_:Object = null;
         var _loc19_:FakeNode = null;
         var _loc20_:IRenderer = null;
         var _loc21_:IRenderer = null;
         var _loc6_:Array = this._levelsBuilder.nodesByLevel;
         var _loc8_:Vector.<FakeNode> = new Vector.<FakeNode>();
         var _loc9_:Number = _loc6_.length;
         var _loc13_:* = false;
         _loc11_ = 1;
         while(_loc11_ < _loc9_)
         {
            _loc7_ = _loc6_[_loc11_];
            _loc10_ = _loc7_.length;
            _loc12_ = 0;
            while(_loc12_ < _loc10_)
            {
               _loc4_ = _loc7_[_loc12_];
               if(_loc4_ != null)
               {
                  _loc5_ = null;
                  _loc13_ = false;
                  if(-1 < _loc4_.index && _loc4_.index < this._dataProvider.length)
                  {
                     _loc5_ = this._dataProvider.getItemAt(_loc4_.index);
                  }
                  _loc14_ = this._dataProvider.resolveEntityType(_loc5_);
                  _loc3_ = new MatrixPosition(_loc11_,_loc12_);
                  _loc2_ = param1.getRenderer(_loc14_);
                  if(_loc2_ == null)
                  {
                     _loc13_ = true;
                     _loc2_ = this.createItemRenderer(_loc14_);
                  }
                  if(_loc2_ != null)
                  {
                     this.renderers[_loc11_][_loc12_] = _loc2_;
                     if(_loc5_ != null)
                     {
                        this.positionByID[_loc5_.id] = _loc3_;
                     }
                     _loc2_.setup(_loc4_.index,_loc5_,_loc14_,_loc3_);
                     if(_loc2_.isFake())
                     {
                        _loc8_.push(_loc2_ as FakeNode);
                     }
                     _loc2_.validateNowEx();
                     if(_loc13_)
                     {
                        this.rGraphics.addChild(DisplayObject(_loc2_));
                     }
                  }
               }
               _loc12_++;
            }
            _loc11_++;
         }
         param1.clearUp(this);
         _loc9_ = _loc8_.length;
         _loc11_ = 0;
         while(_loc11_ < _loc9_)
         {
            _loc19_ = _loc8_[_loc11_];
            _loc15_ = new Vector.<IRenderer>();
            _loc17_ = this._levelsBuilder.getChildrenLevelIdxs(_loc19_.index);
            _loc12_ = 0;
            while(_loc12_ < _loc17_.length)
            {
               _loc20_ = this.renderers[_loc19_.matrixPosition.row + 1][_loc17_[_loc12_]];
               if(_loc20_ != null)
               {
                  _loc15_.push(_loc20_);
               }
               _loc12_++;
            }
            _loc19_.setChildren(_loc15_);
            _loc16_ = new Vector.<IRenderer>();
            _loc18_ = this._levelsBuilder.getParentLevelIdxs(_loc19_.index);
            _loc12_ = 0;
            while(_loc12_ < _loc18_.length)
            {
               _loc21_ = this.renderers[_loc19_.matrixPosition.row-1][_loc18_[_loc12_]];
               if(_loc21_ != null)
               {
                  _loc16_.push(_loc21_);
               }
               _loc12_++;
            }
            _loc19_.setParents(_loc16_);
            _loc11_++;
         }
      }

      private function drawRenderers() : Boolean {
         if(this._levelsBuilder == null || this.rGraphics == null)
         {
            return false;
         }
         var _loc1_:* = false;
         var _loc2_:RenderersOnScene = this.flushRenderersOnScene();
         this.renderers = this.createRenderersMatrix();
         this.positionByID = {};
         if(this.updateRootData())
         {
            this.updateTopRenderers();
            this.updateRenderers(_loc2_);
            this.drawLayout();
            _loc1_ = true;
         }
         return _loc1_;
      }

      private function drawLayout() : void {
         var _loc5_:* = NaN;
         var _loc6_:* = NaN;
         var _loc7_:IRenderer = null;
         var _loc10_:Vector.<IRenderer> = null;
         var _loc11_:Point = null;
         var _loc14_:ResearchDisplayInfo = null;
         var _loc15_:* = NaN;
         var _loc1_:Object = this._levelsBuilder.levelDimension;
         var _loc2_:Number = this.rootRenderer.getY();
         var _loc3_:Number = this.rootRenderer.getOutX();
         var _loc4_:Number = (this.topRenderers.length-1) * this.yRatio;
         _loc5_ = 0;
         _loc6_ = _loc2_ - (_loc4_ >> 1);
         while(_loc5_ < this.topRenderers.length)
         {
            _loc7_ = this.topRenderers[_loc5_];
            _loc7_.x = this.topLevelX;
            _loc7_.y = _loc6_ - (_loc7_.getY() - _loc7_.y);
            _loc5_++;
            _loc6_ = _loc6_ + this.yRatio;
         }
         var _loc8_:Array = new Array(_loc1_.column);
         _loc4_ = (_loc1_.column-1) * this.yRatio;
         _loc8_[0] = _loc2_ - (_loc4_ >> 1);
         var _loc9_:Number = 1;
         while(_loc9_ < _loc1_.column)
         {
            _loc8_[_loc9_] = _loc8_[_loc9_-1] + this.yRatio;
            _loc9_++;
         }
         var _loc12_:Number = _loc3_ + this.xRatio;
         var _loc13_:Number = 0;
         _loc5_ = 1;
         while(_loc5_ < this.renderers.length)
         {
            _loc10_ = this.renderers[_loc5_];
            _loc15_ = 0;
            while(_loc15_ < _loc10_.length)
            {
               _loc7_ = _loc10_[_loc15_];
               if(_loc7_ != null)
               {
                  _loc14_ = _loc7_.getDisplayInfo() as ResearchDisplayInfo;
                  if(!(_loc14_ == null) && (_loc14_.isDrawVehicle()))
                  {
                     _loc11_ = new Point(this.nextLevelX,_loc8_[_loc15_] - _loc7_.getRatioY());
                  }
                  else
                  {
                     _loc11_ = new Point(_loc12_,_loc8_[_loc15_] - _loc7_.getRatioY());
                     _loc13_ = Math.max(_loc7_.getActualWidth(),_loc13_);
                  }
                  _loc7_.setPosition(_loc11_);
               }
               _loc15_++;
            }
            _loc12_ = _loc12_ + (this.xRatio + _loc13_);
            _loc5_++;
         }
      }

      private function drawLines() : void {
         var _loc1_:IRenderer = null;
         var _loc2_:Vector.<IRenderer> = null;
         var _loc4_:NodeIndexFilter = null;
         var _loc5_:* = NaN;
         var _loc6_:Vector.<IRenderer> = null;
         var _loc8_:* = NaN;
         var _loc3_:Boolean = this.isRootUnlocked();
         this.rGraphics.drawTopLevelLines(this.rootRenderer,this.topRenderers,false);
         var _loc7_:Number = 0;
         while(_loc7_ < this.renderers.length-1)
         {
            _loc2_ = this.renderers[_loc7_];
            _loc8_ = 0;
            while(_loc8_ < _loc2_.length)
            {
               _loc1_ = _loc2_[_loc8_];
               if(_loc1_ != null)
               {
                  _loc5_ = _loc1_.matrixPosition.row + 1;
                  _loc4_ = new NodeIndexFilter(this._levelsBuilder.getChildrenLevelIdxs(_loc1_.index));
                  _loc6_ = Vector.<IRenderer>(this.renderers[_loc5_].filter(_loc4_.doFilter,_loc4_));
                  this.rGraphics.drawOutgoingLines(_loc1_,_loc6_,false,_loc3_);
               }
               _loc8_++;
            }
            _loc7_++;
         }
      }

      private function getNodeDataByEvent(param1:TechTreeEvent) : NodeData {
         var _loc2_:NodeData = null;
         if(param1.entityType == NodeEntityType.TOP_VEHICLE)
         {
            _loc2_ = this._dataProvider.getTopLevelAt(param1.index);
         }
         else
         {
            _loc2_ = this._dataProvider.getItemAt(param1.index);
         }
         App.utils.asserter.assertNotNull(_loc2_,"Data of node not found by event = " + param1);
         return _loc2_;
      }

      private function activateCoolDown() : void {
         this.requestInCoolDown = true;
         App.utils.scheduler.scheduleTask(this.deactivateCoolDown,250);
      }

      private function deactivateCoolDown() : void {
         this.requestInCoolDown = false;
      }

      private function handleDataComplete(param1:TechTreeEvent) : void {
         this._levelsBuilder = new ADG_ItemLevelsBuilder(this._dataProvider.length,this.maxNodesOnLevel);
         this._dataProvider.populate(this._levelsBuilder);
         this._levelsBuilder.process();
         if(this._levelsBuilder.hasCyclicReference())
         {
            trace("ERROR: Has cyclic reference.");
            this.titleBar.setTitle("");
            if(this.view != null)
            {
               if(App.utils != null)
               {
                  this.view.showSystemMessageS("Error",App.utils.locale.makeString(SYSTEM_MESSAGES.UNLOCKS_DRAWFAILED));
               }
               this.view.onResearchItemsDrawnS();
            }
            return;
         }
         this.drawEnabled = true;
         invalidateData();
      }

      private function handleReturn2TechTree(param1:TechTreeEvent) : void {
         if(this.view != null)
         {
            this.view.goToTechTreeS(this._dataProvider.nation);
         }
      }

      private function handleRequestModuleInfo(param1:TechTreeEvent) : void {
         if(this.view != null)
         {
            App.utils.asserter.assert(NodeEntityType.isModuleType(param1.entityType),"Node is not module");
            this.view.requestModuleInfoS(this.getNodeDataByEvent(param1).id);
         }
      }

      private function handleRequestVehicleInfo(param1:TechTreeEvent) : void {
         if(this.view != null)
         {
            App.utils.asserter.assert(NodeEntityType.isVehicleType(param1.entityType),"Node is not vehicle");
            this.view.requestVehicleInfoS(this.getNodeDataByEvent(param1).id);
         }
      }

      private function handleOpenVehicle(param1:TechTreeEvent) : void {
         dispatchEvent(new FocusRequestEvent(FocusRequestEvent.REQUEST_FOCUS,this));
         if(this.view != null)
         {
            App.utils.asserter.assert(NodeEntityType.isVehicleType(param1.entityType),"Node is not vehicle");
            this.invalidateNodesData(this._dataProvider.nation,this.view.getResearchItemsDataS(this.getNodeDataByEvent(param1).id,true));
         }
      }

      private function handleUnlockItem(param1:TechTreeEvent) : void {
         var _loc2_:NodeData = null;
         var _loc3_:UnlockProps = null;
         if(!this.requestInCoolDown && !(this.view == null))
         {
            _loc2_ = this.getNodeDataByEvent(param1);
            _loc3_ = _loc2_.unlockProps;
            App.utils.asserter.assertNotNull(_loc3_,"Unlock information is not defined for node = " + param1.target);
            this.view.request4UnlockS(_loc2_.id,_loc3_.parentID,_loc3_.unlockIdx,_loc3_.xpCost);
            this.activateCoolDown();
         }
      }

      private function handleBuyItem(param1:TechTreeEvent) : void {
         if(!this.requestInCoolDown && !(this.view == null))
         {
            this.view.request4BuyS(this.getNodeDataByEvent(param1).id);
            this.activateCoolDown();
         }
      }

      private function handleSellItem(param1:TechTreeEvent) : void {
         if(!this.requestInCoolDown && !(this.view == null))
         {
            this.view.request4SellS(this.getNodeDataByEvent(param1).id);
            this.activateCoolDown();
         }
      }

      private function handleSelectVehicleInHangar(param1:TechTreeEvent) : void {
         if(!this.requestInCoolDown && !(this.view == null) && param1.index > -1)
         {
            this.view.request4SelectInHangarS(this.getNodeDataByEvent(param1).id);
            this.activateCoolDown();
         }
      }

      private function handleShowVehicleInStats(param1:TechTreeEvent) : void {
         if(!this.requestInCoolDown && !(this.view == null) && param1.index > -1)
         {
            this.view.request4ShowVehicleStatisticsS(this.getNodeDataByEvent(param1).id);
            this.activateCoolDown();
         }
      }

      private function handleInstallItem(param1:Object) : void {
         var _loc2_:NodeData = null;
         if(!this.requestInCoolDown && !(this.view == null))
         {
            App.utils.asserter.assert(NodeEntityType.isModuleType(param1.entityType),"Node is not module");
            _loc2_ = this._dataProvider.getItemAt(param1.index);
            App.utils.asserter.assertNotNull(_loc2_,"Data of node not found by event = " + param1);
            this.view.request4InstallS(_loc2_.id);
            this.activateCoolDown();
         }
      }
   }

}   import __AS3__.vec.Vector;
   import net.wg.gui.lobby.techtree.interfaces.IRenderer;
   import net.wg.gui.lobby.techtree.constants.NodeEntityType;
   import net.wg.gui.lobby.techtree.sub.ResearchItems;


   class RenderersOnScene extends Object
   {
          
      function RenderersOnScene() {
         super();
         this.items = new Vector.<IRenderer>();
         this.vehicles = new Vector.<IRenderer>();
         this.fakes = new Vector.<IRenderer>();
      }

      private var items:Vector.<IRenderer>;

      private var vehicles:Vector.<IRenderer>;

      private var fakes:Vector.<IRenderer>;

      public function addRenderer(param1:IRenderer) : void {
         switch(param1.getEntityType())
         {
            case NodeEntityType.NEXT_VEHICLE:
               this.vehicles.push(param1);
               break;
            case NodeEntityType.RESEARCH_ITEM:
               this.items.push(param1);
               break;
            case NodeEntityType.UNDEFINED:
               this.fakes.push(param1);
               break;
         }
      }

      public function getRenderer(param1:uint) : IRenderer {
         var _loc2_:IRenderer = null;
         switch(param1)
         {
            case NodeEntityType.NEXT_VEHICLE:
               if(this.vehicles.length > 0)
               {
                  _loc2_ = this.vehicles.pop();
               }
               break;
            case NodeEntityType.RESEARCH_ITEM:
               if(this.items.length > 0)
               {
                  _loc2_ = this.items.pop();
               }
               break;
            case NodeEntityType.UNDEFINED:
               if(this.fakes.length > 0)
               {
                  _loc2_ = this.fakes.pop();
               }
         }
         return _loc2_;
      }

      public function clearUp(param1:ResearchItems) : void {
         this.clearVector(param1,this.items);
         this.clearVector(param1,this.vehicles);
         this.clearVector(param1,this.fakes);
      }

      private function clearVector(param1:ResearchItems, param2:Vector.<IRenderer>) : void {
         var _loc3_:IRenderer = null;
         while(param2.length > 0)
         {
            _loc3_ = param2.pop();
            param1.cleanUpRenderer(_loc3_);
            param1.rGraphics.removeRenderer(_loc3_);
         }
      }
   }
