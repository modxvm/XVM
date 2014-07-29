package net.wg.gui.lobby.store.shop
{
    import net.wg.gui.lobby.store.shop.base.ShopTableItemRenderer;
    import net.wg.gui.components.advanced.ExtraModuleIcon;
    import flash.text.TextField;
    import net.wg.gui.lobby.store.ModuleRendererCredits;
    import net.wg.gui.components.controls.ActionPrice;
    import scaleform.clik.utils.Constraints;
    import net.wg.data.VO.StoreTableData;
    import net.wg.utils.ILocale;
    import net.wg.gui.components.controls.VO.ActionPriceVO;
    import net.wg.gui.lobby.store.shop.base.ACTION_CREDITS_STATES;
    import net.wg.utils.IAssertable;
    import flash.display.DisplayObject;
    import net.wg.data.constants.Errors;
    
    public class ShopModuleListItemRenderer extends ShopTableItemRenderer
    {
        
        public function ShopModuleListItemRenderer()
        {
            super();
            this.showHideAction();
        }
        
        public var moduleIcon:ExtraModuleIcon = null;
        
        public var orTextField:TextField = null;
        
        public var actionCredits:ModuleRendererCredits = null;
        
        public var actionPriceLeft:ActionPrice = null;
        
        public var vehCount:TextField = null;
        
        public var count:TextField = null;
        
        override protected function onDispose() : void
        {
            this.actionPriceLeft.dispose();
            super.onDispose();
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            constraints.addElement(this.moduleIcon.name,this.moduleIcon,Constraints.LEFT);
            constraints.addElement(this.count.name,this.count,Constraints.RIGHT);
            this.orTextField.text = MENU.SHOP_TABLE_BUYACTIONOR;
        }
        
        override protected function draw() : void
        {
            super.draw();
            this.actionPriceLeft.setup(this);
        }
        
        override protected function update() : void
        {
            var _loc1_:StoreTableData = null;
            super.update();
            if(data)
            {
                _loc1_ = StoreTableData(data);
                this.showHideAction(_loc1_);
                this.updateModuleIcon(_loc1_);
                getHelper().updateCountFields(this.count,this.vehCount,_loc1_);
            }
            else
            {
                getHelper().initModuleIconAsDefault(this.moduleIcon);
            }
        }
        
        override protected function updateCreditPriceForAction(param1:Number, param2:Number, param3:StoreTableData) : void
        {
            var _loc4_:ILocale = null;
            var _loc5_:ActionPriceVO = null;
            if(App.instance)
            {
                super.updateCreditPriceForAction(param1,param2,param3);
                _loc4_ = App.utils.locale;
                if(param2 > param3.tableVO.gold)
                {
                    this.actionCredits.gotoAndStop(ACTION_CREDITS_STATES.GOLD_ERROR);
                    this.actionPriceLeft.textColorType = ActionPrice.TEXT_COLOR_TYPE_ERROR;
                }
                else
                {
                    this.actionCredits.gotoAndStop(ACTION_CREDITS_STATES.GOLD);
                    this.actionPriceLeft.textColorType = ActionPrice.TEXT_COLOR_TYPE_ICON;
                }
                this.actionCredits.price.text = _loc4_.gold(param2);
                if(this.actionPriceLeft)
                {
                    _loc5_ = param3.alternativePriceDataVo;
                    if(_loc5_)
                    {
                        _loc5_.forCredits = false;
                    }
                    this.actionPriceLeft.setData(_loc5_);
                    this.actionPriceLeft.visible = (isUseGoldAndCredits) && (this.actionPriceLeft.visible);
                    this.actionCredits.visible = (isUseGoldAndCredits) && !this.actionPriceLeft.visible;
                }
            }
        }
        
        private function showHideAction(param1:StoreTableData = null) : void
        {
            var _loc2_:ActionPriceVO = null;
            this.orTextField.visible = isUseGoldAndCredits;
            if(param1)
            {
                _loc2_ = param1.alternativePriceDataVo;
                if(_loc2_)
                {
                    _loc2_.forCredits = false;
                }
                this.actionPriceLeft.setData(_loc2_);
            }
            this.actionPriceLeft.visible = (isUseGoldAndCredits) && (this.actionPriceLeft.visible);
            this.actionCredits.visible = (isUseGoldAndCredits) && !this.actionPriceLeft.visible;
        }
        
        private function updateModuleIcon(param1:StoreTableData) : void
        {
            var _loc2_:IAssertable = null;
            var _loc3_:Array = null;
            var _loc4_:DisplayObject = null;
            if(App.instance)
            {
                _loc2_ = App.utils.asserter;
                _loc3_ = [this.moduleIcon,this.moduleIcon.moduleType,this.moduleIcon.moduleType,this.moduleIcon.moduleLevel,this.moduleIcon.artefact,this.moduleIcon.shell];
                for each(_loc4_ in _loc3_)
                {
                    _loc2_.assertNotNull(_loc4_,_loc4_.name + Errors.CANT_NULL);
                }
            }
            this.moduleIcon.setValuesWithType(param1.requestType,param1.type,param1.level);
            this.moduleIcon.extraIconSource = param1.extraModuleInfo;
        }
    }
}
