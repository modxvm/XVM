package net.wg.gui.lobby.settings 
{
    public class SettingsChangesMap extends Object
    {
        public function SettingsChangesMap()
        {
            super();
            this.clear();
            return;
        }

        public function clear():void
        {
            this.clearObject(this._data);
            this._data = new Object();
            this._len = 0;
            return;
        }

        internal function clearObject(arg1:Object):void
        {
            var loc1:*=null;
            if (arg1) 
            {
                var loc2:*=0;
                var loc3:*=arg1;
                for (loc1 in loc3) 
                {
                    if (!(arg1[loc1] is String) && !(arg1[loc1] is Number) && !(arg1[loc1] is Boolean)) 
                    {
                        delete this._data[loc1];
                        continue;
                    }
                    this.clearObject(this._data[loc1]);
                }
            }
            return;
        }

        public function tryAddChanges(arg1:String, arg2:*):void
        {
            this.addChanges(this._data, arg1, arg2);
            return;
        }

        internal function addChanges(arg1:Object, arg2:String, arg3:*):void
        {
            var loc1:*=null;
            if (arg1.hasOwnProperty(arg2)) 
            {
                if (!(arg3 is String) && !(arg3 is Number) && !(arg3 is Boolean)) 
                {
                    loc2 = 0;
                    loc3 = arg3;
                    for (loc1 in loc3) 
                    {
                        this.addChanges(arg1[arg2], loc1, arg3[loc1]);
                    }
                }
                else 
                {
                    arg1[arg2] = arg3;
                }
            }
            else 
            {
                var loc2:*;
                var loc3:*=((loc2 = this)._len + 1);
                loc2._len = loc3;
                arg1[arg2] = arg3;
            }
            return;
        }

        public function tryCutChanges(arg1:String, arg2:*):void
        {
            this.cutChanges(this._data, arg1, arg2);
            return;
        }

        internal function cutChanges(arg1:Object, arg2:String, arg3:*):Boolean
        {
            var loc1:*=null;
            var loc2:*=false;
            var loc3:*=0;
            var loc4:*=null;
            if (arg1.hasOwnProperty(arg2)) 
            {
                if (!(arg3 is String) && !(arg3 is Number) && !(arg3 is Boolean)) 
                {
                    var loc5:*=0;
                    var loc6:*=arg3;
                    for (loc1 in loc6) 
                    {
                        if (!(loc2 = this.cutChanges(arg1[arg2], loc1, arg3[loc1]))) 
                        {
                            continue;
                        }
                        loc3 = 0;
                        var loc7:*=0;
                        var loc8:*=arg1[arg2];
                        for (loc4 in loc8) 
                        {
                            ++loc3;
                        }
                        if (loc3 != 0) 
                        {
                            continue;
                        }
                        delete arg1[arg2];
                        return true;
                    }
                    return false;
                }
                loc6 = ((loc5 = this)._len - 1);
                loc5._len = loc6;
                delete arg1[arg2];
                return true;
            }
            return false;
        }

        public function get length():uint
        {
            return this._len;
        }

        public function getChanges():Object
        {
            return this._data;
        }

        public function debug():void
        {
            var loc1:*=null;
            var loc2:*=null;
            trace(" ");
            trace(" ");
            trace("//////////////////////////////////////////////////////////////");
            trace("------------------------------------SettingsChangesMap: ", this.length);
            var loc3:*=0;
            var loc4:*=this._data;
            for (loc1 in loc4) 
            {
                trace("SettingsChangesMap:", loc1, this._data[loc1]);
                var loc5:*=0;
                var loc6:*=this._data[loc1];
                for (loc2 in loc6) 
                {
                    trace("------", loc2, this._data[loc1][loc2]);
                }
            }
            trace("**************************************************************");
            return;
        }

        internal var _data:Object;

        internal var _len:uint;
    }
}
