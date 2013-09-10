package net.wg.gui.prebattle.data 
{
    import net.wg.data.daapi.base.*;
    
    public class ReceivedInviteVO extends net.wg.data.daapi.base.DAAPIDataClass
    {
        public function ReceivedInviteVO(arg1:Object)
        {
            super(arg1);
            return;
        }

        public function get id():int
        {
            return this._id;
        }

        public function set id(arg1:int):void
        {
            this._id = arg1;
            return;
        }

        public function get text():String
        {
            return this._text;
        }

        public function set text(arg1:String):void
        {
            this._text = arg1;
            return;
        }

        public function get comment():String
        {
            return this._comment;
        }

        public function set comment(arg1:String):void
        {
            this._comment = arg1;
            return;
        }

        public function get note():String
        {
            return this._note;
        }

        public function set note(arg1:String):void
        {
            this._note = arg1;
            return;
        }

        public function get canAccept():Boolean
        {
            return this._canAccept;
        }

        public function set canAccept(arg1:Boolean):void
        {
            this._canAccept = arg1;
            return;
        }

        public function get canDecline():Boolean
        {
            return this._canDecline;
        }

        public function set canDecline(arg1:Boolean):void
        {
            this._canDecline = arg1;
            return;
        }

        public function hasNote():Boolean
        {
            return this._note && this._note.length > 0;
        }

        internal var _id:int=0;

        internal var _text:String="";

        internal var _comment:String="";

        internal var _note:String="";

        internal var _canAccept:Boolean=false;

        internal var _canDecline:Boolean=false;
    }
}
