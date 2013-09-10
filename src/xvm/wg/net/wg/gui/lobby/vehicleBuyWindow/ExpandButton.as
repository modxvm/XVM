package net.wg.gui.lobby.vehicleBuyWindow 
{
    import __AS3__.vec.*;
    import scaleform.clik.controls.*;
    
    public class ExpandButton extends scaleform.clik.controls.Button
    {
        public function ExpandButton()
        {
            super();
            return;
        }

        public function get expanded():Boolean
        {
            return this._expanded;
        }

        public function set expanded(arg1:Boolean):void
        {
            this._expanded = arg1;
            setState("up");
            return;
        }

        public override function set label(arg1:String):void
        {
            if (_label == arg1) 
                return;
            _label = arg1;
            return;
        }

        protected override function getStatePrefixes():__AS3__.vec.Vector.<String>
        {
            var loc1:*=new Vector.<String>();
            if (this._expanded) 
                loc1.push("expanded_");
            else if (_selected) 
            {
                loc1.push("selected_");
                loc1.push("");
            }
            else 
                loc1.push("");
            return loc1;
        }

        internal var _expanded:Boolean=false;
    }
}
