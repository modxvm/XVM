package net.wg.infrastructure.exceptions 
{
    import net.wg.infrastructure.exceptions.base.*;
    
    public class LifecycleException extends net.wg.infrastructure.exceptions.base.WGGUIException
    {
        public function LifecycleException(arg1:*="", arg2:*=0)
        {
            super(arg1, arg2);
            return;
        }
    }
}
