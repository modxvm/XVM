package net.wg.infrastructure.interfaces.entity 
{
    public interface ISerializable
    {
        function encode(arg1:*):String;

        function decode(arg1:String):Object;
    }
}
