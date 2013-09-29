package net.wg.gui.lobby.settings 
{
    import flash.text.*;
    import net.wg.gui.components.controls.*;
    import net.wg.infrastructure.interfaces.*;
    import scaleform.clik.core.*;
    
    public class SettingsBaseView extends scaleform.clik.core.UIComponent implements net.wg.infrastructure.interfaces.IViewStackContent
    {
        public function SettingsBaseView()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            if (this._data) 
            {
                this.setData(this._data);
            }
            return;
        }

        protected function trySetLabel(arg1:String, arg2:String=""):void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            if (this._data[arg1]) 
            {
                loc1 = "";
                if (this._data[arg1].current != null) 
                {
                    loc1 = net.wg.gui.lobby.settings.SettingsConfig.LOCALIZATION + arg2 + arg1;
                }
                if (this._data[arg1].hasLabel && this[arg1 + net.wg.gui.lobby.settings.SettingsConfig.TYPE_LABEL]) 
                {
                    if (this[arg1 + net.wg.gui.lobby.settings.SettingsConfig.TYPE_LABEL] is net.wg.gui.components.controls.LabelControl) 
                    {
                        (loc2 = this[arg1 + net.wg.gui.lobby.settings.SettingsConfig.TYPE_LABEL]).text = loc1;
                    }
                    else 
                    {
                        (loc3 = this[arg1 + net.wg.gui.lobby.settings.SettingsConfig.TYPE_LABEL]).text = loc1;
                    }
                }
                else if (this[arg1 + net.wg.gui.lobby.settings.SettingsConfig.TYPE_CHECKBOX] && this[arg1 + net.wg.gui.lobby.settings.SettingsConfig.TYPE_CHECKBOX].label == "") 
                {
                    (loc4 = this[arg1 + net.wg.gui.lobby.settings.SettingsConfig.TYPE_CHECKBOX]).label = loc1;
                }
            }
            return;
        }

        public function update(arg1:Object):void
        {
            this._viewId = arg1.id;
            this._data = arg1.data;
            if (this.initialized) 
            {
                this.setData(this._data);
            }
            return;
        }

        protected function setData(arg1:Object):void
        {
            return;
        }

        public override function dispose():void
        {
            super.dispose();
            this._data = null;
            this._viewId = null;
            return;
        }

        protected var _data:Object=null;

        protected var _viewId:String="";
    }
}
