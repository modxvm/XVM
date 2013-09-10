package net.wg.gui.lobby.profile 
{
    import flash.text.*;
    import net.wg.gui.components.advanced.*;
    import scaleform.clik.core.*;
    
    public class UserInfoForm extends scaleform.clik.core.UIComponent
    {
        public function UserInfoForm()
        {
            this.USER_INFO_FRAME = {"CLAN":1, "NORMAL":2};
            super();
            return;
        }

        protected override function draw():void
        {
            if (this.dataUpdated) 
                this.dataUpdated = false;
            return;
        }

        public function setData(arg1:Object):void
        {
            if (arg1 && !(arg1 == this._data)) 
            {
                this._data = arg1;
                this.dataUpdated = true;
                invalidate();
            }
            return;
        }

        public var nameField:flash.text.TextField;

        public var clanField:flash.text.TextField;

        public var clanJoinDataField:flash.text.TextField;

        public var clanPositionField:flash.text.TextField;

        public var registrationDateLabel:flash.text.TextField;

        public var registrationDateField:flash.text.TextField;

        public var lastBattleDateLabel:flash.text.TextField;

        public var lastBattleDateField:flash.text.TextField;

        public var clanEmblem:net.wg.gui.components.advanced.ClanEmblem;

        internal var _data:Object;

        internal var dataUpdated:Boolean=false;

        internal var USER_INFO_FRAME:Object;
    }
}
