package net.wg.gui.lobby.battleloading 
{
    import flash.text.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.components.icons.*;
    import scaleform.clik.controls.*;
    import scaleform.clik.core.*;
    import scaleform.clik.data.*;
    
    public class BattleLoadingForm extends scaleform.clik.core.UIComponent
    {
        public function BattleLoadingForm()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            return;
        }

        public function updateProgress(arg1:Number):void
        {
            this.loadingBar.position = arg1;
            return;
        }

        public function updateMapName(arg1:String):void
        {
            this.mapText.text = arg1;
            this.mapText.text = this.mapText.text.toUpperCase();
            return;
        }

        public function setBattleTypeName(arg1:String):void
        {
            this.battleText.text = arg1;
            return;
        }

        public function setBattleTypeFrameNum(arg1:Number):void
        {
            this.battleIcon.typeByNumber = arg1;
            return;
        }

        public function setBattleTypeFrameName(arg1:String):void
        {
            this.battleIcon.type = arg1;
            return;
        }

        public function updateWinText(arg1:String):void
        {
            this.winText.htmlText = arg1;
            this.winText.y = 128 + (40 - this.winText.textHeight >> 1) ^ 0;
            return;
        }

        public function updateTeamsHeaders(arg1:String, arg2:String):void
        {
            this.team1Text.text = arg1;
            this.team2Text.text = arg2;
            return;
        }

        public function updateTip(arg1:String):void
        {
            this.helpTip.text = MENU.LOADING_HELPTIP;
            this.tipText.htmlText = arg1;
            return;
        }

        public function updateTeamValues(arg1:Object):void
        {
            var loc2:*=NaN;
            var loc3:*=null;
            var loc1:*=arg1.playerID;
            loc2 = arg1.squadID;
            var loc4:*=0;
            loc3 = this.normalizeData(arg1.team1, loc1, loc2, 1);
            this.team1List.dataProvider = new scaleform.clik.data.DataProvider(loc3.team);
            this.team1List.selectedIndex = loc3.selected;
            loc3 = this.normalizeData(arg1.team2, loc1, loc2, 2);
            this.team2List.dataProvider = new scaleform.clik.data.DataProvider(loc3.team);
            this.team2List.selectedIndex = loc3.selected;
            return;
        }

        internal function normalizeData(arg1:Array, arg2:Number, arg3:Number, arg4:uint):Object
        {
            var loc1:*;
            (loc1 = new Object()).selected = -1;
            var loc2:*=0;
            while (loc2 < arg1.length) 
            {
                arg1[loc2].position = loc2 + 1;
                if (arg1[loc2].playerID == arg2) 
                {
                    loc1.selected = loc2;
                }
                if (arg3 > 0 && arg1[loc2].squad == arg3 && arg4 == 1) 
                {
                    arg1[loc2].squad = arg1[loc2].squad + 10;
                }
                ++loc2;
            }
            loc1.team = arg1;
            return loc1;
        }

        public function onDispose():void
        {
            this.team1List.disposeRenderers();
            this.team2List.disposeRenderers();
            return;
        }

        public override function toString():String
        {
            return "[WG BattleLoadingForm " + name + "]";
        }

        public var mapText:flash.text.TextField;

        public var battleText:flash.text.TextField;

        public var winText:flash.text.TextField;

        public var team1Text:flash.text.TextField;

        public var team2Text:flash.text.TextField;

        public var helpTip:flash.text.TextField;

        public var tipText:flash.text.TextField;

        public var loadingBar:scaleform.clik.controls.StatusIndicator;

        public var battleIcon:net.wg.gui.components.icons.BattleTypeIcon;

        public var team1List:net.wg.gui.components.controls.ReadOnlyScrollingList;

        public var team2List:net.wg.gui.components.controls.ReadOnlyScrollingList;
    }
}
