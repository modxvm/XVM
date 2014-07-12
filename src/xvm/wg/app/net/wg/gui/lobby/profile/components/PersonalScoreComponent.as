package net.wg.gui.lobby.profile.components
{
    import flash.display.Sprite;
    import flash.display.MovieClip;
    import flash.text.TextField;
    import flash.events.MouseEvent;
    import net.wg.data.constants.Tooltips;
    
    public class PersonalScoreComponent extends Sprite
    {
        
        public function PersonalScoreComponent() {
            super();
            this.tooltipHitArea.addEventListener(MouseEvent.ROLL_OVER,this.mouseRollOverHandler,false,0,true);
            this.tooltipHitArea.addEventListener(MouseEvent.ROLL_OUT,this.mouseRollOutHandler,false,0,true);
        }
        
        private static function hideToolTip() : void {
            App.toolTipMgr.hide();
        }
        
        public var tfPersonalScore:CenteredLineIconText;
        
        public var icon:MovieClip;
        
        public var tooltipHitArea:MovieClip;
        
        public var tfWarning:TextField;
        
        public function set description(param1:String) : void {
            this.tfPersonalScore.description = param1;
            this.tfPersonalScore.validateNow();
            this.layout();
        }
        
        public function set text(param1:String) : void {
            this.tfPersonalScore.visible = true;
            this.tfWarning.visible = false;
            this.tfPersonalScore.text = param1;
            this.tfPersonalScore.validateNow();
            this.layout();
        }
        
        public function showWarning(param1:String) : void {
            this.tfPersonalScore.visible = false;
            this.tfWarning.visible = true;
            this.tfWarning.visible = true;
            this.tfWarning.htmlText = param1;
        }
        
        private function layout() : void {
            this.tfPersonalScore.x = -this.tfPersonalScore.actualWidth >> 1;
        }
        
        private function disposeHandlers() : void {
            if(this.tooltipHitArea)
            {
                this.tooltipHitArea.removeEventListener(MouseEvent.ROLL_OVER,this.mouseRollOverHandler);
                this.tooltipHitArea.removeEventListener(MouseEvent.ROLL_OUT,this.mouseRollOutHandler);
            }
        }
        
        protected function mouseRollOutHandler(param1:MouseEvent) : void {
            hideToolTip();
        }
        
        protected function mouseRollOverHandler(param1:MouseEvent) : void {
            this.showToolTip();
        }
        
        protected function showToolTip() : void {
            App.toolTipMgr.showSpecial(Tooltips.GLOBAL_RATING,null);
        }
        
        public function dispose() : void {
            if(this.tfPersonalScore)
            {
                this.tfPersonalScore.parent.removeChild(this.tfPersonalScore);
                this.tfPersonalScore.dispose();
                this.tfPersonalScore = null;
            }
            if(this.icon)
            {
                this.icon.parent.removeChild(this.icon);
                this.icon = null;
            }
            this.disposeHandlers();
        }
    }
}
