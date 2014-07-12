package net.wg.gui.lobby.GUIEditor
{
   import scaleform.clik.controls.ListItemRenderer;
   import flash.text.TextField;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.controls.CoreList;
   import net.wg.data.constants.Errors;
   
   public class ComponentListItemRenderer extends ListItemRenderer
   {
      
      public function ComponentListItemRenderer() {
         super();
      }
      
      public var classPathField:TextField = null;
      
      private var _component:DisplayObject = null;
      
      override public function setData(param1:Object) : void {
         super.setData(param1);
         invalidateData();
      }
      
      override protected function onDispose() : void {
         if(this._component)
         {
            removeChild(this._component);
            this._component.removeEventListener(MouseEvent.CLICK,this.onComponentClickHandler);
            this._component = null;
         }
         super.onDispose();
      }
      
      override protected function configUI() : void {
         super.configUI();
         _focusable = tabEnabled = tabChildren = mouseChildren = false;
         mouseEnabled = true;
      }
      
      override protected function draw() : void {
         var _loc1_:ComponentInfoVo = null;
         var _loc2_:* = NaN;
         super.draw();
         if(_baseDisposed)
         {
            return;
         }
         if(!(data == null) && (isInvalid(InvalidationType.DATA)))
         {
            _loc1_ = ComponentInfoVo(data);
            this.classPathField.text = _loc1_.shortLinkageName;
            if(this._component != null)
            {
               removeChild(this._component);
               this._component = null;
            }
            this._component = _loc1_.component;
            addEventListener(MouseEvent.CLICK,this.onComponentClickHandler);
            this._component.y = 14;
            _loc2_ = Math.min(20 / this._component.height,280 / this._component.width);
            this._component.height = this._component.height * _loc2_;
            this._component.width = this._component.width * _loc2_;
            if(this._component is CoreList)
            {
               CoreList(this._component).itemRendererName = "DropDownListItemRendererSound";
            }
            addChild(this._component);
         }
      }
      
      private function onComponentClickHandler(param1:MouseEvent) : void {
         App.utils.asserter.assertNotNull(data,"data" + Errors.CANT_NULL);
         var _loc2_:ComponentInfoVo = ComponentInfoVo(data);
         dispatchEvent(new ComponentCreateEvent(ComponentCreateEvent.COMPONENT_CREATE,_loc2_.clone()));
      }
   }
}
