package org.idmedia.as3commons.util 
{
    import org.idmedia.as3commons.lang.*;
    
    internal class EntrySetIterator extends Object implements org.idmedia.as3commons.util.Iterator
    {
        public function EntrySetIterator(arg1:EntrySet=null)
        {
            super();
            this.s = arg1;
            return;
        }

        public function hasNext():Boolean
        {
            return this.cursor < this.s.size();
        }

        public function next():*
        {
            var loc1:*=this.s.size();
            var loc2:*;
            var loc3:*=((loc2 = this).cursor + 1);
            loc2.cursor = loc3;
            this.current = this.s.get((loc2 = this).cursor) as org.idmedia.as3commons.util.Entry;
            if (this.current == null) 
            {
                throw new org.idmedia.as3commons.lang.NoSuchElementException();
            }
            return this.current;
        }

        public function remove():void
        {
            if (this.current == null) 
            {
                throw new org.idmedia.as3commons.lang.IllegalStateException();
            }
            var loc1:*=this.current.getKey();
            this.current = null;
            this.s.removeEntryForKey(loc1);
            return;
        }

        internal var cursor:int=0;

        internal var current:org.idmedia.as3commons.util.Entry=null;

        internal var s:EntrySet=null;
    }
}
