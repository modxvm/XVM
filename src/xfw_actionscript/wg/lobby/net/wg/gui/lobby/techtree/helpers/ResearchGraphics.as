package net.wg.gui.lobby.techtree.helpers
{
    import flash.display.BlendMode;
    import flash.display.Sprite;
    import net.wg.gui.lobby.techtree.interfaces.IRenderer;
    import net.wg.gui.lobby.techtree.interfaces.IResearchContainer;
    import flash.events.MouseEvent;
    import net.wg.gui.lobby.techtree.constants.NodeEntityType;
    import net.wg.gui.lobby.techtree.TechTreeEvent;
    import flash.geom.Point;
    import net.wg.gui.lobby.techtree.constants.ColorIndex;
    import net.wg.gui.lobby.techtree.data.state.NodeStateCollection;

    public class ResearchGraphics extends ModulesGraphics
    {

        private static const RESEARCH_ARROWS_BLEND_MODE:String = BlendMode.ADD;

        private static const LOCKED_LINE_COMP_NAME:String = "ResearchLineLocked";

        private static const LOCKED_LINES_COMP_NAME:String = "ResearchLinesLocked";

        private static const FADE_OUT_ARROW_LOCKED:String = "ResearchArrowDisFadeOut";

        private static const FADE_IN_ARROW_LOCKED:String = "ResearchArrowDisFadeIn";

        private static const FADE_IN_ARROW:String = "ResearchArrowFadeIn";

        private static const MAX_LEVEL:uint = 10;

        private static const MIN_LEVEL:uint = 1;

        private var _lockedOverlay:Sprite = null;

        public function ResearchGraphics()
        {
            super();
        }

        override public function buildRendererLines(param1:IRenderer, param2:Vector.<IRenderer>) : void
        {
            var _loc4_:Vector.<IRenderer> = null;
            var _loc5_:Sprite = null;
            super.buildRendererLines(param1,param2);
            var _loc3_:Object = null;
            if(param1 == rootRenderer)
            {
                _loc4_ = IResearchContainer(_container).getTopLevel();
                if(_loc4_.length > 1)
                {
                    this.drawIngoingLine(param1,_loc4_);
                }
                if(param1.isLocked() && _loc4_.length > 0)
                {
                    _loc3_ = {
                        "x":param1.getInX(),
                        "y":param1.getY()
                    };
                    this._lockedOverlay = App.utils.classFactory.getComponent(_loc4_.length == 1?LOCKED_LINE_COMP_NAME:LOCKED_LINES_COMP_NAME,Sprite,_loc3_);
                    this._lockedOverlay.addEventListener(MouseEvent.ROLL_OVER,this.onLockedRollOverHandler,false,0,true);
                    this._lockedOverlay.addEventListener(MouseEvent.ROLL_OUT,this.onLockedRollOutHandler,false,0,true);
                    getSubSprite(param1).addChild(this._lockedOverlay);
                }
            }
            else if(NodeEntityType.isVehicleType(param1.entityType) && param1.getLevel() < MAX_LEVEL)
            {
                _loc3_ = {
                    "x":param1.getOutX(),
                    "y":param1.getY()
                };
                _loc5_ = App.utils.classFactory.getComponent(FADE_OUT_ARROW_LOCKED,Sprite,_loc3_);
                getSubSprite(param1).addChild(_loc5_);
            }
            param1.addEventListener(TechTreeEvent.STATE_CHANGED,this.onRendererStateChangedHandler,false,0,true);
            setBlendMode(param1,RESEARCH_ARROWS_BLEND_MODE);
        }

        override public function clearLinesAndArrows(param1:IRenderer) : void
        {
            super.clearLinesAndArrows(param1);
            if(this._lockedOverlay != null && param1 == rootRenderer)
            {
                this._lockedOverlay.removeEventListener(MouseEvent.ROLL_OVER,this.onLockedRollOverHandler);
                this._lockedOverlay.removeEventListener(MouseEvent.ROLL_OUT,this.onLockedRollOutHandler);
                this._lockedOverlay = null;
            }
        }

        override public function clearUpRenderer(param1:IRenderer) : void
        {
            param1.removeEventListener(TechTreeEvent.STATE_CHANGED,this.onTopLevelRendererStateChangedHandler);
            param1.removeEventListener(TechTreeEvent.STATE_CHANGED,this.onRendererStateChangedHandler);
        }

        public function buildTopRenderersLines(param1:Vector.<IRenderer>) : void
        {
            var _loc2_:IRenderer = null;
            var _loc3_:Object = null;
            var _loc4_:Sprite = null;
            if(param1)
            {
                for each(_loc2_ in param1)
                {
                    this.clearLinesAndArrows(_loc2_);
                    this.drawTopRendererLine(_loc2_,param1.length == 1);
                    if(NodeEntityType.isVehicleType(_loc2_.entityType) && _loc2_.getLevel() > MIN_LEVEL)
                    {
                        _loc3_ = {
                            "x":_loc2_.getInX(),
                            "y":_loc2_.getY()
                        };
                        _loc4_ = App.utils.classFactory.getComponent(_loc2_.isLocked()?FADE_IN_ARROW_LOCKED:FADE_IN_ARROW,Sprite,_loc3_);
                        getSubSprite(_loc2_).addChild(_loc4_);
                    }
                    _loc2_.addEventListener(TechTreeEvent.STATE_CHANGED,this.onTopLevelRendererStateChangedHandler,false,0,true);
                    setBlendMode(_loc2_,RESEARCH_ARROWS_BLEND_MODE);
                }
            }
        }

        private function drawIngoingLine(param1:IRenderer, param2:Vector.<IRenderer>) : void
        {
            var _loc5_:uint = 0;
            var _loc3_:Point = new Point(param1.getInX(),param1.getY());
            var _loc4_:Point = new Point(param2[0].getOutX() + xRatio,_loc3_.y);
            if(rootRenderer.isNext2Unlock())
            {
                _loc5_ = ColorIndex.UNLOCKED;
            }
            else
            {
                _loc5_ = rootRenderer.getColorIndex();
            }
            if(!param1.isPremium())
            {
                drawLineAndArrow(param1,_colorIdxs[_loc5_],_loc4_,_loc3_);
            }
            else
            {
                drawLine(param1,_colorIdxs[_loc5_],_loc4_,_loc3_);
            }
        }

        private function drawTopRendererLine(param1:IRenderer, param2:Boolean = false) : void
        {
            var _loc6_:Point = null;
            var _loc3_:Point = new Point(param1.getOutX(),param1.getY());
            var _loc4_:Point = new Point(rootRenderer.getInX(),rootRenderer.getY());
            var _loc5_:uint = rootRenderer.getColorIndex(param1);
            if(_loc3_.y == _loc4_.y)
            {
                if(!param2)
                {
                    _loc4_.x = _loc3_.x + xRatio;
                }
                if(param2)
                {
                    drawLineAndArrow(param1,_colorIdxs[_loc5_],_loc3_,_loc4_);
                }
                else
                {
                    drawLine(param1,_colorIdxs[_loc5_],_loc3_,_loc4_);
                }
            }
            else
            {
                _loc6_ = new Point(_loc3_.x + xRatio,_loc3_.y);
                drawLine(param1,_colorIdxs[_loc5_],_loc3_,_loc6_);
                _loc3_ = _loc6_;
                _loc6_ = new Point(_loc3_.x,_loc4_.y);
                drawLine(param1,_colorIdxs[_loc5_],_loc3_,_loc6_);
                if(param2)
                {
                    drawLineAndArrow(param1,_colorIdxs[_loc5_],_loc6_,_loc4_);
                }
            }
        }

        private function onTopLevelRendererStateChangedHandler(param1:TechTreeEvent) : void
        {
            var _loc2_:IRenderer = null;
            if(NodeStateCollection.instance.isRedrawResearchLines(param1.nodeState))
            {
                _loc2_ = param1.target as IRenderer;
                if(_loc2_ != null)
                {
                    this.clearLinesAndArrows(_loc2_);
                    this.drawTopRendererLine(_loc2_,IResearchContainer(_container).getTopLevel().length == 1);
                    setBlendMode(_loc2_,RESEARCH_ARROWS_BLEND_MODE);
                }
            }
        }

        private function onRendererStateChangedHandler(param1:TechTreeEvent) : void
        {
            var _loc2_:IRenderer = null;
            var _loc3_:Vector.<IRenderer> = null;
            if(NodeStateCollection.instance.isRedrawResearchLines(param1.nodeState))
            {
                _loc2_ = param1.target as IRenderer;
                if(_loc2_ != null)
                {
                    _loc3_ = IResearchContainer(_container).getChildren(_loc2_);
                    this.buildRendererLines(_loc2_,_loc3_);
                    _loc3_.splice(0,_loc3_.length);
                    _loc3_ = null;
                }
            }
        }

        private function onLockedRollOverHandler(param1:MouseEvent) : void
        {
            App.toolTipMgr.showComplex(TOOLTIPS.RESEARCHPAGE_VEHICLE_STATUS_PARENTMODULEISLOCKED);
        }

        private function onLockedRollOutHandler(param1:MouseEvent) : void
        {
            App.toolTipMgr.hide();
        }
    }
}
