package net.wg.data.VO
{
    public class TrainingRoomRendererVO extends UserVO
    {
        
        public function TrainingRoomRendererVO(param1:Object) {
            super(param1);
        }
        
        public var himself:Boolean;
        
        public var icon:String = "";
        
        public var vShortName:String = "";
        
        public var vLevel:String = "";
        
        public var chatRoster:Number = 0;
        
        public var stateString:String = "";
        
        public var isPlayerSpeaking:Boolean;
    }
}
