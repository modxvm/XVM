package net.wg.gui.messenger.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class ChannelMemberVO extends DAAPIDataClass
    {
        
        public function ChannelMemberVO(param1:Object) {
            super(param1);
        }
        
        private var _uid:Number;
        
        private var _userName:String = "";
        
        private var _himself:Boolean = false;
        
        private var _state:Number;
        
        private var _isPlayerSpeaking:Boolean = false;
        
        private var _chatRoster:Number;
        
        private var _color:uint;
        
        public function get uid() : Number {
            return this._uid;
        }
        
        public function set uid(param1:Number) : void {
            this._uid = param1;
        }
        
        public function get userName() : String {
            return this._userName;
        }
        
        public function set userName(param1:String) : void {
            this._userName = param1;
        }
        
        public function get himself() : Boolean {
            return this._himself;
        }
        
        public function set himself(param1:Boolean) : void {
            this._himself = param1;
        }
        
        public function get state() : Number {
            return this._state;
        }
        
        public function set state(param1:Number) : void {
            this._state = param1;
        }
        
        public function get isPlayerSpeaking() : Boolean {
            return this._isPlayerSpeaking;
        }
        
        public function set isPlayerSpeaking(param1:Boolean) : void {
            this._isPlayerSpeaking = param1;
        }
        
        public function get chatRoster() : Number {
            return this._chatRoster;
        }
        
        public function set chatRoster(param1:Number) : void {
            this._chatRoster = param1;
        }
        
        public function get color() : uint {
            return this._color;
        }
        
        public function set color(param1:uint) : void {
            this._color = param1;
        }
    }
}
