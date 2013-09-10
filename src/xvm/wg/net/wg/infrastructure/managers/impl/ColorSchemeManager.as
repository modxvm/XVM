package net.wg.infrastructure.managers.impl 
{
    import flash.geom.*;
    import net.wg.data.constants.*;
    import net.wg.infrastructure.base.meta.impl.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.infrastructure.managers.*;
    
    public class ColorSchemeManager extends net.wg.infrastructure.base.meta.impl.ColorSchemeManagerMeta implements net.wg.infrastructure.managers.IColorSchemeManager
    {
        public function ColorSchemeManager()
        {
            super();
            return;
        }

        public function getScheme(arg1:String):net.wg.infrastructure.interfaces.IColorScheme
        {
            var loc1:*=App.utils.classFactory.getClass(net.wg.data.constants.Linkages.CLR_CSS);
            return new loc1(getColorSchemeS(arg1));
        }

        public function getAliasColor(arg1:String):String
        {
            return this.getScheme(arg1).aliasColor;
        }

        public function getRGB(arg1:String):Number
        {
            return this.getScheme(arg1).rgb;
        }

        public function getTransform(arg1:String):flash.geom.ColorTransform
        {
            return this.getScheme(arg1).colorTransform;
        }

        public function as_update():void
        {
            dispatchEvent(new net.wg.infrastructure.events.ColorSchemeEvent(net.wg.infrastructure.events.ColorSchemeEvent.SCHEMAS_UPDATED));
            return;
        }
    }
}
