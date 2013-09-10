package net.wg.gui.lobby.store.shop 
{
    import flash.display.*;
    import flash.text.*;
    import net.wg.data.VO.*;
    import net.wg.data.constants.*;
    import net.wg.gui.components.advanced.*;
    import net.wg.gui.lobby.store.*;
    import net.wg.gui.lobby.store.shop.base.*;
    import net.wg.utils.*;
    import scaleform.clik.utils.*;
    
    public class ShopModuleListItemRenderer extends net.wg.gui.lobby.store.shop.base.ShopTableItemRenderer
    {
        public function ShopModuleListItemRenderer()
        {
            super();
            this.showHideAction();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            constraints.addElement(this.moduleIcon.name, this.moduleIcon, scaleform.clik.utils.Constraints.LEFT);
            constraints.addElement(this.count.name, this.count, scaleform.clik.utils.Constraints.RIGHT);
            this.orTextField.text = MENU.SHOP_TABLE_BUYACTIONOR;
            return;
        }

        protected override function update():void
        {
            var loc1:*=null;
            super.update();
            if (data) 
            {
                loc1 = net.wg.data.VO.StoreTableData(data);
                this.showHideAction();
                this.updateModuleIcon(loc1);
                getHelper().updateCountFields(this.count, this.vehCount, loc1);
            }
            else 
                getHelper().initModuleIconAsDefault(this.moduleIcon);
            return;
        }

        protected override function updateCreditPriceForAction(arg1:Number, arg2:Number, arg3:net.wg.data.VO.StoreTableData):void
        {
            var loc1:*=null;
            if (App.instance) 
            {
                super.updateCreditPriceForAction(arg1, arg2, arg3);
                loc1 = App.utils.locale;
                if (arg2 > arg3.tableVO.gold) 
                    this.actionCredits.gotoAndStop(net.wg.gui.lobby.store.shop.base.ACTION_CREDITS_STATES.GOLD_ERROR);
                else 
                    this.actionCredits.gotoAndStop(net.wg.gui.lobby.store.shop.base.ACTION_CREDITS_STATES.GOLD);
                this.actionCredits.price.text = loc1.gold(arg2);
            }
            return;
        }

        internal function showHideAction():void
        {
            this.orTextField.visible = isUseAction;
            this.actionCredits.visible = isUseAction;
            return;
        }

        internal function updateModuleIcon(arg1:net.wg.data.VO.StoreTableData):void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            if (App.instance) 
            {
                loc1 = App.utils.asserter;
                loc2 = [this.moduleIcon, this.moduleIcon.moduleType, this.moduleIcon.moduleType, this.moduleIcon.moduleLevel, this.moduleIcon.artefact, this.moduleIcon.shell];
                var loc4:*=0;
                var loc5:*=loc2;
                for each (loc3 in loc5) 
                    loc1.assertNotNull(loc3, loc3.name + net.wg.data.constants.Errors.CANT_NULL);
            }
            this.moduleIcon.setValuesWithType(arg1.requestType, arg1.type, arg1.level);
            this.moduleIcon.extraIconSource = arg1.extraModuleInfo;
            return;
        }

        public var moduleIcon:net.wg.gui.components.advanced.ExtraModuleIcon=null;

        public var orTextField:flash.text.TextField=null;

        public var actionCredits:net.wg.gui.lobby.store.ModuleRendererCredits=null;

        public var vehCount:flash.text.TextField=null;

        public var count:flash.text.TextField=null;
    }
}
