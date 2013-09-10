package net.wg.data.VO 
{
    import net.wg.data.daapi.base.*;
    
    public class TrainingRoomRendererVO extends net.wg.data.daapi.base.DAAPIDataClass
    {
        public function TrainingRoomRendererVO(arg1:Object)
        {
            super(arg1);
            return;
        }

        public var accID:Number;

        public var uid:Number;

        public var himself:Boolean;

        public var userName:String="";

        public var fullName:String="";

        public var icon:String="";

        public var vShortName:String="";

        public var vLevel:String="";

        public var chatRoster:Number=0;

        public var stateString:String="";

        public var isPlayerSpeaking:Boolean;
    }
}
