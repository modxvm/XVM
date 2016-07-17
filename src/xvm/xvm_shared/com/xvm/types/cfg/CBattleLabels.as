/**
 * XVM Config
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CBattleLabels extends Object implements ICloneable
    {
        public var formats:Array;

        public function clone():*
        {
            var cloned:CBattleLabels = new CBattleLabels();
            if (formats != null)
            {
                cloned.formats = [];
                var len:uint = formats.length;
                for (var i:uint = 0; i < len; ++i)
                {
                    var format:CExtraField = formats[i] as CExtraField;
                    if (format != null)
                    {
                        cloned.formats.push(format.clone());
                    }
                }
            }
            return cloned;
        }
    }
}
