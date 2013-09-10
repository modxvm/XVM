package org.idmedia.as3commons.util 
{
    import org.idmedia.as3commons.lang.*;
    
    internal class EntrySet extends org.idmedia.as3commons.util.AbstractSet
    {
        public function EntrySet()
        {
            super();
            this.table = new Array();
            this.tableSize = 0;
            return;
        }

        public override function iterator():org.idmedia.as3commons.util.Iterator
        {
            return new EntrySetIterator(this);
        }

        public override function add(arg1:*):Boolean
        {
            if (!(arg1 is org.idmedia.as3commons.util.Entry)) 
                throw new org.idmedia.as3commons.lang.IllegalArgumentException();
            if (!contains(arg1)) 
            {
                this.table.push(arg1);
                var loc1:*;
                var loc2:*=((loc1 = this).tableSize + 1);
                loc1.tableSize = loc2;
                return true;
            }
            return false;
        }

        public override function remove(arg1:*=null):Boolean
        {
            var loc1:*=0;
            while (loc1 < this.tableSize) 
            {
                if (org.idmedia.as3commons.util.Entry(arg1).equals(this.table[loc1])) 
                {
                    this.table.splice(loc1, 1);
                    var loc2:*;
                    var loc3:*=((loc2 = this).tableSize - 1);
                    loc2.tableSize = loc3;
                    return true;
                }
                ++loc1;
            }
            return false;
        }

        public function get(arg1:int):*
        {
            return this.table[arg1];
        }

        public function removeEntryForKey(arg1:*):org.idmedia.as3commons.util.Entry
        {
            var loc1:*=null;
            var loc2:*=0;
            while (loc2 < this.tableSize) 
            {
                if (org.idmedia.as3commons.util.Entry(this.table[loc2]).getKey() === arg1) 
                {
                    loc1 = this.table[loc2];
                    this.table.splice(loc2, 1);
                    var loc3:*;
                    var loc4:*=((loc3 = this).tableSize - 1);
                    loc3.tableSize = loc4;
                    return loc1;
                }
                ++loc2;
            }
            return loc1;
        }

        public override function size():int
        {
            return this.tableSize;
        }

        internal var table:Array;

        internal var tableSize:int;
    }
}
