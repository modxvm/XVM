package net.wg.data.VO
{
    import net.wg.gui.interfaces.IExtendedUserVO;
    
    public class ExtendedUserVO extends UserVO implements IExtendedUserVO
    {
        
        public function ExtendedUserVO(param1:Object) {
            super(param1);
        }
        
        private var _himself:Boolean = false;
        
        private var _chatRoster:Number;
        
        private var _isPlayerSpeaking:Boolean = false;
        
        protected var _colors:Array;
        
        public function get himself() : Boolean {
            return this._himself;
        }
        
        public function set himself(param1:Boolean) : void {
            this._himself = param1;
        }
        
        public function get colors() : Array {
            return this._colors;
        }
        
        public function set colors(param1:Array) : void {
            this._colors = param1;
        }
        
        public function get chatRoster() : Number {
            return this._chatRoster;
        }
        
        public function set chatRoster(param1:Number) : void {
            this._chatRoster = param1;
        }
        
        public function get isPlayerSpeaking() : Boolean {
            return this._isPlayerSpeaking;
        }
        
        public function set isPlayerSpeaking(param1:Boolean) : void {
            this._isPlayerSpeaking = param1;
        }
        
        public function getToolTip() : String {
            return fullName;
        }
    }
}
