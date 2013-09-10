package net.wg.gui.utils 
{
    import flash.filters.*;
    import flash.text.*;
    import net.wg.data.constants.*;
    
    public class VehicleStateString extends Object
    {
        public function VehicleStateString()
        {
            super();
            return;
        }

        public static function getI18nKey(arg1:String):String
        {
            return arg1.length > 0 ? MENU.tankcarousel_vehiclestates(arg1) : "";
        }

        public static function appendText(arg1:flash.text.TextField, arg2:String):void
        {
            var loc1:*=[];
            var loc2:*=0;
            var loc3:*=null;
            var loc4:*=arg2;
            switch (loc4) 
            {
                case net.wg.data.constants.VehicleState.IN_BATTLE:
                case net.wg.data.constants.VehicleState.IN_PREBATTLE:
                    loc2 = 13617064;
                    (loc3 = new flash.filters.DropShadowFilter()).distance = 0;
                    loc3.angle = 90;
                    loc3.color = 0;
                    loc3.alpha = 0.25;
                    loc3.blurX = 8;
                    loc3.blurY = 8;
                    loc3.strength = 16;
                    loc3.quality = 2;
                    loc3.inner = false;
                    loc3.knockout = false;
                    loc3.hideObject = false;
                    loc1.push(loc3);
                    break;
                case net.wg.data.constants.VehicleState.BUY_VEHICLE:
                case net.wg.data.constants.VehicleState.BUY_SLOT:
                    loc2 = 15329754;
                    (loc3 = new flash.filters.GlowFilter()).color = 16777150;
                    loc3.alpha = 0.2;
                    loc3.blurX = 15;
                    loc3.blurY = 15;
                    loc3.strength = 4;
                    loc3.quality = 2;
                    loc3.inner = false;
                    loc3.knockout = false;
                    loc1.push(loc3);
                    break;
                case net.wg.data.constants.VehicleState.AMMO_NOT_FULL:
                case net.wg.data.constants.VehicleState.CREW_NOT_FULL:
                case net.wg.data.constants.VehicleState.EXPLODED:
                case net.wg.data.constants.VehicleState.DESTROYED:
                case net.wg.data.constants.VehicleState.DAMAGED:
                    loc2 = 15400960;
                    (loc3 = new flash.filters.DropShadowFilter()).distance = 0;
                    loc3.angle = 90;
                    loc3.color = 0;
                    loc3.alpha = 0.25;
                    loc3.blurX = 8;
                    loc3.blurY = 8;
                    loc3.strength = 16;
                    loc3.quality = 2;
                    loc3.inner = false;
                    loc3.knockout = false;
                    loc3.hideObject = false;
                    loc1.push(loc3);
                    break;
            }
            arg1.text = getI18nKey(arg2);
            arg1.textColor = loc2;
            arg1.filters = loc1;
            return;
        }
    }
}
