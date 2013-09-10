package net.wg.gui.lobby.settings.vo 
{
    import net.wg.gui.lobby.settings.*;
    import net.wg.utils.*;
    
    public class SettingsKeyProp extends Object
    {
        public function SettingsKeyProp(arg1:String, arg2:Boolean, arg3:String, arg4:String=null, arg5:Number=NaN, arg6:Number=NaN, arg7:Array=null, arg8:Boolean=false, arg9:Number=0)
        {
            var loc2:*=0;
            var loc3:*=null;
            var loc4:*=0;
            var loc5:*=null;
            var loc6:*=null;
            super();
            this.id = arg1;
            this.header = arg2;
            this.keysRang = net.wg.gui.lobby.settings.SettingsConfig.KEY_RANGE.hasOwnProperty(arg1) ? net.wg.gui.lobby.settings.SettingsConfig.KEY_RANGE[arg1] : net.wg.gui.lobby.settings.SettingsConfig.KEY_RANGE["defaultRange"];
            var loc1:*=null;
            loc1 = null;
            if (arg7) 
            {
                if (loc2 = arg7.length) 
                {
                    loc1 = "";
                    loc3 = App.utils.locale;
                    loc4 = 0;
                    while (loc4 < loc2) 
                    {
                        loc5 = loc3.makeString(arg7[loc4].hasOwnProperty("header") && !(arg7[loc4]["header"] == undefined) ? arg7[loc4]["header"] : "");
                        loc6 = loc3.makeString(arg7[loc4].hasOwnProperty("label") && !(arg7[loc4]["label"] == undefined) ? arg7[loc4]["label"] : "");
                        loc1 = loc1 + (loc5 + " <font size=\"11\" color=\"#615f4f\">" + loc6 + "</font><br/>");
                        ++loc4;
                    }
                }
            }
            if (loc1) 
            {
                this.label = loc1;
            }
            else 
            {
                this.label = App.utils.locale.makeString(this.header ? SETTINGS.keyboard_keysblocks_group(arg3) : SETTINGS.keyboard_keysblocks_command(arg3));
            }
            this.command = arg4;
            this.key = arg5;
            this.keyDefault = arg6;
            this.showUnderline = arg8;
            this.rendererYOffset = arg9;
            return;
        }

        public function getObject():Object
        {
            return {"id":this.id, "header":this.header, "label":this.label, "command":this.command, "key":this.key, "keyDefault":this.keyDefault, "keysRang":this.keysRang, "showUnderline":this.showUnderline, "rendererYOffset":this.rendererYOffset};
        }

        public var id:String=null;

        public var header:Boolean=false;

        public var label:String=null;

        public var command:String=null;

        public var key:Number=NaN;

        public var keyDefault:Number=NaN;

        public var keysRang:Array;

        public var showUnderline:Boolean=false;

        public var rendererYOffset:Number=0;
    }
}
