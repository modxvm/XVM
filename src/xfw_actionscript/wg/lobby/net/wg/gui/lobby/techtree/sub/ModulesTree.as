package net.wg.gui.lobby.techtree.sub
{
    import net.wg.infrastructure.base.UIComponentEx;
    import net.wg.gui.lobby.techtree.interfaces.IResearchContainer;
    import net.wg.infrastructure.interfaces.entity.IFocusContainer;
    import net.wg.gui.lobby.techtree.helpers.ModulesGraphics;
    import net.wg.gui.lobby.techtree.interfaces.IResearchDataProvider;
    import net.wg.gui.lobby.techtree.math.ADG_ItemLevelsBuilder;
    import net.wg.gui.lobby.techtree.interfaces.IRenderer;
    import net.wg.gui.lobby.techtree.TechTreeEvent;
    import net.wg.gui.lobby.techtree.data.ResearchVODataProvider;
    import net.wg.data.constants.Linkages;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.gui.lobby.techtree.helpers.NodeIndexFilter;
    import flash.display.InteractiveObject;
    import net.wg.gui.lobby.techtree.math.MatrixPosition;
    import net.wg.gui.lobby.techtree.data.vo.NodeData;
    import net.wg.gui.lobby.techtree.data.state.NodeStateCollection;
    import net.wg.gui.lobby.techtree.constants.NodeEntityType;
    import flash.geom.Point;
    import net.wg.gui.lobby.techtree.data.vo.ResearchDisplayInfo;
    import net.wg.gui.lobby.techtree.nodes.FakeNode;
    import net.wg.data.constants.Errors;
    import flash.display.DisplayObject;

    public class ModulesTree extends UIComponentEx implements IResearchContainer, IFocusContainer
    {

        private static const ERROR:String = "ERROR: ";

        private static const ZERO_LEVEL_ONE_NODE_ONLY:String = ERROR + "In zero level must has one node only.";

        private static const ROOT_RENDERER_ON_DISPLAY_LIST:String = ERROR + "Root renderer must be on display list.";

        private static const CYCLIC_REFERENCE_ERROR:String = ERROR + "Has cyclic reference.";

        private static const INV_RENDERERS_LINES_STATE:String = "invRenderersLines";

        public var yRatio:int = 90;

        public var xRatio:int = 90;

        public var topLevelOffset:int = -150;

        public var nextLevelOffset:int = 800;

        public var maxNodesOnLevel:int = 10;

        public var rGraphics:ModulesGraphics;

        protected var _dataProvider:IResearchDataProvider;

        private var _itemNodeClass:Class = null;

        private var _fakeNodeClass:Class = null;

        private var _drawEnabled:Boolean = false;

        private var _levelsBuilder:ADG_ItemLevelsBuilder;

        private var _positionByID:Object;

        private var _renderers:Vector.<Vector.<IRenderer>>;

        private var _onScene:RenderersOnScene = null;

        public function ModulesTree()
        {
            super();
        }

        override protected function onDispose() : void
        {
            visible = false;
            this.removeItemRenderers();
            this.rGraphics.dispose();
            this.rGraphics = null;
            App.utils.data.cleanupDynamicObject(this._positionByID);
            this._positionByID = null;
            if(this._onScene != null)
            {
                this._onScene.dispose();
                this._onScene = null;
            }
            if(this._dataProvider != null)
            {
                this._dataProvider.removeEventListener(TechTreeEvent.DATA_BUILD_COMPLETE,this.onDataProviderDataBuildCompleteHandler);
                this._dataProvider.dispose();
                this._dataProvider = null;
            }
            this._itemNodeClass = null;
            this._fakeNodeClass = null;
            this._levelsBuilder = null;
            super.onDispose();
        }

        override protected function initialize() : void
        {
            super.initialize();
            this._dataProvider = new ResearchVODataProvider();
            this._dataProvider.addEventListener(TechTreeEvent.DATA_BUILD_COMPLETE,this.onDataProviderDataBuildCompleteHandler,false,0,true);
            this._levelsBuilder = null;
            this._positionByID = {};
            this.rGraphics.arrowRenderer = Linkages.RESEARCH_ITEMS_ARROW;
            this.rGraphics.container = this;
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.rGraphics.setup();
            this.rGraphics.xRatio = this.xRatio >> 1;
            this.setupVehicleRenderer(this.rootRenderer,true);
        }

        override protected function draw() : void
        {
            super.draw();
            if(this._drawEnabled && isInvalid(InvalidationType.DATA))
            {
                if(this.drawRenderers())
                {
                    invalidate(InvalidationType.LAYOUT);
                }
                this._drawEnabled = false;
            }
            if(isInvalid(InvalidationType.LAYOUT))
            {
                this.updateLayout();
                invalidate(INV_RENDERERS_LINES_STATE);
            }
            if(isInvalid(InvalidationType.LAYOUT,InvalidationType.DATA))
            {
                this.onDrawComplete();
            }
            if(isInvalid(INV_RENDERERS_LINES_STATE))
            {
                this.drawLines();
            }
        }

        public function getChildren(param1:IRenderer) : Vector.<IRenderer>
        {
            var _loc2_:Vector.<IRenderer> = null;
            var _loc4_:NodeIndexFilter = null;
            var _loc3_:int = param1.matrixPosition.row + 1;
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

        public function getComponentForFocus() : InteractiveObject
        {
            return this;
        }

        public function getNation() : String
        {
            return this._dataProvider.nation;
        }

        public function getNodeByID(param1:int) : IRenderer
        {
            var _loc2_:MatrixPosition = this._positionByID[param1];
            return this.renderers[_loc2_.row][_loc2_.column];
        }

        public function getTopLevel() : Vector.<IRenderer>
        {
            return null;
        }

        public function hasUnlockedParent(param1:Number, param2:Number) : Boolean
        {
            var _loc4_:IRenderer = null;
            var _loc3_:Array = this._levelsBuilder.getParentLevelIdxs(param2);
            var _loc5_:int = _loc3_.length;
            var _loc6_:* = 0;
            while(_loc6_ < _loc5_)
            {
                _loc4_ = this.renderers[param1][_loc3_[_loc6_]];
                if(_loc4_ != null && _loc4_.isUnlocked())
                {
                    return true;
                }
                _loc6_++;
            }
            return false;
        }

        public function invalidateNodesData(param1:String, param2:Object) : NodeData
        {
            this._drawEnabled = false;
            this._dataProvider.invalidate(param1,param2);
            return this._dataProvider.getRootItem();
        }

        public function removeItemRenderer(param1:IRenderer) : void
        {
            if(param1 == null)
            {
                return;
            }
            this.rGraphics.removeRenderer(param1);
            param1.dispose();
        }

        protected function onDrawComplete() : void
        {
        }

        protected function updateLayouts() : void
        {
        }

        protected function updateRootData() : Boolean
        {
            var _loc2_:NodeData = null;
            var _loc3_:MatrixPosition = null;
            var _loc1_:* = false;
            if(this._levelsBuilder.nodesByLevel[0][1] != null)
            {
                DebugUtils.LOG_ERROR(ZERO_LEVEL_ONE_NODE_ONLY);
            }
            else if(!this.rootRenderer)
            {
                DebugUtils.LOG_ERROR(ROOT_RENDERER_ON_DISPLAY_LIST);
            }
            else
            {
                _loc1_ = true;
                _loc2_ = this._dataProvider.getRootItem();
                _loc3_ = new MatrixPosition(0,0);
                this.renderers[0][0] = this.rootRenderer;
                this._positionByID[_loc2_.id] = _loc3_;
                this.rootRenderer.setup(0,_loc2_,0,_loc3_);
            }
            return _loc1_;
        }

        protected function setupItemRenderer(param1:IRenderer) : void
        {
            if(param1 == null)
            {
                return;
            }
            param1.container = this;
            param1.addEventListener(TechTreeEvent.STATE_CHANGED,this.onRendererStateChangedHandler,false,0,true);
        }

        protected function setupVehicleRenderer(param1:IRenderer, param2:Boolean = false) : void
        {
            if(param1 == null)
            {
                return;
            }
            param1.container = this;
            param1.addEventListener(TechTreeEvent.STATE_CHANGED,this.onRendererStateChangedHandler,false,0,true);
        }

        private function onRendererStateChangedHandler(param1:TechTreeEvent) : void
        {
            if(NodeStateCollection.instance.isRedrawResearchLines(param1.nodeState))
            {
                invalidate(INV_RENDERERS_LINES_STATE);
            }
        }

        protected function onCircleReferenceDetected() : void
        {
        }

        protected function drawRenderers() : Boolean
        {
            if(this._levelsBuilder == null)
            {
                return false;
            }
            var _loc1_:* = false;
            this.flushRenderersOnScene();
            this.renderers = this.createRenderersMatrix();
            this._positionByID = {};
            if(this.updateRootData())
            {
                this.rootRenderer.validateNow();
                this.updateRenderers();
                this._onScene.clearUp(this);
                _loc1_ = true;
            }
            return _loc1_;
        }

        protected function createItemRenderer(param1:uint) : IRenderer
        {
            var _loc2_:IRenderer = null;
            switch(param1)
            {
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

        protected function drawLines() : void
        {
            var _loc1_:IRenderer = null;
            var _loc2_:Vector.<IRenderer> = null;
            var _loc3_:NodeIndexFilter = null;
            var _loc4_:* = 0;
            var _loc5_:Vector.<IRenderer> = null;
            var _loc7_:* = 0;
            var _loc8_:* = 0;
            this.rGraphics.clearLinesAndArrowsRenderers();
            var _loc6_:int = this.renderers.length;
            var _loc9_:* = 0;
            while(_loc9_ < _loc6_)
            {
                _loc2_ = this.renderers[_loc9_];
                _loc7_ = _loc2_.length;
                _loc8_ = 0;
                while(_loc8_ < _loc7_)
                {
                    _loc1_ = _loc2_[_loc8_];
                    if(_loc1_ != null)
                    {
                        _loc4_ = _loc1_.matrixPosition.row + 1;
                        if(_loc4_ < _loc6_)
                        {
                            _loc3_ = new NodeIndexFilter(this._levelsBuilder.getChildrenLevelIdxs(_loc1_.index));
                            _loc5_ = Vector.<IRenderer>(this.renderers[_loc4_].filter(_loc3_.doFilter,_loc3_));
                        }
                        this.rGraphics.buildRendererLines(_loc1_,_loc5_);
                        if(_loc5_)
                        {
                            _loc5_.splice(0,_loc5_.length);
                        }
                        _loc5_ = null;
                    }
                    _loc8_++;
                }
                _loc9_++;
            }
        }

        protected function updateLayout() : void
        {
            var _loc8_:Vector.<IRenderer> = null;
            var _loc9_:Point = null;
            var _loc12_:ResearchDisplayInfo = null;
            var _loc14_:* = 0;
            var _loc15_:IRenderer = null;
            var _loc17_:* = 0;
            var _loc18_:* = 0;
            var _loc1_:Object = this._levelsBuilder.levelDimension;
            var _loc2_:Number = this.rootRenderer.getY();
            var _loc3_:Number = this.rootRenderer.getOutX();
            var _loc4_:Array = new Array(_loc1_.column);
            var _loc5_:Number = (_loc1_.column - 1) * this.yRatio;
            _loc4_[0] = _loc2_ - (_loc5_ >> 1);
            var _loc6_:int = _loc1_.column;
            var _loc7_:* = 1;
            while(_loc7_ < _loc6_)
            {
                _loc4_[_loc7_] = _loc4_[_loc7_ - 1] + this.yRatio;
                _loc7_++;
            }
            var _loc10_:Number = _loc3_ + this.xRatio;
            var _loc11_:Number = 0;
            var _loc13_:Number = this.rootRenderer.getOutX() + this.nextLevelOffset;
            var _loc16_:int = this.renderers.length;
            _loc14_ = 1;
            while(_loc14_ < _loc16_)
            {
                _loc8_ = this.renderers[_loc14_];
                _loc17_ = _loc8_.length;
                _loc18_ = 0;
                while(_loc18_ < _loc17_)
                {
                    _loc15_ = _loc8_[_loc18_];
                    if(_loc15_ != null)
                    {
                        _loc12_ = _loc15_.getDisplayInfo() as ResearchDisplayInfo;
                        if(_loc12_ != null && _loc12_.isDrawVehicle())
                        {
                            _loc9_ = new Point(_loc13_,_loc4_[_loc18_] - _loc15_.getRatioY());
                        }
                        else
                        {
                            _loc9_ = new Point(_loc10_,_loc4_[_loc18_] - _loc15_.getRatioY());
                            _loc11_ = Math.max(_loc15_.getActualWidth(),_loc11_);
                        }
                        _loc15_.setPosition(_loc9_);
                    }
                    _loc18_++;
                }
                _loc10_ = _loc10_ + (this.xRatio + _loc11_);
                _loc14_++;
            }
        }

        private function createRenderersMatrix() : Vector.<Vector.<IRenderer>>
        {
            var _loc1_:MatrixPosition = this._levelsBuilder.levelDimension;
            var _loc2_:int = _loc1_.row;
            var _loc3_:Vector.<Vector.<IRenderer>> = new Vector.<Vector.<IRenderer>>(_loc2_);
            var _loc4_:* = 0;
            while(_loc4_ < _loc2_)
            {
                _loc3_[_loc4_] = new Vector.<IRenderer>(_loc1_.column);
                _loc4_++;
            }
            return _loc3_;
        }

        private function flushRenderersOnScene() : void
        {
            var _loc1_:Vector.<IRenderer> = null;
            var _loc2_:IRenderer = null;
            var _loc4_:* = 0;
            var _loc6_:* = 0;
            if(this._onScene == null)
            {
                this._onScene = new RenderersOnScene();
            }
            if(this.renderers == null)
            {
                return;
            }
            this.rGraphics.clearLinesAndArrowsRenderers();
            var _loc3_:int = this.renderers.length;
            var _loc5_:* = 1;
            while(_loc5_ < _loc3_)
            {
                _loc1_ = this.renderers[_loc5_];
                _loc6_ = _loc1_.length;
                _loc4_ = 0;
                while(_loc4_ < _loc6_)
                {
                    _loc2_ = _loc1_[_loc4_];
                    if(_loc2_ != null)
                    {
                        this.rGraphics.clearUpRenderer(_loc2_);
                        this._onScene.addRenderer(_loc2_);
                    }
                    _loc4_++;
                }
                _loc5_++;
            }
        }

        private function removeItemRenderers() : void
        {
            var _loc1_:Vector.<IRenderer> = null;
            var _loc3_:* = 0;
            var _loc4_:* = 0;
            var _loc2_:int = this._renderers.length;
            var _loc5_:* = 0;
            while(_loc5_ < _loc2_)
            {
                _loc1_ = this._renderers.pop();
                _loc3_ = _loc1_.length;
                _loc4_ = 0;
                while(_loc4_ < _loc3_)
                {
                    this.removeItemRenderer(_loc1_.pop());
                    _loc4_++;
                }
                _loc5_++;
            }
            this._renderers = null;
        }

        private function updateRenderers() : void
        {
            var _loc1_:IRenderer = null;
            var _loc2_:MatrixPosition = null;
            var _loc3_:Object = null;
            var _loc4_:NodeData = null;
            var _loc6_:Array = null;
            var _loc9_:* = NaN;
            var _loc10_:* = 0;
            var _loc11_:* = 0;
            var _loc13_:uint = 0;
            var _loc14_:Vector.<IRenderer> = null;
            var _loc15_:Vector.<IRenderer> = null;
            var _loc16_:Object = null;
            var _loc17_:Object = null;
            var _loc18_:FakeNode = null;
            var _loc19_:IRenderer = null;
            var _loc20_:IRenderer = null;
            var _loc21_:* = 0;
            var _loc22_:* = 0;
            var _loc23_:FakeNode = null;
            var _loc5_:Array = this._levelsBuilder.nodesByLevel;
            var _loc7_:Vector.<FakeNode> = new Vector.<FakeNode>();
            var _loc8_:int = _loc5_.length;
            var _loc12_:* = false;
            _loc10_ = 1;
            while(_loc10_ < _loc8_)
            {
                _loc6_ = _loc5_[_loc10_];
                _loc9_ = _loc6_.length;
                _loc11_ = 0;
                while(_loc11_ < _loc9_)
                {
                    _loc3_ = _loc6_[_loc11_];
                    if(_loc3_ != null)
                    {
                        _loc4_ = null;
                        _loc12_ = false;
                        if(0 < _loc3_.index && _loc3_.index < this._dataProvider.length)
                        {
                            _loc4_ = this._dataProvider.getItemAt(_loc3_.index);
                        }
                        _loc13_ = this._dataProvider.resolveEntityType(_loc4_);
                        _loc2_ = new MatrixPosition(_loc10_,_loc11_);
                        _loc1_ = this._onScene.getRenderer(_loc13_);
                        if(_loc1_ == null)
                        {
                            _loc12_ = true;
                            _loc1_ = this.createItemRenderer(_loc13_);
                        }
                        if(_loc1_ != null)
                        {
                            this.renderers[_loc10_][_loc11_] = _loc1_;
                            if(_loc4_ != null)
                            {
                                this._positionByID[_loc4_.id] = _loc2_;
                            }
                            _loc1_.setup(_loc3_.index,_loc4_,_loc13_,_loc2_);
                            _loc1_.validateNow();
                            if(_loc1_.isFake())
                            {
                                _loc23_ = _loc1_ as FakeNode;
                                App.utils.asserter.assertNotNull(_loc23_,"fakeNodeRenderer " + Errors.CANT_NULL);
                                _loc7_.push(_loc23_);
                            }
                            if(_loc12_)
                            {
                                this.rGraphics.addChild(DisplayObject(_loc1_));
                            }
                        }
                    }
                    _loc11_++;
                }
                _loc10_++;
            }
            _loc8_ = _loc7_.length;
            _loc10_ = 0;
            while(_loc10_ < _loc8_)
            {
                _loc18_ = _loc7_[_loc10_];
                _loc14_ = new Vector.<IRenderer>();
                _loc16_ = this._levelsBuilder.getChildrenLevelIdxs(_loc18_.index);
                _loc21_ = _loc16_.length;
                _loc11_ = 0;
                while(_loc11_ < _loc21_)
                {
                    _loc19_ = this.renderers[_loc18_.matrixPosition.row + 1][_loc16_[_loc11_]];
                    if(_loc19_ != null)
                    {
                        _loc14_.push(_loc19_);
                    }
                    _loc11_++;
                }
                _loc18_.setChildren(_loc14_);
                _loc15_ = new Vector.<IRenderer>();
                _loc17_ = this._levelsBuilder.getParentLevelIdxs(_loc18_.index);
                _loc22_ = _loc17_.length;
                _loc11_ = 0;
                while(_loc11_ < _loc22_)
                {
                    _loc20_ = this.renderers[_loc18_.matrixPosition.row - 1][_loc17_[_loc11_]];
                    if(_loc20_ != null)
                    {
                        _loc15_.push(_loc20_);
                    }
                    _loc11_++;
                }
                _loc18_.setParents(_loc15_);
                _loc10_++;
            }
        }

        public function get rootRenderer() : IRenderer
        {
            return this.rGraphics != null?IRenderer(this.rGraphics.rootRenderer):null;
        }

        public function get dataProvider() : IResearchDataProvider
        {
            return this._dataProvider;
        }

        public function set dataProvider(param1:IResearchDataProvider) : void
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

        public function set itemNodeClass(param1:Class) : void
        {
            if(this._itemNodeClass == param1)
            {
                return;
            }
            this._itemNodeClass = param1;
            invalidateData();
        }

        public function set fakeNodeClass(param1:Class) : void
        {
            if(this._fakeNodeClass == param1)
            {
                return;
            }
            this._fakeNodeClass = param1;
            invalidateData();
        }

        protected function get positionById() : Object
        {
            return this._positionByID;
        }

        private function get renderers() : Vector.<Vector.<IRenderer>>
        {
            return this._renderers;
        }

        private function set renderers(param1:Vector.<Vector.<IRenderer>>) : void
        {
            if(param1 == this._renderers)
            {
                return;
            }
            if(this._renderers != null)
            {
                this.renderers.splice(0,this.renderers.length);
            }
            this._renderers = param1;
        }

        private function onDataProviderDataBuildCompleteHandler(param1:TechTreeEvent) : void
        {
            this._levelsBuilder = new ADG_ItemLevelsBuilder(this._dataProvider.length,this.maxNodesOnLevel);
            this._dataProvider.populate(this._levelsBuilder);
            this._levelsBuilder.process();
            if(this._levelsBuilder.hasCyclicReference())
            {
                DebugUtils.LOG_ERROR(CYCLIC_REFERENCE_ERROR);
                this.onCircleReferenceDetected();
                return;
            }
            this._drawEnabled = true;
            invalidateData();
        }
    }
}

import net.wg.infrastructure.interfaces.entity.IDisposable;
import net.wg.gui.lobby.techtree.interfaces.IRenderer;
import net.wg.gui.lobby.techtree.constants.NodeEntityType;
import net.wg.gui.lobby.techtree.sub.ModulesTree;

class RenderersOnScene extends Object implements IDisposable
{

    private var _items:Vector.<IRenderer>;

    private var _vehicles:Vector.<IRenderer>;

    private var _fakes:Vector.<IRenderer>;

    function RenderersOnScene()
    {
        super();
        this._items = new Vector.<IRenderer>();
        this._vehicles = new Vector.<IRenderer>();
        this._fakes = new Vector.<IRenderer>();
    }

    public function addRenderer(param1:IRenderer) : void
    {
        switch(param1.entityType)
        {
            case NodeEntityType.NEXT_VEHICLE:
                this._vehicles.push(param1);
                break;
            case NodeEntityType.RESEARCH_ITEM:
                this._items.push(param1);
                break;
            case NodeEntityType.UNDEFINED:
                this._fakes.push(param1);
                break;
        }
    }

    public function clearUp(param1:ModulesTree) : void
    {
        this.clearVector(param1,this._items);
        this.clearVector(param1,this._vehicles);
        this.clearVector(param1,this._fakes);
    }

    public final function dispose() : void
    {
        this.onDispose();
    }

    public function getRenderer(param1:uint) : IRenderer
    {
        var _loc2_:IRenderer = null;
        switch(param1)
        {
            case NodeEntityType.NEXT_VEHICLE:
                if(this._vehicles.length > 0)
                {
                    _loc2_ = this._vehicles.shift();
                }
                break;
            case NodeEntityType.RESEARCH_ITEM:
                if(this._items.length > 0)
                {
                    _loc2_ = this._items.shift();
                }
                break;
            case NodeEntityType.UNDEFINED:
                if(this._fakes.length > 0)
                {
                    _loc2_ = this._fakes.shift();
                }
        }
        return _loc2_;
    }

    protected function onDispose() : void
    {
        this._vehicles.splice(0,this._vehicles.length);
        this._vehicles = null;
        this._items.splice(0,this._items.length);
        this._items = null;
        this._fakes.splice(0,this._fakes.length);
        this._fakes = null;
    }

    private function clearVector(param1:ModulesTree, param2:Vector.<IRenderer>) : void
    {
        var _loc3_:IRenderer = null;
        var _loc4_:int = param2.length;
        var _loc5_:* = 0;
        while(_loc5_ < _loc4_)
        {
            _loc3_ = param2.pop();
            param1.removeItemRenderer(_loc3_);
            _loc5_++;
        }
    }
}
