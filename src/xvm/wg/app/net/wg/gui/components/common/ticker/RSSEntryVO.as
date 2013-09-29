package net.wg.gui.components.common.ticker 
{
    import net.wg.data.daapi.base.*;
    
    public class RSSEntryVO extends net.wg.data.daapi.base.DAAPIDataClass
    {
        public function RSSEntryVO(arg1:Object)
        {
            super(arg1);
            return;
        }

        public function get id():String
        {
            return this._id;
        }

        public function set id(arg1:String):void
        {
            this._id = arg1;
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

        public function get summary():String
        {
            return this._summary;
        }

        public function set summary(arg1:String):void
        {
            this._summary = arg1;
            return;
        }

        internal var _id:String="";

        internal var _title:String="";

        internal var _summary:String="";
    }
}
