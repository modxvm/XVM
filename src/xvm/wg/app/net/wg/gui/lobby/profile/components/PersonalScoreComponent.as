package net.wg.gui.lobby.profile.components 
{
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import net.wg.data.constants.*;
    
    public class PersonalScoreComponent extends flash.display.Sprite
    {
        public function PersonalScoreComponent()
        {
            super();
            this.tooltipHitArea.addEventListener(flash.events.MouseEvent.ROLL_OVER, this.mouseRollOverHandler, false, 0, true);
            this.tooltipHitArea.addEventListener(flash.events.MouseEvent.ROLL_OUT, this.mouseRollOutHandler, false, 0, true);
            return;
        }

        public function set description(arg1:String):void
        {
            this.tfPersonalScore.description = arg1;
            this.tfPersonalScore.validateNow();
            this.layout();
            return;
        }

        public function set text(arg1:String):void
        {
            this.tfPersonalScore.visible = true;
            this.tfWarning.visible = false;
            this.tfPersonalScore.text = arg1;
            this.tfPersonalScore.validateNow();
            this.layout();
            return;
        }

        public function showWarning(arg1:String):void
        {
            this.tfPersonalScore.visible = false;
            this.tfWarning.visible = true;
            this.tfWarning.visible = true;
            this.tfWarning.htmlText = arg1;
            return;
        }

        internal function layout():void
        {
            this.tfPersonalScore.x = -this.tfPersonalScore.actualWidth >> 1;
            return;
        }

        internal function disposeHandlers():void
        {
            this.tooltipHitArea.removeEventListener(flash.events.MouseEvent.ROLL_OVER, this.mouseRollOverHandler);
            this.tooltipHitArea.removeEventListener(flash.events.MouseEvent.ROLL_OUT, this.mouseRollOutHandler);
            return;
        }

        protected function mouseRollOutHandler(arg1:flash.events.MouseEvent):void
        {
            hideToolTip();
            return;
        }

        protected function mouseRollOverHandler(arg1:flash.events.MouseEvent):void
        {
            this.showToolTip();
            return;
        }

        protected function showToolTip():void
        {
            App.toolTipMgr.showSpecial(net.wg.data.constants.Tooltips.GLOBAL_RATING, null);
            return;
        }

        internal static function hideToolTip():void
        {
            App.toolTipMgr.hide();
            return;
        }

        public var tfPersonalScore:net.wg.gui.lobby.profile.components.CenteredLineIconText;

        public var background:flash.display.MovieClip;

        public var tooltipHitArea:flash.display.MovieClip;

        public var tfWarning:flash.text.TextField;
    }
}
