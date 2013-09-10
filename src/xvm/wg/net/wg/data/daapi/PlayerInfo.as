package net.wg.data.daapi 
{
    import net.wg.data.daapi.base.*;
    
    public class PlayerInfo extends net.wg.data.daapi.base.DAAPIDataClass
    {
        public function PlayerInfo(arg1:Object)
        {
            super(arg1);
            return;
        }

        public function get displayName():String
        {
            return this._displayName;
        }

        public function set displayName(arg1:String):void
        {
            this._displayName = arg1;
            return;
        }

        public function get isMuted():Boolean
        {
            return this._isMuted;
        }

        public function set isMuted(arg1:Boolean):void
        {
            this._isMuted = arg1;
            return;
        }

        public function get isIgnored():Boolean
        {
            return this._isIgnored;
        }

        public function set isIgnored(arg1:Boolean):void
        {
            this._isIgnored = arg1;
            return;
        }

        public function get isFriend():Boolean
        {
            return this._isFriend;
        }

        public function set isFriend(arg1:Boolean):void
        {
            this._isFriend = arg1;
            return;
        }

        internal var _isFriend:Boolean;

        internal var _isIgnored:Boolean;

        internal var _isMuted:Boolean;

        internal var _displayName:String="";
    }
}
