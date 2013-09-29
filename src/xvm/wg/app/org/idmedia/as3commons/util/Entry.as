package org.idmedia.as3commons.util 
{
    public interface Entry
    {
        function getKey():*;

        function getValue():*;

        function setValue(arg1:*):*;

        function equals(arg1:*):Boolean;
    }
}
