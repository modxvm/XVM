package org.idmedia.as3commons.util 
{
    import org.idmedia.as3commons.lang.*;
    
    public class AbstractSet extends org.idmedia.as3commons.util.AbstractCollection implements org.idmedia.as3commons.util.Set
    {
        public function AbstractSet()
        {
            super();
            return;
        }

        public override function equals(arg1:*):Boolean
        {
            var o:*;
            var c:org.idmedia.as3commons.util.Collection;

            var loc1:*;
            o = arg1;
            if (o === this) 
                return true;
            if (!(o is org.idmedia.as3commons.util.Set)) 
                return false;
            c = org.idmedia.as3commons.util.Collection(o);
            if (c.size() != size()) 
                return false;
            try 
                return containsAll(c);
            catch (unused:org.idmedia.as3commons.lang.NullPointerException)
            {
                return false;
            }
            return false;
        }
    }
}
