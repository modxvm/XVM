package net.wg.gui.cyberSport.views
{
    import net.wg.infrastructure.base.meta.impl.CyberSportIntroMeta;
    import net.wg.infrastructure.base.meta.ICyberSportIntroMeta;
    import net.wg.infrastructure.base.meta.IBaseRallyViewMeta;
    import net.wg.gui.components.controls.SoundButtonEx;
    import flash.text.TextField;
    import net.wg.gui.cyberSport.controls.SelectedVehiclesMsg;
    import net.wg.gui.components.advanced.ButtonDnmIcon;
    import net.wg.data.constants.generated.CYBER_SPORT_ALIASES;
    import scaleform.clik.events.ButtonEvent;
    import flash.events.MouseEvent;
    import net.wg.data.constants.Tooltips;
    import net.wg.gui.cyberSport.controls.events.CSComponentEvent;
    import net.wg.gui.rally.events.RallyViewsEvent;
    
    public class IntroView extends CyberSportIntroMeta implements ICyberSportIntroMeta, IBaseRallyViewMeta
    {
        
        public function IntroView() {
            this._selectedVehicles = [];
            super();
        }
        
        public var autoMatchBtn:SoundButtonEx;
        
        public var createTitleLbl:TextField;
        
        public var createDescrLbl:TextField;
        
        public var autoTitleLbl:TextField;
        
        public var autoDescrLbl:TextField;
        
        public var selectedVehiclesInfo:SelectedVehiclesMsg;
        
        public var chooseVehiclesButton:ButtonDnmIcon;
        
        private var _selectedVehicles:Array;
        
        private var _readyVehiclesSelected:Boolean = false;
        
        public function as_setSelectedVehicles(param1:Array, param2:String, param3:Boolean) : void {
            this._selectedVehicles = param1;
            this._readyVehiclesSelected = param3;
            this.selectedVehiclesInfo.update(param2,!param3);
            invalidateData();
        }
        
        override protected function getRallyViewAlias() : String {
            return CYBER_SPORT_ALIASES.UNIT_VIEW_UI;
        }
        
        override protected function configUI() : void {
            super.configUI();
            titleLbl.text = CYBERSPORT.WINDOW_INTRO_TITLE;
            descrLbl.text = CYBERSPORT.WINDOW_INTRO_DESCRIPTION;
            listRoomTitleLbl.text = CYBERSPORT.WINDOW_INTRO_SEARCH_TITLE;
            listRoomDescrLbl.text = CYBERSPORT.WINDOW_INTRO_SEARCH_DESCRIPTION;
            this.createTitleLbl.text = CYBERSPORT.WINDOW_INTRO_CREATE_TITLE;
            this.createDescrLbl.text = CYBERSPORT.WINDOW_INTRO_CREATE_DESCRIPTION;
            this.autoTitleLbl.text = CYBERSPORT.WINDOW_INTRO_AUTO_TITLE;
            this.autoDescrLbl.text = CYBERSPORT.WINDOW_INTRO_AUTO_DESCRIPTION;
            this.autoMatchBtn.addEventListener(ButtonEvent.CLICK,this.onAutoSearchClick);
            this.autoMatchBtn.addEventListener(MouseEvent.ROLL_OVER,this.onControlRollOver);
            this.autoMatchBtn.addEventListener(MouseEvent.ROLL_OUT,onControlRollOut);
            this.chooseVehiclesButton.addEventListener(ButtonEvent.CLICK,this.csVehicleBtnOnClick);
            this.chooseVehiclesButton.addEventListener(MouseEvent.ROLL_OVER,this.onControlRollOver);
            this.chooseVehiclesButton.addEventListener(MouseEvent.ROLL_OUT,onControlRollOut);
            this.selectedVehiclesInfo.addEventListener(MouseEvent.ROLL_OVER,this.onControlRollOver);
            this.selectedVehiclesInfo.addEventListener(MouseEvent.ROLL_OUT,onControlRollOut);
        }
        
        override protected function draw() : void {
            super.draw();
            this.autoMatchBtn.enabled = this._readyVehiclesSelected;
            this.autoMatchBtn.mouseChildren = true;
        }
        
        override protected function onPopulate() : void {
            super.onPopulate();
        }
        
        override protected function onDispose() : void {
            this.autoMatchBtn.removeEventListener(ButtonEvent.CLICK,this.onAutoSearchClick);
            this.autoMatchBtn.removeEventListener(MouseEvent.ROLL_OVER,this.onControlRollOver);
            this.autoMatchBtn.removeEventListener(MouseEvent.ROLL_OUT,onControlRollOut);
            this.chooseVehiclesButton.removeEventListener(ButtonEvent.CLICK,this.csVehicleBtnOnClick);
            this.chooseVehiclesButton.removeEventListener(MouseEvent.ROLL_OVER,this.onControlRollOver);
            this.chooseVehiclesButton.removeEventListener(MouseEvent.ROLL_OUT,onControlRollOut);
            this.selectedVehiclesInfo.removeEventListener(MouseEvent.ROLL_OVER,this.onControlRollOver);
            this.selectedVehiclesInfo.removeEventListener(MouseEvent.ROLL_OUT,onControlRollOut);
            this.autoMatchBtn.dispose();
            this.autoMatchBtn = null;
            this.chooseVehiclesButton.dispose();
            this.chooseVehiclesButton = null;
            super.onDispose();
        }
        
        override protected function onControlRollOver(param1:MouseEvent) : void {
            var _loc2_:* = "";
            var _loc3_:* = "";
            switch(param1.currentTarget)
            {
                case listRoomBtn:
                    App.toolTipMgr.showComplex(TOOLTIPS.CYBERSPORT_INTRO_SEARCH_BTN);
                    break;
                case createBtn:
                    App.toolTipMgr.showComplex(TOOLTIPS.CYBERSPORT_INTRO_CREATE_BTN);
                    break;
                case this.chooseVehiclesButton:
                    App.toolTipMgr.showComplex(TOOLTIPS.CYBERSPORT_INTRO_CHOOSEVEHICLES);
                    break;
                case this.autoMatchBtn:
                    _loc2_ = CYBERSPORT.WINDOW_INTRO_AUTO_BTN_TOOLTIP_TITLE;
                    _loc3_ = this.autoMatchBtn.enabled?CYBERSPORT.WINDOW_INTRO_AUTO_BTN_TOOLTIP_DESCRIPTION_ENABLED:CYBERSPORT.WINDOW_INTRO_AUTO_BTN_TOOLTIP_DESCRIPTION_DISABLED;
                    showComplexTooltip(_loc2_,_loc3_);
                    break;
                case this.selectedVehiclesInfo:
                    App.toolTipMgr.showSpecial(Tooltips.CYBER_SPORT_AUTOSEARCH_VEHICLES,null,this._selectedVehicles);
                    break;
            }
        }
        
        private function onAutoSearchClick(param1:ButtonEvent) : void {
            dispatchEvent(new CSComponentEvent(CSComponentEvent.SHOW_AUTO_SEARCH_VIEW,{
                "state":CYBER_SPORT_ALIASES.INTRO_VIEW_UI,
                "cmpDescr":this._selectedVehicles
            }));
    }
    
    override protected function onListRoomBtnClick(param1:ButtonEvent) : void {
        var _loc2_:Object = {
            "alias":CYBER_SPORT_ALIASES.UNITS_LIST_VIEW_UI,
            "itemId":Number.NaN,
            "peripheryID":0,
            "slotIndex":-1
        };
    dispatchEvent(new RallyViewsEvent(RallyViewsEvent.LOAD_VIEW_REQUEST,_loc2_));
}

private function csVehicleBtnOnClick(param1:ButtonEvent) : void {
    showSelectorPopupS();
}
}
}
