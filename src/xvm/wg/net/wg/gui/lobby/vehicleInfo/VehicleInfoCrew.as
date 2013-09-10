package net.wg.gui.lobby.vehicleInfo 
{
    import net.wg.infrastructure.interfaces.*;
    import scaleform.clik.core.*;
    
    public class VehicleInfoCrew extends scaleform.clik.core.UIComponent implements net.wg.infrastructure.interfaces.IViewStackContent
    {
        public function VehicleInfoCrew()
        {
            super();
            return;
        }

        public function update(arg1:Object):void
        {
            var loc2:*=null;
            this._data = arg1 as Array;
            var loc1:*=0;
            while (loc1 < this._data.length) 
            {
                loc2 = new net.wg.gui.lobby.vehicleInfo.CrewBlock();
                loc2.setData(this._data[loc1]);
                loc2.x = this.startX;
                loc2.y = this.startY + this.yOffset * loc1;
                this.addChild(loc2);
                ++loc1;
            }
            return;
        }

        public override function dispose():void
        {
            super.dispose();
            while (this.numChildren > 0) 
            {
                this.removeChildAt(0);
            }
            return;
        }

        public override function toString():String
        {
            return "[WG VehicleInfoCrew " + name + "]";
        }

        internal var _data:Array;

        internal var yOffset:Number=19;

        internal var startY:Number=10;

        internal var startX:Number=10;
    }
}
