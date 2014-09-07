package net.wg.gui.lobby.fortifications.cmp.build.impl
{
    import flash.display.MovieClip;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.events.MouseEvent;
    import flash.text.TextField;
    import scaleform.clik.controls.StatusIndicator;
    import net.wg.gui.lobby.fortifications.data.BuildingIndicatorsVO;
    
    public class BuildingIndicatorsCmp extends MovieClip implements IDisposable
    {
        
        public function BuildingIndicatorsCmp()
        {
            super();
        }
        
        private static function onRollOutHandler(param1:MouseEvent) : void
        {
            App.toolTipMgr.hide();
        }
        
        public var hpLbl:TextField;
        
        public var defResLbl:TextField;
        
        public var hpProgress:StatusIndicator;
        
        public var defResProgress:StatusIndicator;
        
        public var hpProgressLabels:ProgressTotalLabels;
        
        public var defResLabels:ProgressTotalLabels;
        
        public var hpToolTipArea:MovieClip;
        
        public var defResToolTipArea:MovieClip;
        
        private var model:BuildingIndicatorsVO;
        
        public function dispose() : void
        {
            this.hpToolTipArea.removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
            this.hpToolTipArea.removeEventListener(MouseEvent.ROLL_OUT,onRollOutHandler);
            this.defResToolTipArea.removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
            this.defResToolTipArea.removeEventListener(MouseEvent.ROLL_OUT,onRollOutHandler);
            this.hpToolTipArea = null;
            this.defResToolTipArea = null;
            this.hpProgress.dispose();
            this.hpProgress = null;
            this.defResProgress.dispose();
            this.defResProgress = null;
            this.hpProgressLabels.dispose();
            this.hpProgressLabels = null;
            this.defResLabels.dispose();
            this.defResLabels = null;
            if(this.model)
            {
                this.model.dispose();
                this.model = null;
            }
        }
        
        public function setData(param1:BuildingIndicatorsVO) : void
        {
            this.model = param1;
            this.hpLbl.htmlText = this.model.hpLabel;
            this.defResLbl.htmlText = this.model.defResLabel;
            this.hpProgress.maximum = this.model.hpTotalValue;
            this.hpProgress.value = this.model.hpCurrentValue;
            this.defResProgress.maximum = this.model.defResTotalValue;
            this.defResProgress.value = this.model.defResCurrentValue;
            this.hpProgressLabels.setData = this.model.hpProgressLabels;
            this.defResLabels.setData = this.model.defResProgressLabels;
        }
        
        public function showToolTips(param1:Boolean) : void
        {
            if(param1)
            {
                this.hpToolTipArea.addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
                this.hpToolTipArea.addEventListener(MouseEvent.ROLL_OUT,onRollOutHandler);
                this.defResToolTipArea.addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
                this.defResToolTipArea.addEventListener(MouseEvent.ROLL_OUT,onRollOutHandler);
            }
        }
        
        private function onRollOverHandler(param1:MouseEvent) : void
        {
            if(param1.target == this.hpToolTipArea)
            {
                App.toolTipMgr.showComplex(TOOLTIPS.FORTIFICATION_POPOVER_HPPROGRESS);
            }
            else if(param1.target == this.defResToolTipArea)
            {
                App.toolTipMgr.showComplex(TOOLTIPS.FORTIFICATION_POPOVER_DEFRESPROGRESS);
            }
            
        }
    }
}
