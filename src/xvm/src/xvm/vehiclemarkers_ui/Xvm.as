/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.vehiclemarkers_ui
{
    import com.xfw.*;
    import flash.display.*;

    /**
     *  This class is used to link UI classes into *_ui.swf
     */
    public class Xvm extends Sprite
    {
        public function Xvm():void
        {
            Xfw.addCommandListener("xvm.as.set_config", onSetConfig);
        }

        private function onSetConfig(config_data:Object, lang_data:Object, vehInfo_data:Array,
            networkServicesSettings:Object, IS_DEVELOPMENT:Boolean):void
        {
            Logger.addObject("IS_DEVELOPMENT=" + IS_DEVELOPMENT);
            Logger.add("onSetConfig");
            Logger.addObject(config_data);
            Logger.addObject(lang_data);
            //Logger.addObject(vehInfo_data);
            Logger.addObject(networkServicesSettings);
        }
    }
}
