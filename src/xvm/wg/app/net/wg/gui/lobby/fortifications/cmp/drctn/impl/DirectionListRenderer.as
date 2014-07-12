package net.wg.gui.lobby.fortifications.cmp.drctn.impl
{
    import scaleform.clik.core.UIComponent;
    import flash.text.TextField;
    import net.wg.gui.components.controls.SoundButtonEx;
    import flash.display.Sprite;
    import net.wg.gui.lobby.fortifications.cmp.build.impl.BuildingThumbnail;
    import net.wg.gui.lobby.fortifications.data.DirectionVO;
    import scaleform.clik.events.ButtonEvent;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.gui.lobby.fortifications.events.DirectionEvent;
    
    public class DirectionListRenderer extends UIComponent
    {
        
        public function DirectionListRenderer() {
            super();
        }
        
        public var textField:TextField;
        
        public var closeBtn:SoundButtonEx;
        
        public var roadPic:Sprite;
        
        public var building1:BuildingThumbnail;
        
        public var building2:BuildingThumbnail;
        
        public var statusTF:TextField;
        
        private var model:DirectionVO;
        
        override protected function configUI() : void {
            super.configUI();
            this.closeBtn.label = FORTIFICATIONS.FORTDIRECTIONSWINDOW_BUTTON_CLOSEDIRECTION;
            this.closeBtn.addEventListener(ButtonEvent.CLICK,this.onCloseClick);
        }
        
        override protected function onDispose() : void {
            this.closeBtn.removeEventListener(ButtonEvent.CLICK,this.onCloseClick);
            this.closeBtn.dispose();
            this.closeBtn = null;
            this.building1.dispose();
            this.building1 = null;
            this.building2.dispose();
            this.building2 = null;
            this.roadPic = null;
            if(this.model)
            {
                this.model.dispose();
                this.model = null;
            }
            super.onDispose();
        }
        
        override protected function draw() : void {
            super.draw();
            if(isInvalid(InvalidationType.DATA))
            {
                if(this.model)
                {
                    this.setControlsVisible(true);
                    this.textField.text = this.model.name;
                    this.closeBtn.visible = this.model.closeButtonVisible;
                    this.closeBtn.enabled = this.model.canBeClosed;
                    this.closeBtn.tooltip = this.closeBtn.enabled?TOOLTIPS.FORTIFICATION_CLOSEDIRECTIONBUTTON_ACTIVE:TOOLTIPS.FORTIFICATION_CLOSEDIRECTIONBUTTON_INACTIVE;
                    if(this.model.hasBuildings)
                    {
                        this.building1.model = this.model.buildings[0];
                        if(this.model.buildings.length > 1)
                        {
                            this.building2.model = this.model.buildings[1];
                        }
                        else
                        {
                            this.building2.visible = false;
                        }
                        this.statusTF.visible = false;
                    }
                    else
                    {
                        this.roadPic.visible = false;
                        this.building1.visible = false;
                        this.building2.visible = false;
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
        
        public function setData(param1:DirectionVO) : void {
            this.model = param1;
            invalidateData();
        }
        
        private function onCloseClick(param1:ButtonEvent) : void {
            dispatchEvent(new DirectionEvent(DirectionEvent.CLOSE_DIRECTION,this.model.uid));
        }
        
        private function setControlsVisible(param1:Boolean) : void {
            this.textField.visible = param1;
            this.closeBtn.visible = param1;
            this.roadPic.visible = param1;
            this.building1.visible = param1;
            this.building2.visible = param1;
        }
    }
}
