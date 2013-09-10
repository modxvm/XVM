package org.idmedia.as3commons.util 
{
    import org.idmedia.as3commons.lang.*;
    
    public class AbstractMap extends Object implements org.idmedia.as3commons.util.Map
    {
        public function AbstractMap()
        {
            super();
            return;
        }

        public function put(arg1:*, arg2:*):*
        {
            throw new org.idmedia.as3commons.lang.UnsupportedOperationException();
        }

        public function get(arg1:*):*
        {
            var loc3:*=null;
            if (arg1 === undefined) 
                return null;
            var loc1:*=arg1;
            var loc2:*=this.entrySet().iterator();
            while (loc2.hasNext()) 
            {
                loc3 = loc2.next() as org.idmedia.as3commons.util.Entry;
                if (loc1 !== loc3.getKey()) 
                    continue;
                return loc3.getValue();
            }
            return null;
        }

        public function containsKey(arg1:*):Boolean
        {
            var loc3:*=null;
            var loc1:*=arg1 || null;
            var loc2:*=this.entrySet().iterator();
            while (loc2.hasNext()) 
            {
                loc3 = loc2.next() as org.idmedia.as3commons.util.Entry;
                if (loc1 !== loc3.getKey()) 
                    continue;
                return true;
            }
            return false;
        }

        public function containsValue(arg1:*):Boolean
        {
            var loc3:*=null;
            var loc1:*=arg1 || null;
            var loc2:*=this.entrySet().iterator();
            while (loc2.hasNext()) 
            {
                loc3 = loc2.next() as org.idmedia.as3commons.util.Entry;
                if (loc1 !== loc3.getValue()) 
                    continue;
                return true;
            }
            return false;
        }

        public function remove(arg1:*):*
        {
            var loc5:*=null;
            var loc1:*=arg1 || null;
            var loc2:*=this.entrySet().iterator();
            var loc3:*=null;
            while (loc3 == null && loc2.hasNext()) 
            {
                loc5 = org.idmedia.as3commons.util.Entry(loc2.next());
                if (arg1 !== loc5.getKey()) 
                    continue;
                loc3 = loc5;
            }
            var loc4:*=null;
            if (loc3 != null) 
            {
                loc4 = loc3.getValue();
                loc2.remove();
            }
            return loc4;
        }

        public function clear():void
        {
            this.entrySet().clear();
            return;
        }

        public function size():int
        {
            return this.entrySet().size();
        }

        public function values():org.idmedia.as3commons.util.Collection
        {
            if (this.v == null) 
                this.v = new CollectionImpl(this);
            return this.v;
        }

        public function keySet():org.idmedia.as3commons.util.Set
        {
            if (this.k == null) 
                this.k = new AbstractEntrySet(this);
            return this.k;
        }

        public function entrySet():org.idmedia.as3commons.util.Set
        {
            throw new org.idmedia.as3commons.lang.UnsupportedOperationException();
        }

        public function isEmpty():Boolean
        {
            return this.size() == 0;
        }

        public function putAll(arg1:org.idmedia.as3commons.util.Map):void
        {
            var loc2:*=null;
            var loc1:*=arg1.entrySet().iterator();
            while (loc1.hasNext()) 
            {
                loc2 = loc1.next() as org.idmedia.as3commons.util.Entry;
                this.put(loc2.getKey(), loc2.getValue());
            }
            return;
        }

        public function equals(arg1:*):Boolean
        {
            return arg1 === this;
        }

        internal var v:org.idmedia.as3commons.util.Collection=null;

        internal var k:org.idmedia.as3commons.util.Set=null;
    }
}


class AbstractEntrySet extends org.idmedia.as3commons.util.AbstractSet
{
    public function AbstractEntrySet(arg1:org.idmedia.as3commons.util.Map)
    {
        super();
        this.m = arg1;
        return;
    }

    public override function iterator():org.idmedia.as3commons.util.Iterator
    {
        return new KeyIterator(this.m.entrySet().iterator());
    }

    public override function size():int
    {
        return this.m.size();
    }

    public override function contains(arg1:*):Boolean
    {
        return this.m.containsKey(arg1);
    }

    internal var m:org.idmedia.as3commons.util.Map=null;
}

final class CollectionImpl extends org.idmedia.as3commons.util.AbstractCollection
{
    public function CollectionImpl(arg1:org.idmedia.as3commons.util.Map)
    {
        super();
        this.map = arg1;
        return;
    }

    public override function iterator():org.idmedia.as3commons.util.Iterator
    {
        return new ValueIterator(this.map.entrySet().iterator());
    }

    public override function size():int
    {
        return this.map.size();
    }

    internal var map:org.idmedia.as3commons.util.Map;
}

class KeyIterator extends Object implements org.idmedia.as3commons.util.Iterator
{
    public function KeyIterator(arg1:org.idmedia.as3commons.util.Iterator)
    {
        super();
        this.iter = arg1;
        return;
    }

    public function hasNext():Boolean
    {
        return this.iter.hasNext();
    }

    public function next():*
    {
        return org.idmedia.as3commons.util.Entry(this.iter.next()).getKey();
    }

    public function remove():void
    {
        this.iter.remove();
        return;
    }

    protected var iter:org.idmedia.as3commons.util.Iterator;
}

final class ValueIterator extends KeyIterator
{
    public function ValueIterator(arg1:org.idmedia.as3commons.util.Iterator)
    {
        super(arg1);
        return;
    }

    public override function next():*
    {
        return org.idmedia.as3commons.util.Entry(iter.next()).getValue();
    }
}