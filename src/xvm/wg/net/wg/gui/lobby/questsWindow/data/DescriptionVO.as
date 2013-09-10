package net.wg.gui.lobby.questsWindow.data 
{
    import net.wg.data.daapi.base.*;
    
    public class DescriptionVO extends net.wg.data.daapi.base.DAAPIDataClass
    {
        public function DescriptionVO(arg1:Object)
        {
            super(arg1);
            return;
        }

        public function get title():String
        {
            return this._title;
        }

        public function set title(arg1:String):void
        {
            this._title = arg1;
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

        internal var _title:String="";

        internal var _descr:String="";
    }
}
