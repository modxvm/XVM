package net.wg.gui.lobby.techtree.data.state 
{
    public class StateProperties extends Object
    {
        public function StateProperties(arg1:uint, arg2:uint, arg3:String=null, arg4:uint=0, arg5:Boolean=false, arg6:net.wg.gui.lobby.techtree.data.state.AnimationProperties=null, arg7:Number=1)
        {
            super();
            this.id = arg1;
            this.index = arg2;
            this.label = arg3;
            this.enough = arg4;
            this.visible = arg5;
            this.animation = arg6;
            this.icoAlpha = arg7;
            return;
        }

        public function toString():String
        {
            var loc1:*="StateProperties(";
            loc1 = loc1 + ("id = " + this.id);
            loc1 = loc1 + (", index = " + this.index);
            loc1 = loc1 + (", label = " + this.label);
            loc1 = loc1 + (", enough = " + this.enough);
            loc1 = loc1 + (", visible = " + this.visible);
            loc1 = loc1 + (" animation = " + this.animation);
            loc1 = loc1 + (", icoAlpha = " + this.icoAlpha);
            return loc1 + ")";
        }

        public var id:uint;

        public var index:uint;

        public var label:String;

        public var enough:uint;

        public var visible:Boolean;

        public var animation:net.wg.gui.lobby.techtree.data.state.AnimationProperties;

        public var icoAlpha:Number;
    }
}
