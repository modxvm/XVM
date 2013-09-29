package org.idmedia.as3commons.util 
{
    public interface Map
    {
        function put(arg1:*, arg2:*):*;

        function get(arg1:*):*;

        function containsKey(arg1:*):Boolean;

        function containsValue(arg1:*):Boolean;

        function remove(arg1:*):*;

        function clear():void;

        function size():int;

        function values():org.idmedia.as3commons.util.Collection;

        function keySet():org.idmedia.as3commons.util.Set;

        function entrySet():org.idmedia.as3commons.util.Set;

        function isEmpty():Boolean;

        function putAll(arg1:org.idmedia.as3commons.util.Map):void;
    }
}
