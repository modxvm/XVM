package net.wg.gui.lobby.header 
{
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import net.wg.gui.components.advanced.*;
    import scaleform.clik.core.*;
    
    public class TankPanel extends scaleform.clik.core.UIComponent
    {
        public function TankPanel()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            this.clanEmblem.visible = false;
            this.elite.visible = false;
            this.tank_name.mouseEnabled = false;
            this.tank_type.mouseEnabled = false;
            this.account_name.mouseEnabled = false;
            this.clan_name.mouseEnabled = false;
            this.elite.useHandCursor = false;
            this.elite.addEventListener(flash.events.MouseEvent.ROLL_OVER, showTooltip);
            this.elite.addEventListener(flash.events.MouseEvent.ROLL_OUT, hideTooltip);
            return;
        }

        public override function dispose():void
        {
            super.dispose();
            this.elite.removeEventListener(flash.events.MouseEvent.ROLL_OVER, showTooltip);
            this.elite.removeEventListener(flash.events.MouseEvent.ROLL_OUT, hideTooltip);
            return;
        }

        public function setClanEmblem(arg1:String):void
        {
            this.clanEmblem.setImage(arg1);
            this.clanEmblem.visible = true;
            return;
        }

        public function setTankName(arg1:String):void
        {
            var loc1:*=null;
            if (arg1.length == 0) 
                this.tank_name.text = "";
            else 
            {
                loc1 = App.utils.locale.makeString(arg1, {});
                this.tank_name.text = loc1;
            }
            return;
        }

        public function setAccountName(arg1:String, arg2:Boolean, arg3:Boolean):void
        {
            this.account_name.text = arg1;
            var loc1:*=this.account_name.getTextFormat();
            if (arg2) 
            {
                loc1.color = 60159;
                this.account_name.setTextFormat(loc1);
            }
            this._clanEmblemVisible = arg3;
            invalidate(INVALIDATE_CLAN_EMBLEM);
            return;
        }

        public function setTankType(arg1:String):void
        {
            var loc1:*=null;
            if (arg1.length == 0) 
                this.tank_type.text = "";
            else 
            {
                loc1 = App.utils.locale.makeString(MENU.tankmen(arg1), {});
                this.tank_type.text = loc1.toUpperCase();
            }
            return;
        }

        public function setTankElite(arg1:Boolean):void
        {
            if (this._eliteVisible == arg1) 
                return;
            this._eliteVisible = arg1;
            invalidate(INVALIDATE_TANK_ELITE);
            return;
        }

        protected override function draw():void
        {
            if (isInvalid(INVALIDATE_TANK_ELITE)) 
                this.elite.visible = this._eliteVisible;
            if (isInvalid(INVALIDATE_CLAN_EMBLEM)) 
                this.clanEmblem.visible = this._clanEmblemVisible;
            return;
        }

        internal static function showTooltip(arg1:flash.events.MouseEvent):void
        {
            App.toolTipMgr.showComplex(TOOLTIPS.HEADER_ELITEICON);
            return;
        }

        internal static function hideTooltip(arg1:flash.events.MouseEvent):void
        {
            App.toolTipMgr.hide();
            return;
        }

        internal static const INVALIDATE_CLAN_EMBLEM:String="ClanEmblem";

        internal static const INVALIDATE_TANK_ELITE:String="TankElite";

        public var elite:flash.display.MovieClip;

        public var tank_name:flash.text.TextField;

        public var tank_type:flash.text.TextField;

        public var account_name:flash.text.TextField;

        public var clan_name:flash.text.TextField;

        public var clanEmblem:net.wg.gui.components.advanced.ClanEmblem;

        internal var _eliteVisible:Boolean=false;

        internal var _clanEmblemVisible:Boolean=false;
    }
}
