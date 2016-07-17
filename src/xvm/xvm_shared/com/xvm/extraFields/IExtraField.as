package com.xvm.extraFields
{
    import com.xvm.vo.*;
    import com.xvm.types.cfg.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.infrastructure.interfaces.entity.*;

    public interface IExtraField extends IDisplayObject, IDisposable
    {
        function get cfg():CExtraField;
        function update(options:IVOMacrosOptions, bindToIconOffset:Number = 0, offsetX:Number = 0, offsetY:Number = 0):void;
    }
}
