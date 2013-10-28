package net.wg.gui.lobby.profile.pages.summary
{
   import scaleform.clik.core.UIComponent;
   import flash.text.TextField;
   import net.wg.gui.lobby.battleResults.MedalsList;
   import scaleform.clik.data.DataProvider;


   public class AwardsListComponent extends UIComponent
   {
          
      public function AwardsListComponent() {
         super();
      }

      private static const DP_INV:String = "dpInv";

      private static const TEXT_INVALID:String = "txtInv";

      public var textField:TextField;

      public var medalsList:MedalsList;

      private var _dataProvider:DataProvider;

      private var _label:String = "";

      private var _errorText:String = "";

      private var _isShowError:Boolean;

      private var _errorTextPadding:uint = 85;

      override protected function configUI() : void {
         super.configUI();
      }

      override protected function draw() : void {
         super.draw();
         if(isInvalid(DP_INV))
         {
            this.medalsList.dataProvider = this._dataProvider;
            this._isShowError = this._dataProvider?this._dataProvider.length <= 0:true;
            invalidate(TEXT_INVALID);
         }
         if(isInvalid(TEXT_INVALID))
         {
            if(this._isShowError)
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

      public function get errorText() : String {
         return this._errorText;
      }

      public function set errorText(param1:String) : void {
         this._errorText = param1;
         invalidate(TEXT_INVALID);
      }

      public function get errorTextPadding() : uint {
         return this._errorTextPadding;
      }

      public function set errorTextPadding(param1:uint) : void {
         this._errorTextPadding = param1;
         invalidate(TEXT_INVALID);
      }
   }

}