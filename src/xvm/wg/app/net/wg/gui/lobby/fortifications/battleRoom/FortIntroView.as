package net.wg.gui.lobby.fortifications.battleRoom
{
    import net.wg.infrastructure.base.meta.impl.FortIntroMeta;
    import net.wg.infrastructure.base.meta.IFortIntroMeta;
    import flash.text.TextField;
    import net.wg.gui.components.controls.SoundButtonEx;
    import net.wg.gui.lobby.fortifications.data.battleRoom.IntroViewVO;
    import flash.display.InteractiveObject;
    import scaleform.clik.constants.InvalidationType;
    import scaleform.clik.events.ButtonEvent;
    import flash.events.MouseEvent;
    import net.wg.data.constants.generated.FORTIFICATION_ALIASES;
    import net.wg.gui.rally.events.RallyViewsEvent;
    import net.wg.data.constants.Values;
    
    public class FortIntroView extends FortIntroMeta implements IFortIntroMeta
    {
        
        public function FortIntroView()
        {
            super();
            listRoomBtn.UIID = 30;
            this.fortBattleBtn.UIID = 285212702;
            visible = false;
        }
        
        public var fortBattleTitleLbl:TextField = null;
        
        public var fortBattleDescrLbl:TextField = null;
        
        public var additionalText:TextField = null;
        
        public var fortBattleBtn:SoundButtonEx = null;
        
        public var fortBattleBtnTitle:TextField = null;
        
        private var model:IntroViewVO = null;
        
        override public function getComponentForFocus() : InteractiveObject
        {
            return listRoomBtn;
        }
        
        override public function canShowAutomatically() : Boolean
        {
            return false;
        }
        
        override protected function setIntroData(param1:IntroViewVO) : void
        {
            this.model = param1;
            invalidateData();
        }
        
        override protected function draw() : void
        {
            super.draw();
            if((isInvalid(InvalidationType.DATA)) && !(this.model == null))
            {
                this.updateIntroData();
                visible = true;
            }
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            titleLbl.text = FORTIFICATIONS.SORTIE_INTROVIEW_TITLE;
            descrLbl.text = FORTIFICATIONS.SORTIE_INTROVIEW_DESCR;
            listRoomTitleLbl.text = FORTIFICATIONS.SORTIE_INTROVIEW_SORTIE_TITLE;
            listRoomDescrLbl.text = FORTIFICATIONS.SORTIE_INTROVIEW_SORTIE_DESCR;
            listRoomBtn.label = FORTIFICATIONS.SORTIE_INTROVIEW_SORTIE_BTNTITLE;
            var _loc1_:Boolean = App.globalVarsMgr.isFortificationBattleAvailableS();
            this.fortBattleBtnTitle.visible = !_loc1_;
            if(_loc1_)
            {
                gotoAndStop("battles_allowed");
            }
            else
            {
                gotoAndStop("battles_denied");
                this.fortBattleBtnTitle.text = FORTIFICATIONS.SORTIE_INTROVIEW_FORTBATTLES_BTNTITLE;
            }
        }
        
        override protected function onDispose() : void
        {
            this.fortBattleBtn.removeEventListener(ButtonEvent.CLICK,this.onClickFortBattleBtnHandler);
            this.fortBattleBtn.removeEventListener(MouseEvent.ROLL_OVER,this.onControlRollOver);
            this.fortBattleBtn.removeEventListener(MouseEvent.ROLL_OUT,onControlRollOut);
            this.fortBattleBtn.dispose();
            this.fortBattleBtn = null;
            this.fortBattleBtnTitle = null;
            this.fortBattleTitleLbl = null;
            this.fortBattleDescrLbl = null;
            this.additionalText = null;
            this.model.dispose();
            this.model = null;
            super.onDispose();
        }
        
        override protected function onListRoomBtnClick(param1:ButtonEvent) : void
        {
            App.eventLogManager.logUIEvent(param1,0);
            var _loc2_:String = param1.target == this.fortBattleBtn?FORTIFICATION_ALIASES.FORT_CLAN_BATTLE_LIST_VIEW_UI:FORTIFICATION_ALIASES.FORT_BATTLE_ROOM_LIST_VIEW_UI;
            var _loc3_:Object = {"alias":_loc2_,
            "itemId":Number.NaN,
            "peripheryID":0,
            "slotIndex":-1
        };
        dispatchEvent(new RallyViewsEvent(RallyViewsEvent.LOAD_VIEW_REQUEST,_loc3_));
    }
    
    override protected function onControlRollOver(param1:MouseEvent) : void
    {
        switch(param1.target)
        {
            case listRoomBtn:
                App.toolTipMgr.show(TOOLTIPS.FORTIFICATION_INTROVIEW_SORTIE_BTNTOOLTIP);
                break;
            case this.fortBattleBtn:
                App.toolTipMgr.show(this.model?this.model.clanBattleBtnSimpleTooltip:"empty tooltip");
                break;
        }
    }
    
    private function onClickFortBattleBtnHandler(param1:ButtonEvent) : void
    {
        this.onListRoomBtnClick(param1);
    }
    
    private function updateIntroData() : void
    {
        this.fortBattleTitleLbl.text = this.model.fortBattleTitle;
        this.fortBattleDescrLbl.text = this.model.fortBattleDescr;
        this.additionalText.htmlText = this.model.clanBattleAdditionalText;
        this.fortBattleBtn.enabled = this.model.enableBtn;
        this.fortBattleBtn.label = this.model.fortBattleBtnTitle;
        this.fortBattleBtn.validateNow();
        if(this.model.clanBattleBtnSimpleTooltip != Values.EMPTY_STR)
        {
            if(App.globalVarsMgr.isFortificationBattleAvailableS())
            {
                this.fortBattleBtn.addEventListener(MouseEvent.ROLL_OVER,this.onControlRollOver);
                this.fortBattleBtn.addEventListener(MouseEvent.ROLL_OUT,onControlRollOut);
                if(!this.fortBattleBtn.enabled)
                {
                    this.fortBattleBtn.mouseChildren = this.fortBattleBtn.mouseEnabled = true;
                }
            }
        }
        else
        {
            this.fortBattleBtn.tooltip = this.model.clanBattleBtnComplexTooltip;
            this.fortBattleBtn.removeEventListener(MouseEvent.ROLL_OVER,this.onControlRollOver);
            this.fortBattleBtn.removeEventListener(MouseEvent.ROLL_OUT,onControlRollOut);
        }
        if(this.fortBattleBtn.enabled)
        {
            this.fortBattleBtn.addEventListener(ButtonEvent.CLICK,this.onClickFortBattleBtnHandler);
        }
        this.additionalText.x = Math.round(this.fortBattleBtn.x + (this.fortBattleBtn.width >> 1) - (this.additionalText.width >> 1));
    }
}
}
