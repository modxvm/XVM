package net.wg.gui.lobby.battleResults 
{
    import flash.display.*;
    import flash.text.*;
    import net.wg.gui.components.advanced.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.events.*;
    import net.wg.infrastructure.interfaces.*;
    import scaleform.clik.core.*;
    import scaleform.clik.data.*;
    import scaleform.clik.events.*;
    
    public class TeamStats extends scaleform.clik.core.UIComponent implements net.wg.infrastructure.interfaces.IViewStackContent
    {
        public function TeamStats()
        {
            this.iconTypeToKey = {"squad":{"key":"prebattleID", "isNumeric":true, "index":0}, "player":{"key":"playerName", "isNumeric":false, "index":1}, "tank":{"key":"vehicleSort", "isNumeric":true, "index":2}, "damage":{"key":"damageDealt", "isNumeric":true, "index":3}, "frag":{"key":"realKills", "isNumeric":true, "index":4}, "xp":{"key":"xp", "isNumeric":true, "index":5}, "medal":{"key":"medalsCount", "isNumeric":true, "index":6}};
            super();
            return;
        }

        protected override function configUI():void
        {
            var loc1:*=null;
            super.configUI();
            var loc6:*;
            this.header2.dataProvider = loc6 = this.getHeadersProvider();
            this.header1.dataProvider = loc6;
            this.header1.tabEnabled = false;
            this.header1.focusable = false;
            this.header1.validateNow();
            this.header2.validateNow();
            this.ownTitle.text = BATTLE_RESULTS.TEAM_STATS_OWNTEAM;
            this.enemyTitle.text = BATTLE_RESULTS.TEAM_STATS_ENEMYTEAM;
            this.header2.tabEnabled = false;
            this.header2.focusable = false;
            loc1 = this.myParent.data;
            this.team1Stats.list = this.team1List;
            this.team2Stats.list = this.team2List;
            this.team1Stats.visible = loc6 = false;
            this.team2Stats.visible = loc6;
            this.team2List.mouseEnabled = loc6 = false;
            this.team1List.mouseEnabled = loc6;
            this.header1.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onHeaderClick);
            this.header2.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onHeaderClick);
            this.myParent.addEventListener(net.wg.gui.events.FinalStatisticEvent.HIDE_STATS_VIEW, this.hideStatsView);
            this.team1List.addEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE, this.onItemSelect);
            this.team2List.addEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE, this.onItemSelect);
            this.team1List.addEventListener(net.wg.gui.events.ListEventEx.ITEM_CLICK, this.onItemSelect);
            this.team2List.addEventListener(net.wg.gui.events.ListEventEx.ITEM_CLICK, this.onItemSelect);
            this.team1List.dataProvider = new scaleform.clik.data.DataProvider(loc1.team1);
            this.team2List.dataProvider = new scaleform.clik.data.DataProvider(loc1.team2);
            var loc2:*=loc1.common.iconType;
            var loc3:*=loc1.common.sortDirection;
            this.header2.selectedIndex = loc6 = this.iconTypeToKey[loc2].index;
            this.header1.selectedIndex = loc6;
            var loc4:*=net.wg.gui.components.advanced.InteractiveSortingButton(this.header1.getButtonAt(this.iconTypeToKey[loc2].index));
            var loc5:*=net.wg.gui.components.advanced.InteractiveSortingButton(this.header2.getButtonAt(this.iconTypeToKey[loc2].index));
            loc5.sortDirection = loc6 = loc3;
            loc4.sortDirection = loc6;
            this.applySort(loc2, loc3);
            return;
        }

        internal function hideStatsView(arg1:net.wg.gui.events.FinalStatisticEvent):void
        {
            this.team1List.selectedIndex = -1;
            this.team2List.selectedIndex = -1;
            return;
        }

        internal function onItemSelect(arg1:scaleform.clik.events.ListEvent):void
        {
            var loc1:*=null;
            if (arg1.type == net.wg.gui.events.ListEventEx.ITEM_CLICK) 
            {
                if (arg1.target.selectedIndex != -1) 
                {
                    arg1.target.selectedIndex = -1;
                }
                if (App.stage.focus != arg1.target) 
                {
                    App.utils.focusHandler.setFocus(flash.display.InteractiveObject(arg1.target));
                }
            }
            if (arg1.target.selectedIndex != -1) 
            {
                loc1 = arg1.target != this.team1List ? this.team1List : this.team2List;
                loc1.selectedIndex = -1;
                loc1.validateNow();
            }
            if (arg1.itemData || arg1.target.selectedIndex == -1) 
            {
                this.header1.visible = this.team2List.selectedIndex == -1;
                var loc2:*;
                this.team1List.visible = loc2 = this.team2List.selectedIndex == -1;
                this.team1List.tabEnabled = loc2;
                this.team1Stats.data = this.team1List.selectedIndex > -1 ? this.team1List.dataProvider[this.team1List.selectedIndex] : null;
                this.team1Stats.visible = this.team1List.selectedIndex > -1 && this.team1Stats.data;
                this.header2.visible = this.team1List.selectedIndex == -1;
                this.team2List.visible = loc2 = this.team1List.selectedIndex == -1;
                this.team2List.tabEnabled = loc2;
                this.team2Stats.data = this.team2List.selectedIndex > -1 ? this.team2List.dataProvider[this.team2List.selectedIndex] : null;
                this.team2Stats.visible = this.team2List.selectedIndex > -1 && this.team2Stats.data;
            }
            return;
        }

        public function get myParent():net.wg.gui.lobby.battleResults.BattleResults
        {
            return net.wg.gui.lobby.battleResults.BattleResults(parent.parent.parent);
        }

        internal function onHeaderClick(arg1:scaleform.clik.events.ButtonEvent):void
        {
            var loc1:*=null;
            if (arg1.target is net.wg.gui.components.advanced.InteractiveSortingButton) 
            {
                if (arg1.currentTarget != this.header1) 
                {
                    this.header1.selectedIndex = this.header2.selectedIndex;
                    loc1 = net.wg.gui.components.advanced.InteractiveSortingButton(this.header1.getButtonAt(this.header2.selectedIndex));
                }
                else 
                {
                    this.header2.selectedIndex = this.header1.selectedIndex;
                    loc1 = net.wg.gui.components.advanced.InteractiveSortingButton(this.header2.getButtonAt(this.header1.selectedIndex));
                }
                loc1.sortDirection = net.wg.gui.components.advanced.InteractiveSortingButton(arg1.target).sortDirection;
                this.applySort(loc1.id, loc1.sortDirection);
            }
            return;
        }

        internal function applySort(arg1:String, arg2:String):void
        {
            var loc1:*=0;
            if (this.iconTypeToKey[arg1].isNumeric) 
            {
                loc1 = loc1 | Array.NUMERIC;
            }
            else 
            {
                loc1 = loc1 | Array.CASEINSENSITIVE;
            }
            if (arg2 == net.wg.gui.components.advanced.SortingButton.DESCENDING_SORT) 
            {
                loc1 = loc1 | Array.DESCENDING;
            }
            var loc2:*;
            (loc2 = scaleform.clik.data.DataProvider(this.team1List.dataProvider).slice()).sortOn(this.iconTypeToKey[arg1].key, loc1);
            this.team1List.selectedIndex = -1;
            this.team1List.dataProvider = new scaleform.clik.data.DataProvider(loc2);
            (loc2 = scaleform.clik.data.DataProvider(this.team2List.dataProvider).slice()).sortOn(this.iconTypeToKey[arg1].key, loc1);
            this.team2List.selectedIndex = -1;
            this.team2List.dataProvider = new scaleform.clik.data.DataProvider(loc2);
            this.myParent.saveSortingS(arg1, arg2);
            return;
        }

        public override function dispose():void
        {
            super.dispose();
            this.header1.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onHeaderClick);
            this.header2.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onHeaderClick);
            this.team1List.removeEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE, this.onItemSelect);
            this.team2List.removeEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE, this.onItemSelect);
            this.team1List.removeEventListener(net.wg.gui.events.ListEventEx.ITEM_CLICK, this.onItemSelect);
            this.team2List.removeEventListener(net.wg.gui.events.ListEventEx.ITEM_CLICK, this.onItemSelect);
            this.myParent.removeEventListener(net.wg.gui.events.FinalStatisticEvent.HIDE_STATS_VIEW, this.hideStatsView);
            return;
        }

        internal function getHeadersProvider():scaleform.clik.data.DataProvider
        {
            var loc1:*="../maps/icons/buttons/tab_sort_button/ascendingSortArrow.png";
            var loc2:*="../maps/icons/buttons/tab_sort_button/descendingSortArrow.png";
            var loc3:*=new net.wg.gui.components.advanced.SortingButtonInfo();
            loc3.iconId = SQUAD;
            loc3.iconSource = "../maps/icons/buttons/tab_sort_button/squad.png";
            loc3.ascendingIconSource = loc1;
            loc3.descendingIconSource = loc2;
            loc3.toolTip = BATTLE_RESULTS.TEAM_SQUADHEADER;
            loc3.buttonWidth = 30;
            loc3.buttonHeight = 30;
            loc3.enabled = true;
            loc3.defaultSortDirection = net.wg.gui.components.advanced.SortingButton.ASCENDING_SORT;
            var loc4:*;
            (loc4 = new net.wg.gui.components.advanced.SortingButtonInfo()).iconId = PLAYER;
            loc4.iconSource = "../maps/icons/buttons/tab_sort_button/player.png";
            loc4.ascendingIconSource = loc1;
            loc4.descendingIconSource = loc2;
            loc4.toolTip = BATTLE_RESULTS.TEAM_PLAYERHEADER;
            loc4.buttonWidth = 135;
            loc4.buttonHeight = 30;
            loc4.enabled = true;
            loc4.defaultSortDirection = net.wg.gui.components.advanced.SortingButton.ASCENDING_SORT;
            var loc5:*;
            (loc5 = new net.wg.gui.components.advanced.SortingButtonInfo()).iconId = TANK;
            loc5.iconSource = "../maps/icons/buttons/tab_sort_button/tank.png";
            loc5.ascendingIconSource = loc1;
            loc5.descendingIconSource = loc2;
            loc5.toolTip = BATTLE_RESULTS.TEAM_TANKHEADER;
            loc5.buttonWidth = 128;
            loc5.buttonHeight = 30;
            loc5.enabled = true;
            loc5.defaultSortDirection = net.wg.gui.components.advanced.SortingButton.DESCENDING_SORT;
            var loc6:*;
            (loc6 = new net.wg.gui.components.advanced.SortingButtonInfo()).iconId = DAMAGE;
            loc6.iconSource = "../maps/icons/buttons/tab_sort_button/damage.png";
            loc6.ascendingIconSource = loc1;
            loc6.descendingIconSource = loc2;
            loc6.toolTip = BATTLE_RESULTS.TEAM_DAMAGEHEADER;
            loc6.buttonWidth = 47;
            loc6.buttonHeight = 30;
            loc6.enabled = true;
            loc6.defaultSortDirection = net.wg.gui.components.advanced.SortingButton.DESCENDING_SORT;
            var loc7:*;
            (loc7 = new net.wg.gui.components.advanced.SortingButtonInfo()).iconId = FRAG;
            loc7.iconSource = "../maps/icons/buttons/tab_sort_button/frag.png";
            loc7.ascendingIconSource = loc1;
            loc7.descendingIconSource = loc2;
            loc7.toolTip = BATTLE_RESULTS.TEAM_FRAGHEADER;
            loc7.buttonWidth = 47;
            loc7.buttonHeight = 30;
            loc7.enabled = true;
            loc7.defaultSortDirection = net.wg.gui.components.advanced.SortingButton.DESCENDING_SORT;
            var loc8:*;
            (loc8 = new net.wg.gui.components.advanced.SortingButtonInfo()).iconId = XP;
            loc8.iconSource = "../maps/icons/buttons/tab_sort_button/star.png";
            loc8.ascendingIconSource = loc1;
            loc8.descendingIconSource = loc2;
            loc8.toolTip = BATTLE_RESULTS.TEAM_XPHEADER;
            loc8.buttonWidth = 61;
            loc8.buttonHeight = 30;
            loc8.enabled = true;
            loc8.defaultSortDirection = net.wg.gui.components.advanced.SortingButton.DESCENDING_SORT;
            var loc9:*;
            (loc9 = new net.wg.gui.components.advanced.SortingButtonInfo()).iconId = MEDAL;
            loc9.iconSource = "../maps/icons/buttons/tab_sort_button/medal.png";
            loc9.ascendingIconSource = loc1;
            loc9.descendingIconSource = loc2;
            loc9.toolTip = BATTLE_RESULTS.TEAM_MEDALHEADER;
            loc9.buttonWidth = 47;
            loc9.buttonHeight = 30;
            loc9.enabled = true;
            loc9.defaultSortDirection = net.wg.gui.components.advanced.SortingButton.DESCENDING_SORT;
            return new scaleform.clik.data.DataProvider([loc3, loc4, loc5, loc6, loc7, loc8, loc9]);
        }

        public function update(arg1:Object):void
        {
            return;
        }

        public function get changeIndexOnFocus():Boolean
        {
            return this._changeIndexOnFocus;
        }

        public function set changeIndexOnFocus(arg1:Boolean):void
        {
            this._changeIndexOnFocus = arg1;
            return;
        }

        internal static const SQUAD:String="squad";

        internal static const PLAYER:String="player";

        internal static const TANK:String="tank";

        internal static const DAMAGE:String="damage";

        internal static const FRAG:String="frag";

        internal static const XP:String="xp";

        internal static const MEDAL:String="medal";

        internal static const MAX_TEAM_LEN:Number=15;

        public var team1List:net.wg.gui.lobby.battleResults.TeamStatsList;

        public var team2List:net.wg.gui.lobby.battleResults.TeamStatsList;

        public var team1Stats:net.wg.gui.lobby.battleResults.TeamMemberStatsView;

        public var team2Stats:net.wg.gui.lobby.battleResults.TeamMemberStatsView;

        public var ownTitle:flash.text.TextField;

        public var enemyTitle:flash.text.TextField;

        internal var _changeIndexOnFocus:Boolean=true;

        public var header1:net.wg.gui.components.advanced.SortableHeaderButtonBar;

        public var header2:net.wg.gui.components.advanced.SortableHeaderButtonBar;

        internal var iconTypeToKey:Object;
    }
}
