package net.wg.infrastructure.exceptions 
{
    import net.wg.infrastructure.exceptions.base.*;
    
    public class TypeCastException extends net.wg.infrastructure.exceptions.base.WGGUIException
    {
        public function TypeCastException(arg1:*="", arg2:*=0)
        {
            super(arg1, arg2);
            return;
        }
    }
}
