package net.wg.gui.intro 
{
    import net.wg.data.daapi.base.*;
    
    public class IntroInfoVO extends net.wg.data.daapi.base.DAAPIDataClass
    {
        public function IntroInfoVO(arg1:Object)
        {
            super(arg1);
            return;
        }

        public var source:String="";

        public var volume:Number;
    }
}
