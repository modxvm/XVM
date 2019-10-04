package net.wg.gui.lobby.settings.feedback.damageIndicator
{
    import flash.display.Sprite;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.text.TextField;

    public class DamageIndicatorsContainer extends Sprite implements IDisposable
    {

        private static const INDICATOR_COUNT:int = 3;

        public var extendedMc:DamageIndicatorExtended = null;

        private var _tfWithArrow:Vector.<TextField> = null;

        private var _isWithValue:Boolean = true;

        private var _isInitialized:Boolean = false;

        public function DamageIndicatorsContainer()
        {
            super();
            this._tfWithArrow = Vector.<TextField>([this.extendedMc.damageModuleTF,null,this.extendedMc.damageCountTF]);
        }

        public final function dispose() : void
        {
            this._tfWithArrow.splice(0,this._tfWithArrow.length);
            this._tfWithArrow = null;
            this.extendedMc.dispose();
            this.extendedMc = null;
        }

        public function updateSettings(param1:Boolean, param2:Boolean, param3:Boolean) : void
        {
            var _loc4_:* = 0;
            this.extendedMc.visible = !param1;
            if(!param1)
            {
                if(param2 != this._isWithValue || !this._isInitialized)
                {
                    _loc4_ = 0;
                    while(_loc4_ < INDICATOR_COUNT)
                    {
                        if(this._tfWithArrow[_loc4_])
                        {
                            this._tfWithArrow[_loc4_].visible = param2;
                        }
                        _loc4_++;
                    }
                }
                this.extendedMc.damageModuleTF.visible = param3 && param2;
                this.extendedMc.critTF.visible = param3;
                this._isInitialized = true;
                this._isWithValue = param2;
            }
        }
    }
}
