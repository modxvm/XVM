package net.wg.gui.lobby.fortifications.windows.impl
{
    import net.wg.infrastructure.base.meta.impl.FortBattleResultsWindowMeta;
    import net.wg.infrastructure.base.meta.IFortBattleResultsWindowMeta;
    import net.wg.gui.components.controls.NormalSortingBtnInfo;
    import flash.display.MovieClip;
    import flash.text.TextField;
    import net.wg.gui.components.controls.SortableTable;
    import net.wg.gui.lobby.battleResults.BattleResultsMedalsList;
    import net.wg.gui.lobby.fortifications.data.battleResults.BattleResultsVO;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.gui.lobby.fortifications.events.FortBattleResultsEvent;
    import scaleform.clik.data.DataProvider;
    import flash.text.TextFieldAutoSize;
    
    public class FortBattleResultsWindow extends FortBattleResultsWindowMeta implements IFortBattleResultsWindowMeta
    {
        
        public function FortBattleResultsWindow()
        {
            super();
            isModal = false;
            isCentered = true;
        }
        
        private static var RES_ICON_PADDING:int = 4;
        
        private static function createTableBtnInfo(param1:String, param2:Number, param3:Number, param4:String) : NormalSortingBtnInfo
        {
            var _loc5_:NormalSortingBtnInfo = new NormalSortingBtnInfo();
            _loc5_.label = param1;
            _loc5_.buttonWidth = param2;
            _loc5_.sortOrder = param3;
            _loc5_.textAlign = param4;
            return _loc5_;
        }
        
        public var bgImage:MovieClip = null;
        
        public var resultTF:TextField = null;
        
        public var descriptionTF:TextField = null;
        
        public var defResReceivedTF:TextField = null;
        
        public var byClanTF:TextField = null;
        
        public var byPlayerTF:TextField = null;
        
        public var clanResTF:TextField = null;
        
        public var playerResTF:TextField = null;
        
        public var clanResIcon:MovieClip = null;
        
        public var playerResIcon:MovieClip = null;
        
        public var journalTF:TextField = null;
        
        public var table:SortableTable = null;
        
        public var medalsListLeft:BattleResultsMedalsList = null;
        
        public var medalsListRight:BattleResultsMedalsList = null;
        
        private var data:BattleResultsVO = null;
        
        public function as_notAvailableInfo(param1:int) : void
        {
            this.data.battles[param1].infoNotAvailable = true;
            this.table.listDP = this.getListDP();
        }
        
        public function as_setClanEmblem(param1:String) : void
        {
            this.descriptionTF.htmlText = App.utils.locale.makeString(this.data.descriptionStartText + param1 + this.data.descriptionEndText);
        }
        
        override protected function setData(param1:BattleResultsVO) : void
        {
            this.data = param1;
            invalidateData();
        }
        
        override protected function draw() : void
        {
            super.draw();
            if((isInvalid(InvalidationType.DATA)) && (this.data))
            {
                window.title = this.data.windowTitle;
                this.setBGImage();
                this.setTexts();
                this.setTableData();
                this.setMedalListsData();
                this.clanResIcon.x = this.clanResTF.x + (this.clanResTF.width + this.clanResTF.textWidth >> 1) + RES_ICON_PADDING;
                this.playerResIcon.x = this.playerResTF.x + (this.playerResTF.width + this.playerResTF.textWidth >> 1) + RES_ICON_PADDING;
            }
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            this.table.addEventListener(FortBattleResultsEvent.MORE_BTN_CLICK,this.onMoreBtnClick);
        }
        
        override protected function onPopulate() : void
        {
            super.onPopulate();
        }
        
        override protected function onDispose() : void
        {
            this.table.removeEventListener(FortBattleResultsEvent.MORE_BTN_CLICK,this.onMoreBtnClick);
            this.table.dispose();
            this.table = null;
            this.clanResIcon = null;
            this.playerResIcon = null;
            this.bgImage = null;
            this.resultTF = null;
            this.descriptionTF = null;
            this.defResReceivedTF = null;
            this.byClanTF = null;
            this.byPlayerTF = null;
            this.clanResTF = null;
            this.playerResTF = null;
            this.journalTF = null;
            this.medalsListLeft.dispose();
            this.medalsListRight.dispose();
            this.medalsListLeft = null;
            this.medalsListRight = null;
            if(this.data)
            {
                this.data.dispose();
            }
            this.data = null;
            super.onDispose();
        }
        
        private function setTexts() : void
        {
            this.resultTF.htmlText = this.data.resultText;
            this.descriptionTF.htmlText = App.utils.locale.makeString(this.data.descriptionStartText + " " + this.data.descriptionEndText);
            this.journalTF.htmlText = this.data.journalText;
            this.defResReceivedTF.htmlText = this.data.defResReceivedText;
            this.byClanTF.htmlText = this.data.byClanText;
            this.byPlayerTF.htmlText = this.data.byPlayerText;
            this.clanResTF.htmlText = this.data.clanResText;
            this.playerResTF.htmlText = this.data.playerResText;
            getClanEmblemS();
        }
        
        private function setBGImage() : void
        {
            this.bgImage.gotoAndStop(this.data.battleResult);
        }
        
        private function setTableData() : void
        {
            this.table.headerDP = this.getHeadersDP();
            this.table.listDP = this.getListDP();
        }
        
        private function setMedalListsData() : void
        {
            this.medalsListLeft.dataProvider = new DataProvider(this.data.achievementsLeft);
            this.medalsListRight.dataProvider = new DataProvider(this.data.achievementsRight);
        }
        
        private function getHeadersDP() : DataProvider
        {
            var _loc1_:Array = [];
            _loc1_.push(createTableBtnInfo(FORTIFICATIONS.FORTBATTLERESULTSWINDOW_TABLE_STARTTIME,88,0,TextFieldAutoSize.LEFT));
            _loc1_.push(createTableBtnInfo(FORTIFICATIONS.FORTBATTLERESULTSWINDOW_TABLE_BUILDING,320,0,TextFieldAutoSize.LEFT));
            _loc1_.push(createTableBtnInfo(FORTIFICATIONS.FORTBATTLERESULTSWINDOW_TABLE_RESULT,180,0,TextFieldAutoSize.LEFT));
            return new DataProvider(_loc1_);
        }
        
        private function getListDP() : DataProvider
        {
            var _loc1_:Array = this.data.battles;
            return new DataProvider(_loc1_);
        }
        
        private function onMoreBtnClick(param1:FortBattleResultsEvent) : void
        {
            getMoreInfoS(param1.rendererID);
        }
    }
}
