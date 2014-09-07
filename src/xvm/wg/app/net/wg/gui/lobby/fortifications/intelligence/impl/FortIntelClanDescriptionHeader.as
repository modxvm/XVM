package net.wg.gui.lobby.fortifications.intelligence.impl
{
    import scaleform.clik.core.UIComponent;
    import flash.events.MouseEvent;
    import flash.text.TextField;
    import net.wg.gui.components.controls.TextFieldShort;
    import net.wg.gui.components.advanced.ClanEmblem;
    import net.wg.gui.components.controls.CheckBox;
    import net.wg.gui.components.controls.UILoaderAlt;
    import flash.display.MovieClip;
    import net.wg.gui.lobby.fortifications.data.ClanDescriptionVO;
    import net.wg.data.constants.Values;
    import scaleform.clik.constants.InvalidationType;
    import scaleform.clik.events.ButtonEvent;
    import net.wg.gui.lobby.fortifications.events.FortIntelClanDescriptionEvent;
    import net.wg.infrastructure.interfaces.IContextItem;
    import net.wg.data.components.ContextItem;
    import net.wg.gui.events.ContextMenuEvent;
    
    public class FortIntelClanDescriptionHeader extends UIComponent
    {
        
        public function FortIntelClanDescriptionHeader()
        {
            super();
        }
        
        private static var OPEN_CLAN_CARD:String = "openClanCard";
        
        private static var CLAN_LIST:String = "clanList";
        
        private static var CLAN_STATISTICS:String = "clanStatistics";
        
        private static var DEFAULT_CONTENT_WIDTH:uint = 408;
        
        private static var DEFAULT_PADDING:uint = 20;
        
        private static var DEFAULT_TEXT_MARGIN:uint = 6;
        
        private static function onCheckBoxRollOut(param1:MouseEvent) : void
        {
            App.toolTipMgr.hide();
        }
        
        public var battlesField:FortIntelClanDescriptionLIT;
        
        public var winsField:FortIntelClanDescriptionLIT;
        
        public var avgDefresField:FortIntelClanDescriptionLIT;
        
        public var clanTagTF:TextField = null;
        
        public var clanNameTFShort:TextFieldShort = null;
        
        public var clanInfoTFShort:TextFieldShort = null;
        
        public var clanEmblem:ClanEmblem = null;
        
        public var checkBox:CheckBox = null;
        
        public var checkBoxIcon:UILoaderAlt = null;
        
        public var infotipHitArea:MovieClip = null;
        
        private var _model:ClanDescriptionVO;
        
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
            this.infotipHitArea.alpha = 0;
            this.checkBox.label = Values.EMPTY_STR;
            this.checkBoxIcon.source = RES_ICONS.MAPS_ICONS_BUTTONS_BOOKMARK;
            this.clanNameTFShort.buttonMode = false;
            this.clanInfoTFShort.buttonMode = false;
            this.clanNameTFShort.mouseEnabled = false;
            this.clanInfoTFShort.mouseEnabled = false;
            this.infotipHitArea.addEventListener(MouseEvent.ROLL_OVER,this.onHitAreaRollOver);
            this.infotipHitArea.addEventListener(MouseEvent.ROLL_OUT,this.onHitAreaRollOut);
        }
        
        override protected function onDispose() : void
        {
            this.infotipHitArea.removeEventListener(MouseEvent.ROLL_OVER,this.onHitAreaRollOver);
            this.infotipHitArea.removeEventListener(MouseEvent.ROLL_OUT,this.onHitAreaRollOut);
            this.removeCheckBoxListeners();
            this.clanTagTF = null;
            this.clanNameTFShort.dispose();
            this.clanNameTFShort = null;
            this.clanInfoTFShort.dispose();
            this.clanInfoTFShort = null;
            this.battlesField.dispose();
            this.battlesField = null;
            this.winsField.dispose();
            this.winsField = null;
            this.avgDefresField.dispose();
            this.avgDefresField = null;
            this.clanEmblem.dispose();
            this.clanEmblem = null;
            this.checkBox.dispose();
            this.checkBox = null;
            this.checkBoxIcon.dispose();
            this.checkBoxIcon = null;
            this.infotipHitArea = null;
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
                this.clanEmblem.setImage(this._model.clanEmblem);
                this.clanTagTF.text = this._model.clanTag;
                this.clanNameTFShort.label = this._model.clanName;
                this.clanInfoTFShort.label = this._model.clanInfo;
                this.clanNameTFShort.x = this.clanTagTF.x + this.clanTagTF.textWidth + DEFAULT_TEXT_MARGIN;
                this.battlesField.model = this._model.clanBattles;
                this.winsField.model = this._model.clanWins;
                this.avgDefresField.model = this._model.clanAvgDefres;
                this.checkBox.visible = this.checkBoxIcon.visible = this._model.canAddToFavorite;
                if(!this._model.canAddToFavorite)
                {
                    this.clanNameTFShort.width = DEFAULT_CONTENT_WIDTH - this.clanNameTFShort.x - DEFAULT_PADDING;
                    this.removeCheckBoxListeners();
                }
                else
                {
                    this.checkBox.selected = this._model.isFavorite;
                    this.checkBox.enabled = !(!this._model.isFavorite && this._model.numOfFavorites >= this._model.favoritesLimit);
                    this.clanNameTFShort.width = this.checkBox.x - this.clanNameTFShort.x - DEFAULT_PADDING;
                    this.addCheckBoxListeners();
                }
                this.clanInfoTFShort.width = this.clanNameTFShort.x + this.clanNameTFShort.width - this.clanInfoTFShort.x;
                App.utils.scheduler.scheduleTask(this.calculateHitAreaWidth,100);
            }
        }
        
        private function calculateHitAreaWidth() : void
        {
            if(this.clanNameTFShort.x + this.clanNameTFShort.textField.textWidth >= this.clanInfoTFShort.x + this.clanInfoTFShort.textField.textWidth)
            {
                this.infotipHitArea.width = this.clanNameTFShort.x + this.clanNameTFShort.textField.textWidth - this.infotipHitArea.x;
            }
            else
            {
                this.infotipHitArea.width = this.clanInfoTFShort.x + this.clanInfoTFShort.textField.textWidth - this.infotipHitArea.x;
            }
        }
        
        private function addCheckBoxListeners() : void
        {
            this.checkBox.addEventListener(ButtonEvent.CLICK,this.onClickCheckBox);
            this.checkBox.addEventListener(MouseEvent.ROLL_OVER,this.onCheckBoxRollOver);
            this.checkBox.addEventListener(MouseEvent.ROLL_OUT,onCheckBoxRollOut);
        }
        
        private function removeCheckBoxListeners() : void
        {
            this.checkBox.removeEventListener(ButtonEvent.CLICK,this.onClickCheckBox);
            this.checkBox.removeEventListener(MouseEvent.ROLL_OVER,this.onCheckBoxRollOver);
            this.checkBox.removeEventListener(MouseEvent.ROLL_OUT,onCheckBoxRollOut);
        }
        
        private function onHitAreaRollOver(param1:MouseEvent) : void
        {
            dispatchEvent(new FortIntelClanDescriptionEvent(FortIntelClanDescriptionEvent.SHOW_CLAN_INFOTIP));
        }
        
        private function onHitAreaRollOut(param1:MouseEvent) : void
        {
            dispatchEvent(new FortIntelClanDescriptionEvent(FortIntelClanDescriptionEvent.HIDE_CLAN_INFOTIP));
        }
        
        private function onClickCheckBox(param1:ButtonEvent) : void
        {
            dispatchEvent(new FortIntelClanDescriptionEvent(FortIntelClanDescriptionEvent.CHECKBOX_CLICK));
        }
        
        private function onCheckBoxRollOver(param1:MouseEvent) : void
        {
            var _loc2_:* = "";
            if(!this.checkBox.selected)
            {
                if(this.checkBox.enabled)
                {
                    _loc2_ = TOOLTIPS.FORTIFICATION_FORTINTELLIGENCECLANDESCRIPTION_ADDTOFAVORITE;
                }
                else
                {
                    _loc2_ = TOOLTIPS.FORTIFICATION_FORTINTELLIGENCECLANDESCRIPTION_MAXFAVORITES;
                }
            }
            else
            {
                _loc2_ = TOOLTIPS.FORTIFICATION_FORTINTELLIGENCECLANDESCRIPTION_REMOVEFROMFAVORITE;
            }
            App.toolTipMgr.show(_loc2_);
        }
        
        private function onClanEmblemClick(param1:MouseEvent) : void
        {
            var _loc2_:Vector.<IContextItem> = null;
            if(App.utils.commons.isRightButton(param1))
            {
                _loc2_ = Vector.<IContextItem>([new ContextItem(OPEN_CLAN_CARD,MENU.FORTIFICATIONCTX_CLANDESCRIPTION_OPENCLANCARD),new ContextItem(CLAN_LIST,MENU.FORTIFICATIONCTX_CLANDESCRIPTION_CLANCREW),new ContextItem(CLAN_STATISTICS,MENU.FORTIFICATIONCTX_CLANDESCRIPTION_CLANSTATISTICS)]);
                App.contextMenuMgr.show(_loc2_,this,this.onContextMenuAction);
            }
        }
        
        private function onContextMenuAction(param1:ContextMenuEvent) : void
        {
            switch(param1.id)
            {
                case OPEN_CLAN_CARD:
                    dispatchEvent(new FortIntelClanDescriptionEvent(FortIntelClanDescriptionEvent.OPEN_CLAN_CARD));
                    break;
                case CLAN_LIST:
                    dispatchEvent(new FortIntelClanDescriptionEvent(FortIntelClanDescriptionEvent.OPEN_CLAN_LIST));
                    break;
                case CLAN_STATISTICS:
                    dispatchEvent(new FortIntelClanDescriptionEvent(FortIntelClanDescriptionEvent.OPEN_CLAN_STATISTICS));
                    break;
            }
        }
    }
}
