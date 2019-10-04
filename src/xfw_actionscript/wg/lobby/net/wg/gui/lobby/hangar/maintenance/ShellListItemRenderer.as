package net.wg.gui.lobby.hangar.maintenance
{
    import net.wg.gui.components.controls.SoundListItemRenderer;
    import net.wg.gui.components.controls.UILoaderAlt;
    import flash.text.TextField;
    import net.wg.gui.components.controls.IconText;
    import net.wg.gui.components.controls.ActionPrice;
    import flash.display.MovieClip;
    import net.wg.gui.lobby.components.maintenance.data.MaintenanceShellVO;
    import net.wg.data.constants.Errors;
    import scaleform.clik.constants.InvalidationType;
    import flash.events.MouseEvent;
    import net.wg.data.constants.SoundTypes;
    import net.wg.utils.ILocale;
    import net.wg.gui.components.controls.VO.ActionPriceVO;
    import net.wg.data.constants.Currencies;
    import net.wg.data.constants.generated.CURRENCIES_CONSTANTS;
    import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
    import scaleform.gfx.MouseEventEx;
    import net.wg.gui.events.ModuleInfoEvent;

    public class ShellListItemRenderer extends SoundListItemRenderer
    {

        private static const MAINTENANCE_SHELL_VO_TYPE:String = "MaintenanceShellVO";

        public var icon:UILoaderAlt;

        public var title:TextField;

        public var desc:TextField;

        public var price:IconText;

        public var actionPrice:ActionPrice;

        public var hitMc:MovieClip;

        private var _rendererData:MaintenanceShellVO;

        public function ShellListItemRenderer()
        {
            super();
        }

        override public function setData(param1:Object) : void
        {
            super.setData(param1);
            this._rendererData = param1 as MaintenanceShellVO;
            App.utils.asserter.assertNotNull(this._rendererData,Errors.INVALID_TYPE + MAINTENANCE_SHELL_VO_TYPE);
            invalidate(InvalidationType.DATA);
        }

        override protected function configUI() : void
        {
            super.configUI();
            addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
            addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
            addEventListener(MouseEvent.CLICK,this.onClickHandler);
            soundType = SoundTypes.NORMAL_BTN;
            if(this.hitMc)
            {
                hitArea = this.hitMc;
            }
        }

        override protected function draw() : void
        {
            var _loc1_:ILocale = null;
            var _loc2_:Object = null;
            var _loc3_:ActionPriceVO = null;
            super.draw();
            if(isInvalid(InvalidationType.DATA))
            {
                if(this._rendererData != null)
                {
                    visible = true;
                    this.icon.visible = true;
                    this.icon.source = this._rendererData.icon;
                    this.title.text = this._rendererData.ammoName;
                    this.desc.text = this._rendererData.desc;
                    this.price.icon = this._rendererData.currency;
                    _loc1_ = App.utils.locale;
                    this.price.textColor = this._rendererData.prices[0] < this._rendererData.userCredits[this._rendererData.currency]?Currencies.TEXT_COLORS[this._rendererData.currency]:Currencies.TEXT_COLORS[CURRENCIES_CONSTANTS.ERROR];
                    this.actionPrice.textColorType = this._rendererData.prices[0] < this._rendererData.userCredits[this._rendererData.currency]?ActionPrice.TEXT_COLOR_TYPE_ICON:ActionPrice.TEXT_COLOR_TYPE_ERROR;
                    this.price.text = this._rendererData.currency == CURRENCIES_CONSTANTS.CREDITS?_loc1_.integer(this._rendererData.prices[0]):_loc1_.gold(this._rendererData.prices[1]);
                    this.price.validateNow();
                    _loc2_ = this._rendererData.actionPriceData;
                    _loc3_ = null;
                    if(_loc2_ != null)
                    {
                        _loc3_ = new ActionPriceVO(_loc2_);
                        _loc3_.forCredits = this._rendererData.currency == CURRENCIES_CONSTANTS.CREDITS;
                    }
                    this.actionPrice.setData(_loc3_);
                    this.actionPrice.setup(this);
                    this.price.visible = !this.actionPrice.visible;
                    this.actionPrice.validateNow();
                }
                else
                {
                    visible = false;
                }
            }
        }

        override protected function onDispose() : void
        {
            removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
            removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
            removeEventListener(MouseEvent.CLICK,this.onClickHandler);
            this.icon.dispose();
            this.icon = null;
            this.title = null;
            this.desc = null;
            this.price.dispose();
            this.price = null;
            this.actionPrice.dispose();
            this.actionPrice = null;
            this.hitMc = null;
            this._rendererData = null;
            super.onDispose();
        }

        private function onRollOverHandler(param1:MouseEvent) : void
        {
            App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.TECH_MAIN_SHELL,null,this._rendererData.id,this._rendererData.prices,this._rendererData.inventoryCount,this._rendererData.count);
        }

        private function onRollOutHandler(param1:MouseEvent) : void
        {
            App.toolTipMgr.hide();
        }

        private function onClickHandler(param1:MouseEvent) : void
        {
            App.toolTipMgr.hide();
            if(param1 is MouseEventEx)
            {
                if(App.utils.commons.isRightButton(param1))
                {
                    dispatchEvent(new ModuleInfoEvent(ModuleInfoEvent.SHOW_INFO,MaintenanceShellVO(this._rendererData).id));
                }
            }
        }
    }
}
