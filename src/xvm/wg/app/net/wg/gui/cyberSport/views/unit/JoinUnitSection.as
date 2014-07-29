package net.wg.gui.cyberSport.views.unit
{
    import net.wg.gui.rally.views.list.BaseRallyDetailsSection;
    import flash.text.TextField;
    import flash.display.MovieClip;
    import net.wg.gui.cyberSport.controls.GrayButtonText;
    import net.wg.gui.rally.vo.RallyShortVO;
    import net.wg.gui.rally.BaseRallyMainWindow;
    import flash.events.MouseEvent;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.gui.rally.interfaces.IRallyVO;
    import net.wg.data.constants.Values;
    import net.wg.infrastructure.interfaces.IUserProps;
    
    public class JoinUnitSection extends BaseRallyDetailsSection
    {
        
        public function JoinUnitSection()
        {
            super();
        }
        
        public var headerRatingTF:TextField;
        
        public var freezeIcon:MovieClip;
        
        public var restrictionIcon:MovieClip;
        
        public var joinUnitButton:GrayButtonText;
        
        public var slot0:SimpleSlotRenderer;
        
        public var slot1:SimpleSlotRenderer;
        
        public var slot2:SimpleSlotRenderer;
        
        public var slot3:SimpleSlotRenderer;
        
        public var slot4:SimpleSlotRenderer;
        
        public var slot5:SimpleSlotRenderer;
        
        public var slot6:SimpleSlotRenderer;
        
        public function get unitModel() : RallyShortVO
        {
            return model as RallyShortVO;
        }
        
        override protected function getSlots() : Array
        {
            var _loc2_:SimpleSlotRenderer = null;
            var _loc1_:Array = [this.slot0,this.slot1,this.slot2,this.slot3,this.slot4,this.slot5,this.slot6];
            var _loc3_:UnitSlotHelper = new UnitSlotHelper();
            for each(_loc2_ in _loc1_)
            {
                _loc2_.helper = _loc3_;
            }
            return _loc1_;
        }
        
        override protected function configUI() : void
        {
            joinButton = this.joinUnitButton;
            super.configUI();
            headerTF.text = CYBERSPORT.WINDOW_UNITLISTVIEW_SELECTEDTEAM;
            rallyInfoTF.htmlText = BaseRallyMainWindow.getTeamHeader(CYBERSPORT.WINDOW_UNIT_TEAMMEMBERS,model);
            vehiclesInfoTF.text = CYBERSPORT.WINDOW_UNITLISTVIEW_VEHICLES;
            joinInfoTF.text = CYBERSPORT.WINDOW_UNITLISTVIEW_ENTERTEXT;
            this.freezeIcon.addEventListener(MouseEvent.ROLL_OVER,this.onControlRollOver);
            this.freezeIcon.addEventListener(MouseEvent.ROLL_OUT,onControlRollOut);
            this.restrictionIcon.addEventListener(MouseEvent.ROLL_OVER,this.onControlRollOver);
            this.restrictionIcon.addEventListener(MouseEvent.ROLL_OUT,onControlRollOut);
        }
        
        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.DATA))
            {
                if((model) && (model.isAvailable()))
                {
                    this.freezeIcon.visible = this.unitModel.isFreezed;
                    this.restrictionIcon.visible = this.unitModel.hasRestrictions;
                }
                rallyInfoTF.htmlText = BaseRallyMainWindow.getTeamHeader(CYBERSPORT.WINDOW_UNIT_TEAMMEMBERS,model);
            }
        }
        
        override protected function updateTitle(param1:IRallyVO) : void
        {
            super.updateTitle(param1);
            if((this.unitModel) && (this.unitModel.commander))
            {
                this.headerRatingTF.text = this.unitModel.commander.rating;
            }
            else
            {
                this.headerRatingTF.text = Values.EMPTY_STR;
            }
        }
        
        override protected function updateDescription(param1:IRallyVO) : void
        {
            super.updateDescription(param1);
            var _loc2_:IUserProps = App.utils.commons.getUserProps(param1.description,null,null,0);
            var _loc3_:Boolean = App.utils.commons.formatPlayerName(descriptionTF,_loc2_);
            if(_loc3_)
            {
                descriptionTF.addEventListener(MouseEvent.ROLL_OVER,this.onControlRollOver);
                descriptionTF.addEventListener(MouseEvent.ROLL_OUT,onControlRollOut);
            }
        }
        
        override protected function onDispose() : void
        {
            this.freezeIcon.removeEventListener(MouseEvent.ROLL_OVER,this.onControlRollOver);
            this.freezeIcon.removeEventListener(MouseEvent.ROLL_OUT,onControlRollOut);
            this.restrictionIcon.removeEventListener(MouseEvent.ROLL_OVER,this.onControlRollOver);
            this.restrictionIcon.removeEventListener(MouseEvent.ROLL_OUT,onControlRollOut);
            super.onDispose();
        }
        
        override protected function onControlRollOver(param1:MouseEvent) : void
        {
            switch(param1.currentTarget)
            {
                case this.freezeIcon:
                    App.toolTipMgr.showComplex(TOOLTIPS.SETTINGSICON_FREEZED);
                    break;
                case this.restrictionIcon:
                    App.toolTipMgr.showComplex(TOOLTIPS.SETTINGSICON_CONDITIONS);
                    break;
                case joinButton:
                    App.toolTipMgr.showComplex(TOOLTIPS.CYBERSPORT_UNITLIST_JOIN);
                    break;
                case headerTF:
                    App.toolTipMgr.show(this.unitModel.commander.getToolTip());
                    break;
                case descriptionTF:
                    if(descriptionTF.text)
                    {
                        App.toolTipMgr.show(model.description);
                    }
                    break;
            }
        }
    }
}
