package net.wg.gui.messenger.data 
{
    import net.wg.data.daapi.base.*;
    
    public class ChannelMemberVO extends net.wg.data.daapi.base.DAAPIDataClass
    {
        public function ChannelMemberVO(arg1:Object)
        {
            super(arg1);
            return;
        }

        public function get uid():Number
        {
            return this._uid;
        }

        public function set uid(arg1:Number):void
        {
            this._uid = arg1;
            return;
        }

        public function get userName():String
        {
            return this._userName;
        }

        public function set userName(arg1:String):void
        {
            this._userName = arg1;
            return;
        }

        public function get himself():Boolean
        {
            return this._himself;
        }

        public function set himself(arg1:Boolean):void
        {
            this._himself = arg1;
            return;
        }

        public function get state():Number
        {
            return this._state;
        }

        public function set state(arg1:Number):void
        {
            this._state = arg1;
            return;
        }

        public function get isPlayerSpeaking():Boolean
        {
            return this._isPlayerSpeaking;
        }

        public function set isPlayerSpeaking(arg1:Boolean):void
        {
            this._isPlayerSpeaking = arg1;
            return;
        }

        public function get chatRoster():Number
        {
            return this._chatRoster;
        }

        public function set chatRoster(arg1:Number):void
        {
            this._chatRoster = arg1;
            return;
        }

        public function get color():uint
        {
            return this._color;
        }

        public function set color(arg1:uint):void
        {
            this._color = arg1;
            return;
        }

        internal var _uid:Number;

        internal var _userName:String="";

        internal var _himself:Boolean=false;

        internal var _state:Number;

        internal var _isPlayerSpeaking:Boolean=false;

        internal var _chatRoster:Number;

        internal var _color:uint;
    }
}
