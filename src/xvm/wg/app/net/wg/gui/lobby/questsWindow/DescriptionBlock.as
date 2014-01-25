package net.wg.gui.lobby.questsWindow
{
   import scaleform.clik.core.UIComponent;
   import flash.text.TextField;
   import scaleform.clik.constants.InvalidationType;
   import flash.events.Event;


   public class DescriptionBlock extends UIComponent
   {
          
      public function DescriptionBlock() {
         super();
      }

      private static const BOTTOM_PADDING:int = 18;

      public var lableTF:TextField;

      public var descrTF:TextField;

      private var _title:String = "";

      private var _descr:String = "";

      private var _isReadyForLayout:Boolean = false;

      override protected function configUI() : void {
         super.configUI();
         mouseChildren = mouseEnabled = false;
      }

      public function setLabels(param1:String, param2:String) : void {
         this._title = param1;
         this._descr = param2;
         invalidateData();
      }

      override protected function draw() : void {
         var _loc1_:* = NaN;
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.lableTF.htmlText = this._title;
            this.descrTF.htmlText = this._descr;
            this.descrTF.y = this._title?Math.round(this.lableTF.y + this.lableTF.textHeight + 3):this.lableTF.y;
            _loc1_ = 0;
            if(this._descr)
            {
               _loc1_ = Math.round(this.descrTF.y + this.descrTF.textHeight + BOTTOM_PADDING);
            }
            else
            {
               if(this._title)
               {
                  _loc1_ = Math.round(this.lableTF.y + this.lableTF.textHeight + BOTTOM_PADDING);
               }
            }
            setSize(this.width,_loc1_);
            this.isReadyForLayout = true;
            dispatchEvent(new Event(Event.RESIZE));
         }
      }

      override protected function onDispose() : void {
         this.lableTF = null;
         this.descrTF = null;
         super.onDispose();
      }

      public function get isReadyForLayout() : Boolean {
         return this._isReadyForLayout;
      }

      public function set isReadyForLayout(param1:Boolean) : void {
         this._isReadyForLayout = param1;
      }
   }

}