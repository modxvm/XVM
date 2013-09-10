package net.wg.gui.lobby.battleResults 
{
    import flash.display.*;
    import flash.text.*;
    import net.wg.gui.components.controls.*;
    import scaleform.clik.core.*;
    import scaleform.clik.data.*;
    import scaleform.clik.events.*;
    
    public class TeamMemberStatsView extends scaleform.clik.core.UIComponent
    {
        public function TeamMemberStatsView()
        {
            super();
            return;
        }

        public function get data():Object
        {
            return this._data;
        }

        public function set data(arg1:Object):void
        {
            this._data = arg1;
            this._dataDirty = true;
            invalidate();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.initialStatsY = this.vehicleStats.y;
            this.initialCloseBtnY = this.closeBtn.y;
            this.closeBtn.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onCloseClick);
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (this._dataDirty) 
            {
                this.vehicleStats.state = net.wg.gui.lobby.battleResults.VehicleDetails.STATE_WIDE;
                this.vehicleStats.y = this.initialStatsY;
                this.closeBtn.y = this.initialCloseBtnY;
                this.achievements.visible = false;
                if (this.data) 
                {
                    this.tankIcon.source = this.data.bigTankIcon;
                    this.playerName.text = this.data.playerName;
                    this.vehicleName.text = this.data.vehicleFullName;
                    this.vehicleStateLbl.text = this.data.vehicleStateStr;
                    this.vehicleStats.data = this.data.statValues;
                    this.deadBg.visible = this.data.killerID > 0;
                    this.medalBg.visible = this.data.medalsCount > 0;
                    if (this.data.medalsCount > 0) 
                    {
                        this.vehicleStats.y = this.vehicleStats.y + this.STATS_DY;
                        this.closeBtn.y = this.initialCloseBtnY;
                        this.achievements.visible = true;
                        this.achievements.dataProvider = new scaleform.clik.data.DataProvider(this.data.achievements);
                        this.achievements.validateNow();
                    }
                }
                else 
                {
                    this.tankIcon.source = "";
                    this.playerName.text = "";
                    this.vehicleName.text = "";
                    this.vehicleStateLbl.text = "";
                    this.vehicleStats.data = [];
                    this.deadBg.visible = false;
                    this.medalBg.visible = false;
                }
                this._dataDirty = false;
            }
            return;
        }

        internal function onCloseClick(arg1:scaleform.clik.events.ButtonEvent):void
        {
            net.wg.gui.lobby.battleResults.TeamStats(this.parent).changeIndexOnFocus = false;
            this.list.selectedIndex = -1;
            App.utils.focusHandler.setFocus(this.list);
            return;
        }

        internal const STATS_DY:Number=48;

        public var list:net.wg.gui.components.controls.ScrollingListEx;

        public var tankIcon:net.wg.gui.components.controls.UILoaderAlt;

        public var playerName:flash.text.TextField;

        public var vehicleName:flash.text.TextField;

        public var vehicleStateLbl:flash.text.TextField;

        public var vehicleStats:net.wg.gui.lobby.battleResults.VehicleDetails;

        public var closeBtn:net.wg.gui.components.controls.SoundButtonEx;

        public var myArea:flash.display.MovieClip;

        public var deadBg:flash.display.MovieClip;

        public var medalBg:flash.display.MovieClip;

        public var achievements:net.wg.gui.lobby.battleResults.MedalsList;

        internal var initialStatsY:Number=0;

        internal var initialCloseBtnY:Number=0;

        internal var _data:Object;

        internal var _dataDirty:Boolean;
    }
}
