package com.xvm.wg
{
    import flash.events.*;

    public interface IImageDataWG extends IEventDispatcher
    {
        function showTo(image:IImageWG):void;
        function get ready():Boolean;
    }
}
