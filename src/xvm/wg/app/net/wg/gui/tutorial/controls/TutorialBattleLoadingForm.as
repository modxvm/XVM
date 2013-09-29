package net.wg.gui.tutorial.controls 
{
    import flash.text.*;
    import scaleform.clik.controls.*;
    import scaleform.clik.core.*;
    
    public class TutorialBattleLoadingForm extends scaleform.clik.core.UIComponent
    {
        public function TutorialBattleLoadingForm()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            return;
        }

        public function updateProgress(arg1:Number):void
        {
            this.loadingBar.position = arg1;
            return;
        }

        public function updateMapName(arg1:String):void
        {
            this.mapText.text = arg1 ? arg1.toUpperCase() : "";
            return;
        }

        public function updateBattleType(arg1:String):void
        {
            this.battleText.text = arg1;
            return;
        }

        public var mapText:flash.text.TextField;

        public var battleText:flash.text.TextField;

        public var loadingBar:scaleform.clik.controls.StatusIndicator;
    }
}
