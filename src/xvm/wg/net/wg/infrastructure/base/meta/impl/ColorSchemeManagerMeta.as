package net.wg.infrastructure.base.meta.impl 
{
    import net.wg.data.constants.*;
    import net.wg.infrastructure.base.*;
    
    public class ColorSchemeManagerMeta extends net.wg.infrastructure.base.BaseDAAPIModule
    {
        public function ColorSchemeManagerMeta()
        {
            super();
            return;
        }

        public function getColorSchemeS(arg1:String):Object
        {
            App.utils.asserter.assertNotNull(this.getColorScheme, "getColorScheme" + net.wg.data.constants.Errors.CANT_NULL);
            return this.getColorScheme(arg1);
        }

        public var getColorScheme:Function=null;
    }
}
