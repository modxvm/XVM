package net.wg.gui.components.controls
{
    import flash.events.MouseEvent;
    import scaleform.clik.events.ButtonEvent;
    import net.wg.gui.lobby.header.BattleSelectDropDownVO;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.gui.components.controls.events.FancyRendererEvent;
    import net.wg.data.constants.SoundTypes;
    
    public class FightListItemRenderer extends SoundListItemRenderer
    {
        
        public function FightListItemRenderer() {
            super();
            soundType = SoundTypes.RNDR_NORMAL;
        }
        
        override protected function configUI() : void {
            super.configUI();
            addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver,false,0,true);
            addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut,false,0,true);
            addEventListener(MouseEvent.MOUSE_DOWN,this.onMousePress,false,0,true);
            addEventListener(ButtonEvent.CLICK,this.onButtonClick,false,0,true);
        }
        
        override protected function draw() : void {
            var _loc1_:BattleSelectDropDownVO = BattleSelectDropDownVO(data);
            if((isInvalid(InvalidationType.DATA)) && (data))
            {
                this.enabled = !_loc1_.disabled;
            }
            super.draw();
            if((isInvalid(InvalidationType.DATA)) && (data))
            {
                this.applyData(_loc1_);
            }
        }
        
        protected function applyData(param1:BattleSelectDropDownVO) : void {
            this.textField.text = param1.label;
        }
        
        private function onButtonClick(param1:ButtonEvent) : void {
            dispatchEvent(new FancyRendererEvent(FancyRendererEvent.RENDERER_CLICK,true));
        }
        
        protected function onMouseOver(param1:MouseEvent) : void {
            if(data.tooltip)
            {
                App.toolTipMgr.showComplex(this.data.tooltip);
            }
        }
        
        protected function onMouseOut(param1:MouseEvent) : void {
            App.toolTipMgr.hide();
        }
        
        protected function onMousePress(param1:MouseEvent) : void {
            App.toolTipMgr.hide();
        }
        
        override public function setData(param1:Object) : void {
            super.setData(param1);
            invalidateData();
        }
        
        override protected function setState(param1:String) : void {
            super.setState(param1);
        }
        
        override protected function onDispose() : void {
            removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
            removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
            removeEventListener(MouseEvent.MOUSE_DOWN,this.onMousePress);
            removeEventListener(ButtonEvent.CLICK,this.onButtonClick);
            super.onDispose();
        }
    }
}
