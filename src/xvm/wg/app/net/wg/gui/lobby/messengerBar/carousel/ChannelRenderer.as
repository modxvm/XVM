package net.wg.gui.lobby.messengerBar.carousel
{
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.interfaces.IListItemRenderer;
   import scaleform.clik.controls.Button;
   import flash.display.MovieClip;
   import net.wg.gui.lobby.messengerBar.carousel.data.ChannelListItemVO;
   import scaleform.clik.data.ListData;
   import scaleform.clik.constants.InvalidationType;


   public class ChannelRenderer extends UIComponent implements IListItemRenderer
   {
          
      public function ChannelRenderer() {
         super();
         visible = false;
      }

      public var openButton:ChannelButton;

      public var closeButton:Button;

      public var progressIndicator:MovieClip;

      protected var _index:uint = 0;

      protected var _selectable:Boolean = true;

      protected var _owner:UIComponent = null;

      protected var model:ChannelListItemVO;

      public function get index() : uint {
         return this._index;
      }

      public function set index(param1:uint) : void {
         this._index = param1;
      }

      public function get owner() : UIComponent {
         return this._owner;
      }

      public function set owner(param1:UIComponent) : void {
         this._owner = param1;
      }

      public function get selectable() : Boolean {
         return this._selectable;
      }

      public function set selectable(param1:Boolean) : void {
         this._selectable = param1;
      }

      public function get selected() : Boolean {
         return this.openButton.selected;
      }

      public function set selected(param1:Boolean) : void {
         this.openButton.selected = param1;
      }

      public function setListData(param1:ListData) : void {
         this.index = param1.index;
         this.selected = param1.selected;
         this.openButton.label = (param1.label) || "";
      }

      public function setData(param1:Object) : void {
         if(param1)
         {
            this.model = new ChannelListItemVO(param1);
            invalidateData();
         }
      }

      public function getData() : Object {
         return this.model;
      }

      override protected function onDispose() : void {
         super.onDispose();
         if(this.model)
         {
            this.model.dispose();
            this.model = null;
         }
      }

      override protected function draw() : void {
         super.draw();
         if((isInvalid(InvalidationType.DATA)) && (this.model))
         {
            this.openButton.label = this.model.label;
            this.openButton.blinking = this.model.isNotified;
            this.openButton.iconSource = this.model.icon;
            this.closeButton.visible = this.model.canClose;
            this.progressIndicator.visible = this.model.isInProgress;
         }
         visible = Boolean(this.model);
      }
   }

}