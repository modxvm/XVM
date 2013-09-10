package net.wg.data.components 
{
    import net.wg.data.daapi.base.*;
    
    public class AccordionRendererData extends net.wg.data.daapi.base.DAAPIDataClass
    {
        public function AccordionRendererData(arg1:Object)
        {
            super(arg1);
            return;
        }

        public function get enabled():Boolean
        {
            return this._enabled;
        }

        public function set enabled(arg1:Boolean):void
        {
            this._enabled = arg1;
            return;
        }

        public function get linkage():String
        {
            return this._linkage;
        }

        public function set linkage(arg1:String):void
        {
            this._linkage = arg1;
            return;
        }

        public function get label():String
        {
            return this._label;
        }

        public function set label(arg1:String):void
        {
            this._label = arg1;
            return;
        }

        internal var _label:String="";

        internal var _linkage:String="";

        internal var _enabled:Boolean=false;
    }
}
