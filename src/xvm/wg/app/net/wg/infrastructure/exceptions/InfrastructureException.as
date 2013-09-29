package net.wg.infrastructure.exceptions 
{
    import net.wg.infrastructure.exceptions.base.*;
    
    public class InfrastructureException extends net.wg.infrastructure.exceptions.base.WGGUIException
    {
        public function InfrastructureException(arg1:String="", arg2:*=0)
        {
            super(arg1, arg2);
            return;
        }
    }
}
