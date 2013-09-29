package net.wg.data.utilData 
{
    public class TankmanRoleLevel extends Object
    {
        public function TankmanRoleLevel(arg1:uint, arg2:int, arg3:int, arg4:int, arg5:int, arg6:int)
        {
            super();
            this._roleLevel = arg1;
            this._common = arg2;
            this._brotherhood = arg3;
            this._equipment = arg4;
            this._optDevs = arg5;
            this._penalty = arg6;
            return;
        }

        public function get roleLevel():uint
        {
            return this._roleLevel;
        }

        public function get common():uint
        {
            return this._common;
        }

        public function get brotherhood():uint
        {
            return this._brotherhood;
        }

        public function get equipment():uint
        {
            return this._equipment;
        }

        public function get optDevs():uint
        {
            return this._optDevs;
        }

        public function get penalty():uint
        {
            return this._penalty;
        }

        internal var _roleLevel:uint;

        internal var _common:int;

        internal var _brotherhood:int;

        internal var _equipment:int;

        internal var _optDevs:int;

        internal var _penalty:int;
    }
}
