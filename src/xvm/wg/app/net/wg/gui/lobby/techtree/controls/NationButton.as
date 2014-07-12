package net.wg.gui.lobby.techtree.controls
{
    import net.wg.gui.components.controls.SoundButton;
    import flash.events.MouseEvent;
    import flash.display.MovieClip;
    import net.wg.data.constants.SoundTypes;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.gui.utils.ComplexTooltipHelper;
    
    public class NationButton extends SoundButton
    {
        
        public function NationButton() {
            super();
        }
        
        private static function hideTooltip(param1:MouseEvent) : void {
            if(App.toolTipMgr != null)
            {
                App.toolTipMgr.hide();
            }
        }
        
        public var ico:MovieClip;
        
        public var icoAdd:MovieClip;
        
        override protected function onDispose() : void {
            removeEventListener(MouseEvent.ROLL_OVER,this.showTooltip,false);
            removeEventListener(MouseEvent.ROLL_OUT,hideTooltip,false);
            removeEventListener(MouseEvent.CLICK,hideTooltip,false);
            super.onDispose();
        }
        
        protected function defineSoundProps() : void {
            soundType = SoundTypes.TAB;
        }
        
        override protected function preInitialize() : void {
            super.preInitialize();
            this.defineSoundProps();
        }
        
        override protected function configUI() : void {
            super.configUI();
            addEventListener(MouseEvent.ROLL_OVER,this.showTooltip,false,0,true);
            addEventListener(MouseEvent.ROLL_OUT,hideTooltip,false,0,true);
            addEventListener(MouseEvent.CLICK,hideTooltip,false,0,true);
        }
        
        override protected function draw() : void {
            super.draw();
            if(!(_label == null) && (isInvalid(InvalidationType.DATA)))
            {
                if(this.ico != null)
                {
                    this.ico.gotoAndStop(_label);
                }
                if(this.icoAdd != null)
                {
                    this.icoAdd.gotoAndStop(_label);
                }
            }
        }
        
        override protected function handleMouseRelease(param1:MouseEvent) : void {
            if(!_selected)
            {
                super.handleMouseRelease(param1);
            }
        }
        
        private function showTooltip(param1:MouseEvent) : void {
            if(!(_label == null) && !_selected)
            {
                if(App.toolTipMgr != null)
                {
                    App.toolTipMgr.showComplex(new ComplexTooltipHelper().addHeader(TOOLTIPS.techtreepage_nations(_label),true).make());
                }
            }
        }
    }
}
