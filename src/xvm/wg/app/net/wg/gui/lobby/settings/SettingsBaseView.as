package net.wg.gui.lobby.settings
{
    import scaleform.clik.core.UIComponent;
    import net.wg.infrastructure.interfaces.IViewStackContent;
    import net.wg.gui.interfaces.ISettingsBase;
    import flash.utils.Dictionary;
    import flash.display.DisplayObject;
    import flash.events.MouseEvent;
    import net.wg.data.constants.Tooltips;
    import net.wg.gui.components.controls.LabelControl;
    import flash.text.TextField;
    import net.wg.gui.components.controls.CheckBox;
    import flash.display.InteractiveObject;
    
    public class SettingsBaseView extends UIComponent implements IViewStackContent, ISettingsBase
    {
        
        public function SettingsBaseView()
        {
            super();
        }
        
        protected var _data:Object = null;
        
        protected var _viewId:String = "";
        
        protected var headDependedControls:Vector.<String> = null;
        
        protected var toolTipMapping:Dictionary = null;
        
        override protected function configUI() : void
        {
            super.configUI();
            if(this._data)
            {
                this.setData(this._data);
            }
            this.toolTipMapping = new Dictionary(true);
            this.initToolTipMapping();
        }
        
        protected function initToolTipMapping() : void
        {
            var _loc1_:DisplayObject = null;
            var _loc2_:Object = null;
            for(_loc2_ in this.toolTipMapping)
            {
                _loc1_ = _loc2_ as DisplayObject;
                _loc1_.addEventListener(MouseEvent.ROLL_OVER,this.onControlOver);
                _loc1_.addEventListener(MouseEvent.ROLL_OUT,this.onControlOut);
            }
        }
        
        private function onControlOut(param1:MouseEvent) : void
        {
            App.toolTipMgr.hide();
        }
        
        private function onControlOver(param1:MouseEvent) : void
        {
            var _loc2_:String = this.getControlId(param1.currentTarget as DisplayObject);
            if(_loc2_)
            {
                App.toolTipMgr.showSpecial(Tooltips.SETTINGS_CONTROL,null,_loc2_);
            }
        }
        
        protected function getControlId(param1:DisplayObject) : String
        {
            return this.toolTipMapping[param1];
        }
        
        protected function trySetLabel(param1:String, param2:String = "") : void
        {
            var _loc3_:String = null;
            var _loc4_:LabelControl = null;
            var _loc5_:TextField = null;
            var _loc6_:CheckBox = null;
            if(this._data[param1])
            {
                _loc3_ = "";
                if(this._data[param1].current != null)
                {
                    _loc3_ = SettingsConfig.LOCALIZATION + param2 + param1;
                }
                if((this._data[param1].hasLabel) && (this[param1 + SettingsConfig.TYPE_LABEL]))
                {
                    if(this[param1 + SettingsConfig.TYPE_LABEL] is LabelControl)
                    {
                        _loc4_ = this[param1 + SettingsConfig.TYPE_LABEL];
                        _loc4_.text = _loc3_;
                        _loc4_.visible = true;
                    }
                    else
                    {
                        _loc5_ = this[param1 + SettingsConfig.TYPE_LABEL];
                        _loc5_.text = _loc3_;
                    }
                }
                else if((this[param1 + SettingsConfig.TYPE_CHECKBOX]) && this[param1 + SettingsConfig.TYPE_CHECKBOX].label == "")
                {
                    _loc6_ = this[param1 + SettingsConfig.TYPE_CHECKBOX];
                    _loc6_.label = _loc3_;
                }
                
            }
        }
        
        public function update(param1:Object) : void
        {
            this._viewId = param1.id;
            this._data = param1.data;
            if(this.initialized)
            {
                this.headDependedControls = new Vector.<String>();
                this.setData(this._data);
            }
        }
        
        protected function setData(param1:Object) : void
        {
            this.initDependedControls();
        }
        
        private function initDependedControls() : void
        {
            this.headDependedControls.forEach(this.updateDependedControl);
        }
        
        protected function updateDependedControl(param1:String) : void
        {
        }
        
        protected final function findSelectedIndexForDD(param1:Number, param2:Array) : Number
        {
            var _loc4_:* = undefined;
            var _loc3_:Number = 0;
            if((param2) && param2.length > 0)
            {
                _loc4_ = 0;
                while(_loc4_ < param2.length)
                {
                    if((param2[_loc4_].hasOwnProperty("data")) && param1 == param2[_loc4_].data)
                    {
                        _loc3_ = _loc4_;
                        break;
                    }
                    _loc4_++;
                }
            }
            return _loc3_;
        }
        
        public function updateDependentData() : void
        {
        }
        
        override protected function onDispose() : void
        {
            var _loc1_:DisplayObject = null;
            var _loc2_:Object = null;
            super.onDispose();
            for(_loc2_ in this.toolTipMapping)
            {
                _loc1_ = _loc2_ as DisplayObject;
                _loc1_.removeEventListener(MouseEvent.ROLL_OVER,this.onControlOver);
                _loc1_.removeEventListener(MouseEvent.ROLL_OUT,this.onControlOut);
                delete this.toolTipMapping[_loc2_];
                true;
            }
            this.toolTipMapping = null;
            while(this.headDependedControls.length)
            {
                this.headDependedControls.pop();
            }
            this.headDependedControls = null;
            this._data = null;
            this._viewId = null;
        }
        
        public function getComponentForFocus() : InteractiveObject
        {
            return null;
        }
        
        public function canShowAutomatically() : Boolean
        {
            return true;
        }
    }
}
