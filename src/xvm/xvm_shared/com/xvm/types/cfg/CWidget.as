/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CWidget implements ICloneable
    {
        public var enabled:*;
        public var formats:Array;
        public var layer:String;
        public var type:String;

        public function clone():*
        {
            var cloned:CWidget = new CWidget();
            cloned.enabled = enabled;
            if (formats)
            {
                cloned.formats = [];
                var len:int = formats.length;
                for (var i:int = 0; i < len; ++i)
                {
                    if (formats[i] != null)
                    {
                        var format:ICloneable = formats[i] as ICloneable;
                        if (format)
                        {
                            cloned.formats.push(format.clone());
                        }
                        else
                        {
                            cloned.formats.push(XfwUtils.jsonclone(formats[i]));
                        }
                    }
                }
            }
            cloned.layer = layer;
            cloned.type = type;
            return cloned;
        }
    }
}
