package net.wg.gui.lobby.recruitWindow
{
    import net.wg.infrastructure.base.meta.impl.QuestRecruitWindowMeta;
    import net.wg.infrastructure.base.meta.IQuestRecruitWindowMeta;
    import net.wg.gui.components.advanced.TankmanCard;
    import net.wg.gui.components.advanced.RecruitParametersComponent;
    import net.wg.gui.components.controls.SoundButtonEx;
    import net.wg.data.Aliases;
    import scaleform.clik.events.ButtonEvent;
    import flash.events.Event;
    import net.wg.utils.ILocale;
    import net.wg.data.VO.TankmanCardVO;
    
    public class QuestRecruitWindow extends QuestRecruitWindowMeta implements IQuestRecruitWindowMeta
    {
        
        public function QuestRecruitWindow()
        {
            super();
        }
        
        private static var INIT_DATA_INV:String = "initDataInv";
        
        public var card:TankmanCard;
        
        public var paramsComponent:RecruitParametersComponent;
        
        public var btnApply:SoundButtonEx;
        
        private var initData:Object;
        
        public function as_setInitData(param1:Object) : void
        {
            this.initData = param1;
            invalidate(INIT_DATA_INV);
        }
        
        override protected function onPopulate() : void
        {
            super.onPopulate();
            window.useBottomBtns = true;
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            registerComponent(this.paramsComponent,Aliases.RECRUIT_PARAMS);
            this.btnApply.addEventListener(ButtonEvent.CLICK,this.btnApplyClickHandler,false,0,true);
            this.paramsComponent.addEventListener(Event.CHANGE,this.paramsChangeHandler,false,0,true);
            var _loc1_:ILocale = App.utils.locale;
            this.window.title = _loc1_.makeString(DIALOGS.RECRUITWINDOW_TITLE);
            this.btnApply.label = _loc1_.makeString(DIALOGS.RECRUITWINDOW_SUBMIT);
        }
        
        private function btnApplyClickHandler(param1:ButtonEvent) : void
        {
            this.onApplyS({"nation":this.paramsComponent.getSelectedNation(),
            "vehicleClass":this.paramsComponent.getSelectedVehicleClass(),
            "vehicle":this.paramsComponent.getSelectedVehicle(),
            "tankmanRole":this.paramsComponent.getSelectedTankmanRole()
        });
    }
    
    override protected function draw() : void
    {
        super.draw();
        if((isInvalid(INIT_DATA_INV)) && (this.initData))
        {
            this.card.model = new TankmanCardVO(this.initData);
            this.initData = null;
        }
    }
    
    override protected function onDispose() : void
    {
        this.initData = null;
        this.btnApply.removeEventListener(ButtonEvent.CLICK,this.btnApplyClickHandler);
        this.paramsComponent.removeEventListener(Event.CHANGE,this.paramsChangeHandler);
        this.card.dispose();
        super.onDispose();
    }
    
    private function paramsChangeHandler(param1:Event = null) : void
    {
        this.btnApply.enabled = !(this.paramsComponent.vehicleClassDropdown.selectedIndex == 0) && !(this.paramsComponent.vehicleTypeDropdown.selectedIndex == 0) && !(this.paramsComponent.roleDropdown.selectedIndex == 0);
    }
}
}
