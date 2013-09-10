package net.wg.gui.lobby.window 
{
    import flash.filters.*;
    import net.wg.gui.components.controls.*;
    
    public class ExchangeUtils extends Object
    {
        public function ExchangeUtils()
        {
            super();
            return;
        }

        public static function getGlow(arg1:String, arg2:Number=NaN):Array
        {
            var loc1:*=NaN;
            var loc2:*;
            (loc2 = new flash.filters.DropShadowFilter()).distance = 0;
            loc2.angle = 0;
            loc2.alpha = 0.5;
            loc2.blurX = 4;
            loc2.blurY = 4;
            loc2.quality = 2;
            var loc3:*=arg1;
            switch (loc3) 
            {
                case net.wg.gui.components.controls.IconText.GOLD:
                {
                    loc1 = 16736256;
                    arg2 = isNaN(arg2) ? 0.8 : arg2;
                    break;
                }
                case net.wg.gui.components.controls.IconText.CREDITS:
                {
                    loc1 = 13556185;
                    arg2 = isNaN(arg2) ? 0.3 : arg2;
                    break;
                }
                case net.wg.gui.components.controls.IconText.FREE_XP:
                case net.wg.gui.components.controls.IconText.ELITE_XP:
                {
                    loc1 = 14570496;
                    arg2 = isNaN(arg2) ? 0.6 : arg2;
                    break;
                }
                case net.wg.gui.components.controls.IconText.VCOIN:
                {
                    loc1 = 16736256;
                    arg2 = isNaN(arg2) ? 0.6 : arg2;
                    break;
                }
                case ICON_TYPE_BLACK:
                {
                    loc1 = 0;
                    arg2 = isNaN(arg2) ? 0.3 : arg2;
                    break;
                }
                case STATE_SMALL_MONEY:
                {
                    loc1 = 16718080;
                    arg2 = isNaN(arg2) ? 0.6 : arg2;
                    break;
                }
                default:
                {
                    break;
                }
            }
            loc2.color = loc1;
            loc2.strength = arg2;
            return [loc2];
        }

        public static const STATE_SMALL_MONEY:String="small_money";

        public static const ICON_TYPE_BLACK:String="black";
    }
}
