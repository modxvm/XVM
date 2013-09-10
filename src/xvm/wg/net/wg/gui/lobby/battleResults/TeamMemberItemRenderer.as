package net.wg.gui.lobby.battleResults 
{
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.text.*;
    import net.wg.data.components.*;
    import net.wg.gui.components.controls.*;
    
    public class TeamMemberItemRenderer extends net.wg.gui.components.controls.SoundListItemRenderer
    {
        public function TeamMemberItemRenderer()
        {
            super();
            return;
        }

        public override function setData(arg1:Object):void
        {
            this.data = arg1;
            this._dataDirty = true;
            invalidate();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.mouseChildren = true;
            this.medalIcon.addEventListener(flash.events.MouseEvent.ROLL_OVER, this.onMedalRollOver);
            this.medalIcon.addEventListener(flash.events.MouseEvent.ROLL_OUT, this.onMedalRollOut);
            this.medalIcon.addEventListener(flash.events.MouseEvent.CLICK, this.onMedalClick);
            return;
        }

        public override function dispose():void
        {
            super.dispose();
            this.medalIcon.removeEventListener(flash.events.MouseEvent.ROLL_OVER, this.onMedalRollOver);
            this.medalIcon.removeEventListener(flash.events.MouseEvent.ROLL_OUT, this.onMedalRollOut);
            this.medalIcon.removeEventListener(flash.events.MouseEvent.CLICK, this.onMedalClick);
            this.medalIcon.dispose();
            this.vehicleIcon.dispose();
            return;
        }

        internal function onMedalRollOver(arg1:flash.events.MouseEvent):void
        {
            var loc1:*=null;
            var loc2:*=0;
            if (data.achievements.length > 0) 
            {
                loc1 = [];
                loc2 = 0;
                while (loc2 < data.achievements.length) 
                {
                    loc1.push(App.utils.locale.makeString(ACHIEVEMENTS.all(data.achievements[loc2].type)));
                    ++loc2;
                }
                App.toolTipMgr.show(loc1.join("\n"));
            }
            return;
        }

        protected override function handleMouseRollOver(arg1:flash.events.MouseEvent):void
        {
            super.handleMouseRollOver(arg1);
            this.fakeFocusIndicator.gotoAndPlay("over");
            return;
        }

        protected override function handleMouseRollOut(arg1:flash.events.MouseEvent):void
        {
            super.handleMouseRollOut(arg1);
            this.fakeFocusIndicator.gotoAndPlay("out");
            return;
        }

        internal function onMedalRollOut(arg1:flash.events.MouseEvent):void
        {
            App.toolTipMgr.hide();
            return;
        }

        internal function onMedalClick(arg1:flash.events.MouseEvent):void
        {
            this.handleMouseRelease(arg1);
            return;
        }

        protected override function handleMouseRelease(arg1:flash.events.MouseEvent):void
        {
            var loc1:*=null;
            if (App.utils.commons.isRightButton(arg1) && this.data) 
            {
                loc1 = {"uid":data.playerId, "userName":data.userName, "himself":data.isSelf};
                App.contextMenuMgr.showUserContextMenu(this, loc1, new net.wg.data.components.BattleResultsCIGenerator(data.isOwnSquad));
            }
            super.handleMouseRelease(arg1);
            return;
        }

        internal function getDimmFilter():flash.filters.ColorMatrixFilter
        {
            var loc1:*=new flash.filters.ColorMatrixFilter();
            var loc2:*=[0.4, 0, 0, 0, 0];
            var loc3:*=[0, 0.4, 0, 0, 0];
            var loc4:*=[0, 0, 0.4, 0, 0];
            var loc5:*=[0, 0, 0, 1, 0];
            var loc6:*=(loc6 = (loc6 = (loc6 = (loc6 = new Array()).concat(loc2)).concat(loc3)).concat(loc4)).concat(loc5);
            loc1.matrix = loc6;
            return loc1;
        }

        protected override function draw():void
        {
            var loc1:*=NaN;
            var loc2:*=NaN;
            super.draw();
            if (this._dataDirty) 
            {
                if (data) 
                {
                    this.visible = true;
                    this.selfBg.visible = data.isSelf;
                    this.sqadIcon.visible = false;
                    App.utils.commons.formatPlayerName(this.playerName, data.userName, data.playerClan, null, data.isIGR, null, -5);
                    this.vehicleIcon.source = data.tankIcon ? data.tankIcon : this.vehicleIcon.sourceAlt;
                    this.vehicleName.text = data.vehicleName;
                    this.xpLbl.text = App.utils.locale.integer(data.xp);
                    this.damageLbl.text = "0";
                    this.fragsLbl.text = " ";
                    this.playerName.textColor = 13224374;
                    this.vehicleName.textColor = 13224374;
                    var loc3:*;
                    this.damageLbl.textColor = loc3 = 13413751;
                    this.fragsLbl.textColor = loc3;
                    this.deadBg.visible = false;
                    this.medalIcon.visible = false;
                    if (data.killerID > 0) 
                    {
                        this.playerName.textColor = 6381391;
                        this.vehicleName.textColor = 6381391;
                        this.damageLbl.textColor = 6381391;
                        this.deadBg.visible = true;
                        this.vehicleIcon.filters = [this.getDimmFilter()];
                    }
                    else 
                        this.vehicleIcon.filters = [];
                    if (data.damageDealt > 0) 
                        this.damageLbl.text = App.utils.locale.integer(data.damageDealt);
                    if (data.squadID > 0) 
                    {
                        this.sqadIcon.visible = true;
                        this.sqadIcon.gotoAndStop(data.isOwnSquad ? "own" : "other");
                        if (data.isOwnSquad) 
                        {
                            loc1 = this.getColorForAlias("squad", 16761700);
                            this.playerName.textColor = loc1;
                            this.vehicleName.textColor = loc1;
                        }
                        this.sqadIcon.squadLbl.text = data.squadID;
                    }
                    if (data.kills) 
                    {
                        this.fragsLbl.htmlText = data.kills;
                        if (this.fragsLbl.text == "0") 
                            this.fragsLbl.text = " ";
                    }
                    if (data.tkills > 0) 
                    {
                        loc2 = this.getColorForAlias("teamkiller", 65535);
                        this.fragsLbl.htmlText = this.fragsLbl.htmlText + ("(<FONT color=\"#" + loc2.toString(16) + "\">" + data.tkills + "</FONT>)");
                        if (data.isTeamKiller) 
                        {
                            this.playerName.textColor = loc2;
                            this.vehicleName.textColor = loc2;
                        }
                    }
                    if (data.medalsCount > 0) 
                    {
                        this.medalIcon.value = data.medalsCount;
                        this.medalIcon.validateNow();
                        this.medalIcon.visible = true;
                    }
                }
                else 
                {
                    this.visible = false;
                    this.selectable = false;
                }
                this._dataDirty = false;
            }
            return;
        }

        internal function getColorForAlias(arg1:String, arg2:Number):Number
        {
            var alias:String;
            var defaultColor:Number;
            var result:Number;

            var loc1:*;
            alias = arg1;
            defaultColor = arg2;
            result = undefined;
            try 
                result = App.colorSchemeMgr.getRGB(alias);
            catch (e:Error)
            {
                result = defaultColor;
            }
            finally
            {
                if (!result) 
                    result = defaultColor;
            }
            return result;
        }

        public var selfBg:flash.display.MovieClip;

        public var teamKillBg:flash.display.MovieClip;

        public var deadBg:flash.display.MovieClip;

        public var selectionBg:flash.display.MovieClip;

        public var playerName:flash.text.TextField;

        public var vehicleName:flash.text.TextField;

        public var damageLbl:flash.text.TextField;

        public var fragsLbl:flash.text.TextField;

        public var xpLbl:flash.text.TextField;

        public var medalIcon:net.wg.gui.lobby.battleResults.EfficiencyIconRenderer;

        public var fakeFocusIndicator:flash.display.MovieClip;

        public var sqadIcon:flash.display.MovieClip;

        public var vehicleIcon:net.wg.gui.components.controls.UILoaderAlt;

        internal var _dataDirty:Boolean=false;
    }
}
