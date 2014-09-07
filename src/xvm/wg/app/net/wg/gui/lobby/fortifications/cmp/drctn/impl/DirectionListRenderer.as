package net.wg.gui.lobby.fortifications.cmp.drctn.impl
{
    import scaleform.clik.core.UIComponent;
    import flash.text.TextField;
    import net.wg.gui.components.controls.SoundButtonEx;
    import net.wg.gui.lobby.fortifications.data.DirectionVO;
    import scaleform.clik.events.ButtonEvent;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.gui.lobby.fortifications.events.DirectionEvent;
    
    public class DirectionListRenderer extends UIComponent
    {
        
        public function DirectionListRenderer()
        {
            super();
        }
        
        public var textField:TextField;
        
        public var closeBtn:SoundButtonEx;
        
        public var direction:DirectionCmp;
        
        public var statusTF:TextField;
        
        private var model:DirectionVO;
        
        override protected function configUI() : void
        {
            super.configUI();
            this.closeBtn.label = FORTIFICATIONS.FORTDIRECTIONSWINDOW_BUTTON_CLOSEDIRECTION;
            this.closeBtn.mouseEnabledOnDisabled = true;
            this.direction.labelVisible = false;
            this.direction.solidMode = false;
            this.direction.useDirectionBuildingTooltips = false;
            this.closeBtn.addEventListener(ButtonEvent.CLICK,this.onCloseClick);
        }
        
        override protected function onDispose() : void
        {
            this.closeBtn.removeEventListener(ButtonEvent.CLICK,this.onCloseClick);
            this.closeBtn.dispose();
            this.closeBtn = null;
            this.direction.dispose();
            this.direction = null;
            if(this.model)
            {
                this.model.dispose();
                this.model = null;
            }
            super.onDispose();
        }
        
        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.DATA))
            {
                if(this.model)
                {
                    this.setControlsVisible(true);
                    this.textField.text = this.model.fullName;
                    this.closeBtn.visible = this.model.closeButtonVisible;
                    this.closeBtn.enabled = this.model.canBeClosed;
                    this.closeBtn.tooltip = this.closeBtn.enabled?TOOLTIPS.FORTIFICATION_CLOSEDIRECTIONBUTTON_ACTIVE:TOOLTIPS.FORTIFICATION_CLOSEDIRECTIONBUTTON_INACTIVE;
                    if(this.model.hasBuildings)
                    {
                        this.direction.visible = true;
                        this.statusTF.visible = false;
                    }
                    else
                    {
                        this.direction.visible = false;
                        this.statusTF.visible = true;
                        this.statusTF.htmlText = this.model.isOpened?FORTIFICATIONS.FORTDIRECTIONSWINDOW_LABEL_NOBUILDINGS:FORTIFICATIONS.FORTDIRECTIONSWINDOW_LABEL_NOTOPENED;
                    }
                }
                else
                {
                    this.setControlsVisible(false);
                }
            }
        }
        
        public function setData(param1:DirectionVO) : void
        {
            this.model = param1;
            this.direction.setData(param1);
            invalidateData();
        }
        
        private function onCloseClick(param1:ButtonEvent) : void
        {
            dispatchEvent(new DirectionEvent(DirectionEvent.CLOSE_DIRECTION,this.model.uid));
        }
        
        private function setControlsVisible(param1:Boolean) : void
        {
            this.textField.visible = param1;
            this.closeBtn.visible = param1;
            this.direction.visible = param1;
        }
    }
}
