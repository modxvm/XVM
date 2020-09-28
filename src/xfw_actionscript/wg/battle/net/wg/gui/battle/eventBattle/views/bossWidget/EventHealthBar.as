package net.wg.gui.battle.eventBattle.views.bossWidget
{
    import net.wg.gui.battle.components.BattleUIComponent;
    import flash.display.Graphics;
    import flash.display.BitmapData;
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import net.wg.gui.battle.components.BattleAtlasSprite;
    import net.wg.data.constants.generated.BATTLEATLAS;

    public class EventHealthBar extends BattleUIComponent
    {

        private static const BG_PATTERN:String = "wt_hp_pattern_bg";

        private static const SHIELD_PATTERN:String = "wt_hp_pattern_shield";

        private static const HP_PATTERN:String = "wt_hp_pattern_health";

        private static const BASE_OFFSET:int = 3;

        public var hp:MovieClip = null;

        public var hpMask:MovieClip = null;

        public var hpBg:MovieClip = null;

        public var hpGlow:MovieClip = null;

        public var hpGradient:Sprite = null;

        public var shield:MovieClip = null;

        public var shieldMask:MovieClip = null;

        public var shieldBg:MovieClip = null;

        public var shieldGlow:MovieClip = null;

        public var shieldGradient:Sprite = null;

        public var ruler:BattleAtlasSprite = null;

        private var _progressBarWidth:int = 479;

        private var _hpRatio:Number = 1;

        private var _currentHpPercent:Number = 1;

        private var _bgPattern:BitmapData;

        private var _shieldPattern:BitmapData;

        private var _hpPattern:BitmapData;

        public function EventHealthBar()
        {
            super();
        }

        private static function redraw(param1:Graphics, param2:Number, param3:BitmapData) : void
        {
            param1.beginBitmapFill(param3,null,true);
            param1.drawRect(0,0,param2,param3.height);
            param1.endFill();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this._bgPattern = App.utils.classFactory.getObject(BG_PATTERN) as BitmapData;
            this._shieldPattern = App.utils.classFactory.getObject(SHIELD_PATTERN) as BitmapData;
            this._hpPattern = App.utils.classFactory.getObject(HP_PATTERN) as BitmapData;
            this.ruler.imageName = BATTLEATLAS.BOSS_WIDGET_RULER;
            this.updateLayout();
        }

        override protected function onDispose() : void
        {
            this.hp = null;
            this.hpBg = null;
            this.hpMask = null;
            this.hpGlow = null;
            this.hpGradient = null;
            this.shield = null;
            this.shieldBg = null;
            this.shieldMask = null;
            this.shieldGlow = null;
            this.shieldGradient = null;
            if(this._bgPattern)
            {
                this._bgPattern.dispose();
                this._bgPattern = null;
            }
            if(this._shieldPattern)
            {
                this._shieldPattern.dispose();
                this._shieldPattern = null;
            }
            if(this._hpPattern)
            {
                this._hpPattern.dispose();
                this._hpPattern = null;
            }
            this.ruler = null;
            super.onDispose();
        }

        public function setHp(param1:Number) : void
        {
            this._currentHpPercent = param1;
            this.updateMaskAndGlow();
        }

        private function updateMaskAndGlow() : void
        {
            if(this._currentHpPercent > this._hpRatio)
            {
                this.hpMask.width = this.hpGradient.width = this._hpRatio * this._progressBarWidth;
                this.shieldMask.width = this.shieldGradient.width = (this._currentHpPercent - this._hpRatio) * this._progressBarWidth - BASE_OFFSET;
                this.shieldGlow.visible = true;
                this.shieldGlow.x = this.shieldMask.x + this.shieldMask.width - BASE_OFFSET;
                this.hpGlow.visible = false;
            }
            else
            {
                this.hpMask.width = this._currentHpPercent * this._progressBarWidth;
                this.shieldMask.width = 0;
                this.shieldGlow.visible = false;
                this.hpGlow.visible = true;
                this.hpGlow.x = this.hpMask.width;
            }
        }

        private function updateLayout() : void
        {
            var _loc2_:* = NaN;
            var _loc1_:Number = this._progressBarWidth * (1 - this._hpRatio) - BASE_OFFSET;
            _loc2_ = this._progressBarWidth * this._hpRatio;
            if(this._bgPattern && this._hpPattern && this._shieldPattern)
            {
                redraw(this.hpBg.graphics,_loc2_,this._bgPattern);
                redraw(this.shieldBg.graphics,_loc1_,this._bgPattern);
                redraw(this.hp.graphics,_loc2_,this._hpPattern);
                redraw(this.shield.graphics,_loc1_,this._shieldPattern);
            }
            this.hpGradient.width = _loc2_;
            this.shieldGradient.width = _loc1_;
            this.shield.x = this.shieldMask.x = this.shieldBg.x = this.shieldGradient.x = _loc2_ + BASE_OFFSET;
            this.hpGlow.x = _loc2_ - BASE_OFFSET;
            this.shieldGlow.x = this.shieldMask.x + this.shieldMask.width - BASE_OFFSET;
        }

        override public function set width(param1:Number) : void
        {
            if(param1 != this._progressBarWidth)
            {
                this._progressBarWidth = param1;
                this.updateLayout();
                this.updateMaskAndGlow();
            }
        }

        public function get hpRatio() : Number
        {
            return this._hpRatio;
        }

        public function set hpRatio(param1:Number) : void
        {
            if(this._hpRatio != param1)
            {
                this._hpRatio = param1;
                this.updateLayout();
                this.updateMaskAndGlow();
            }
        }
    }
}
