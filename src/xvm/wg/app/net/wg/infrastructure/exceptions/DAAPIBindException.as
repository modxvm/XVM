package net.wg.infrastructure.exceptions 
{
    import net.wg.infrastructure.exceptions.base.*;
    
    public class DAAPIBindException extends net.wg.infrastructure.exceptions.base.WGGUIException
    {
        public function DAAPIBindException(arg1:*="", arg2:*=0)
        {
            super(arg1, arg2);
            return;
        }
    }
}
