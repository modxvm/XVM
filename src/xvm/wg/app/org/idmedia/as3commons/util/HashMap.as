package org.idmedia.as3commons.util 
{
    public class HashMap extends org.idmedia.as3commons.util.AbstractMap implements org.idmedia.as3commons.util.Map
    {
        public function HashMap()
        {
            super();
            this.entries = new EntrySet();
            return;
        }

        public override function entrySet():org.idmedia.as3commons.util.Set
        {
            return this.entries;
        }

        public override function put(arg1:*, arg2:*):*
        {
            var loc2:*=null;
            var loc3:*=undefined;
            var loc1:*=this.entries.iterator();
            while (loc1.hasNext()) 
            {
                if ((loc2 = org.idmedia.as3commons.util.Entry(loc1.next())).getKey() !== arg1) 
                {
                    continue;
                }
                loc3 = loc2.getValue();
                loc2.setValue(arg2);
                return loc3;
            }
            this.entries.add(new EntryImpl(arg1, arg2));
            return null;
        }

        public function forEach(arg1:Function):void
        {
            var loc2:*=null;
            var loc1:*=this.keySet().toArray();
            var loc3:*=0;
            var loc4:*=loc1;
            for each (loc2 in loc4) 
            {
                arg1(loc2, this.get(loc2));
            }
            return;
        }

        internal var entries:org.idmedia.as3commons.util.Set;
    }
}


class EntryImpl extends Object implements org.idmedia.as3commons.util.Entry
{
    public function EntryImpl(arg1:*, arg2:*)
    {
        super();
        this.key = arg1;
        this.value = arg2;
        return;
    }

    public function getKey():*
    {
        return this.key;
    }

    public function getValue():*
    {
        return this.value;
    }

    public function setValue(arg1:*):*
    {
        var loc1:*=this.value;
        this.value = arg1;
        return loc1;
    }

    public function equals(arg1:*):Boolean
    {
        return arg1 === this;
    }

    internal var key:*;

    internal var value:*;
}