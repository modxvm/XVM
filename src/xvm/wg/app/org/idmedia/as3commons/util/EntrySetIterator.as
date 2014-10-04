package org.idmedia.as3commons.util
{
    import org.idmedia.as3commons.lang.NoSuchElementException;
    import org.idmedia.as3commons.lang.IllegalStateException;
    
    public class EntrySetIterator extends Object implements Iterator
    {
        
        public function EntrySetIterator(param1:EntrySet = null)
        {
            super();
            this.s = param1;
        }
        
        private var cursor:int = 0;
        
        private var current:Entry = null;
        
        private var s:EntrySet = null;
        
        public function hasNext() : Boolean
        {
            return this.cursor < this.s.size();
        }
        
        public function next() : *
        {
            var _loc1_:int = this.s.size();
            this.current = this.s.get(this.cursor++) as Entry;
            if(this.current == null)
            {
                throw new NoSuchElementException();
            }
            else
            {
                return this.current;
            }
        }
        
        public function remove() : void
        {
            if(this.current == null)
            {
                throw new IllegalStateException();
            }
            else
            {
                var _loc1_:* = this.current.getKey();
                this.current = null;
                this.s.removeEntryForKey(_loc1_);
                return;
            }
        }
    }
}
