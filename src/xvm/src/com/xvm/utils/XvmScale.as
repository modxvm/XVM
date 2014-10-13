/**
 * XVM Scale for ratings
 * http://www.koreanrandom.com/forum/topic/2625-/
 * @author Maxim Schedriviy "m.schedriviy(at)gmail.com"
 */
package com.xvm.utils
{
    public class XvmScale
    {
        public static function XEFF(EFF:Number):Number
        {
            return EFF < 350 ? 0 :
                Math.round(Math.max(0, Math.min(100,
                    EFF*(EFF*(EFF*(EFF*(EFF*(EFF*
                    0.00000000000000003388
                    - 0.0000000000002469)
                    + 0.00000000069335)
                    - 0.00000095342)
                    + 0.0006656)
                    - 0.1485)
                    - 0.85
                )));
        }

        public static function XWN6(WN6:Number):Number
        {
            return WN6 > 2300 ? 100 :
                Math.round(Math.max(0, Math.min(100,
                    WN6*(WN6*(WN6*(WN6*(WN6*(WN6*
                    0.00000000000000000466
                    - 0.000000000000032413)
                    + 0.00000000007524)
                    - 0.00000006516)
                    + 0.00001307)
                    + 0.05153)
                    - 3.9
                )));
        }

        public static function XWN8(WN8:Number):Number
        {
            return WN8 > 3400 ? 100 :
                Math.round(Math.max(0, Math.min(100,
                    WN8*(WN8*(WN8*(WN8*(WN8*(WN8*
                    0.00000000000000000009553
                    - 0.0000000000000001644)
                    - 0.00000000000426)
                    + 0.0000000197)
                    - 0.00003192)
                    + 0.056265)
                    - 0.157
                )));
        }

        public static function XWGR(WGR:Number):Number
        {
            return WGR > 11000 ? 100 :
                Math.round(Math.max(0, Math.min(100,
                    WGR*(WGR*(WGR*(WGR*(WGR*(-WGR*
                    0.0000000000000000000004209
                    + 0.000000000000000012477)
                    - 0.00000000000014338)
                    + 0.0000000008309)
                    - 0.000002361)
                    + 0.01048)
                    + 0.4
                )));
        }
    }
}
