package net.wg.gui.lobby.epicBattles.components
{
    import net.wg.gui.components.controls.SoundButtonEx;
    import net.wg.gui.lobby.components.IconTextWrapper;
    import flash.display.Sprite;
    import flash.display.MovieClip;
    import net.wg.gui.lobby.epicBattles.data.EpicBattlesWidgetVO;
    import net.wg.infrastructure.managers.ITooltipMgr;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;

    public class EpicBattlesWidgetButton extends SoundButtonEx
    {

        public var abilityPoints:IconTextWrapper = null;

        public var metaLevelElement:EpicBattlesMetaLevel = null;

        public var abilityPointsBg:Sprite = null;

        public var prestigeGlow:MovieClip = null;

        public var roundGlowHover:MovieClip = null;

        private var _epicData:EpicBattlesWidgetVO = null;

        private var _toolTipMgr:ITooltipMgr;

        public function EpicBattlesWidgetButton()
        {
            this._toolTipMgr = App.toolTipMgr;
            super();
        }

        override protected function onDispose() : void
        {
            this.metaLevelElement.dispose();
            this.metaLevelElement = null;
            this.abilityPoints.dispose();
            this.abilityPoints = null;
            this.prestigeGlow.stop();
            this.prestigeGlow = null;
            this.roundGlowHover = null;
            this.abilityPointsBg = null;
            this._toolTipMgr = null;
            if(this._epicData)
            {
                this._epicData = null;
            }
            super.onDispose();
        }

        override protected function draw() : void
        {
            var _loc1_:* = false;
            super.draw();
            if(isInvalid(InvalidationType.DATA) && this._epicData != null)
            {
                _loc1_ = this._epicData.skillPoints > 0;
                this.roundGlowHover.visible = this.abilityPointsBg.visible = this.abilityPoints.visible = _loc1_;
                if(_loc1_)
                {
                    this.abilityPoints.setText(this._epicData.skillPoints.toString());
                }
                this.metaLevelElement.setData(this._epicData.epicMetaLevelIconData);
                if(this._epicData.canPrestige)
                {
                    this.prestigeGlow.visible = true;
                }
            }
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.prestigeGlow.visible = false;
            this.abilityPointsBg.visible = false;
            this.roundGlowHover.visible = false;
            this.prestigeGlow.mouseEnabled = this.prestigeGlow.mouseChildren = false;
            this.roundGlowHover.mouseEnabled = this.roundGlowHover.mouseChildren = false;
            this.abilityPointsBg.mouseEnabled = this.abilityPointsBg.mouseChildren = false;
            this.abilityPoints.mouseEnabled = this.abilityPoints.mouseChildren = false;
            this.metaLevelElement.mouseEnabled = this.metaLevelElement.mouseChildren = false;
            bgMc.mouseEnabled = bgMc.mouseChildren = false;
        }

        override protected function showTooltip() : void
        {
            this._toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.EPIC_META_LEVEL_PROGRESS_INFO,null);
        }

        public function setEpicData(param1:EpicBattlesWidgetVO) : void
        {
            this._epicData = param1;
            invalidateData();
        }
    }
}
