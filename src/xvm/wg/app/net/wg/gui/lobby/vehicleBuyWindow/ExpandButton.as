package net.wg.gui.lobby.vehicleBuyWindow
{
    import net.wg.gui.components.controls.SoundButton;
    
    public class ExpandButton extends SoundButton
    {
        
        public function ExpandButton()
        {
            super();
        }
        
        private var _expanded:Boolean = false;
        
        public function get expanded() : Boolean
        {
            return this._expanded;
        }
        
        public function set expanded(param1:Boolean) : void
        {
            this._expanded = param1;
            setState("up");
        }
        
        override public function set label(param1:String) : void
        {
            if(_label == param1)
            {
                return;
            }
            _label = param1;
        }
        
        override protected function getStatePrefixes() : Vector.<String>
        {
            var _loc1_:Vector.<String> = new Vector.<String>();
            if(this._expanded)
            {
                _loc1_.push("expanded_");
            }
            else if(_selected)
            {
                _loc1_.push("selected_");
                _loc1_.push("");
            }
            else
            {
                _loc1_.push("");
            }
            
            return _loc1_;
        }
    }
}
