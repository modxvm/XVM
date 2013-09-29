package net.wg.infrastructure.exceptions 
{
    import net.wg.infrastructure.exceptions.base.*;
    
    public class EnvironmentException extends net.wg.infrastructure.exceptions.base.WGGUIException
    {
        public function EnvironmentException(arg1:*="", arg2:*=0)
        {
            super(arg1, arg2);
            return;
        }
    }
}
