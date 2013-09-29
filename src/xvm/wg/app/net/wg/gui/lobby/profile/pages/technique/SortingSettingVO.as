package net.wg.gui.lobby.profile.pages.technique 
{
    import net.wg.data.daapi.base.*;
    
    public class SortingSettingVO extends net.wg.data.daapi.base.DAAPIDataClass
    {
        public function SortingSettingVO(arg1:Object)
        {
            super(arg1);
            return;
        }

        public function get btnType():String
        {
            return this._btnType;
        }

        public function set btnType(arg1:String):void
        {
            this._btnType = arg1;
            return;
        }

        public function get sortDirection():String
        {
            return this._sortDirection;
        }

        public function set sortDirection(arg1:String):void
        {
            this._sortDirection = arg1;
            return;
        }

        internal var _btnType:String="";

        internal var _sortDirection:String="";
    }
}
