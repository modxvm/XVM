package net.wg.gui.lobby.questsWindow.data 
{
    import net.wg.data.constants.*;
    import net.wg.data.daapi.base.*;
    
    public class VehicleBlockVO extends net.wg.data.daapi.base.DAAPIDataClass
    {
        public function VehicleBlockVO(arg1:Object)
        {
            super(arg1);
            return;
        }

        public function get nationID():int
        {
            return this._nationID;
        }

        public function set nationID(arg1:int):void
        {
            this._nationID = arg1;
            return;
        }

        public function get vType():String
        {
            return this._vType;
        }

        public function set vType(arg1:String):void
        {
            this._vType = arg1;
            return;
        }

        public function get vLevel():int
        {
            return this._vLevel;
        }

        public function set vLevel(arg1:int):void
        {
            this._vLevel = arg1;
            return;
        }

        public function get vName():String
        {
            return this._vName;
        }

        public function set vName(arg1:String):void
        {
            this._vName = arg1;
            return;
        }

        public function get nationIconPath():String
        {
            var loc1:*=[net.wg.data.constants.Nations.USSR, net.wg.data.constants.Nations.GERMANY, net.wg.data.constants.Nations.USA, net.wg.data.constants.Nations.CHINA, net.wg.data.constants.Nations.FRANCE, net.wg.data.constants.Nations.UK];
            return "../maps/icons/filters/nations/" + loc1[this._nationID] + ".png";
        }

        public function get typeIconPath():String
        {
            return "../maps/icons/filters/tanks/" + this._vType + ".png";
        }

        public function get vIconSmall():String
        {
            return this._vIconSmall;
        }

        public function set vIconSmall(arg1:String):void
        {
            this._vIconSmall = arg1;
            return;
        }

        internal var _nationID:int;

        internal var _vIconSmall:String="";

        internal var _vType:String="";

        internal var _vLevel:int;

        internal var _vName:String="";
    }
}
