package com.xvm.extraFields
{
    import com.xvm.vo.*;
    import net.wg.infrastructure.interfaces.entity.IDisposable;

    public interface IExtraField extends IDisposable
    {
        function alignField():void;
        function update(options:IVOMacrosOptions):void;
    }
}
