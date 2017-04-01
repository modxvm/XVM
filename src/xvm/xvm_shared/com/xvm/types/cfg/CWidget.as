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
        public var format:*;

        public function clone():*
        {
            var cloned:CWidget = new CWidget();
            cloned.enabled = enabled;
            cloned.layer = layer;
            cloned.type = type;
            switch (type)
            {
                case Defines.WIDGET_TYPE_EXTRAFIELD:
                    var extraField:CExtraField = ObjectConverter.convertData(format, CExtraField);
                    if (extraField != null)
                    {
                        cloned.format = extraField.clone();
                    }
                    break;
            }
            return cloned;
        }
    }
}
