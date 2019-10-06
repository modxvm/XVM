package net.wg.gui.battle.views.ribbonsPanel
{
    import flash.display.MovieClip;
    import org.idmedia.as3commons.util.StringUtils;

    public class EfficiencyBonusAnimation extends MovieClip
    {

        private static const VALUE_OFFSET_X:int = -50;

        private var _isExtendedAnim:Boolean = true;

        private var _totalFrames:int = 0;

        public function EfficiencyBonusAnimation()
        {
            super();
            stop();
            visible = false;
            this._totalFrames = totalFrames;
        }

        public function setSettings(param1:Boolean) : void
        {
            this._isExtendedAnim = param1;
            gotoAndStop(this._totalFrames);
        }

        public function show() : void
        {
            if(this._isExtendedAnim && visible)
            {
                gotoAndPlay(1);
            }
        }

        public function update(param1:String, param2:Number) : void
        {
            visible = StringUtils.isNotEmpty(param1);
            if(visible)
            {
                this.x = param2 + VALUE_OFFSET_X | 0;
            }
        }
    }
}
