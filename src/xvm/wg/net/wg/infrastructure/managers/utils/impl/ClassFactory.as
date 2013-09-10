package net.wg.infrastructure.managers.utils.impl 
{
    import flash.display.*;
    import flash.utils.*;
    import net.wg.data.constants.*;
    import net.wg.infrastructure.exceptions.*;
    import net.wg.utils.*;
    
    public class ClassFactory extends Object implements net.wg.utils.IClassFactory
    {
        public function ClassFactory()
        {
            super();
            return;
        }

        public function getClass(arg1:String):Class
        {
            var classpath:String;
            var outcomeClass:Class;

            var loc1:*;
            classpath = arg1;
            outcomeClass = null;
            try 
                outcomeClass = flash.utils.getDefinitionByName(classpath) as Class;
            catch (e:ReferenceError)
            {
                DebugUtils.LOG_ERROR(net.wg.data.constants.Errors.BAD_LINKAGE + classpath);
            }
            return outcomeClass;
        }

        public function getObject(arg1:String, arg2:Object=null):Object
        {
            var loc3:*=null;
            var loc4:*=null;
            var loc1:*=null;
            var loc2:*;
            if ((loc2 = this.getClass(arg1)) != null) 
            {
                loc1 = new loc2();
                if (arg2 != null) 
                {
                    var loc5:*=0;
                    var loc6:*=arg2;
                    for (loc3 in loc6) 
                    {
                        if (loc1.hasOwnProperty(loc3)) 
                        {
                            loc1[loc3] = arg2[loc3];
                            continue;
                        }
                        loc4 = "object with linkage \'" + arg1 + "\' doesn`t contain property " + "with name \'" + loc3 + "\'. Initialization error.";
                        throw new net.wg.infrastructure.exceptions.ArgumentException(loc4);
                    }
                }
            }
            return loc1;
        }

        public function getComponent(arg1:String, arg2:Class, arg3:Object=null):*
        {
            var loc1:*=this.getObject(arg1, arg3);
            var loc2:*;
            var loc3:*=(loc2 = "object with \"" + arg1 + "\" linkage ") + "is not a component from library!";
            var loc4:*=loc2 + "can`t cast to " + arg2;
            var loc5:*;
            (loc5 = App.utils.asserter).assert(loc1 is flash.display.DisplayObject, loc3, net.wg.infrastructure.exceptions.InvalidComponentCastException);
            loc5.assert(loc1 is arg2, loc4, net.wg.infrastructure.exceptions.InvalidComponentCastException);
            return loc1;
        }
    }
}
