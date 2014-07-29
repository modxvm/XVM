package net.wg.gui.lobby.hangar.maintenance
{
    import net.wg.gui.components.controls.SoundListItemRenderer;
    import net.wg.gui.components.controls.UILoaderAlt;
    import flash.text.TextField;
    import net.wg.gui.components.controls.IconText;
    import net.wg.gui.components.controls.ActionPrice;
    import flash.display.MovieClip;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.utils.IEventCollector;
    import flash.events.MouseEvent;
    import net.wg.data.constants.SoundTypes;
    import net.wg.utils.ILocale;
    import net.wg.gui.components.controls.VO.ActionPriceVO;
    import net.wg.data.constants.Currencies;
    import net.wg.data.constants.Tooltips;
    import scaleform.gfx.MouseEventEx;
    import net.wg.gui.events.ModuleInfoEvent;
    import net.wg.gui.lobby.hangar.maintenance.data.ShellVO;
    
    public class ShellListItemRenderer extends SoundListItemRenderer
    {
        
        public function ShellListItemRenderer()
        {
            super();
        }
        
        public var icon:UILoaderAlt;
        
        public var title:TextField;
        
        public var desc:TextField;
        
        public var price:IconText;
        
        public var actionPrice:ActionPrice;
        
        public var hitMc:MovieClip;
        
        override public function setData(param1:Object) : void
        {
            super.setData(param1);
            invalidate(InvalidationType.DATA);
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            this.desc.text = MENU.SHELLLISTITEMRENDERER_REPLACE;
            var _loc1_:IEventCollector = App.utils.events;
            _loc1_.addEvent(this,MouseEvent.ROLL_OVER,this.onRollOver);
            _loc1_.addEvent(this,MouseEvent.ROLL_OUT,this.onRollOut);
            _loc1_.addEvent(this,MouseEvent.CLICK,this.onClick);
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
            var _loc3_:* = NaN;
            var _loc4_:ActionPriceVO = null;
            super.draw();
            if(isInvalid(InvalidationType.DATA))
            {
                if(data)
                {
                    visible = true;
                    this.icon.visible = true;
                    this.icon.source = data.icon;
                    this.title.text = data.ammoName;
                    this.price.icon = data.currency;
                    _loc1_ = App.utils.locale;
                    this.price.textColor = data.prices[0] < data.userCredits[data.currency]?Currencies.TEXT_COLORS[data.currency]:Currencies.TEXT_COLORS[Currencies.ERROR];
                    this.actionPrice.textColorType = data.prices[0] < data.userCredits[data.currency]?ActionPrice.TEXT_COLOR_TYPE_ICON:ActionPrice.TEXT_COLOR_TYPE_ERROR;
                    this.price.text = data.currency == Currencies.CREDITS?_loc1_.integer(data.prices[0]):_loc1_.gold(data.prices[1]);
                    this.price.validateNow();
                    _loc2_ = data.hasOwnProperty("actionPriceData")?data.actionPriceData:null;
                    _loc3_ = data.currency == Currencies.CREDITS?data.prices[0]:data.prices[1];
                    _loc4_ = null;
                    if(_loc2_)
                    {
                        _loc4_ = new ActionPriceVO(_loc2_);
                        _loc4_.forCredits = data.currency == Currencies.CREDITS;
                    }
                    this.actionPrice.setData(_loc4_);
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
        
        private function onRollOver(param1:MouseEvent) : void
        {
            App.toolTipMgr.showSpecial(Tooltips.TECH_MAIN_SHELL,null,data.id,data.prices,data.inventoryCount,data.count);
        }
        
        private function onRollOut(param1:MouseEvent) : void
        {
            App.toolTipMgr.hide();
        }
        
        private function onClick(param1:MouseEvent) : void
        {
            App.toolTipMgr.hide();
            if(param1 is MouseEventEx)
            {
                if(App.utils.commons.isRightButton(param1))
                {
                    dispatchEvent(new ModuleInfoEvent(ModuleInfoEvent.SHOW_INFO,ShellVO(data).id));
                }
            }
        }
    }
}
