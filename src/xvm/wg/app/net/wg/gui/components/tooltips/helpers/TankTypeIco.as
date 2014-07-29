package net.wg.gui.components.tooltips.helpers
{
    import scaleform.clik.core.UIComponent;
    
    public class TankTypeIco extends UIComponent
    {
        
        public function TankTypeIco()
        {
            super();
            stop();
        }
        
        private var _type:String = null;
        
        override protected function configUI() : void
        {
            super.configUI();
            gotoAndStop(1);
            this._labelHash;
        }
        
        override protected function draw() : void
        {
            super.draw();
            if(_labelHash[this.type])
            {
                gotoAndStop(this.type);
            }
        }
        
        public function get type() : String
        {
            return this._type;
        }
        
        public function set type(param1:String) : void
        {
            this._type = param1;
            invalidate();
        }
    }
}
