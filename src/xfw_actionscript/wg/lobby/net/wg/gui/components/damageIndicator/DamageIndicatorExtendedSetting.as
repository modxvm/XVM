package net.wg.gui.components.damageIndicator
{
    import net.wg.infrastructure.interfaces.entity.IDisposable;

    public class DamageIndicatorExtendedSetting extends DamageIndicatorStandardSetting implements IDisposable
    {

        public var tankName:String = "";

        public var tankTypeStr:String = "";

        public var damageValue:String = "";

        private var _circle:String = "";

        private var _blindCircle:String = "";

        public function DamageIndicatorExtendedSetting(param1:int, param2:String, param3:String, param4:String, param5:String, param6:String, param7:String, param8:String, param9:int, param10:int, param11:Number)
        {
            super(param1,param2,param3,param9,param10,param11);
            this._circle = param4;
            this._blindCircle = param5;
            this.tankName = param6;
            this.tankTypeStr = param7;
            this.damageValue = param8;
        }

        public function getCircle() : String
        {
            return _colorMgr.getIsColorBlindS()?this._blindCircle:this._circle;
        }
    }
}
