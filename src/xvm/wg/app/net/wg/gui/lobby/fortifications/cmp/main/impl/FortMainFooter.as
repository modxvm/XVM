package net.wg.gui.lobby.fortifications.cmp.main.impl
{
    import net.wg.infrastructure.base.UIComponentEx;
    import net.wg.gui.lobby.fortifications.cmp.main.IMainFooter;
    import net.wg.gui.components.controls.BitmapFill;
    import net.wg.gui.components.controls.SoundButtonEx;
    import net.wg.gui.lobby.fortifications.cmp.orders.IOrdersPanel;
    import net.wg.gui.lobby.fortifications.utils.impl.FortsControlsAligner;
    import flash.display.DisplayObject;
    import flash.display.InteractiveObject;
    
    public class FortMainFooter extends UIComponentEx implements IMainFooter
    {
        
        public function FortMainFooter()
        {
            super();
        }
        
        private static var LEAVE_TRANSPORT_BTN_OFFSET_Y:uint = 16;
        
        private var _footerBitmapFill:BitmapFill = null;
        
        private var _intelligenceButton:SoundButtonEx = null;
        
        private var _sortieBtn:SoundButtonEx = null;
        
        private var _ordersPanel:IOrdersPanel = null;
        
        private var _leaveModeBtn:SoundButtonEx = null;
        
        public function updateControls() : void
        {
            FortsControlsAligner.instance.rightControl(DisplayObject(this._intelligenceButton),0);
            this._leaveModeBtn.y = actualHeight - this._leaveModeBtn.actualHeight >> 1 - LEAVE_TRANSPORT_BTN_OFFSET_Y;
            FortsControlsAligner.instance.centerControl(this._leaveModeBtn,false);
            FortsControlsAligner.instance.centerControl(this.ordersPanel,false);
            this.ordersPanel.y = this._footerBitmapFill.y;
        }
        
        public function getComponentForFocus() : InteractiveObject
        {
            return this._leaveModeBtn;
        }
        
        public function set widthFill(param1:Number) : void
        {
            this._footerBitmapFill.widthFill = param1;
        }
        
        public function get heightFill() : Number
        {
            return this._footerBitmapFill.heightFill;
        }
        
        public function get leaveModeBtn() : SoundButtonEx
        {
            return this._leaveModeBtn;
        }
        
        public function set leaveModeBtn(param1:SoundButtonEx) : void
        {
            this._leaveModeBtn = param1;
        }
        
        public function get ordersPanel() : IOrdersPanel
        {
            return this._ordersPanel;
        }
        
        public function set ordersPanel(param1:IOrdersPanel) : void
        {
            this._ordersPanel = param1;
        }
        
        public function get intelligenceButton() : SoundButtonEx
        {
            return this._intelligenceButton;
        }
        
        public function set intelligenceButton(param1:SoundButtonEx) : void
        {
            this._intelligenceButton = param1;
        }
        
        public function get sortieBtn() : SoundButtonEx
        {
            return this._sortieBtn;
        }
        
        public function set sortieBtn(param1:SoundButtonEx) : void
        {
            this._sortieBtn = param1;
        }
        
        public function get footerBitmapFill() : BitmapFill
        {
            return this._footerBitmapFill;
        }
        
        public function set footerBitmapFill(param1:BitmapFill) : void
        {
            this._footerBitmapFill = param1;
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            this._sortieBtn.label = FORTIFICATIONS.FORTMAINVIEW_SORTIEBUTTON_TITLE;
            this._sortieBtn.tooltip = TOOLTIPS.FORTIFICATION_FOOTER_SORTIEBUTTON;
            this._intelligenceButton.label = FORTIFICATIONS.FORTMAINVIEW_INTELLIGENCEBUTTON_TITLE;
            this._intelligenceButton.tooltip = TOOLTIPS.FORTIFICATION_FOOTER_INTELLIGENCEBUTTON;
            this._leaveModeBtn.label = FORTIFICATIONS.FORTMAINVIEW_LEAVE_BUTTON_LABEL;
            this._sortieBtn.focusIndicator.mouseEnabled = false;
            this._leaveModeBtn.UIID = 27;
            this._sortieBtn.UIID = 28;
        }
        
        override protected function onDispose() : void
        {
            this.ordersPanel = null;
            this._leaveModeBtn.dispose();
            this._leaveModeBtn = null;
            this._footerBitmapFill.dispose();
            this._footerBitmapFill = null;
            this._intelligenceButton.dispose();
            this._intelligenceButton = null;
            this._sortieBtn.dispose();
            this._sortieBtn = null;
            super.onDispose();
        }
    }
}
