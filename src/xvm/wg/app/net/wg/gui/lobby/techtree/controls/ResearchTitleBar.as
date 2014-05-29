package net.wg.gui.lobby.techtree.controls
{
   import scaleform.clik.core.UIComponent;
   import flash.text.TextField;
   import net.wg.gui.lobby.techtree.constants.TTInvalidationType;
   import scaleform.clik.events.ButtonEvent;
   import flash.events.MouseEvent;
   import scaleform.clik.utils.Constraints;
   import scaleform.gfx.TextFieldEx;
   import scaleform.clik.constants.InvalidationType;
   import net.wg.gui.lobby.techtree.TechTreeEvent;
   import net.wg.data.constants.Tooltips;
   import scaleform.gfx.Extensions;


   public class ResearchTitleBar extends UIComponent
   {
          
      public function ResearchTitleBar() {
         super();
         Extensions.enabled = true;
      }

      private var _title:String = "";

      private var _nation:String = "";

      private var _hbID:int = -1;

      public var titleField:TextField;

      public var infoField:TextField;

      public var returnButton:ReturnToTTButton;

      public function setTitle(param1:String) : void {
         if(this._title == param1)
         {
            return;
         }
         this._title = param1;
         invalidate(TTInvalidationType.TITLE);
      }

      public function setNation(param1:String) : void {
         if(this._nation == param1)
         {
            return;
         }
         this._nation = param1;
         invalidate(TTInvalidationType.NATION);
      }

      public function setHBID(param1:int) : void {
         this._hbID = param1;
      }

      public function setInfoMessage(param1:String) : void {
         this.infoField.htmlText = param1;
         this.infoField.visible = (param1) && param1.length > 0;
         this.centerInfoField();
      }

      override protected function onDispose() : void {
         if(this.returnButton != null)
         {
            this.returnButton.removeEventListener(ButtonEvent.CLICK,this.handleClickReturnButton,false);
            this.returnButton.dispose();
         }
         if(this.infoField != null)
         {
            this.infoField.removeEventListener(MouseEvent.ROLL_OVER,this.onInfoFieldRollOver);
            this.infoField.removeEventListener(MouseEvent.ROLL_OUT,this.onInfoFieldRollOut);
         }
         super.onDispose();
      }

      override protected function configUI() : void {
         constraints = new Constraints(this);
         if(this.titleField != null)
         {
            constraints.addElement(this.titleField.name,this.titleField,Constraints.LEFT | Constraints.RIGHT);
         }
         if(this.infoField != null)
         {
            this.infoField.addEventListener(MouseEvent.ROLL_OVER,this.onInfoFieldRollOver);
            this.infoField.addEventListener(MouseEvent.ROLL_OUT,this.onInfoFieldRollOut);
         }
         if(this.returnButton != null)
         {
            constraints.addElement(this.returnButton.name,this.returnButton,Constraints.TOP | Constraints.LEFT);
            this.returnButton.addEventListener(ButtonEvent.CLICK,this.handleClickReturnButton,false,0,true);
         }
         super.configUI();
      }

      override protected function draw() : void {
         super.draw();
         if((isInvalid(TTInvalidationType.TITLE)) && !(this.titleField == null))
         {
            TextFieldEx.setVerticalAlign(this.titleField,TextFieldEx.VALIGN_CENTER);
            this.titleField.text = this._title;
         }
         if((isInvalid(TTInvalidationType.NATION)) && !(this.returnButton == null))
         {
            if(this._nation.length > 0)
            {
               this.returnButton.label = this._nation;
               this.returnButton.visible = true;
            }
            else
            {
               this.returnButton.visible = false;
            }
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            constraints.update(_width,_height);
            this.centerInfoField();
         }
      }

      private function handleClickReturnButton(param1:ButtonEvent) : void {
         dispatchEvent(new TechTreeEvent(TechTreeEvent.RETURN_2_TECHTREE));
      }

      private function onInfoFieldRollOut(param1:MouseEvent) : void {
         App.toolTipMgr.hide();
      }

      private function onInfoFieldRollOver(param1:MouseEvent) : void {
         if(this._hbID != -1)
         {
            App.toolTipMgr.showSpecial(Tooltips.HISTORICAL_MODULES,null,this._hbID);
         }
      }

      private function centerInfoField() : void {
         this.infoField.width = this.infoField.textWidth;
         this.infoField.x = this.titleField.width - this.infoField.width >> 1;
      }
   }

}