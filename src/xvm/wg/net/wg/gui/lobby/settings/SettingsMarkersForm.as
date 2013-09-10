package net.wg.gui.lobby.settings 
{
    import flash.events.*;
    import flash.text.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.lobby.settings.evnts.*;
    import net.wg.gui.lobby.settings.vo.*;
    import scaleform.clik.core.*;
    import scaleform.clik.data.*;
    import scaleform.clik.events.*;
    
    public class SettingsMarkersForm extends scaleform.clik.core.UIComponent
    {
        public function SettingsMarkersForm()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            return;
        }

        protected override function draw():void
        {
            super.draw();
            return;
        }

        public function setData(arg1:String, arg2:Object):void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            this._id = arg1;
            if (arg2 == null) 
                this.disableAllControls();
            else 
            {
                this._data = arg2;
                var loc5:*=0;
                var loc6:*=this._data;
                label325: for (loc1 in loc6) 
                {
                    loc2 = net.wg.gui.lobby.settings.vo.SettingsControlProp(this._data[loc1]);
                    if (!this[loc1 + loc2.type]) 
                        continue;
                    var loc7:*=loc2.type;
                    switch (loc7) 
                    {
                        case net.wg.gui.lobby.settings.SettingsConfig.TYPE_CHECKBOX:
                            (loc3 = this[loc1 + loc2.type]).selected = loc2.current;
                            loc3.addEventListener(flash.events.Event.SELECT, this.onCheckBoxSelected);
                            continue label325;
                        case net.wg.gui.lobby.settings.SettingsConfig.TYPE_DROPDOWN:
                            (loc4 = this[loc1 + loc2.type]).menuRowCount = loc2.options.length;
                            loc4.dataProvider = new scaleform.clik.data.DataProvider(loc2.options);
                            loc4.selectedIndex = loc2.current;
                            loc4.enabled = loc2.current != null ? true : false;
                            loc4.addEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE, this.onDropDownChange);
                            continue label325;
                    }
                }
            }
            return;
        }

        internal function onDropDownChange(arg1:scaleform.clik.events.ListEvent):void
        {
            var loc1:*=net.wg.gui.components.controls.DropdownMenu(arg1.target);
            var loc2:*=net.wg.gui.lobby.settings.SettingsConfig.getControlId(loc1.name, net.wg.gui.lobby.settings.SettingsConfig.TYPE_DROPDOWN);
            var loc3:*=this.getAltPrefix(loc2);
            dispatchEvent(new net.wg.gui.lobby.settings.evnts.SettingsSubVewEvent(net.wg.gui.lobby.settings.evnts.SettingsSubVewEvent.ON_CONTROL_CHANGE, this._id, loc2, loc1.selectedIndex, loc3));
            return;
        }

        internal function onCheckBoxSelected(arg1:flash.events.Event):void
        {
            var loc1:*=net.wg.gui.components.controls.CheckBox(arg1.target);
            var loc2:*=net.wg.gui.lobby.settings.SettingsConfig.getControlId(loc1.name, net.wg.gui.lobby.settings.SettingsConfig.TYPE_CHECKBOX);
            var loc3:*=this.getAltPrefix(loc2);
            dispatchEvent(new net.wg.gui.lobby.settings.evnts.SettingsSubVewEvent(net.wg.gui.lobby.settings.evnts.SettingsSubVewEvent.ON_CONTROL_CHANGE, this._id, loc2, loc1.selected, loc3));
            return;
        }

        internal function getAltPrefix(arg1:String):String
        {
            return arg1.indexOf("Alt", 0) >= 0 ? "Alt" : "";
        }

        internal function disableAllControls():void
        {
            this.markerBaseIconCheckbox.enabled = false;
            this.markerBaseLevelCheckbox.enabled = false;
            this.markerBaseVehicleNameCheckbox.enabled = false;
            this.markerBasePlayerNameCheckbox.enabled = false;
            this.markerBaseHpIndicatorCheckbox.enabled = false;
            this.markerBaseHpDropDown.enabled = false;
            this.markerBaseDamageCheckbox.enabled = false;
            this.markerAltIconCheckbox.enabled = false;
            this.markerAltLevelCheckbox.enabled = false;
            this.markerAltVehicleNameCheckbox.enabled = false;
            this.markerAltPlayerNameCheckbox.enabled = false;
            this.markerAltHpIndicatorCheckbox.enabled = false;
            this.markerAltHpDropDown.enabled = false;
            this.markerAltDamageCheckbox.enabled = false;
            return;
        }

        public override function dispose():void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            super.dispose();
            if (this._data != null) 
            {
                var loc5:*=0;
                var loc6:*=this._data;
                label274: for (loc1 in loc6) 
                {
                    loc2 = net.wg.gui.lobby.settings.vo.SettingsControlProp(this._data[loc1]);
                    if (!this[loc1 + loc2.type]) 
                        continue;
                    var loc7:*=loc2.type;
                    switch (loc7) 
                    {
                        case net.wg.gui.lobby.settings.SettingsConfig.TYPE_CHECKBOX:
                            loc3 = this[loc1 + loc2.type];
                            if (loc3.hasEventListener(flash.events.Event.SELECT)) 
                                loc3.removeEventListener(flash.events.Event.SELECT, this.onCheckBoxSelected);
                            continue label274;
                        case net.wg.gui.lobby.settings.SettingsConfig.TYPE_DROPDOWN:
                            if ((loc4 = this[loc1 + loc2.type]).hasEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE)) 
                                loc4.removeEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE, this.onDropDownChange);
                            continue label274;
                    }
                }
                this._data = null;
            }
            return;
        }

        internal var _id:String=null;

        internal var _data:Object=null;

        public var markerHeader:flash.text.TextField=null;

        public var markerHP:flash.text.TextField=null;

        public var markerHeaderAlt:flash.text.TextField=null;

        public var markerHPAlt:flash.text.TextField=null;

        public var markerBaseIconCheckbox:net.wg.gui.components.controls.CheckBox=null;

        public var markerBaseLevelCheckbox:net.wg.gui.components.controls.CheckBox=null;

        public var markerBaseVehicleNameCheckbox:net.wg.gui.components.controls.CheckBox=null;

        public var markerBasePlayerNameCheckbox:net.wg.gui.components.controls.CheckBox=null;

        public var markerBaseHpIndicatorCheckbox:net.wg.gui.components.controls.CheckBox=null;

        public var markerBaseHpDropDown:net.wg.gui.components.controls.DropdownMenu=null;

        public var markerBaseDamageCheckbox:net.wg.gui.components.controls.CheckBox=null;

        public var markerAltIconCheckbox:net.wg.gui.components.controls.CheckBox=null;

        public var markerAltLevelCheckbox:net.wg.gui.components.controls.CheckBox=null;

        public var markerAltVehicleNameCheckbox:net.wg.gui.components.controls.CheckBox=null;

        public var markerAltPlayerNameCheckbox:net.wg.gui.components.controls.CheckBox=null;

        public var markerAltHpIndicatorCheckbox:net.wg.gui.components.controls.CheckBox=null;

        public var markerAltHpDropDown:net.wg.gui.components.controls.DropdownMenu=null;

        public var markerAltDamageCheckbox:net.wg.gui.components.controls.CheckBox=null;
    }
}
