/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.extraFields
{
    import com.xfw.*;

    public class ExtraFieldsHelper
    {
        // cleanup formats without macros to remove extra checks
        public static function cleanupFormat(field:*, format:Object):void
        {
            if (format.x != null && (typeof format.x != "string" || format.x.indexOf("{{") < 0) && !format.bindToIcon)
                delete format.x;
            if (format.y != null && (typeof format.y != "string" || format.y.indexOf("{{") < 0))
                delete format.y;
            if (format.w != null && (typeof format.w != "string" || format.w.indexOf("{{") < 0))
                delete format.w;
            if (format.h != null && (typeof format.h != "string" || format.h.indexOf("{{") < 0))
                delete format.h;
            if (format.alpha != null && (typeof format.alpha != "string" || format.alpha.indexOf("{{") < 0))
                delete format.alpha;
            if (format.rotation != null && (typeof format.rotation != "string" || format.rotation.indexOf("{{") < 0))
                delete format.rotation;
            if (format.borderColor != null && (typeof format.borderColor != "string" || format.borderColor.indexOf("{{") < 0))
                delete format.borderColor;
            if (format.bgColor != null && (typeof format.bgColor != "string" || format.bgColor.indexOf("{{") < 0))
                delete format.bgColor;
        }
    }
}
