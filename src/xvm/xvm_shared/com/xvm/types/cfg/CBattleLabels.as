/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CBattleLabels implements ICloneable
    {
        public var formats:Array;

        public function clone():*
        {
            var cloned:CBattleLabels = new CBattleLabels();
            if (formats)
            {
                cloned.formats = [];
                var len:int = formats.length;
                for (var i:int = 0; i < len; ++i)
                {
                    var format:CExtraField = formats[i] as CExtraField;
                    if (format)
                    {
                        cloned.formats.push(format.clone());
                    }
                }
            }
            return cloned;
        }
    }
}
