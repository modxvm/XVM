package net.wg.infrastructure 
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.utils.*;
    
    public class BaseImporter extends flash.display.Sprite
    {
        public function BaseImporter()
        {
            super();
            return;
        }

        protected final function importClasses(arg1:__AS3__.vec.Vector.<Class>, arg2:Boolean=false):void
        {
            var loc1:*=null;
            if (arg2 && arg1) 
            {
                trace("Importing " + flash.utils.getQualifiedClassName(this) + ":...");
                var loc2:*=0;
                var loc3:*=arg1;
                for each (loc1 in loc3) 
                    trace("--" + loc1);
            }
            return;
        }
    }
}
