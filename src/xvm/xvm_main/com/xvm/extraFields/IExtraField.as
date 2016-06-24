package com.xvm.extraFields
{
    import com.xvm.vo.*;
    import net.wg.infrastructure.interfaces.entity.IDisposable;

    public interface IExtraField extends IDisposable
    {
        function update(options:IVOMacrosOptions, bindToIconOffset:Number = NaN):void;
    }
}
