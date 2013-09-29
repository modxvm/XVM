package net.wg.data.daapi.base 
{
    import avmplus.*;
    import flash.events.*;
    import net.wg.data.constants.*;
    import net.wg.infrastructure.exceptions.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.utils.*;
    
    public class DAAPIDataClass extends flash.events.EventDispatcher implements net.wg.infrastructure.interfaces.IDAAPIDataClass
    {
        public function DAAPIDataClass(arg1:Object)
        {
            super();
            this.fromHash(arg1);
            return;
        }

        public function fromHash(arg1:Object):void
        {
            var loc3:*=null;
            var loc4:*=undefined;
            var loc5:*=null;
            var loc6:*=null;
            var loc7:*=null;
            var loc8:*=null;
            var loc1:*=App.utils.asserter;
            loc1.assertNotNull(arg1, "Hash" + net.wg.data.constants.Errors.CANT_NULL);
            this._hash = arg1;
            var loc2:*="can\'t find property for DAAPI data binding: ";
            var loc9:*=0;
            var loc10:*=arg1;
            for (loc3 in loc10) 
            {
                loc4 = arg1[loc3];
                loc5 = loc3;
                if (!this.onDataWrite(loc5, loc4)) 
                {
                    continue;
                }
                loc1.assert(hasOwnProperty(loc5), loc2 + loc5, net.wg.infrastructure.exceptions.DAAPIBindException);
                if (loc4 != undefined) 
                {
                    loc6 = typeof this[loc3];
                    loc7 = typeof loc4;
                    if (loc6 == "object") 
                    {
                        loc1.assert(loc7 == "object", "incorrect cast value \'" + loc4 + "\' to field with type Object." + " Please, change type of \'" + avmplus.getQualifiedClassName(this) + "." + loc3 + "\' field  to \'" + loc7 + "\' type or initialize it as Values.EMPTY_STR", net.wg.infrastructure.exceptions.DAAPIBindException);
                    }
                    else 
                    {
                        loc8 = "invalid type on property \'" + avmplus.getQualifiedClassName(this) + "." + loc3 + "\': can`t cast value \'" + loc4 + "\' with type \'" + loc7 + "\'to \'" + loc6 + "\'";
                        loc1.assert(loc6 == loc7, loc8, net.wg.infrastructure.exceptions.DAAPIBindException);
                    }
                }
                this[loc3] = loc4;
            }
            return;
        }

        public function dispose():void
        {
            var loc1:*=null;
            var loc2:*=undefined;
            var loc3:*=null;
            var loc4:*=0;
            var loc5:*=this._hash;
            for (loc1 in loc5) 
            {
                loc2 = this._hash[loc1];
                loc3 = loc1;
                delete this[loc1];
            }
            this._hash = null;
            return;
        }

        public function toHash():Object
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            var loc1:*={};
            var loc5:*=0;
            var loc6:*=this;
            for (loc2 in loc6) 
            {
                loc3 = loc1[loc2];
                loc4 = loc2.substr(1);
                if (!this.onDataRead(loc2, loc1)) 
                {
                    continue;
                }
                loc1[loc4] = loc3;
            }
            return loc1;
        }

        protected function onDataWrite(arg1:String, arg2:Object):Boolean
        {
            return true;
        }

        protected function onDataRead(arg1:String, arg2:Object):Boolean
        {
            return true;
        }

        internal var _hash:Object=null;
    }
}
