/**
 * XVM - hangar
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.lobby.hangar
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.infrastructure.*;
    import com.xvm.types.cfg.*;
    import com.xvm.lobby.hangar.components.*;
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
            //Logger.add("onAfterPopulate: " + view.as_alias);
            //Logger.addObject(page);

            // fix bottomBg height - original is too high and affects carousel
            page.bottomBg.height = 45; // MESSENGER_BAR_PADDING

            //XfwUtils.logChilds(page);

            Xfw.addCommandListener(XvmCommands.AS_UPDATE_CURRENT_VEHICLE, onUpdateCurrentVehicle);

            setup();

            //Logger.add("ON_HANGAR_AFTER_POPULATE");
            Xvm.dispatchEvent(new Event(ON_HANGAR_AFTER_POPULATE));
        }

        override public function onBeforeDispose(e:LifeCycleEvent):void
        {
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
            setupTxtTankInfo();
            setupBtnCommonQuests();
            setupBtnPersonalQuests();
        }

        // txtTankInfo

        private var _orig_txtTankInfo_x:Number = NaN;
        private var _orig_txtTankInfo_y:Number = NaN;
        private var _orig_tankTypeIcon_x:Number = NaN;
        private var _orig_tankTypeIcon_y:Number = NaN;
        private function setupTxtTankInfo():void
        {
            var cfg:CHangarElement = Config.config.hangar.vehicleName;
            if (!cfg.enabled)
            {
                page.header.txtTankInfo.mouseEnabled = false;
                page.header.txtTankInfo.alpha = 0;

                page.header.tankTypeIcon.mouseEnabled = false;
                page.header.tankTypeIcon.mouseChildren = false;
                page.header.tankTypeIcon.alpha = 0;
            }
            else
            {
                page.header.txtTankInfo.mouseEnabled = true;
                if (isNaN(_orig_txtTankInfo_x))
                {
                    _orig_txtTankInfo_x = page.header.txtTankInfo.x;
                    _orig_txtTankInfo_y = page.header.txtTankInfo.y;
                }
                page.header.txtTankInfo.x = _orig_txtTankInfo_x + cfg.shiftX;
                page.header.txtTankInfo.y = _orig_txtTankInfo_y + cfg.shiftY;
                page.header.txtTankInfo.alpha = cfg.alpha / 100.0;
                page.header.txtTankInfo.rotation = cfg.rotation;

                page.header.tankTypeIcon.mouseEnabled = true;
                page.header.tankTypeIcon.mouseChildren = true;
                if (isNaN(_orig_tankTypeIcon_x))
                {
                    _orig_tankTypeIcon_x = page.header.tankTypeIcon.x;
                    _orig_tankTypeIcon_y = page.header.tankTypeIcon.y;
                }
                page.header.tankTypeIcon.x = _orig_tankTypeIcon_x + cfg.shiftX;
                page.header.tankTypeIcon.y = _orig_tankTypeIcon_y + cfg.shiftY;
                page.header.tankTypeIcon.alpha = cfg.alpha / 100.0;
                page.header.tankTypeIcon.rotation = cfg.rotation;
            }
        }

        // btnCommonQuests

        private var _orig_btnCommonQuests_x:Number = NaN;
        private var _orig_btnCommonQuests_y:Number = NaN;
        private function setupBtnCommonQuests():void
        {
            var cfg:CHangarElement = Config.config.hangar.commonQuests;
            if (!cfg.enabled)
            {
                page.header.btnCommonQuests.mouseEnabled = false;
                page.header.btnCommonQuests.mouseChildren = false;
                page.header.btnCommonQuests.alpha = 0;
            }
            else
            {
                page.header.btnCommonQuests.mouseEnabled = true;
                page.header.btnCommonQuests.mouseChildren = true;
                if (isNaN(_orig_btnCommonQuests_x))
                {
                    _orig_btnCommonQuests_x = page.header.btnCommonQuests.x;
                    _orig_btnCommonQuests_y = page.header.btnCommonQuests.y;
                }
                page.header.btnCommonQuests.x = _orig_btnCommonQuests_x + cfg.shiftX;
                page.header.btnCommonQuests.y = _orig_btnCommonQuests_y + cfg.shiftY;
                page.header.btnCommonQuests.alpha = cfg.alpha / 100.0;
                page.header.btnCommonQuests.rotation = cfg.rotation;
            }
        }

        // btnPersonalQuests

        private var _orig_btnPersonalQuests_x:Number = NaN;
        private var _orig_btnPersonalQuests_y:Number = NaN;
        private function setupBtnPersonalQuests():void
        {
            var cfg:CHangarElement = Config.config.hangar.personalQuests;
            if (!cfg.enabled)
            {
                page.header.btnPersonalQuests.mouseEnabled = false;
                page.header.btnPersonalQuests.mouseChildren = false;
                page.header.btnPersonalQuests.alpha = 0;
            }
            else
            {
                page.header.btnPersonalQuests.mouseEnabled = true;
                page.header.btnPersonalQuests.mouseChildren = true;
                if (isNaN(_orig_btnPersonalQuests_x))
                {
                    _orig_btnPersonalQuests_x = page.header.btnPersonalQuests.x;
                    _orig_btnPersonalQuests_y = page.header.btnPersonalQuests.y;
                }
                page.header.btnPersonalQuests.x = _orig_btnPersonalQuests_x + cfg.shiftX;
                page.header.btnPersonalQuests.y = _orig_btnPersonalQuests_y + cfg.shiftY;
                page.header.btnPersonalQuests.alpha = cfg.alpha / 100.0;
                page.header.btnPersonalQuests.rotation = cfg.rotation;
            }
        }

        //

        private function onUpdateCurrentVehicle(data:Object):Object
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
