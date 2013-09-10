package org.idmedia.as3commons.util 
{
    public interface Collection
    {
        function add(arg1:*):Boolean;

        function clear():void;

        function contains(arg1:*):Boolean;

        function containsAll(arg1:org.idmedia.as3commons.util.Collection):Boolean;

        function addAll(arg1:org.idmedia.as3commons.util.Collection):Boolean;

        function isEmpty():Boolean;

        function iterator():org.idmedia.as3commons.util.Iterator;

        function remove(arg1:*=null):Boolean;

        function size():int;

        function toArray():Array;
    }
}
