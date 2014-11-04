package net.wg.gui.lobby.fortifications.intelligence.impl
{
    import net.wg.infrastructure.base.meta.impl.FortIntelligenceClanDescriptionMeta;
    import net.wg.infrastructure.base.meta.IFortIntelligenceClanDescriptionMeta;
    import net.wg.infrastructure.interfaces.IPopOverCaller;
    import flash.text.TextField;
    import flash.display.MovieClip;
    import net.wg.gui.lobby.fortifications.data.ClanDescriptionVO;
    import net.wg.gui.lobby.fortifications.events.FortIntelClanDescriptionEvent;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.data.constants.Values;
    import net.wg.data.constants.generated.FORTIFICATION_ALIASES;
    import net.wg.data.constants.Tooltips;
    import flash.display.DisplayObject;
    
    public class FortIntelligenceClanDescription extends FortIntelligenceClanDescriptionMeta implements IFortIntelligenceClanDescriptionMeta, IPopOverCaller
    {
        
        public function FortIntelligenceClanDescription()
        {
            super();
        }
        
        public var notSelectedTF:TextField = null;
        
        public var notSelectedBG:MovieClip = null;
        
        public var descriptionHeader:FortIntelClanDescriptionHeader = null;
        
        public var descriptionFooter:FortIntelClanDescriptionFooter = null;
        
        private var model:ClanDescriptionVO = null;
        
        public function as_updateBookMark(param1:Boolean) : void
        {
            this.descriptionHeader.checkBox.selected = param1;
        }
        
        override protected function setData(param1:ClanDescriptionVO) : void
        {
            this.model = param1;
            invalidateData();
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            this.descriptionHeader.visible = this.descriptionFooter.visible = false;
            this.descriptionFooter.addEventListener(FortIntelClanDescriptionEvent.OPEN_CALENDAR,this.onOpenCalendarHandler);
            this.descriptionFooter.addEventListener(FortIntelClanDescriptionEvent.CLICK_LINK_BTN,this.onLinkBtnClick);
            this.descriptionFooter.addEventListener(FortIntelClanDescriptionEvent.ATTACK_DIRECTION,this.onAttackDirectionHandler);
            this.descriptionFooter.addEventListener(FortIntelClanDescriptionEvent.HOVER_DIRECTION,this.onHoverDirectionHandler);
            this.descriptionHeader.addEventListener(FortIntelClanDescriptionEvent.SHOW_CLAN_INFOTIP,this.onShowClanInfotip);
            this.descriptionHeader.addEventListener(FortIntelClanDescriptionEvent.HIDE_CLAN_INFOTIP,this.onHideClanInfotip);
            this.descriptionHeader.addEventListener(FortIntelClanDescriptionEvent.CHECKBOX_CLICK,this.onCheckBoxClick);
            this.descriptionHeader.addEventListener(FortIntelClanDescriptionEvent.OPEN_CLAN_LIST,this.onOpenClanListHandler);
            this.descriptionHeader.addEventListener(FortIntelClanDescriptionEvent.OPEN_CLAN_STATISTICS,this.onOpenClanStatisticsHandler);
            this.descriptionHeader.addEventListener(FortIntelClanDescriptionEvent.OPEN_CLAN_CARD,this.onOpenClanCardHandler);
        }
        
        override protected function onDispose() : void
        {
            this.descriptionFooter.removeEventListener(FortIntelClanDescriptionEvent.OPEN_CALENDAR,this.onOpenCalendarHandler);
            this.descriptionFooter.removeEventListener(FortIntelClanDescriptionEvent.CLICK_LINK_BTN,this.onLinkBtnClick);
            this.descriptionFooter.removeEventListener(FortIntelClanDescriptionEvent.ATTACK_DIRECTION,this.onAttackDirectionHandler);
            this.descriptionFooter.removeEventListener(FortIntelClanDescriptionEvent.HOVER_DIRECTION,this.onHoverDirectionHandler);
            this.descriptionHeader.removeEventListener(FortIntelClanDescriptionEvent.SHOW_CLAN_INFOTIP,this.onShowClanInfotip);
            this.descriptionHeader.removeEventListener(FortIntelClanDescriptionEvent.HIDE_CLAN_INFOTIP,this.onHideClanInfotip);
            this.descriptionHeader.removeEventListener(FortIntelClanDescriptionEvent.CHECKBOX_CLICK,this.onCheckBoxClick);
            this.descriptionHeader.removeEventListener(FortIntelClanDescriptionEvent.OPEN_CLAN_LIST,this.onOpenClanListHandler);
            this.descriptionHeader.removeEventListener(FortIntelClanDescriptionEvent.OPEN_CLAN_STATISTICS,this.onOpenClanStatisticsHandler);
            this.descriptionHeader.removeEventListener(FortIntelClanDescriptionEvent.OPEN_CLAN_CARD,this.onOpenClanCardHandler);
            this.notSelectedTF = null;
            this.notSelectedBG = null;
            this.descriptionHeader.dispose();
            this.descriptionHeader = null;
            this.descriptionFooter.dispose();
            this.descriptionFooter = null;
            if(this.model)
            {
                this.model.dispose();
                this.model = null;
            }
            super.onDispose();
        }
        
        override protected function draw() : void
        {
            super.draw();
            if((isInvalid(InvalidationType.DATA)) && (this.model))
            {
                this.updateElements();
            }
        }
        
        private function updateElements() : void
        {
            if(this.model)
            {
                this.notSelectedTF.visible = this.notSelectedBG.visible = !this.model.isSelected;
                this.descriptionHeader.visible = this.descriptionFooter.visible = this.model.isSelected;
                if(this.model.isSelected)
                {
                    this.descriptionHeader.model = this.model;
                    this.descriptionFooter.model = this.model;
                }
                else if(!this.model.haveResults)
                {
                    this.notSelectedTF.text = Values.EMPTY_STR;
                }
                else if((this.model.canAttackDirection) && !this.model.isOurFortFrozen)
                {
                    this.notSelectedTF.text = FORTIFICATIONS.FORTINTELLIGENCE_CLANDESCRIPTION_NOTSELECTEDSCREEN_COMMANDER;
                }
                else
                {
                    this.notSelectedTF.text = FORTIFICATIONS.FORTINTELLIGENCE_CLANDESCRIPTION_NOTSELECTEDSCREEN_NOTCOMMANDER;
                }
                
                
            }
            else
            {
                this.notSelectedTF.visible = true;
                this.notSelectedBG.visible = true;
                this.notSelectedTF.text = Values.EMPTY_STR;
            }
        }
        
        private function onOpenCalendarHandler(param1:FortIntelClanDescriptionEvent) : void
        {
            var _loc2_:Object = {"timestamp":(this.model?this.model.selectedDayTimestamp:null)};
            App.popoverMgr.show(this,FORTIFICATION_ALIASES.FORT_DATE_PICKER_POPOVER_ALIAS,_loc2_);
        }
        
        private function onShowClanInfotip(param1:FortIntelClanDescriptionEvent) : void
        {
            App.toolTipMgr.showSpecial(Tooltips.CLAN_INFO,null,this.model.clanId);
        }
        
        private function onHideClanInfotip(param1:FortIntelClanDescriptionEvent) : void
        {
            App.toolTipMgr.hide();
        }
        
        private function onCheckBoxClick(param1:FortIntelClanDescriptionEvent) : void
        {
            onAddRemoveFavoriteS(this.descriptionHeader.checkBox.selected);
        }
        
        private function onLinkBtnClick(param1:FortIntelClanDescriptionEvent) : void
        {
            onOpenCalendarS();
        }
        
        private function onOpenClanListHandler(param1:FortIntelClanDescriptionEvent) : void
        {
            onOpenClanListS();
        }
        
        private function onOpenClanStatisticsHandler(param1:FortIntelClanDescriptionEvent) : void
        {
            onOpenClanStatisticsS();
        }
        
        private function onOpenClanCardHandler(param1:FortIntelClanDescriptionEvent) : void
        {
            onOpenClanCardS();
        }
        
        private function onAttackDirectionHandler(param1:FortIntelClanDescriptionEvent) : void
        {
            var _loc2_:int = param1.data;
            onAttackDirectionS(_loc2_);
        }
        
        private function onHoverDirectionHandler(param1:FortIntelClanDescriptionEvent) : void
        {
            onHoverDirectionS();
        }
        
        public function getTargetButton() : DisplayObject
        {
            return this.descriptionFooter.calendarBtn;
        }
        
        public function getHitArea() : DisplayObject
        {
            return this.descriptionFooter.calendarBtn;
        }
    }
}
