package net.wg.gui.lobby.fortifications.battleRoom.clanBattle
{
    import net.wg.infrastructure.base.meta.impl.FortClanBattleListMeta;
    import net.wg.infrastructure.base.meta.IFortClanBattleListMeta;
    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;
    import net.wg.gui.lobby.fortifications.data.battleRoom.clanBattle.ClanBattleListVO;
    import net.wg.gui.rally.interfaces.IRallyVO;
    import net.wg.gui.lobby.fortifications.data.battleRoom.clanBattle.ClanBattleDetailsVO;
    import net.wg.gui.rally.events.RallyViewsEvent;
    import net.wg.data.constants.generated.FORTIFICATION_ALIASES;
    import scaleform.clik.events.ButtonEvent;
    import flash.events.MouseEvent;
    import net.wg.gui.rally.interfaces.IRallyListItemVO;
    import net.wg.gui.components.controls.NormalSortingBtnInfo;
    import scaleform.clik.data.DataProvider;
    import net.wg.data.constants.SortingInfo;
    import net.wg.gui.rally.data.ManualSearchDataProvider;
    import net.wg.gui.lobby.fortifications.data.battleRoom.clanBattle.ClanBattleRenderListVO;
    
    public class FortClanBattleList extends FortClanBattleListMeta implements IFortClanBattleListMeta
    {
        
        public function FortClanBattleList()
        {
            super();
            listDataProvider = new ManualSearchDataProvider(ClanBattleRenderListVO);
            detailsSection.addEventListener(RallyViewsEvent.CREATE_CLAN_BATTLE_ROOM,this.onCreateClanBattleRoomHandler);
        }
        
        public var currentBattlesCount:TextField;
        
        public var currentBattlesCountTitle:TextField;
        
        public var actionDescr:TextField;
        
        public function as_upateClanBattlesCount(param1:String) : void
        {
            this.currentBattlesCount.autoSize = TextFieldAutoSize.LEFT;
            this.currentBattlesCount.htmlText = param1;
            this.updateTextPosition();
        }
        
        override protected function setClanBattleData(param1:ClanBattleListVO) : void
        {
            this.currentBattlesCountTitle.autoSize = TextFieldAutoSize.LEFT;
            this.currentBattlesCountTitle.htmlText = param1.battlesCountTitle;
            this.updateTextPosition();
            this.actionDescr.htmlText = param1.actionDescr;
            titleLbl.htmlText = param1.titleLbl;
            descrLbl.htmlText = param1.descrLbl;
            titleLbl.x = Math.floor((this._width - titleLbl.width) / 2);
            descrLbl.x = Math.floor((this._width - descrLbl.width) / 2);
        }
        
        private function updateTextPosition() : void
        {
            this.currentBattlesCount.x = Math.round(this.currentBattlesCountTitle.x + this.currentBattlesCountTitle.width);
        }
        
        override protected function convertToRallyVO(param1:Object) : IRallyVO
        {
            return new ClanBattleDetailsVO(param1);
        }
        
        override protected function onPopulate() : void
        {
            super.onPopulate();
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            this.initListColumns();
        }
        
        override protected function onDispose() : void
        {
            detailsSection.removeEventListener(RallyViewsEvent.CREATE_CLAN_BATTLE_ROOM,this.onCreateClanBattleRoomHandler);
            detailsSection.dispose();
            detailsSection = null;
            this.currentBattlesCount = null;
            this.currentBattlesCountTitle = null;
            this.actionDescr = null;
            super.onDispose();
        }
        
        override protected function getRallyViewAlias() : String
        {
            return FORTIFICATION_ALIASES.FORT_CLAN_BATTLE_ROOM_VIEW_UI;
        }
        
        override protected function onCreateClick(param1:ButtonEvent) : void
        {
            var _loc2_:Object = {"alias":FORTIFICATION_ALIASES.FORT_CLAN_BATTLE_ROOM_VIEW_UI,
            "itemId":Number.NaN,
            "peripheryID":0,
            "slotIndex":-1
        };
        dispatchEvent(new RallyViewsEvent(RallyViewsEvent.LOAD_VIEW_REQUEST,_loc2_));
    }
    
    override protected function onControlRollOver(param1:MouseEvent) : void
    {
        switch(param1.currentTarget)
        {
            case backBtn:
                App.toolTipMgr.showComplex(TOOLTIPS.FORTIFICATION_CLAN_LISTROOM_BACK);
                break;
        }
    }
    
    override protected function onJoinRequest(param1:RallyViewsEvent) : void
    {
        var _loc3_:Object = null;
        var _loc2_:IRallyListItemVO = rallyTable.getListSelectedItem() as IRallyListItemVO;
        if((_loc2_) && !(_loc2_.mgrID == 0))
        {
            _loc3_ = {"alias":this.getRallyViewAlias(),
            "itemId":_loc2_.mgrID,
            "peripheryID":_loc2_.peripheryID,
            "slotIndex":(param1.data?param1.data:-1)
        };
        dispatchEvent(new RallyViewsEvent(RallyViewsEvent.LOAD_VIEW_REQUEST,_loc3_));
    }
}

private function initListColumns() : void
{
    var _loc1_:NormalSortingBtnInfo = null;
    var _loc2_:Array = [];
    _loc1_ = new NormalSortingBtnInfo();
    _loc1_.label = FORTIFICATIONS.FORTCLANBATTLELIST_TABLEHEADER_BATTLENAME;
    _loc1_.buttonWidth = 247;
    _loc1_.textAlign = TextFieldAutoSize.LEFT;
    _loc1_.iconId = "direction";
    _loc1_.toolTip = TOOLTIPS.FORTIFICATION_FORTCLANBATTLELIST_BATTLENAME;
    _loc1_.sortOrder = 1;
    _loc2_.push(_loc1_);
    _loc1_ = new NormalSortingBtnInfo();
    _loc1_.label = FORTIFICATIONS.FORTCLANBATTLELIST_TABLEHEADER_DAYOFBATTLE;
    _loc1_.buttonWidth = 200;
    _loc1_.iconId = "description";
    _loc1_.textAlign = TextFieldAutoSize.CENTER;
    _loc1_.toolTip = TOOLTIPS.FORTIFICATION_FORTCLANBATTLELIST_BATTLEDATE;
    _loc1_.sortOrder = 2;
    _loc2_.push(_loc1_);
    _loc1_ = new NormalSortingBtnInfo();
    _loc1_.label = FORTIFICATIONS.FORTCLANBATTLELIST_TABLEHEADER_BATTLETIME;
    _loc1_.textAlign = TextFieldAutoSize.RIGHT;
    _loc1_.buttonWidth = 122;
    _loc1_.iconId = "startTimeLeft";
    _loc1_.toolTip = TOOLTIPS.FORTIFICATION_FORTCLANBATTLELIST_BATTLETIME;
    _loc1_.sortOrder = 0;
    _loc2_.push(_loc1_);
    rallyTable.headerDP = new DataProvider(_loc2_);
    rallyTable.sortByField("startTimeLeft",SortingInfo.ASCENDING_SORT);
}

private function onCreateClanBattleRoomHandler(param1:RallyViewsEvent) : void
{
    var _loc3_:Object = null;
    var _loc2_:IRallyListItemVO = rallyTable.getListSelectedItem() as IRallyListItemVO;
    if((_loc2_) && !(_loc2_.mgrID == 0))
    {
        _loc3_ = {"alias":RallyViewsEvent.CREATE_CLAN_BATTLE_ROOM,
        "itemId":_loc2_.mgrID,
        "peripheryID":_loc2_.peripheryID
    };
    dispatchEvent(new RallyViewsEvent(RallyViewsEvent.LOAD_VIEW_REQUEST,_loc3_));
}
}
}
}
