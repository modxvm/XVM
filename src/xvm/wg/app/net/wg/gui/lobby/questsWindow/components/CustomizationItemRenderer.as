package net.wg.gui.lobby.questsWindow.components
{
    import scaleform.clik.core.UIComponent;
    import net.wg.gui.components.controls.UILoaderAlt;
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
            addEventListener(MouseEvent.ROLL_OVER,this.onRollOver);
            addEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
        }
        
        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.DATA))
            {
                this.loader.source = this.data.texture;
            }
        }
        
        override protected function onDispose() : void
        {
            this._data = null;
            this.loader.dispose();
            this.loader = null;
            super.onDispose();
        }
        
        private function onRollOver(param1:MouseEvent) : void
        {
            this.toolTipMgr.showSpecial(Tooltips.CUSTOMIZATION_ITEM,null,this.data.type,this.data.id,this.data.nationId,this.data.isPermanent?0:this.data.value);
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
