package net.wg.gui.lobby.fortifications.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class ConnectedDirectionsVO extends DAAPIDataClass
    {
        
        public function ConnectedDirectionsVO(param1:Object)
        {
            super(param1);
        }
        
        private static var FIELD_LEFT_DIRECTION:String = "leftDirection";
        
        private static var FIELD_RIGHT_DIRECTION:String = "rightDirection";
        
        public var leftDirection:DirectionVO;
        
        public var rightDirection:DirectionVO;
        
        public var connectionIcon:String = "";
        
        public var connectionIconTTHeader:String = "";
        
        public var connectionIconTTBody:String = "";
        
        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            if(param1 == FIELD_LEFT_DIRECTION)
            {
                this.leftDirection = new DirectionVO(param2);
                return false;
            }
            if(param1 == FIELD_RIGHT_DIRECTION)
            {
                this.rightDirection = new DirectionVO(param2);
                return false;
            }
            return true;
        }
        
        override protected function onDispose() : void
        {
            if(this.leftDirection)
            {
                this.leftDirection.dispose();
                this.leftDirection = null;
            }
            if(this.rightDirection)
            {
                this.rightDirection.dispose();
                this.rightDirection = null;
            }
            super.onDispose();
        }
    }
}
