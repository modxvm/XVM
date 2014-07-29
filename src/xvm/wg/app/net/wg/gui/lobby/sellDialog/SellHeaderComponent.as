package net.wg.gui.lobby.sellDialog
{
    import scaleform.clik.core.UIComponent;
    import net.wg.gui.components.controls.IconText;
    import net.wg.gui.components.controls.ActionPrice;
    import flash.text.TextField;
    import net.wg.gui.components.advanced.TankIcon;
    import net.wg.gui.components.controls.DropdownMenu;
    import flash.display.MovieClip;
    import net.wg.utils.ILocale;
    import net.wg.gui.lobby.sellDialog.VO.SellVehicleVo;
    import flash.text.TextFormat;
    import scaleform.clik.data.DataProvider;
    import net.wg.data.constants.IconsTypes;
    import net.wg.gui.components.controls.VO.ActionPriceVO;
    
    public class SellHeaderComponent extends UIComponent
    {
        
        public function SellHeaderComponent()
        {
            super();
            this.locale = App.utils.locale;
        }
        
        private static var VEHICLE_LEVELS:Array = ["I","II","III","IV","V","VI","VII","VIII","IX","X"];
        
        private static var PADDING_FOR_NEXT_ELEMENT:int = 8;
        
        private static function showLevel(param1:Number) : String
        {
            return VEHICLE_LEVELS[param1 - 1].toString();
        }
        
        public var emptySellIT:IconText;
        
        public var vehicleActionPrice:ActionPrice;
        
        public var tankLevelTF:TextField;
        
        public var tankNameTF:TextField;
        
        public var tankPriceTF:TextField;
        
        public var tankDescribeTF:TextField;
        
        public var tankIcon:TankIcon;
        
        public var crewTF:TextField;
        
        public var inBarracsDrop:DropdownMenu;
        
        public var crewBG:MovieClip;
        
        private var _tankPrice:Number = 0;
        
        private var _tankGoldPrice:Number = 0;
        
        private var _creditsCommon:Number = 0;
        
        private var locale:ILocale;
        
        override protected function onDispose() : void
        {
            super.onDispose();
            this.vehicleActionPrice.dispose();
            this.emptySellIT.dispose();
            this.inBarracsDrop.dispose();
            this.tankIcon.dispose();
        }
        
        public function setData(param1:SellVehicleVo) : void
        {
            var _loc2_:String = null;
            this.tankNameTF.text = param1.userName;
            if(param1.isElite)
            {
                _loc2_ = this.locale.makeString(TOOLTIPS.tankcaruseltooltip_vehicletype_elite(param1.type),{});
            }
            else
            {
                _loc2_ = this.locale.makeString(DIALOGS.vehicleselldialog_vehicletype(param1.type),{});
            }
            this.tankDescribeTF.text = _loc2_;
            var _loc3_:TextFormat = new TextFormat();
            _loc3_ = this.tankLevelTF.getTextFormat();
            _loc3_.color = 16643278;
            var _loc4_:String = showLevel(param1.level);
            this.tankLevelTF.text = _loc4_ + " " + this.locale.makeString(DIALOGS.VEHICLESELLDIALOG_VEHICLE_LEVEL);
            this.tankLevelTF.setTextFormat(_loc3_,0,_loc4_.length);
            this.tankIcon.image = param1.icon;
            this.tankIcon.level = param1.level;
            this.tankIcon.isElite = param1.isElite;
            this.tankIcon.isPremium = param1.isPremium;
            this.tankIcon.tankType = param1.type;
            this.tankIcon.nation = param1.nationID;
            var _loc5_:String = this.locale.makeString(DIALOGS.GATHERINGXPFORM_HEADERBUTTONS_CREW);
            this.inBarracsDrop.dataProvider = new DataProvider([{"label":MENU.BARRACKS_BTNUNLOAD},{"label":MENU.BARRACKS_BTNDISSMISS}]);
            if(param1.hasCrew)
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
            this.crewTF.text = App.utils.toUpperOrLowerCase(_loc5_,true) + ": ";
            if(param1.sellPrice[1] > 0)
            {
                this._tankGoldPrice = param1.sellPrice[1];
                this._tankPrice = 0;
                if(param1.actionVo)
                {
                    param1.actionVo.ico = IconsTypes.GOLD;
                }
                this.showPrice(true,this._tankGoldPrice,param1.actionVo);
            }
            else
            {
                this._tankPrice = param1.sellPrice[0];
                this._tankGoldPrice = 0;
                if(param1.actionVo)
                {
                    param1.actionVo.ico = IconsTypes.CREDITS;
                }
                this.showPrice(false,this._tankPrice,param1.actionVo);
                this._creditsCommon = this._creditsCommon + this.tankPrice;
            }
        }
        
        public function getNextPosition() : int
        {
            return this.crewBG.y + this.crewBG.height + PADDING_FOR_NEXT_ELEMENT;
        }
        
        public function get tankGoldPrice() : Number
        {
            return this._tankGoldPrice;
        }
        
        public function set tankGoldPrice(param1:Number) : void
        {
            this._tankGoldPrice = param1;
        }
        
        public function get tankPrice() : Number
        {
            return this._tankPrice;
        }
        
        public function set tankPrice(param1:Number) : void
        {
            this._tankPrice = param1;
        }
        
        public function get creditsCommon() : Number
        {
            return this._creditsCommon;
        }
        
        public function set creditsCommon(param1:Number) : void
        {
            this._creditsCommon = param1;
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            this.tankPriceTF.text = DIALOGS.VEHICLESELLDIALOG_VEHICLE_EMPTYSELLPRICE;
            this.emptySellIT.textFieldYOffset = VehicleSellDialog.ICONS_TEXT_OFFSET;
            this.vehicleActionPrice.textYOffset = VehicleSellDialog.ICONS_TEXT_OFFSET;
        }
        
        private function showPrice(param1:Boolean, param2:Number, param3:ActionPriceVO) : void
        {
            if(param1)
            {
                this.emptySellIT.text = "+ " + this.locale.gold(param2);
            }
            else
            {
                this.emptySellIT.text = "+ " + this.locale.integer(param2);
            }
            this.emptySellIT.icon = param1?IconsTypes.GOLD:IconsTypes.CREDITS;
            this.emptySellIT.textColor = param1?16763253:13556185;
            this.emptySellIT.validateNow();
            this.vehicleActionPrice.setData(param3);
            this.emptySellIT.visible = !this.vehicleActionPrice.visible;
        }
    }
}
