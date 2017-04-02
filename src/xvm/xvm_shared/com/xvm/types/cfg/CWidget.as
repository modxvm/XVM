/**
 * XVM Config
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.types.cfg
{
    import com.xfw.*;
    import com.xvm.*;

    public dynamic class CWidget extends Object implements ICloneable
    {
        public var enabled:*;
        public var layer:String;
        public var type:String;
        public var formats:Array;

        public function clone():*
        {
            var cloned:CWidget = new CWidget();
            cloned.enabled = enabled;
            cloned.layer = layer;
            cloned.type = type;
            if (formats)
            {
                cloned.formats = [];
                var len:uint = formats.length;
                for (var i:uint = 0; i < len; ++i)
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
            return cloned;
        }
    }
}
