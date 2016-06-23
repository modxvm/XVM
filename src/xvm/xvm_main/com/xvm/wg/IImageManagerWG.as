package com.xvm.wg
{
    import net.wg.infrastructure.interfaces.entity.IDisposable;

    public interface IImageManagerWG extends IDisposable
    {
        function getImageData(url:String):IImageDataWG;
    }
}
