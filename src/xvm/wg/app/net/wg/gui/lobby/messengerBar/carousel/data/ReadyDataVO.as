package net.wg.gui.lobby.messengerBar.carousel.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class ReadyDataVO extends DAAPIDataClass
    {
        
        public function ReadyDataVO(param1:Object)
        {
            super(param1);
        }
        
        public var isReady:Boolean;
    }
}
