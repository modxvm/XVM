package net.wg.gui.lobby.techtree.controls 
{
    import net.wg.gui.lobby.techtree.interfaces.*;
    import scaleform.clik.core.*;
    
    public class NodeComponent extends scaleform.clik.core.UIComponent implements net.wg.gui.lobby.techtree.interfaces.IHasRendererAsOwner
    {
        public function NodeComponent()
        {
            super();
            return;
        }

        public function get state():String
        {
            return this._state;
        }

        public function set state(arg1:String):void
        {
            if (this._state == arg1) 
            {
                return;
            }
            this._state = arg1;
            return;
        }

        public function setOwner(arg1:net.wg.gui.lobby.techtree.interfaces.IRenderer, arg2:Boolean=false):void
        {
            if (this._owner != arg1) 
            {
                this._owner = arg1;
            }
            invalidateData();
            if (arg2) 
            {
                validateNow();
            }
            return;
        }

        public override function dispose():void
        {
            this._owner = null;
            super.dispose();
            return;
        }

        internal var _state:String="locked";

        protected var _owner:net.wg.gui.lobby.techtree.interfaces.IRenderer=null;
    }
}
