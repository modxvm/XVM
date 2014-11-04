package net.wg.gui.lobby.profile.pages.technique
{
    import net.wg.infrastructure.base.meta.impl.ProfileTechniquePageMeta;
    import net.wg.infrastructure.base.meta.IProfileTechniquePageMeta;
    import flash.events.MouseEvent;
    import net.wg.gui.components.controls.CompactCheckBox;
    import flash.events.Event;
    import flash.text.TextField;
    
    public class ProfileTechniquePage extends ProfileTechniquePageMeta implements IProfileTechniquePageMeta
    {
        
        public function ProfileTechniquePage()
        {
            super();
        }
        
        private static var LAYOUT_INVALID:String = "layoutInv";
        
        private static var SEL_ITEM_INDEX_INVALID:String = "selIndInv";
        
        private static function checkBoxMouseOverHandler(param1:MouseEvent) : void
        {
            App.toolTipMgr.showComplex(PROFILE.SECTION_TECHNIQUE_CHECKBOXHANGARVEHICLES_TOOLTIP);
        }
        
        private static function checkBoxMouseOutHandler(param1:MouseEvent) : void
        {
            App.toolTipMgr.hide();
        }
        
        public var checkBoxExistence:CompactCheckBox;
        
        private var selVehicleCompDescr:int = -1;
        
        override protected function configUI() : void
        {
            super.configUI();
            this.checkBoxExistence.addEventListener(Event.SELECT,this.checkBoxSelectHandler,false,0,true);
            this.checkBoxExistence.addEventListener(MouseEvent.MOUSE_OVER,checkBoxMouseOverHandler,false,0,true);
            this.checkBoxExistence.addEventListener(MouseEvent.MOUSE_OUT,checkBoxMouseOutHandler,false,0,true);
        }
        
        private function checkBoxSelectHandler(param1:Event) : void
        {
            setIsInHangarSelectedS(this.checkBoxExistence.selected);
        }
        
        override protected function draw() : void
        {
            var _loc1_:TextField = null;
            var _loc2_:* = 0;
            var _loc3_:TextField = null;
            var _loc4_:* = 0;
            var _loc5_:* = 0;
            var _loc6_:* = 0;
            super.draw();
            if(isInvalid(LAYOUT_INVALID))
            {
                _loc1_ = battlesDropdown.txtLabel;
                _loc2_ = _loc1_.x + _loc1_.width - _loc1_.textWidth;
                _loc3_ = this.checkBoxExistence.textField;
                _loc4_ = _loc3_.x + _loc3_.textWidth;
                _loc5_ = 10;
                _loc6_ = battlesDropdown.x + _loc2_ - (this.checkBoxExistence.x + _loc4_ + _loc5_);
                if(_loc6_ < 0)
                {
                    this.checkBoxExistence.x = this.checkBoxExistence.x + _loc6_;
                }
            }
            if((isInvalid(SEL_ITEM_INDEX_INVALID)) && !(this.selVehicleCompDescr == -1))
            {
                listComponent.techniqueList.selectedVehIntCD = this.selVehicleCompDescr;
            }
        }
        
        override public function as_setInitData(param1:Object) : void
        {
            var _loc2_:TechStatisticsInitVO = null;
            super.as_setInitData(param1);
            _loc2_ = new TechStatisticsInitVO(param1);
            this.checkBoxExistence.label = _loc2_.hangarVehiclesLabel;
            this.checkBoxExistence.selected = _loc2_.isInHangarSelected;
            this.checkBoxExistence.validateNow();
            invalidate(LAYOUT_INVALID);
        }
        
        public function as_setSelectedVehicleIntCD(param1:Number) : void
        {
            this.selVehicleCompDescr = param1;
            invalidate(SEL_ITEM_INDEX_INVALID);
        }
        
        override protected function onDispose() : void
        {
            this.checkBoxExistence.removeEventListener(MouseEvent.MOUSE_OVER,checkBoxMouseOverHandler);
            this.checkBoxExistence.removeEventListener(MouseEvent.MOUSE_OUT,checkBoxMouseOutHandler);
            super.onDispose();
        }
    }
}
