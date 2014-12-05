package net.wg.gui.lobby.fortifications.cmp.build.impl
{
    import flash.display.MovieClip;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.events.MouseEvent;
    import flash.text.TextField;
    import net.wg.gui.components.controls.StatusIndicatorAnim;
    import net.wg.gui.lobby.fortifications.data.BuildingIndicatorsVO;
    import net.wg.gui.lobby.fortifications.data.BuildingProgressLblVO;
    
    public class BuildingIndicatorsCmp extends MovieClip implements IDisposable
    {
        
        public function BuildingIndicatorsCmp()
        {
            super();
            this.hpProgress.callback = this.updateHpLabel;
            this.defResProgress.callback = this.updateResLabel;
        }
        
        private static function onRollOutHandler(param1:MouseEvent) : void
        {
            App.toolTipMgr.hide();
        }
        
        public var hpLbl:TextField;
        
        public var defResLbl:TextField;
        
        public var hpProgress:StatusIndicatorAnim;
        
        public var defResProgress:StatusIndicatorAnim;
        
        public var hpProgressLabels:ProgressTotalLabels;
        
        public var defResLabels:ProgressTotalLabels;
        
        public var hpToolTipArea:MovieClip;
        
        public var defResToolTipArea:MovieClip;
        
        private var model:BuildingIndicatorsVO;
        
        private var _invokeFirstTime:Boolean = true;
        
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
            this.defResProgress.maximum = this.model.defResTotalValue;
            if(this._invokeFirstTime)
            {
                this.hpProgress.useAnim = false;
                this.defResProgress.useAnim = false;
                this._invokeFirstTime = false;
            }
            else
            {
                this.hpProgress.useAnim = true;
                this.defResProgress.useAnim = true;
            }
            this.hpProgress.value = this.model.hpCurrentValue;
            this.defResProgress.value = this.model.defResCurrentValue;
        }
        
        private function updateHpLabel() : void
        {
            if(this.model)
            {
                this.model.hpProgressLabels.currentValue = App.utils.locale.integer(this.hpProgress.value);
                this.updateLabel(this.hpProgressLabels,this.model.hpProgressLabels);
            }
        }
        
        private function updateResLabel() : void
        {
            if(this.model)
            {
                this.model.defResProgressLabels.currentValue = App.utils.locale.integer(this.defResProgress.value);
                this.updateLabel(this.defResLabels,this.model.defResProgressLabels);
            }
        }
        
        private function updateLabel(param1:ProgressTotalLabels, param2:BuildingProgressLblVO) : void
        {
            param1.setData = param2;
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
