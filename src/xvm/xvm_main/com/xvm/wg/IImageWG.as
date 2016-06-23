package com.xvm.wg
{
    import flash.display.*;
    import net.wg.infrastructure.interfaces.IDisplayObject;
    import net.wg.infrastructure.interfaces.entity.IDisposable;

    public interface IImageWG extends IDisplayObject, IDisposable
    {
        function set bitmapData(param1:BitmapData) : void;
        function set source(param1:String) : void;
    }
}
