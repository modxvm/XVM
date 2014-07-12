package net.wg.gui.lobby.techtree.controls
{
    import scaleform.clik.core.UIComponent;
    import net.wg.gui.lobby.techtree.interfaces.IHasRendererAsOwner;
    import net.wg.gui.lobby.techtree.interfaces.IRenderer;
    
    public class NodeComponent extends UIComponent implements IHasRendererAsOwner
    {
        
        public function NodeComponent() {
            super();
        }
        
        private var _state:String = "locked";
        
        protected var _owner:IRenderer = null;
        
        public function get state() : String {
            return this._state;
        }
        
        public function set state(param1:String) : void {
            if(this._state == param1)
            {
                return;
            }
            this._state = param1;
        }
        
        public function setOwner(param1:IRenderer, param2:Boolean = false) : void {
            if(this._owner != param1)
            {
                this._owner = param1;
            }
            invalidateData();
            if(param2)
            {
                validateNow();
            }
        }
        
        override protected function onDispose() : void {
            this._owner = null;
            super.onDispose();
        }
    }
}
