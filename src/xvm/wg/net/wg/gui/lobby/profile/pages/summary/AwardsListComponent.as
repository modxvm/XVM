package net.wg.gui.lobby.profile.pages.summary 
{
    import flash.text.*;
    import net.wg.gui.lobby.battleResults.*;
    import scaleform.clik.core.*;
    import scaleform.clik.data.*;
    
    public class AwardsListComponent extends scaleform.clik.core.UIComponent
    {
        public function AwardsListComponent()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(DP_INV)) 
            {
                this.medalsList.dataProvider = this._dataProvider;
                this._isShowError = this._dataProvider ? this._dataProvider.length <= 0 : true;
                invalidate(TEXT_INVALID);
            }
            if (isInvalid(TEXT_INVALID)) 
            {
                if (this._isShowError) 
                {
                    this.textField.text = this._errorText;
                    this.textField.y = this._errorTextPadding;
                }
                else 
                {
                    this.textField.text = this._label;
                    this.textField.y = 0;
                }
            }
            return;
        }

        public function set dataProvider(arg1:Array):void
        {
            this._dataProvider = new scaleform.clik.data.DataProvider(arg1);
            invalidate(DP_INV);
            return;
        }

        public function get label():String
        {
            return this._label;
        }

        public function set label(arg1:String):void
        {
            this._label = arg1;
            invalidate(TEXT_INVALID);
            return;
        }

        public function get errorText():String
        {
            return this._errorText;
        }

        public function set errorText(arg1:String):void
        {
            this._errorText = arg1;
            invalidate(TEXT_INVALID);
            return;
        }

        public function get errorTextPadding():uint
        {
            return this._errorTextPadding;
        }

        public function set errorTextPadding(arg1:uint):void
        {
            this._errorTextPadding = arg1;
            invalidate(TEXT_INVALID);
            return;
        }

        internal static const DP_INV:String="dpInv";

        internal static const TEXT_INVALID:String="txtInv";

        public var textField:flash.text.TextField;

        public var medalsList:net.wg.gui.lobby.battleResults.MedalsList;

        internal var _dataProvider:scaleform.clik.data.DataProvider;

        internal var _label:String="";

        internal var _errorText:String="";

        internal var _isShowError:Boolean;

        internal var _errorTextPadding:uint=85;
    }
}
