package net.wg.gui.lobby.profile.components 
{
    import flash.events.*;
    import net.wg.data.constants.*;
    import net.wg.gui.components.controls.*;
    
    public class TechMasteryIcon extends net.wg.gui.components.controls.UILoaderAlt
    {
        public function TechMasteryIcon()
        {
            super();
            this.addEventListener(flash.events.MouseEvent.ROLL_OVER, this.rollOverHandler, false, 0, true);
            this.addEventListener(flash.events.MouseEvent.ROLL_OUT, this.rollOutHandler, false, 0, true);
            return;
        }

        internal function rollOverHandler(arg1:flash.events.MouseEvent):void
        {
            if (this._data) 
            {
                App.toolTipMgr.showSpecial(net.wg.data.constants.Tooltips.TANK_CLASS, null, "markOfMastery", this._data.markOfMastery);
            }
            return;
        }

        internal function rollOutHandler(arg1:flash.events.MouseEvent):void
        {
            App.toolTipMgr.hide();
            return;
        }

        public function set data(arg1:Object):void
        {
            this._data = arg1;
            return;
        }

        public override function dispose():void
        {
            this.removeEventListener(flash.events.MouseEvent.ROLL_OVER, this.rollOverHandler);
            this.removeEventListener(flash.events.MouseEvent.ROLL_OUT, this.rollOutHandler);
            super.dispose();
            return;
        }

        internal var _data:Object;
    }
}
