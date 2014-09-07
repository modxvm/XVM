package net.wg.gui.lobby.messengerBar.carousel
{
    import net.wg.gui.components.controls.UILoaderAlt;
    import net.wg.gui.components.advanced.IndicationOfStatus;
    import scaleform.clik.utils.Padding;
    import flash.geom.ColorTransform;
    import net.wg.gui.lobby.messengerBar.carousel.data.MessengerBarConstants;
    
    public class PreBattleChannelRenderer extends BaseChannelRenderer
    {
        
        public function PreBattleChannelRenderer()
        {
            super();
            this.currentPadding = DEFAULT_TF_PADDING;
        }
        
        public var icon:UILoaderAlt;
        
        public var readyIndicator:IndicationOfStatus;
        
        private var currentPadding:Padding;
        
        override protected function configUI() : void
        {
            super.configUI();
            this.icon.mouseChildren = false;
            this.icon.mouseEnabled = false;
            this.readyIndicator.mouseChildren = false;
            this.readyIndicator.mouseEnabled = false;
            this.readyIndicator.visible = false;
            openButton.textFieldPadding = this.currentPadding;
        }
        
        override protected function applyData() : void
        {
            super.applyData();
            if(_data.icon)
            {
                this.icon.source = _data.icon;
                this.currentPadding.left = 27;
            }
            else
            {
                this.icon.unload();
                this.currentPadding.left = DEFAULT_TF_PADDING.left;
            }
            var _loc1_:* = !(_data.readyDataVO == null);
            if(_loc1_)
            {
                this.readyIndicator.visible = true;
                this.readyIndicator.status = _data.readyDataVO.isReady?IndicationOfStatus.STATUS_READY:IndicationOfStatus.STATUS_NORMAL;
                openButton.showColorBg(false);
                openButton.setTextFieldColorTransform(new ColorTransform());
            }
            else
            {
                this.readyIndicator.visible = false;
                openButton.showColorBg(true);
                openButton.setTextFieldColorTransform(App.colorSchemeMgr.getTransform(MessengerBarConstants.MESSENGER_BAR_PRE_BATTLE_BTN_TEXT_COLOR));
            }
            if((_data.isInProgress) || (_loc1_))
            {
                this.currentPadding.right = 23;
            }
            else
            {
                this.currentPadding.right = DEFAULT_TF_PADDING.right;
            }
            openButton.textFieldPadding = this.currentPadding;
        }
        
        public function set data(param1:Object) : void
        {
            setData(param1);
        }
    }
}
