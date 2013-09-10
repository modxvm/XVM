package net.wg.gui.lobby.sellDialog 
{
    import flash.display.*;
    import flash.text.*;
    import net.wg.gui.components.advanced.*;
    import net.wg.gui.components.controls.*;
    import net.wg.utils.*;
    import scaleform.clik.core.*;
    import scaleform.clik.data.*;
    
    public class SellHeaderComponent extends scaleform.clik.core.UIComponent
    {
        public function SellHeaderComponent()
        {
            super();
            this.locale = App.utils.locale;
            return;
        }

        public override function dispose():void
        {
            super.dispose();
            this.emptySellIT.dispose();
            this.inBarracsDrop.dispose();
            this.tankIcon.dispose();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.tankPriceTF.text = DIALOGS.VEHICLESELLDIALOG_VEHICLE_EMPTYSELLPRICE;
            this.emptySellIT.textFieldYOffset = net.wg.gui.lobby.sellDialog.VehicleSellDialog.ICONS_TEXT_OFFSET;
            return;
        }

        public function get tankGoldPrice():Number
        {
            return this._tankGoldPrice;
        }

        public function set tankGoldPrice(arg1:Number):void
        {
            this._tankGoldPrice = arg1;
            return;
        }

        public function set tankPrice(arg1:Number):void
        {
            this._tankPrice = arg1;
            return;
        }

        public function get tankPrice():Number
        {
            return this._tankPrice;
        }

        public function set creditsCommon(arg1:Number):void
        {
            this._creditsCommon = arg1;
            return;
        }

        public function get creditsCommon():Number
        {
            return this._creditsCommon;
        }

        public function setData(arg1:Object):void
        {
            var loc1:*=null;
            this.tankNameTF.text = arg1.userName;
            if (arg1.isElite) 
                loc1 = this.locale.makeString(TOOLTIPS.tankcaruseltooltip_vehicletype_elite(arg1.type), {});
            else 
                loc1 = this.locale.makeString(DIALOGS.vehicleselldialog_vehicletype(arg1.type), {});
            this.tankDescribeTF.text = loc1;
            var loc2:*=new flash.text.TextFormat();
            loc2 = this.tankLevelTF.getTextFormat();
            loc2.color = 16643278;
            var loc3:*=showLevel(arg1.level);
            this.tankLevelTF.text = loc3 + " " + this.locale.makeString(DIALOGS.VEHICLESELLDIALOG_VEHICLE_LEVEL);
            this.tankLevelTF.setTextFormat(loc2, 0, loc3.length);
            this.tankIcon.image = arg1.icon;
            this.tankIcon.level = arg1.level;
            this.tankIcon.isElite = arg1.isElite;
            this.tankIcon.isPremium = arg1.isPremium;
            this.tankIcon.tankType = arg1.type;
            this.tankIcon.nation = arg1.nationID;
            var loc4:*=this.locale.makeString(DIALOGS.GATHERINGXPFORM_HEADERBUTTONS_CREW);
            this.inBarracsDrop.dataProvider = new scaleform.clik.data.DataProvider([{"label":MENU.BARRACKS_BTNUNLOAD}, {"label":MENU.BARRACKS_BTNDISSMISS}]);
            var loc5:*=0;
            var loc6:*=0;
            while (loc6 < arg1.crew.length) 
            {
                if (arg1.crew[loc6] != (null || undefined)) 
                    ++loc5;
                ++loc6;
            }
            if (loc5 != 0) 
            {
                this.inBarracsDrop.selectedIndex = 0;
                this.inBarracsDrop.enabled = true;
            }
            else 
            {
                this.inBarracsDrop.selectedIndex = 1;
                this.inBarracsDrop.enabled = false;
            }
            this.inBarracsDrop.validateNow();
            this.crewTF.text = loc4.toUpperCase() + ": ";
            if (arg1.sellPrice[1] > 0) 
            {
                this._tankGoldPrice = arg1.sellPrice[1];
                this._tankPrice = 0;
                this.showPrice(true, this._tankGoldPrice);
            }
            else 
            {
                this._tankPrice = arg1.sellPrice[0];
                this._tankGoldPrice = 0;
                this.showPrice(false, this._tankPrice);
                this._creditsCommon = this._creditsCommon + this.tankPrice;
            }
            return;
        }

        internal function showPrice(arg1:Boolean, arg2:Number=0):void
        {
            this.emptySellIT.text = "+ " + this.locale.gold(arg2);
            this.emptySellIT.icon = arg1 ? "gold" : "credits";
            this.emptySellIT.textColor = arg1 ? 16763253 : 13556185;
            this.emptySellIT.validateNow();
            return;
        }

        public function getNextPosition():int
        {
            return this.crewBG.y + this.crewBG.height + PADDING_FOR_NEXT_ELEMENT;
        }

        internal static function showLevel(arg1:Number):String
        {
            return VEHICLE_LEVELS[(arg1 - 1)].toString();
        }

        internal static const VEHICLE_LEVELS:Array=["I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X"];

        internal static const PADDING_FOR_NEXT_ELEMENT:int=8;

        public var emptySellIT:net.wg.gui.components.controls.IconText;

        public var tankLevelTF:flash.text.TextField;

        public var tankNameTF:flash.text.TextField;

        public var tankPriceTF:flash.text.TextField;

        public var tankDescribeTF:flash.text.TextField;

        public var tankIcon:net.wg.gui.components.advanced.TankIcon;

        public var crewTF:flash.text.TextField;

        public var inBarracsDrop:net.wg.gui.components.controls.DropdownMenu;

        public var crewBG:flash.display.MovieClip;

        internal var _tankPrice:Number=0;

        internal var _tankGoldPrice:Number=0;

        internal var _creditsCommon:Number=0;

        internal var locale:net.wg.utils.ILocale;
    }
}
