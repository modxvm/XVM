/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.lobby.hangar
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.infrastructure.*;
    import com.xvm.types.cfg.*;
    import flash.events.*;
    import net.wg.gui.lobby.hangar.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;

    public class HangarXvmView extends XvmViewBase
    {
        public static const ON_HANGAR_AFTER_POPULATE:String = "ON_HANGAR_AFTER_POPULATE";
        public static const ON_HANGAR_BEFORE_DISPOSE:String = "ON_HANGAR_BEFORE_DISPOSE";

        private var _disposed:Boolean = false;

        public function HangarXvmView(view:IView)
        {
            super(view);
        }

        public function get page():Hangar
        {
            return super.view as Hangar;
        }

        public override function onAfterPopulate(e:LifeCycleEvent):void
        {
            super.onAfterPopulate(e);

            // fix bottomBg height and position - original is too high and affects carousel
            page.bottomBg.height = 47; // MESSENGER_BAR_PADDING + 2
            page.bottomBg.y = App.appHeight - 90; // MESSENGER_BAR_PADDING * 2

            Xfw.addCommandListener(XvmCommands.AS_UPDATE_CURRENT_VEHICLE, onUpdateCurrentVehicle);

            App.utils.scheduler.scheduleOnNextFrame(function():void {
                setup();
            });

            Xvm.dispatchEvent(new Event(ON_HANGAR_AFTER_POPULATE));
        }

        override public function onBeforeDispose(e:LifeCycleEvent):void
        {
            super.onBeforeDispose(e);
            // This method is called twice on config reload
            if (_disposed)
                return;
            _disposed = true;

            //Logger.add("ON_HANGAR_BEFORE_DISPOSE");
            Xvm.dispatchEvent(new Event(ON_HANGAR_BEFORE_DISPOSE));
            Xfw.removeCommandListener(XvmCommands.AS_UPDATE_CURRENT_VEHICLE, onUpdateCurrentVehicle);
        }

        // PRIVATE

        private function setup():void
        {
            //setupTxtTankInfo(); // TODO:1.8.0
            //setupBtnCommonQuests(); // TODO:1.1
            //setupBtnPersonalQuests(); // TODO:1.1
        }

        // txtTankInfo
        // TODO:1.8.0
        /*
        private var _orig_txtTankInfo_x:Number = NaN;
        private var _orig_txtTankInfo_y:Number = NaN;
        private var _orig_tankTypeIcon_x:Number = NaN;
        private var _orig_tankTypeIcon_y:Number = NaN;
        private function setupTxtTankInfo():void
        {
            try
            {
            var cfg:CHangarElement = Config.config.hangar.vehicleName;
            if (!cfg.enabled)
            {
                page.xfw_header.txtTankInfo.mouseEnabled = false;
                page.xfw_header.txtTankInfo.alpha = 0;
                page.xfw_header.tankTypeIcon.mouseEnabled = false;
                page.xfw_header.tankTypeIcon.alpha = 0;
            }
            else
            {
                page.xfw_header.txtTankInfo.mouseEnabled = true;
                if (isNaN(_orig_txtTankInfo_x))
                {
                    _orig_txtTankInfo_x = page.xfw_header.txtTankInfo.x;
                    _orig_txtTankInfo_y = page.xfw_header.txtTankInfo.y;
                }
                page.xfw_header.txtTankInfo.x = _orig_txtTankInfo_x + cfg.offsetX;
                page.xfw_header.txtTankInfo.y = _orig_txtTankInfo_y + cfg.offsetY;
                page.xfw_header.txtTankInfo.alpha = cfg.alpha / 100.0;
                page.xfw_header.txtTankInfo.rotation = cfg.rotation;

                page.xfw_header.tankTypeIcon.mouseEnabled = true;
                if (isNaN(_orig_tankTypeIcon_x))
                {
                    _orig_tankTypeIcon_x = page.xfw_header.tankTypeIcon.x;
                    _orig_tankTypeIcon_y = page.xfw_header.tankTypeIcon.y;
                }
                page.xfw_header.tankTypeIcon.x = _orig_tankTypeIcon_x + cfg.offsetX;
                page.xfw_header.tankTypeIcon.y = _orig_tankTypeIcon_y + cfg.offsetY;
                page.xfw_header.tankTypeIcon.alpha = cfg.alpha / 100.0;
                page.xfw_header.tankTypeIcon.rotation = cfg.rotation;
            }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }
        */

        // btnCommonQuests
        // TODO:1.1
        /*
        private var _orig_btnCommonQuests_x:Number = NaN;
        private var _orig_btnCommonQuests_y:Number = NaN;
        private function setupBtnCommonQuests():void
        {
            var cfg:CHangarElement = Config.config.hangar.commonQuests;
            if (!cfg.enabled)
            {
                page.xfw_header.btnCommonQuests.mouseEnabled = false;
                page.xfw_header.btnCommonQuests.alpha = 0;
            }
            else
            {
                page.xfw_header.btnCommonQuests.mouseEnabled = true;
                if (isNaN(_orig_btnCommonQuests_x))
                {
                    _orig_btnCommonQuests_x = page.xfw_header.btnCommonQuests.x;
                    _orig_btnCommonQuests_y = page.xfw_header.btnCommonQuests.y;
                }
                page.xfw_header.btnCommonQuests.x = _orig_btnCommonQuests_x + cfg.offsetX;
                page.xfw_header.btnCommonQuests.y = _orig_btnCommonQuests_y + cfg.offsetY;
                page.xfw_header.btnCommonQuests.alpha = cfg.alpha / 100.0;
                page.xfw_header.btnCommonQuests.rotation = cfg.rotation;
            }
        }
        */

        // btnPersonalQuests
        // TODO:1.1
        /*
        private var _orig_btnPersonalQuests_x:Number = NaN;
        private var _orig_btnPersonalQuests_y:Number = NaN;
        private function setupBtnPersonalQuests():void
        {
            var cfg:CHangarElement = Config.config.hangar.personalQuests;
            if (!cfg.enabled)
            {
                page.xfw_header.btnPersonalQuests.mouseEnabled = false;
                page.xfw_header.btnPersonalQuests.alpha = 0;
            }
            else
            {
                page.xfw_header.btnPersonalQuests.mouseEnabled = true;
                if (isNaN(_orig_btnPersonalQuests_x))
                {
                    _orig_btnPersonalQuests_x = page.xfw_header.btnPersonalQuests.x;
                    _orig_btnPersonalQuests_y = page.xfw_header.btnPersonalQuests.y;
                }
                page.xfw_header.btnPersonalQuests.x = _orig_btnPersonalQuests_x + cfg.offsetX;
                page.xfw_header.btnPersonalQuests.y = _orig_btnPersonalQuests_y + cfg.offsetY;
                page.xfw_header.btnPersonalQuests.alpha = cfg.alpha / 100.0;
                page.xfw_header.btnPersonalQuests.rotation = cfg.rotation;
            }
        }
        */

        //

        private function onUpdateCurrentVehicle(vehCD:int, data:Object):Object
        {
            try
            {
                if (!Config.config.minimap.circles._internal)
                    Config.config.minimap.circles._internal = new CMinimapCirclesInternal();
                for (var n:String in data)
                    Config.config.minimap.circles._internal[n] = data[n];

                VehicleParams.updateVehicleParams(page.params);
                App.utils.scheduler.scheduleOnNextFrame(function():void
                {
                    VehicleParams.updateVehicleParams(page.params);
                });
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }

            return null;
        }
    }
}
