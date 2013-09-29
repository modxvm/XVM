package org.idmedia.as3commons.util 
{
    import org.idmedia.as3commons.lang.*;
    
    public class AbstractCollection extends Object implements org.idmedia.as3commons.util.Collection
    {
        public function AbstractCollection()
        {
            super();
            return;
        }

        public function add(arg1:*):Boolean
        {
            throw new org.idmedia.as3commons.lang.UnsupportedOperationException();
        }

        public function addAll(arg1:org.idmedia.as3commons.util.Collection):Boolean
        {
            var loc1:*=false;
            var loc2:*=arg1.iterator();
            while (loc2.hasNext()) 
            {
                if (!this.add(loc2.next())) 
                {
                    continue;
                }
                loc1 = true;
            }
            return loc1;
        }

        public function clear():void
        {
            var loc1:*=this.iterator();
            while (loc1.hasNext()) 
            {
                loc1.next();
                loc1.remove();
            }
            return;
        }

        public function contains(arg1:*):Boolean
        {
            return this.toArray().indexOf(arg1) > -1;
        }

        public function containsAll(arg1:org.idmedia.as3commons.util.Collection):Boolean
        {
            var loc1:*=arg1.iterator();
            while (loc1.hasNext()) 
            {
                if (this.contains(loc1.next())) 
                {
                    continue;
                }
                return false;
            }
            return true;
        }

        public function isEmpty():Boolean
        {
            return this.size() == 0;
        }

        public function iterator():org.idmedia.as3commons.util.Iterator
        {
            return null;
        }

        public function remove(arg1:*=null):Boolean
        {
            var loc1:*=this.iterator();
            while (loc1.hasNext()) 
            {
                if (loc1.next() != arg1) 
                {
                    continue;
                }
                loc1.remove();
                return true;
            }
            return false;
        }

        public function size():int
        {
            return 0;
        }

        public function toArray():Array
        {
            var loc1:*=new Array();
            var loc2:*=this.iterator();
            while (loc2.hasNext()) 
            {
                loc1.push(loc2.next());
            }
            return loc1;
        }

        public function equals(arg1:*):Boolean
        {
            return arg1 === this;
        }
    }
}
