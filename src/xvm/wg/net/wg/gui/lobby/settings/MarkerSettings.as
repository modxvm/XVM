package net.wg.gui.lobby.settings 
{
    import flash.display.*;
    import net.wg.gui.components.advanced.*;
    import net.wg.gui.components.common.*;
    import net.wg.gui.components.common.markers.*;
    import net.wg.gui.lobby.settings.evnts.*;
    import net.wg.gui.lobby.settings.vo.*;
    import scaleform.clik.data.*;
    import scaleform.clik.events.*;
    
    public class MarkerSettings extends net.wg.gui.lobby.settings.SettingsBaseView
    {
        public function MarkerSettings()
        {
            this.markerAllyData = {"vClass":"heavyTank", "vIconSource":"../maps/icons/vehicle/contour/usa-T32.png", "vType":"T32", "vLevel":8, "pFullName":"Killer", "curHealth":1075, "maxHealth":1400, "entityName":"ally", "speaking":false, "hunt":false, "entityType":"ally"};
            this.markerEnemyData = {"vClass":"heavyTank", "vIconSource":"../maps/icons/vehicle/contour/germany-PzVI.png", "vType":"PzKpfw VI Tiger", "vLevel":7, "pFullName":"Killer", "curHealth":985, "maxHealth":1350, "entityName":"enemy", "speaking":false, "hunt":false, "entityType":"enemy"};
            this.markerDeadData = {"vClass":"heavyTank", "vIconSource":"../maps/icons/vehicle/contour/germany-E-75.png", "vType":"E-75", "vLevel":9, "pFullName":"Killer", "curHealth":0, "maxHealth":1920, "entityName":"ally", "speaking":false, "hunt":false, "entityType":"ally"};
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.initMarkers();
            return;
        }

        internal function initMarkers():void
        {
            this.markerAlly.init(this.markerAllyData);
            this.markerAllyAlt.init(this.markerAllyData);
            this.markerEnemy.init(this.markerEnemyData);
            this.markerEnemyAlt.init(this.markerEnemyData);
            this.markerDead.init(this.markerDeadData);
            this.markerDeadAlt.init(this.markerDeadData);
            this.markerAlly.setMarkerState("normal");
            this.markerAllyAlt.setMarkerState("normal");
            this.markerEnemy.setMarkerState("normal");
            this.markerEnemyAlt.setMarkerState("normal");
            this.markerDead.setMarkerState("immediate_dead");
            this.markerDeadAlt.setMarkerState("immediate_dead");
            this.markerAllyAlt.exInfo = true;
            this.markerEnemyAlt.exInfo = true;
            this.markerDeadAlt.exInfo = true;
            return;
        }

        public override function update(arg1:Object):void
        {
            super.update(arg1);
            return;
        }

        protected override function setData(arg1:Object):void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            super.setData(arg1);
            this._dynamicMarkersData = {};
            var loc4:*=0;
            var loc5:*=arg1;
            for (loc1 in loc5) 
            {
                if (this[loc1 + this.FORM]) 
                {
                    (loc3 = net.wg.gui.lobby.settings.SettingsMarkersForm(this[loc1 + this.FORM])).setData(loc1, arg1[loc1]);
                    loc3.addEventListener(net.wg.gui.lobby.settings.evnts.SettingsSubVewEvent.ON_CONTROL_CHANGE, this.onControlChange);
                }
                var loc6:*=0;
                var loc7:*=arg1[loc1];
                for (loc2 in loc7) 
                {
                    if (!this._dynamicMarkersData.hasOwnProperty(loc1)) 
                        this._dynamicMarkersData[loc1] = {};
                    this._dynamicMarkersData[loc1][loc2] = net.wg.gui.lobby.settings.vo.SettingsControlProp(arg1[loc1][loc2]).current;
                }
            }
            this.tabs.dataProvider = new scaleform.clik.data.DataProvider(net.wg.gui.lobby.settings.SettingsConfig.markerTabsDataProvider);
            this.tabs.addEventListener(scaleform.clik.events.IndexEvent.INDEX_CHANGE, this.onTabChange);
            this.tabs.selectedIndex = this.__currentTab;
            return;
        }

        internal function onControlChange(arg1:net.wg.gui.lobby.settings.evnts.SettingsSubVewEvent):void
        {
            var loc1:*=arg1.subViewId;
            var loc2:*=arg1.controlId;
            var loc3:*;
            (loc3 = {})[loc2] = arg1.controlValue;
            if (this._dynamicMarkersData != null) 
                this._dynamicMarkersData[loc1][arg1.controlId] = arg1.controlValue;
            dispatchEvent(new net.wg.gui.lobby.settings.evnts.SettingViewEvent(net.wg.gui.lobby.settings.evnts.SettingViewEvent.ON_CONTROL_CHANGED, _viewId, loc1, loc3));
            this.updateShowContent();
            return;
        }

        public override function dispose():void
        {
            this.tabs.removeEventListener(scaleform.clik.events.IndexEvent.INDEX_CHANGE, this.onTabChange);
            if (this.enemyForm.hasEventListener(net.wg.gui.lobby.settings.evnts.SettingsSubVewEvent.ON_CONTROL_CHANGE)) 
                this.enemyForm.removeEventListener(net.wg.gui.lobby.settings.evnts.SettingsSubVewEvent.ON_CONTROL_CHANGE, this.onControlChange);
            if (this.allyForm.hasEventListener(net.wg.gui.lobby.settings.evnts.SettingsSubVewEvent.ON_CONTROL_CHANGE)) 
                this.allyForm.removeEventListener(net.wg.gui.lobby.settings.evnts.SettingsSubVewEvent.ON_CONTROL_CHANGE, this.onControlChange);
            if (this.deadForm.hasEventListener(net.wg.gui.lobby.settings.evnts.SettingsSubVewEvent.ON_CONTROL_CHANGE)) 
                this.deadForm.removeEventListener(net.wg.gui.lobby.settings.evnts.SettingsSubVewEvent.ON_CONTROL_CHANGE, this.onControlChange);
            this.enemyForm.dispose();
            this.allyForm.dispose();
            this.deadForm.dispose();
            this._dynamicMarkersData = null;
            super.dispose();
            return;
        }

        public override function toString():String
        {
            return "[WG MarkerSettings " + name + "]";
        }

        internal function onTabChange(arg1:scaleform.clik.events.IndexEvent):void
        {
            this.__currentTab = arg1.index;
            this.updateShowContent();
            return;
        }

        public function updateShowContent():void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=NaN;
            var loc6:*=null;
            var loc7:*=null;
            var loc8:*=null;
            var loc1:*=0;
            while (loc1 < net.wg.gui.lobby.settings.SettingsConfig.markerTabsDataProvider.length) 
            {
                loc2 = net.wg.gui.lobby.settings.SettingsConfig.markerTabsDataProvider[loc1].formID;
                loc3 = net.wg.gui.lobby.settings.SettingsConfig.markerTabsDataProvider[loc1].markerID;
                loc4 = net.wg.gui.lobby.settings.SettingsConfig.markerTabsDataProvider[loc1].id;
                loc5 = net.wg.gui.lobby.settings.SettingsConfig.markerTabsDataProvider[loc1].markerFlag;
                if (this[loc2]) 
                    (loc6 = net.wg.gui.lobby.settings.SettingsMarkersForm(this[loc2])).visible = this.__currentTab != loc1 ? false : true;
                if (this[loc3]) 
                {
                    (loc7 = net.wg.gui.components.common.markers.VehicleMarker(this[loc3])).visible = this.__currentTab != loc1 ? false : true;
                    loc7.markerSettings = this._dynamicMarkersData[loc4];
                    loc7.settingsUpdate(loc5);
                }
                if (this[loc3 + "Alt"]) 
                {
                    (loc8 = net.wg.gui.components.common.markers.VehicleMarker(this[loc3 + "Alt"])).visible = this.__currentTab != loc1 ? false : true;
                    loc8.markerSettings = this._dynamicMarkersData[loc4];
                    loc8.settingsUpdate(loc5);
                }
                ++loc1;
            }
            this.bg.gotoAndStop(net.wg.gui.lobby.settings.SettingsConfig.markerTabsDataProvider[this.__currentTab].id);
            return;
        }

        internal const FORM:String="Form";

        public var tabs:net.wg.gui.components.advanced.ButtonBarEx=null;

        public var bg:flash.display.MovieClip=null;

        public var enemyForm:net.wg.gui.lobby.settings.SettingsMarkersForm=null;

        public var allyForm:net.wg.gui.lobby.settings.SettingsMarkersForm=null;

        public var deadForm:net.wg.gui.lobby.settings.SettingsMarkersForm=null;

        internal var __currentTab:uint=0;

        internal var _dynamicMarkersData:Object=null;

        public var markerEnemy:net.wg.gui.components.common.VehicleMarkerEnemy=null;

        public var markerEnemyAlt:net.wg.gui.components.common.VehicleMarkerEnemy=null;

        public var markerAlly:net.wg.gui.components.common.VehicleMarkerAlly=null;

        public var markerAllyAlt:net.wg.gui.components.common.VehicleMarkerAlly=null;

        public var markerDead:net.wg.gui.components.common.VehicleMarkerAlly=null;

        public var markerDeadAlt:net.wg.gui.components.common.VehicleMarkerAlly=null;

        internal var markerAllyData:Object;

        internal var markerEnemyData:Object;

        internal var markerDeadData:Object;
    }
}
