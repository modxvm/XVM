package org.idmedia.as3commons.lang 
{
    import flash.utils.*;
    
    public class Throwable extends Error
    {
        public function Throwable(arg1:String)
        {
            super(arg1);
            return;
        }

        public function getMessage():String
        {
            return message;
        }

        public function getName():String
        {
            return flash.utils.getQualifiedClassName(this);
        }
    }
}
