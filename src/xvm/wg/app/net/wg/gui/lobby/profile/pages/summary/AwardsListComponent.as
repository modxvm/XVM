package net.wg.gui.lobby.profile.pages.summary
{
    import scaleform.clik.core.UIComponent;
    import flash.text.TextField;
    import net.wg.gui.lobby.battleResults.MedalsList;
    import scaleform.clik.data.DataProvider;
    import flash.text.TextFieldAutoSize;
    import flash.events.MouseEvent;
    import net.wg.data.managers.IToolTipParams;
    
    public class AwardsListComponent extends UIComponent
    {
        
        public function AwardsListComponent() {
            super();
        }
        
        private static var DP_INV:String = "dpInv";
        
        private static var TEXT_INVALID:String = "txtInv";
        
        private static function hideToolTip() : void {
            App.toolTipMgr.hide();
        }
        
        public var textField:TextField;
        
        public var medalsList:MedalsList;
        
        private var _dataProvider:DataProvider;
        
        private var _label:String = "";
        
        private var _errorText:String = "";
        
        private var _errorTextPadding:uint = 85;
        
        private var _titleToolTip:String;
        
        private var _isToolTipShowing:Boolean;
        
        override protected function draw() : void {
            var _loc1_:* = false;
            super.draw();
            if(isInvalid(DP_INV))
            {
                this.medalsList.dataProvider = this._dataProvider;
                _loc1_ = this._dataProvider?this._dataProvider.length <= 0:true;
                invalidate(TEXT_INVALID);
            }
            if(isInvalid(TEXT_INVALID))
            {
                this.textField.autoSize = TextFieldAutoSize.CENTER;
                if(_loc1_)
                {
                    this.textField.text = this._errorText;
                    this.textField.y = this._errorTextPadding;
                }
                else
                {
                    this.textField.text = this._label;
                    this.textField.y = 0;
                }
                this.textField.x = this.medalsList.width - this.textField.width >> 1;
            }
        }
        
        public function set dataProvider(param1:Array) : void {
            this._dataProvider = new DataProvider(param1);
            invalidate(DP_INV);
        }
        
        public function get label() : String {
            return this._label;
        }
        
        public function set label(param1:String) : void {
            this._label = param1;
            invalidate(TEXT_INVALID);
        }
        
        public function set errorText(param1:String) : void {
            this._errorText = param1;
            invalidate(TEXT_INVALID);
        }
        
        public function set titleToolTip(param1:String) : void {
            this._titleToolTip = param1;
            if(this._isToolTipShowing)
            {
                hideToolTip();
            }
            this.disposeHandlers();
            if(this._titleToolTip)
            {
                this.textField.addEventListener(MouseEvent.ROLL_OVER,this.mouseRollOverHandler,false,0,true);
                this.textField.addEventListener(MouseEvent.ROLL_OUT,this.mouseRollOutHandler,false,0,true);
            }
        }
        
        protected function mouseRollOverHandler(param1:MouseEvent) : void {
            this._isToolTipShowing = true;
            this.showToolTip(null);
        }
        
        protected function mouseRollOutHandler(param1:MouseEvent) : void {
            this._isToolTipShowing = false;
            hideToolTip();
        }
        
        protected function showToolTip(param1:IToolTipParams) : void {
            if(this._titleToolTip)
            {
                App.toolTipMgr.showComplex(this._titleToolTip);
            }
        }
        
        private function disposeHandlers() : void {
            this.textField.removeEventListener(MouseEvent.ROLL_OVER,this.mouseRollOverHandler);
            this.textField.removeEventListener(MouseEvent.ROLL_OUT,this.mouseRollOutHandler);
        }
        
        override protected function onDispose() : void {
            this._dataProvider = null;
            this.medalsList.dispose();
            this.disposeHandlers();
            super.onDispose();
        }
    }
}
