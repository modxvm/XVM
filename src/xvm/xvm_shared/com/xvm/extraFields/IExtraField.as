package com.xvm.extraFields
{
    import com.xvm.vo.*;
    import net.wg.infrastructure.interfaces.entity.IDisposable;

    public interface IExtraField extends IDisposable
    {
        function update(options:IVOMacrosOptions, bindToIconOffset:Number = 0, offsetX:Number = 0, offsetY:Number = 0):void;
    }
}
