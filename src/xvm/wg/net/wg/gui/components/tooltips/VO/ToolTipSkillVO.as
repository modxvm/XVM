package net.wg.gui.components.tooltips.VO 
{
    import net.wg.data.daapi.base.*;
    
    public class ToolTipSkillVO extends net.wg.data.daapi.base.DAAPIDataClass
    {
        public function ToolTipSkillVO(arg1:Object)
        {
            super(arg1);
            return;
        }

        public function get level():Number
        {
            return this._level;
        }

        public function set level(arg1:Number):void
        {
            this._level = arg1;
            return;
        }

        public function get shortDescr():String
        {
            return this._shortDescr;
        }

        public function set shortDescr(arg1:String):void
        {
            this._shortDescr = arg1;
            return;
        }

        public function get type():String
        {
            return this._type;
        }

        public function set type(arg1:String):void
        {
            this._type = arg1;
            return;
        }

        public function get descr():String
        {
            return this._descr;
        }

        public function set descr(arg1:String):void
        {
            this._descr = arg1;
            return;
        }

        public function get name():String
        {
            return this._name;
        }

        public function set name(arg1:String):void
        {
            this._name = arg1;
            return;
        }

        internal var _name:String="";

        internal var _descr:String="";

        internal var _type:String="";

        internal var _shortDescr:String="";

        internal var _level:Number=0;
    }
}
