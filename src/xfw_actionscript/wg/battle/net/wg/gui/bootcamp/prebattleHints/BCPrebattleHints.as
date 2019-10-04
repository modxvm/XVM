package net.wg.gui.bootcamp.prebattleHints
{
    import net.wg.infrastructure.base.meta.impl.BCPrebattleHintsMeta;
    import net.wg.infrastructure.base.meta.IBCPrebattleHintsMeta;
    import net.wg.gui.bootcamp.prebattleHints.controls.CrosshairContainer;
    import net.wg.gui.bootcamp.prebattleHints.controls.HintContainer;
    import flash.display.Sprite;
    import net.wg.gui.battle.views.minimap.BaseMinimap;
    import net.wg.gui.battle.views.ticker.BattleTicker;
    import net.wg.gui.battle.views.minimap.events.MinimapEvent;
    import net.wg.gui.components.common.ticker.events.BattleTickerEvent;
    import scaleform.clik.utils.Constraints;
    import scaleform.clik.constants.ConstrainMode;
    import net.wg.gui.bootcamp.events.BootcampBattleEvent;
    import flash.display.DisplayObject;
    import net.wg.gui.components.common.ticker.Ticker;
    import flash.geom.Rectangle;
    import scaleform.clik.utils.ConstrainedElement;

    public class BCPrebattleHints extends BCPrebattleHintsMeta implements IBCPrebattleHintsMeta
    {

        private static const HINTS_VISIBILITY:String = "hintsVisibility";

        private static const MINIMAP_HINT_RIGHT_OFFSET:int = 10;

        private static const MINIMAP_HINT_BOTTOM_OFFSET:int = 70;

        private static const SCORE_HINT_TOP_OFFSET:int = 25;

        public var crosshairHint:CrosshairContainer = null;

        public var crewHint:HintContainer = null;

        public var modulesHint:HintContainer = null;

        public var hitpointsHint:HintContainer = null;

        public var teamsHint:HintContainer = null;

        public var scoreHint:HintContainer = null;

        public var minimapHint:HintContainer = null;

        public var consumablesHint:HintContainer = null;

        public var sizeMc:Sprite = null;

        private var _visible:Vector.<String>;

        private var _hidden:Vector.<String>;

        private var _minimap:BaseMinimap;

        private var _battleTicker:BattleTicker;

        public function BCPrebattleHints()
        {
            super();
        }

        override public function updateStage(param1:Number, param2:Number) : void
        {
            this.sizeMc.width = param1;
            this.sizeMc.height = param2;
            if(constraints)
            {
                constraints.update(param1,param2);
            }
        }

        override protected function onDispose() : void
        {
            constraints.removeAllElements();
            constraints.dispose();
            this.crosshairHint.dispose();
            this.crewHint.dispose();
            this.hitpointsHint.dispose();
            this.modulesHint.dispose();
            this.scoreHint.dispose();
            this.teamsHint.dispose();
            this.minimapHint.dispose();
            this.consumablesHint.dispose();
            constraints = null;
            this.crosshairHint = null;
            this.crewHint = null;
            this.hitpointsHint = null;
            this.modulesHint = null;
            this.scoreHint = null;
            this.teamsHint = null;
            this.minimapHint = null;
            this.consumablesHint = null;
            this.sizeMc = null;
            this._visible = null;
            this._hidden = null;
            if(this._minimap != null)
            {
                this._minimap.removeEventListener(MinimapEvent.SIZE_CHANGED,this.onMiniMapSizeChangedHandler);
                this._minimap = null;
            }
            if(this._battleTicker != null)
            {
                this._battleTicker.removeEventListener(BattleTickerEvent.SHOW,this.onBattleTickerShowHandler);
                this._battleTicker.removeEventListener(BattleTickerEvent.HIDE,this.onBattleTickerShowHandler);
                this._battleTicker = null;
            }
            super.onDispose();
        }

        override protected function configUI() : void
        {
            super.configUI();
            constraints = new Constraints(this,ConstrainMode.REFLOW);
            constraints.addElement(this.crosshairHint.name,this.crosshairHint,Constraints.CENTER_H | Constraints.CENTER_V);
            constraints.addElement(this.crewHint.name,this.crewHint,Constraints.BOTTOM | Constraints.LEFT);
            constraints.addElement(this.hitpointsHint.name,this.hitpointsHint,Constraints.BOTTOM | Constraints.LEFT);
            constraints.addElement(this.modulesHint.name,this.modulesHint,Constraints.BOTTOM | Constraints.LEFT);
            constraints.addElement(this.consumablesHint.name,this.consumablesHint,Constraints.BOTTOM | Constraints.CENTER_H);
            constraints.addElement(this.minimapHint.name,this.minimapHint,Constraints.BOTTOM | Constraints.RIGHT);
            constraints.addElement(this.scoreHint.name,this.scoreHint,Constraints.CENTER_H | Constraints.TOP);
            constraints.addElement(this.teamsHint.name,this.teamsHint,Constraints.LEFT | Constraints.TOP);
            this.crewHint.setLabel(BOOTCAMP.PREBATTLE_HINT_CREW);
            this.hitpointsHint.setLabel(BOOTCAMP.PREBATTLE_HINT_HP);
            this.modulesHint.setLabel(BOOTCAMP.PREBATTLE_HINT_MODULES);
            this.scoreHint.setLabel(BOOTCAMP.PREBATTLE_HINT_SCORE);
            this.minimapHint.setLabel(BOOTCAMP.PREBATTLE_HINT_MINIMAP);
            this.consumablesHint.setLabel(BOOTCAMP.PREBATTLE_HINT_CONSUMABLES);
            this.updateStage(App.appWidth,App.appHeight);
            dispatchEvent(new BootcampBattleEvent(BootcampBattleEvent.PREBATTLE_CREATED,true));
        }

        override protected function draw() : void
        {
            var _loc1_:* = 0;
            var _loc2_:uint = 0;
            var _loc3_:DisplayObject = null;
            super.draw();
            if(isInvalid(HINTS_VISIBILITY))
            {
                _loc1_ = this._visible.length;
                _loc2_ = 0;
                _loc2_ = 0;
                while(_loc2_ < _loc1_)
                {
                    _loc3_ = constraints.getElement(this._visible[_loc2_]).clip;
                    _loc3_.visible = true;
                    _loc2_++;
                }
                _loc1_ = this._hidden.length;
                _loc2_ = 0;
                while(_loc2_ < _loc1_)
                {
                    _loc3_ = constraints.getElement(this._hidden[_loc2_]).clip;
                    _loc3_.visible = false;
                    _loc2_++;
                }
            }
        }

        override protected function setHintsVisibility(param1:Vector.<String>, param2:Vector.<String>) : void
        {
            this._visible = param1;
            this._hidden = param2;
            invalidate(HINTS_VISIBILITY);
        }

        public function setBattleTickerComponent(param1:BattleTicker) : void
        {
            this._battleTicker = param1;
            this._battleTicker.addEventListener(BattleTickerEvent.SHOW,this.onBattleTickerShowHandler);
            this._battleTicker.addEventListener(BattleTickerEvent.HIDE,this.onBattleTickerShowHandler);
            this.updateScoreHintOffset();
        }

        public function setMinimapComponent(param1:BaseMinimap) : void
        {
            this._minimap = param1;
            this._minimap.addEventListener(MinimapEvent.SIZE_CHANGED,this.onMiniMapSizeChangedHandler);
            this.updateMinimapHint();
        }

        private function updateScoreHintOffset() : void
        {
            var _loc1_:int = this._battleTicker.visible?this._battleTicker.y + this._battleTicker.height + Ticker.TICKER_Y_PADDING:0;
            this.scoreHint.y = _loc1_ + SCORE_HINT_TOP_OFFSET;
        }

        private function updateMinimapHint() : void
        {
            var _loc1_:Rectangle = this._minimap.getMinimapRectBySizeIndex(this._minimap.currentSizeIndex);
            var _loc2_:ConstrainedElement = constraints.getElement(this.minimapHint.name);
            _loc2_.right = _loc1_.width + MINIMAP_HINT_RIGHT_OFFSET;
            _loc2_.bottom = _loc1_.height - MINIMAP_HINT_BOTTOM_OFFSET;
            constraints.update(this.sizeMc.width,this.sizeMc.height);
        }

        private function onBattleTickerShowHandler(param1:BattleTickerEvent) : void
        {
            this.updateScoreHintOffset();
        }

        private function onMiniMapSizeChangedHandler(param1:MinimapEvent) : void
        {
            this.updateMinimapHint();
        }
    }
}
