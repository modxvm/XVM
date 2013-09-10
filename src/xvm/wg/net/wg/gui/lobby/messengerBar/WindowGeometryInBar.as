package net.wg.gui.lobby.messengerBar 
{
    import net.wg.gui.events.*;
    import net.wg.infrastructure.base.*;
    import net.wg.infrastructure.interfaces.*;
    
    public class WindowGeometryInBar extends net.wg.infrastructure.base.DefaultWindowGeometry
    {
        public function WindowGeometryInBar(arg1:String, arg2:Number=0)
        {
            super();
            this.eventType = arg1;
            this.clientID = arg2;
            return;
        }

        public override function setPosition(arg1:net.wg.infrastructure.interfaces.IWindow):Boolean
        {
            var loc1:*=arg1.sourceView;
            if (loc1 && this.doPositionOnce) 
            {
                loc1.dispatchEvent(new net.wg.gui.events.MessengerBarEvent(this.eventType, this.clientID));
                this.doPositionOnce = false;
            }
            return false;
        }

        internal var eventType:String;

        internal var clientID:Number;

        internal var doPositionOnce:Boolean=true;
    }
}
