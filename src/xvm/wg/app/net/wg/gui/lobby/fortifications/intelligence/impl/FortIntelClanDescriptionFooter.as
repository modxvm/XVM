package net.wg.gui.lobby.fortifications.intelligence.impl
{
    import scaleform.clik.core.UIComponent;
    import flash.events.MouseEvent;
    import flash.text.TextField;
    import net.wg.gui.components.controls.IconTextButton;
    import net.wg.gui.components.controls.SoundButtonEx;
    import flash.display.MovieClip;
    import net.wg.gui.lobby.fortifications.cmp.drctn.impl.DirectionButtonRenderer;
    import net.wg.gui.lobby.fortifications.data.ClanDescriptionVO;
    import scaleform.clik.events.ButtonEvent;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.gui.lobby.fortifications.data.DirectionVO;
    import net.wg.gui.lobby.fortifications.events.FortIntelClanDescriptionEvent;
    
    public class FortIntelClanDescriptionFooter extends UIComponent
    {
        
        public function FortIntelClanDescriptionFooter()
        {
            super();
            this.allRenderers = [this.direction0,this.direction1,this.direction2,this.direction3];
        }
        
        private static var LINKBTN_OFFSET_X:int = 7;
        
        private static var LINKBTN_OFFSET_Y:int = 4;
        
        private static var CALENDAR_ICON_PNG:String = "calendar.png";
        
        private static var ALPHA_ENABLE:Number = 1;
        
        private static var ALPHA_DISABLE:Number = 0.5;
        
        private static var DEFAULT_WAR_TIME_POSITION:int = 46;
        
        private static var WAR_TIME_Y_OFFSET:int = 2;
        
        private static function onCalendarBtnRollOut(param1:MouseEvent) : void
        {
            App.toolTipMgr.hide();
        }
        
        private static function onLinkBtnRollOver(param1:MouseEvent) : void
        {
            App.toolTipMgr.show(TOOLTIPS.FORTIFICATION_FORTINTELLIGENCECLANDESCRIPTION_LINKBTN);
        }
        
        private static function onLinkBtnRollOut(param1:MouseEvent) : void
        {
            App.toolTipMgr.hide();
        }
        
        private static function onWarTimeTFRollOut(param1:MouseEvent) : void
        {
            App.toolTipMgr.hide();
        }
        
        public var selectDateTF:TextField = null;
        
        public var dateSelectedTF:TextField = null;
        
        public var warDeclaredTF:TextField = null;
        
        public var warDescriptionTF:TextField = null;
        
        public var warTimeTF:TextField = null;
        
        public var calendarBtn:IconTextButton = null;
        
        public var linkBtn:SoundButtonEx = null;
        
        public var background:MovieClip = null;
        
        public var direction0:DirectionButtonRenderer;
        
        public var direction1:DirectionButtonRenderer;
        
        public var direction2:DirectionButtonRenderer;
        
        public var direction3:DirectionButtonRenderer;
        
        private var allRenderers:Array;
        
        private var _model:ClanDescriptionVO = null;
        
        public function get model() : ClanDescriptionVO
        {
            return this._model;
        }
        
        public function set model(param1:ClanDescriptionVO) : void
        {
            this._model = param1;
            invalidateData();
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            this.calendarBtn.icon = CALENDAR_ICON_PNG;
        }
        
        override protected function onDispose() : void
        {
            this.calendarBtn.removeEventListener(ButtonEvent.CLICK,this.onClickCalendarBtn);
            this.calendarBtn.removeEventListener(MouseEvent.ROLL_OVER,this.onCalendarBtnRollOver);
            this.calendarBtn.removeEventListener(MouseEvent.ROLL_OUT,onCalendarBtnRollOut);
            this.linkBtn.removeEventListener(ButtonEvent.CLICK,this.onClickLinkBtn);
            this.linkBtn.removeEventListener(MouseEvent.ROLL_OVER,onLinkBtnRollOver);
            this.linkBtn.removeEventListener(MouseEvent.ROLL_OUT,onLinkBtnRollOut);
            this.selectDateTF = null;
            this.dateSelectedTF = null;
            this.warDeclaredTF = null;
            this.warDescriptionTF = null;
            this.warTimeTF = null;
            this.calendarBtn.dispose();
            this.calendarBtn = null;
            this.linkBtn.dispose();
            this.linkBtn = null;
            this.background = null;
            this.disposeDirections();
            if(this._model)
            {
                this._model.dispose();
                this._model = null;
            }
            super.onDispose();
        }
        
        override protected function draw() : void
        {
            super.draw();
            if((isInvalid(InvalidationType.DATA)) && (this._model))
            {
                this.updateElements();
                this.updateDirections();
            }
        }
        
        private function disposeDirections() : void
        {
            var _loc1_:DirectionButtonRenderer = null;
            for each(_loc1_ in this.allRenderers)
            {
                _loc1_.dispose();
                _loc1_ = null;
            }
            this.allRenderers.splice(0);
            this.allRenderers = null;
        }
        
        private function updateDirections() : void
        {
            var _loc2_:DirectionButtonRenderer = null;
            var _loc3_:DirectionVO = null;
            var _loc1_:* = 0;
            if((this._model) && (this._model.hasDirections))
            {
                while(_loc1_ < this._model.directions.length)
                {
                    _loc3_ = this._model.directions[_loc1_];
                    _loc2_ = this.allRenderers[_loc1_];
                    _loc2_.model = _loc3_;
                    _loc2_.canAttackMode = (this._model.canAttackDirection) && !this._model.isOurFortFrozen;
                    _loc1_++;
                }
            }
            while(_loc1_ < this.allRenderers.length)
            {
                _loc2_ = this.allRenderers[_loc1_];
                _loc2_.model = null;
                _loc1_++;
            }
        }
        
        private function updateElements() : void
        {
            var _loc1_:* = NaN;
            this.selectDateTF.htmlText = this._model.selectedDateText;
            if(this._model.warPlannedTime)
            {
                this.warTimeTF.visible = true;
                this.warTimeTF.htmlText = this._model.warPlannedTime;
                this.warTimeTF.addEventListener(MouseEvent.ROLL_OVER,this.onWarTimeTFRollOver);
                this.warTimeTF.addEventListener(MouseEvent.ROLL_OUT,onWarTimeTFRollOut);
            }
            else
            {
                this.warTimeTF.visible = false;
                this.warTimeTF.removeEventListener(MouseEvent.ROLL_OVER,this.onWarTimeTFRollOver);
                this.warTimeTF.removeEventListener(MouseEvent.ROLL_OUT,onWarTimeTFRollOut);
            }
            if(!this._model.canAttackDirection)
            {
                this.selectDateTF.visible = true;
                this.warDeclaredTF.visible = false;
                this.warDescriptionTF.visible = false;
                this.dateSelectedTF.visible = true;
                this.dateSelectedTF.text = this._model.dateSelected;
                this.calendarBtn.visible = true;
                this.addCalendarBtnListeners();
                this.linkBtn.visible = false;
                this.removeLinkBtnListeners();
                this.background.alpha = ALPHA_ENABLE;
            }
            else if(this._model.isWarDeclared)
            {
                this.selectDateTF.visible = false;
                this.dateSelectedTF.visible = false;
                this.calendarBtn.visible = false;
                this.warDeclaredTF.visible = true;
                this.warDescriptionTF.visible = true;
                this.linkBtn.visible = true;
                this.background.alpha = ALPHA_DISABLE;
                this.warDeclaredTF.text = App.utils.locale.makeString(FORTIFICATIONS.FORTINTELLIGENCE_CLANDESCRIPTION_WARDECLARED,{"clanName":this._model.clanTag});
                this.warDescriptionTF.text = App.utils.locale.makeString(FORTIFICATIONS.FORTINTELLIGENCE_CLANDESCRIPTION_NEXTAVAILABLEATTACKINAWEEK,{"nextDate":this._model.warPlannedDate});
                _loc1_ = this.warDescriptionTF.getLineMetrics(this.warDescriptionTF.numLines - 1).width;
                this.linkBtn.y = Math.round(this.warDescriptionTF.textHeight + this.warDescriptionTF.y - this.linkBtn.height + LINKBTN_OFFSET_Y);
                this.linkBtn.x = Math.round(this.warDescriptionTF.x + _loc1_ + LINKBTN_OFFSET_X);
                this.addLinkBtnListeners();
                this.removeCalendarBtnListeners();
            }
            else if(this._model.isAlreadyFought)
            {
                this.selectDateTF.visible = false;
                this.dateSelectedTF.visible = false;
                this.calendarBtn.visible = false;
                this.warDeclaredTF.visible = true;
                this.warDescriptionTF.visible = true;
                this.linkBtn.visible = false;
                this.background.alpha = ALPHA_DISABLE;
                this.warDeclaredTF.text = App.utils.locale.makeString(FORTIFICATIONS.FORTINTELLIGENCE_CLANDESCRIPTION_ALREADYFOUGHT,{"clanName":this._model.clanTag});
                this.warDescriptionTF.text = App.utils.locale.makeString(FORTIFICATIONS.FORTINTELLIGENCE_CLANDESCRIPTION_NEXTAVAILABLEATTACK,{"nextDate":this._model.warNextAvailableDate});
                this.removeLinkBtnListeners();
                this.removeCalendarBtnListeners();
            }
            else
            {
                this.selectDateTF.visible = true;
                this.dateSelectedTF.visible = true;
                this.calendarBtn.visible = true;
                this.warDeclaredTF.visible = false;
                this.warDescriptionTF.visible = false;
                this.linkBtn.visible = false;
                this.dateSelectedTF.text = this._model.dateSelected;
                this.background.alpha = ALPHA_ENABLE;
                this.addCalendarBtnListeners();
                this.removeLinkBtnListeners();
            }
            
            
            if(this._model.warPlannedTime)
            {
                this.updateWarTimePosition();
            }
        }
        
        private function updateWarTimePosition() : void
        {
            if(!this.warTimeTF.visible)
            {
                return;
            }
            if(this.linkBtn.visible)
            {
                this.warTimeTF.y = this.linkBtn.y - WAR_TIME_Y_OFFSET;
            }
            else if(this.calendarBtn.visible)
            {
                this.warTimeTF.y = this.calendarBtn.y - WAR_TIME_Y_OFFSET;
            }
            else
            {
                this.warTimeTF.y = DEFAULT_WAR_TIME_POSITION;
            }
            
        }
        
        private function addCalendarBtnListeners() : void
        {
            this.calendarBtn.addEventListener(ButtonEvent.CLICK,this.onClickCalendarBtn);
            this.calendarBtn.addEventListener(MouseEvent.ROLL_OVER,this.onCalendarBtnRollOver);
            this.calendarBtn.addEventListener(MouseEvent.ROLL_OUT,onCalendarBtnRollOut);
        }
        
        private function removeCalendarBtnListeners() : void
        {
            this.calendarBtn.removeEventListener(ButtonEvent.CLICK,this.onClickCalendarBtn);
            this.calendarBtn.removeEventListener(MouseEvent.ROLL_OVER,this.onCalendarBtnRollOver);
            this.calendarBtn.removeEventListener(MouseEvent.ROLL_OUT,onCalendarBtnRollOut);
        }
        
        private function addLinkBtnListeners() : void
        {
            this.linkBtn.addEventListener(ButtonEvent.CLICK,this.onClickLinkBtn);
            this.linkBtn.addEventListener(MouseEvent.ROLL_OVER,onLinkBtnRollOver);
            this.linkBtn.addEventListener(MouseEvent.ROLL_OUT,onLinkBtnRollOut);
        }
        
        private function removeLinkBtnListeners() : void
        {
            this.linkBtn.removeEventListener(ButtonEvent.CLICK,this.onClickLinkBtn);
            this.linkBtn.removeEventListener(MouseEvent.ROLL_OVER,onLinkBtnRollOver);
            this.linkBtn.removeEventListener(MouseEvent.ROLL_OUT,onLinkBtnRollOut);
        }
        
        private function onClickCalendarBtn(param1:ButtonEvent) : void
        {
            dispatchEvent(new FortIntelClanDescriptionEvent(FortIntelClanDescriptionEvent.OPEN_CALENDAR));
        }
        
        private function onCalendarBtnRollOver(param1:MouseEvent) : void
        {
            if(this._model.canAttackDirection)
            {
                App.toolTipMgr.show(TOOLTIPS.FORTIFICATION_FORTINTELLIGENCECLANDESCRIPTION_CALENDARBTN);
            }
            else
            {
                App.toolTipMgr.show(TOOLTIPS.FORTIFICATION_FORTINTELLIGENCECLANDESCRIPTION_CALENDARBTN_CANTATTACK);
            }
        }
        
        private function onClickLinkBtn(param1:ButtonEvent) : void
        {
            dispatchEvent(new FortIntelClanDescriptionEvent(FortIntelClanDescriptionEvent.CLICK_LINK_BTN));
        }
        
        private function onWarTimeTFRollOver(param1:MouseEvent) : void
        {
            App.toolTipMgr.show(this._model.warPlannedTimeTT);
        }
    }
}
