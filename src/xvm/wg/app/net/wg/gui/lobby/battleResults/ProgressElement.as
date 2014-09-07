package net.wg.gui.lobby.battleResults
{
    import scaleform.clik.core.UIComponent;
    import net.wg.gui.lobby.interfaces.ISubtaskComponent;
    import flash.events.MouseEvent;
    import net.wg.gui.components.controls.TextFieldShort;
    import flash.display.MovieClip;
    import net.wg.gui.lobby.questsWindow.components.ProgressQuestIndicator;
    import net.wg.data.VO.ProgressElementVO;
    import scaleform.clik.constants.InvalidationType;
    
    public class ProgressElement extends UIComponent implements ISubtaskComponent
    {
        
        public function ProgressElement()
        {
            super();
        }
        
        private static function hideTooltip(param1:MouseEvent) : void
        {
            App.toolTipMgr.hide();
        }
        
        public var progressTF:TextFieldShort;
        
        public var progressDiff:MovieClip;
        
        public var progressIndicator:ProgressQuestIndicator;
        
        public var data:ProgressElementVO = null;
        
        private var _showProgressDiffTooltip:Boolean = false;
        
        override protected function configUI() : void
        {
            super.configUI();
            this.progressDiff.addEventListener(MouseEvent.CLICK,hideTooltip);
            this.progressDiff.addEventListener(MouseEvent.ROLL_OUT,hideTooltip);
            this.progressDiff.addEventListener(MouseEvent.ROLL_OVER,this.showDiffTooltip);
        }
        
        override protected function onDispose() : void
        {
            this.progressDiff.removeEventListener(MouseEvent.CLICK,hideTooltip);
            this.progressDiff.removeEventListener(MouseEvent.ROLL_OUT,hideTooltip);
            this.progressDiff.removeEventListener(MouseEvent.ROLL_OVER,this.showDiffTooltip);
            this.progressTF.dispose();
            this.progressTF = null;
            this.progressDiff = null;
            this.progressIndicator.dispose();
            this.progressIndicator = null;
            if(this.data)
            {
                this.data.dispose();
                this.data = null;
            }
            super.onDispose();
        }
        
        public function setData(param1:Object) : void
        {
            this.data = new ProgressElementVO(param1);
            invalidateData();
        }
        
        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.DATA))
            {
                if(this.data)
                {
                    this.visible = true;
                    this.progressTF.label = this.data.description;
                    this.progressDiff.textField.text = this.data.progressDiff;
                    this._showProgressDiffTooltip = Boolean(this.data.progressDiff);
                    this.checkProgressIndicator();
                    setSize(this.width,this.progressTF.height);
                }
                else
                {
                    this.visible = false;
                    setSize(this.width,0);
                }
            }
        }
        
        private function checkProgressIndicator() : void
        {
            if(this.data.progrBarType)
            {
                this.progressIndicator.visible = true;
                this.progressIndicator.setValues(this.data.progrBarType,this.data.currentProgrVal,this.data.maxProgrVal);
                this.progressIndicator.setTooltip(this.data.progrTooltip);
                this.progressIndicator.validateNow();
            }
            else
            {
                this.progressIndicator.visible = false;
            }
        }
        
        public function disableLinkBtns(param1:Vector.<String>) : void
        {
        }
        
        private function showDiffTooltip(param1:MouseEvent) : void
        {
            if(this._showProgressDiffTooltip)
            {
                App.toolTipMgr.show(TOOLTIPS.QUESTS_PROGRESS_EARNEDINBATTLE);
            }
        }
    }
}
