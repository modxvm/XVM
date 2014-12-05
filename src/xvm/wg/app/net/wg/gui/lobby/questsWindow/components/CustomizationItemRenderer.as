package net.wg.gui.lobby.questsWindow.components
{
    import scaleform.clik.core.UIComponent;
    import net.wg.gui.components.controls.UILoaderAlt;
    import flash.text.TextField;
    import flash.events.MouseEvent;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.data.constants.Tooltips;
    import net.wg.infrastructure.managers.ITooltipMgr;
    
    public class CustomizationItemRenderer extends UIComponent
    {
        
        public function CustomizationItemRenderer()
        {
            super();
        }
        
        public var loader:UILoaderAlt;
        
        private var _data:Object;
        
        private var _valueText:TextField;
        
        public function get data() : Object
        {
            return this._data;
        }
        
        public function set data(param1:Object) : void
        {
            this._data = param1;
            invalidateData();
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            this.loader.addEventListener(MouseEvent.ROLL_OVER,this.onRollOver);
            this.loader.addEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
        }
        
        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.DATA))
            {
                this.loader.source = this.data.texture;
                if(this.data.valueStr)
                {
                    this._valueText = new TextField();
                    this._valueText.selectable = false;
                    this._valueText.htmlText = this.data.valueStr;
                    this._valueText.x = Math.round(this.loader.originalWidth + 2);
                    this._valueText.y = Math.round(this.loader.originalHeight - this._valueText.textHeight);
                    this._valueText.width = this._valueText.textWidth + 4;
                    this._valueText.height = this._valueText.textHeight + 4;
                    addChild(this._valueText);
                }
            }
        }
        
        override protected function onDispose() : void
        {
            this._data = null;
            this.loader.removeEventListener(MouseEvent.ROLL_OVER,this.onRollOver);
            this.loader.removeEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
            this.loader.dispose();
            this.loader = null;
            if(this._valueText)
            {
                removeChild(this._valueText);
                this._valueText = null;
            }
            super.onDispose();
        }
        
        private function onRollOver(param1:MouseEvent) : void
        {
            this.toolTipMgr.showSpecial(Tooltips.CUSTOMIZATION_ITEM,null,this.data.type,this.data.id,this.data.nationId,this.data.isPermanent?0:this.data.value,this.data.isPermanent,this.data.isPermanent?1:0,false,this.data.boundVehicle,this.data.boundToCurrentVehicle);
        }
        
        private function onRollOut(param1:MouseEvent) : void
        {
            this.toolTipMgr.hide();
        }
        
        private function get toolTipMgr() : ITooltipMgr
        {
            return App.toolTipMgr;
        }
    }
}
