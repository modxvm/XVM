package net.wg.gui.lobby.settings 
{
    import flash.display.*;
    import net.wg.gui.components.advanced.*;
    import net.wg.gui.components.common.crosshair.*;
    import net.wg.gui.lobby.settings.evnts.*;
    import net.wg.gui.lobby.settings.vo.*;
    import scaleform.clik.data.*;
    import scaleform.clik.events.*;
    
    public class AimSettings extends net.wg.gui.lobby.settings.SettingsBaseView
    {
        public function AimSettings()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.cassete = net.wg.gui.components.common.crosshair.ClipQuantityBar.create(7, 1);
            this.cassete.quantityInClip = 7;
            this.cassete.clipState = "normal";
            this.snpCassete = net.wg.gui.components.common.crosshair.ClipQuantityBar.create(7, 1);
            this.snpCassete.quantityInClip = 7;
            this.snpCassete.clipState = "normal";
            flash.display.MovieClip(this.arcadeCursor.cassette).addChild(this.cassete);
            flash.display.MovieClip(this.snipperCursor.cassette).addChild(this.snpCassete);
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
            this._dynamicCursorsData = {};
            var loc4:*=0;
            var loc5:*=arg1;
            for (loc1 in loc5) 
            {
                if (this[loc1 + this.FORM]) 
                {
                    (loc3 = net.wg.gui.lobby.settings.SettingsAimForm(this[loc1 + this.FORM])).setData(loc1, arg1[loc1]);
                    loc3.addEventListener(net.wg.gui.lobby.settings.evnts.SettingsSubVewEvent.ON_CONTROL_CHANGE, this.onControlChange);
                }
                var loc6:*=0;
                var loc7:*=arg1[loc1];
                for (loc2 in loc7) 
                {
                    if (!this._dynamicCursorsData.hasOwnProperty(loc1)) 
                        this._dynamicCursorsData[loc1] = {};
                    this._dynamicCursorsData[loc1][loc2] = net.wg.gui.lobby.settings.vo.SettingsControlProp(arg1[loc1][loc2]).current ? net.wg.gui.lobby.settings.vo.SettingsControlProp(arg1[loc1][loc2]).current : 0;
                }
            }
            this.tabs.dataProvider = new scaleform.clik.data.DataProvider(net.wg.gui.lobby.settings.SettingsConfig.cursorTabsDataProvider);
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
            if (this._dynamicCursorsData != null) 
                this._dynamicCursorsData[loc1][arg1.controlId] = arg1.controlValue;
            dispatchEvent(new net.wg.gui.lobby.settings.evnts.SettingViewEvent(net.wg.gui.lobby.settings.evnts.SettingViewEvent.ON_CONTROL_CHANGED, _viewId, loc1, loc3));
            this.updateCrosshairs(this.__currentTab);
            return;
        }

        internal function onTabChange(arg1:scaleform.clik.events.IndexEvent):void
        {
            this.__currentTab = arg1.index;
            this.updateShowContent();
            return;
        }

        internal function updateShowContent():void
        {
            var loc3:*=null;
            var loc4:*=null;
            var loc1:*=net.wg.gui.lobby.settings.SettingsConfig.cursorTabsDataProvider.length;
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                loc3 = net.wg.gui.lobby.settings.SettingsAimForm(this[net.wg.gui.lobby.settings.SettingsConfig.cursorTabsDataProvider[loc2].formID]);
                loc3.visible = loc3.id != net.wg.gui.lobby.settings.SettingsConfig.cursorTabsDataProvider[this.__currentTab].id ? false : true;
                (loc4 = flash.display.MovieClip(this[net.wg.gui.lobby.settings.SettingsConfig.cursorTabsDataProvider[loc2].crosshairID])).visible = loc3.visible;
                ++loc2;
            }
            this.updateCrosshairs(this.__currentTab);
            return;
        }

        internal function updateCrosshairs(arg1:Number):void
        {
            var loc1:*=net.wg.gui.lobby.settings.SettingsConfig.cursorTabsDataProvider[arg1].id;
            var loc2:*=this._dynamicCursorsData[loc1];
            var loc3:*=0;
            var loc4:*=loc2["centralTagType"] ? "type" + loc2["centralTagType"] : "type0";
            var loc5:*=loc2["centralTag"] ? loc2["centralTag"] / 100 : 0;
            var loc6:*=loc2["netType"] ? "type" + loc2["netType"] : "type0";
            var loc7:*=loc2["net"] ? loc2["net"] / 100 : 0;
            var loc8:*=loc2["reloader"] ? loc2["reloader"] / 100 : 0;
            var loc9:*=loc2["condition"] ? loc2["condition"] / 100 : 0;
            var loc10:*=loc2["cassette"] ? loc2["cassette"] / 100 : 0;
            var loc11:*=null;
            var loc12:*=arg1;
            switch (loc12) 
            {
                case 0:
                    loc11 = this.arcadeCursor;
                    break;
                case 1:
                    loc11 = this.snipperCursor;
                    break;
            }
            if (loc11) 
            {
                loc11.center.gotoAndStop(loc4);
                loc11.center.alpha = loc5;
                loc11.gotoAndStop(loc6);
                loc11.grid1.alpha = loc7;
                loc11.reloadingBarMC.alpha = loc8;
                loc11.universalBarMC.alpha = loc9;
                loc11.cassette.alpha = loc10;
                loc12 = loc11.currentFrame;
                switch (loc12) 
                {
                    case 1:
                        loc3 = -1;
                        break;
                    case 2:
                        loc3 = 13;
                        break;
                    case 3:
                        loc3 = -11;
                        break;
                    default:
                        loc3 = 0;
                        break;
                }
                loc11.cassette.y = loc3;
                loc11.targetMC.gotoAndStop(60);
                loc11.universalBarMC.gotoAndStop(60);
                loc11.reloadingBarMC.gotoAndStop(60);
            }
            this.setCrossHair(this._dynamicCursorsData[loc1][this.GUN_TAG_TYPE], this._dynamicCursorsData[loc1][this.GUN_TAG], this._dynamicCursorsData[loc1][this.MIXING_TYPE], this._dynamicCursorsData[loc1][this.MIXING]);
            return;
        }

        internal function setCrossHair(arg1:String, arg2:Number, arg3:String, arg4:Number):void
        {
            this.crosshairMC.gotoAndStop(50);
            this.crosshairMC.markerMC.gotoAndStop("type" + arg1);
            this.crosshairMC.markerMC.alpha = arg2 / 100;
            this.crosshairMC.radiusMC.gotoAndStop("type" + arg3);
            this.crosshairMC.radiusMC.mixingMC.gotoAndStop(37);
            this.crosshairMC.radiusMC.mixingMC.alpha = arg4 / 100;
            this.crosshairMC.markerMC.tag.gotoAndStop("normal");
            return;
        }

        public override function dispose():void
        {
            this._dynamicCursorsData = {};
            if (this.cassete && this.arcadeCursor) 
                flash.display.MovieClip(this.arcadeCursor.cassette).removeChild(this.cassete);
            if (this.snpCassete && this.snipperCursor) 
                flash.display.MovieClip(this.snipperCursor.cassette).removeChild(this.snpCassete);
            this.tabs.removeEventListener(scaleform.clik.events.IndexEvent.INDEX_CHANGE, this.onTabChange);
            if (this.arcadeForm.hasEventListener(net.wg.gui.lobby.settings.evnts.SettingsSubVewEvent.ON_CONTROL_CHANGE)) 
                this.arcadeForm.removeEventListener(net.wg.gui.lobby.settings.evnts.SettingsSubVewEvent.ON_CONTROL_CHANGE, this.onControlChange);
            if (this.sniperForm.hasEventListener(net.wg.gui.lobby.settings.evnts.SettingsSubVewEvent.ON_CONTROL_CHANGE)) 
                this.sniperForm.removeEventListener(net.wg.gui.lobby.settings.evnts.SettingsSubVewEvent.ON_CONTROL_CHANGE, this.onControlChange);
            super.dispose();
            return;
        }

        public override function toString():String
        {
            return "[WG AimSettings " + name + "]";
        }

        internal const FORM:String="Form";

        internal const GUN_TAG_TYPE:String="gunTagType";

        internal const GUN_TAG:String="gunTag";

        internal const MIXING_TYPE:String="mixingType";

        internal const MIXING:String="mixing";

        public var tabs:net.wg.gui.components.advanced.ButtonBarEx=null;

        public var arcadeForm:net.wg.gui.lobby.settings.SettingsAimForm=null;

        public var sniperForm:net.wg.gui.lobby.settings.SettingsAimForm=null;

        public var crosshairMC:flash.display.MovieClip=null;

        public var arcadeCursor:flash.display.MovieClip=null;

        public var snipperCursor:flash.display.MovieClip=null;

        internal var __currentTab:uint=0;

        internal var cassete:net.wg.gui.components.common.crosshair.ClipQuantityBar=null;

        internal var snpCassete:net.wg.gui.components.common.crosshair.ClipQuantityBar=null;

        internal var _dynamicCursorsData:Object=null;
    }
}
