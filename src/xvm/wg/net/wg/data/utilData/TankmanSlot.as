package net.wg.data.utilData 
{
    import net.wg.data.gui_items.*;
    
    public class TankmanSlot extends Object
    {
        public function TankmanSlot(arg1:uint, arg2:uint=1)
        {
            super();
            this._roleName = arg1;
            this._tankmanInvID = arg2;
            return;
        }

        public function get roleName():uint
        {
            return this._roleName;
        }

        public function get tankman():net.wg.data.gui_items.Tankman
        {
            if (this._tankmanInvID != -1) 
                return new net.wg.data.gui_items.Tankman(this._tankmanInvID);
            return null;
        }

        internal var _roleName:uint;

        internal var _tankmanInvID:uint;
    }
}
