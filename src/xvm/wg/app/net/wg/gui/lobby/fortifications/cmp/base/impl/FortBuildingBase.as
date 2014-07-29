package net.wg.gui.lobby.fortifications.cmp.base.impl
{
    import flash.display.MovieClip;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    
    public class FortBuildingBase extends MovieClip implements IDisposable
    {
        
        public function FortBuildingBase()
        {
            super();
            buttonMode = true;
            useHandCursor = true;
        }
        
        private var _selected:Boolean = false;
        
        public function updateRollOutState() : void
        {
            this._selected = false;
            this.setState("out");
            App.toolTipMgr.hide();
        }
        
        public function updateRollOverState() : void
        {
            this._selected = false;
            this.setState("over");
        }
        
        public function setState(param1:String) : void
        {
            this.gotoAndPlay(param1);
        }
        
        public function dispose() : void
        {
        }
        
        public function set updatePressState(param1:Boolean) : void
        {
            this.setState(param1?"down":"up");
            this._selected = param1;
        }
        
        public function get selected() : Boolean
        {
            return this._selected;
        }
        
        public function set selected(param1:Boolean) : void
        {
            this._selected = param1;
            this.setState(this._selected?"down":"up");
        }
    }
}
