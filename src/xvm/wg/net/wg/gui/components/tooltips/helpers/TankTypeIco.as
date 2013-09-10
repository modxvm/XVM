package net.wg.gui.components.tooltips.helpers 
{
    import scaleform.clik.core.*;
    
    public class TankTypeIco extends scaleform.clik.core.UIComponent
    {
        public function TankTypeIco()
        {
            super();
            stop();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            gotoAndStop(1);
            this._labelHash;
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (_labelHash[this.type]) 
                gotoAndStop(this.type);
            return;
        }

        public function get type():String
        {
            return this._type;
        }

        public function set type(arg1:String):void
        {
            this._type = arg1;
            invalidate();
            return;
        }

        internal var _type:String=null;
    }
}
