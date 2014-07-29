package net.wg.gui.lobby.training
{
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.events.IEventDispatcher;
    import flash.events.MouseEvent;
    
    public class TooltipViewer extends Object implements IDisposable
    {
        
        public function TooltipViewer(param1:IEventDispatcher)
        {
            super();
            this._target = param1;
            this._target.addEventListener(MouseEvent.ROLL_OVER,this.show,false,0,true);
            this._target.addEventListener(MouseEvent.ROLL_OUT,this.hide,false,0,true);
        }
        
        private var _tooltip:String;
        
        private var _target:IEventDispatcher;
        
        private function hide(param1:MouseEvent) : void
        {
            if(App.toolTipMgr)
            {
                App.toolTipMgr.hide();
            }
        }
        
        private function show(param1:MouseEvent) : void
        {
            if((this._tooltip) && (App.toolTipMgr))
            {
                App.toolTipMgr.showComplex(this._tooltip);
            }
        }
        
        public function setTooltip(param1:String) : void
        {
            this._tooltip = param1;
        }
        
        public function dispose() : void
        {
            this._tooltip = null;
            this._target.removeEventListener(MouseEvent.ROLL_OVER,this.show);
            this._target.removeEventListener(MouseEvent.ROLL_OUT,this.hide);
            this._target = null;
        }
    }
}
