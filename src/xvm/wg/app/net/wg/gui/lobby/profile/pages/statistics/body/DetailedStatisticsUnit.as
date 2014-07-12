package net.wg.gui.lobby.profile.pages.statistics.body
{
   import scaleform.clik.core.UIComponent;
   import flash.text.TextField;
   import net.wg.gui.components.common.containers.GroupEx;
   import net.wg.gui.components.common.containers.Vertical100PercWidthLayout;
   import flash.events.Event;
   import scaleform.clik.constants.InvalidationType;
   
   public class DetailedStatisticsUnit extends UIComponent
   {
      
      public function DetailedStatisticsUnit() {
         super();
      }
      
      private static const RENDERER_INVALID:String = "rendererInv";
      
      public var label:TextField;
      
      public var group:GroupEx;
      
      private var _data:DetailedStatisticsUnitVO;
      
      private var _itemRendererClass:Class;
      
      override protected function configUI() : void {
         var _loc1_:Vertical100PercWidthLayout = null;
         super.configUI();
         if(!this.group)
         {
            this.group = new GroupEx();
            _loc1_ = new Vertical100PercWidthLayout();
            _loc1_.gap = -5;
            this.group.layout = _loc1_;
            this.group.y = Math.round(this.label.y + this.label.height + 5);
            this.group.addEventListener(Event.RESIZE,this.resizeHandeler,false,0,true);
            this.addChild(this.group);
         }
      }
      
      private function resizeHandeler(param1:Event) : void {
         dispatchEvent(new Event(Event.RESIZE,true));
      }
      
      override protected function draw() : void {
         super.draw();
         if(isInvalid(RENDERER_INVALID))
         {
            this.group.itemRendererClass = this._itemRendererClass;
         }
         if((isInvalid(InvalidationType.DATA)) && (this._data))
         {
            this.label.text = this._data.label;
            this.group.dataProvider = this._data.itemsList;
            this.group.validateNow();
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.group.width = _width;
         }
      }
      
      public function set data(param1:DetailedStatisticsUnitVO) : void {
         this._data = param1;
         invalidateData();
      }
      
      public function set itemRendererClass(param1:Class) : void {
         if(this._itemRendererClass != param1)
         {
            this._itemRendererClass = param1;
            invalidate(RENDERER_INVALID);
         }
      }
      
      override public function set width(param1:Number) : void {
         super.width = param1;
         this.group.width = param1;
         this.group.invalidateLayout();
      }
      
      override public function get height() : Number {
         return actualHeight;
      }
      
      override protected function onDispose() : void {
         this._itemRendererClass = null;
         if(this.group)
         {
            this.group.removeEventListener(Event.RESIZE,this.resizeHandeler);
            this.group.dispose();
         }
         this.label = null;
         this.group = null;
         this._itemRendererClass = null;
         if(this._data)
         {
            this._data.dispose();
            this._data = null;
         }
         super.onDispose();
      }
   }
}
