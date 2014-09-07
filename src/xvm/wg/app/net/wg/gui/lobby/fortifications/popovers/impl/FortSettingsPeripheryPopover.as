package net.wg.gui.lobby.fortifications.popovers.impl
{
    import net.wg.infrastructure.base.meta.impl.FortSettingsPeripheryPopoverMeta;
    import net.wg.infrastructure.base.meta.IFortSettingsPeripheryPopoverMeta;
    import scaleform.clik.events.ButtonEvent;
    import flash.events.MouseEvent;
    import flash.text.TextField;
    import net.wg.gui.components.controls.DropdownMenu;
    import net.wg.gui.components.controls.SoundButtonEx;
    import flash.display.MovieClip;
    import net.wg.infrastructure.interfaces.IWrapper;
    import net.wg.gui.components.popOvers.PopOver;
    import scaleform.clik.events.ListEvent;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.gui.components.popOvers.PopOverConst;
    import flash.display.InteractiveObject;
    import net.wg.gui.lobby.fortifications.data.settings.PeripheryPopoverVO;
    import scaleform.clik.data.DataProvider;
    import scaleform.clik.interfaces.IDataProvider;
    import net.wg.data.constants.Values;
    
    public class FortSettingsPeripheryPopover extends FortSettingsPeripheryPopoverMeta implements IFortSettingsPeripheryPopoverMeta
    {
        
        public function FortSettingsPeripheryPopover()
        {
            super();
        }
        
        private static var DEFAULT_CONTENT_WIDTH:int = 300;
        
        private static var DEFAULT_PADDING:int = 10;
        
        private static function onCancelBtnClick(param1:ButtonEvent) : void
        {
            App.popoverMgr.hide();
        }
        
        private static function onApplyBtnRollOut(param1:MouseEvent) : void
        {
            App.toolTipMgr.hide();
        }
        
        public var descriptionTF:TextField = null;
        
        public var serverTF:TextField = null;
        
        public var dropdownMenu:DropdownMenu = null;
        
        public var applyBtn:SoundButtonEx = null;
        
        public var cancelBtn:SoundButtonEx = null;
        
        public var separatorTop:MovieClip = null;
        
        public var separatorBottom:MovieClip = null;
        
        private var currentServer:int = -1;
        
        override public function set wrapper(param1:IWrapper) : void
        {
            super.wrapper = param1;
            PopOver(param1).isCloseBtnVisible = true;
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            this.applyBtn.mouseEnabledOnDisabled = true;
            this.dropdownMenu.addEventListener(ListEvent.INDEX_CHANGE,this.dropdownMenuSelectHandler);
            this.applyBtn.addEventListener(ButtonEvent.CLICK,this.onApplyBtnClick);
            this.applyBtn.addEventListener(MouseEvent.MOUSE_OVER,this.onApplyBtnRollOver);
            this.applyBtn.addEventListener(MouseEvent.MOUSE_OUT,onApplyBtnRollOut);
            this.cancelBtn.addEventListener(ButtonEvent.CLICK,onCancelBtnClick);
        }
        
        override protected function onPopulate() : void
        {
            super.onPopulate();
        }
        
        override protected function onDispose() : void
        {
            this.dropdownMenu.removeEventListener(ListEvent.INDEX_CHANGE,this.dropdownMenuSelectHandler);
            this.applyBtn.removeEventListener(ButtonEvent.CLICK,this.onApplyBtnClick);
            this.applyBtn.removeEventListener(MouseEvent.MOUSE_OVER,this.onApplyBtnRollOver);
            this.applyBtn.removeEventListener(MouseEvent.MOUSE_OUT,onApplyBtnRollOut);
            this.cancelBtn.removeEventListener(ButtonEvent.CLICK,onCancelBtnClick);
            this.descriptionTF = null;
            this.serverTF = null;
            this.dropdownMenu.dispose();
            this.dropdownMenu = null;
            this.applyBtn.dispose();
            this.applyBtn = null;
            this.cancelBtn.dispose();
            this.cancelBtn = null;
            this.separatorTop = null;
            this.separatorBottom = null;
            super.onDispose();
        }
        
        override protected function draw() : void
        {
            if(isInvalid(InvalidationType.SIZE))
            {
                setSize(DEFAULT_CONTENT_WIDTH > this.width?DEFAULT_CONTENT_WIDTH:this.width,this.applyBtn.y + this.applyBtn.height + DEFAULT_PADDING);
                this.separatorTop.width = this.width;
                this.separatorBottom.width = this.width;
            }
            super.draw();
        }
        
        override protected function initLayout() : void
        {
            popoverLayout.preferredLayout = PopOverConst.ARROW_TOP;
            super.initLayout();
        }
        
        override protected function onInitModalFocus(param1:InteractiveObject) : void
        {
            super.onInitModalFocus(param1);
            setFocus(this.dropdownMenu);
        }
        
        override protected function setData(param1:PeripheryPopoverVO) : void
        {
            this.dropdownMenu.dataProvider = new DataProvider(param1.servers);
            var _loc2_:* = 0;
            while(_loc2_ < param1.servers.length)
            {
                if(param1.servers[_loc2_].id == param1.currentServer)
                {
                    break;
                }
                _loc2_++;
            }
            var _loc3_:* = "No such elemnt with id = " + _loc2_ + " in dropDown.dataProvider";
            assert(_loc2_ < param1.servers.length,_loc3_);
            this.dropdownMenu.selectedIndex = this.currentServer = _loc2_;
            this.applyBtn.enabled = false;
        }
        
        override protected function setTexts(param1:PeripheryPopoverVO) : void
        {
            this.descriptionTF.htmlText = param1.descriptionText;
            this.serverTF.htmlText = param1.serverText;
            this.applyBtn.label = param1.applyBtnLabel;
            this.cancelBtn.label = param1.cancelBtnLabel;
        }
        
        private function dropdownMenuSelectHandler(param1:ListEvent) : void
        {
            this.applyBtn.enabled = !(this.dropdownMenu.selectedIndex == this.currentServer);
        }
        
        private function onApplyBtnClick(param1:ButtonEvent) : void
        {
            var _loc2_:IDataProvider = this.dropdownMenu.dataProvider;
            var _loc3_:int = _loc2_[this.dropdownMenu.selectedIndex].id;
            onApplyS(_loc3_);
            App.popoverMgr.hide();
        }
        
        private function onApplyBtnRollOver(param1:MouseEvent) : void
        {
            var _loc2_:String = Values.EMPTY_STR;
            if(!this.applyBtn.enabled)
            {
                _loc2_ = TOOLTIPS.FORTIFICATION_FORTSETTINGSPERIPHERYPOPOVER_APPLYBTN_DISABLED;
            }
            else
            {
                _loc2_ = TOOLTIPS.FORTIFICATION_FORTSETTINGSPERIPHERYPOPOVER_APPLYBTN_ENABLED;
            }
            App.toolTipMgr.show(_loc2_);
        }
    }
}
