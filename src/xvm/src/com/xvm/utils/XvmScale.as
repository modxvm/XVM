/**
 * XVM Scale for ratings
 * http://www.koreanrandom.com/forum/topic/2625-/
 * @author Maxim Schedriviy "m.schedriviy(at)gmail.com"
 */
package com.xvm.utils
{
    public class XvmScale
    {
        public static function XEFF(value:Number):Number
        {
            return value < 420 ? 0 :
                Math.round(Math.max(0, Math.min(100,
                    value * (value * (value * (value * (value * (value *
                    0.000000000000000045254
                    - 0.00000000000033131)
                    + 0.00000000094164)
                    - 0.0000013227)
                    + 0.00095664)
                    - 0.2598)
                    + 13.23
                )));
        }

        public static function XWN6(WN6:Number):Number
        {
            return WN6 > 2160 ? 100 :
                Math.round(Math.max(0, Math.min(100,
                    WN6*(WN6*(WN6*(WN6*
                    - 0.00000000001268
                    + 0.00000005147)
                    - 0.00006418)
                    + 0.07576)
                    - 7.25
                )));
        }

        public static function XWN8(WN8:Number):Number
        {
            return WN8 > 3250 ? 100 :
                Math.round(Math.max(0, Math.min(100,
                    WN8*(WN8*(WN8*(WN8*(WN8*(WN8*
                    0.00000000000000000007119
                    + 0.0000000000000002334)
                    - 0.000000000006963)
                    + 0.00000002845)
                    - 0.00004558)
                    + 0.06565)
                    - 0.18
                )));
        }
    }
}
