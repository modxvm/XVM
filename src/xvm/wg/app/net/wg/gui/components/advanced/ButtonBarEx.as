package net.wg.gui.components.advanced
{
   import scaleform.clik.controls.ButtonBar;
   import net.wg.infrastructure.interfaces.IGroupedControl;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.controls.Button;
   import net.wg.gui.components.controls.SoundButtonEx;
   import scaleform.clik.interfaces.IListItemRenderer;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import flash.display.DisplayObject;
   import scaleform.clik.events.InputEvent;
   import flash.events.Event;
   import scaleform.clik.events.ButtonEvent;


   public class ButtonBarEx extends ButtonBar implements IGroupedControl
   {
          
      public function ButtonBarEx() {
         super();
      }

      private var _paddingHorizontal:Number = 10;

      public function get paddingHorizontal() : Number {
         return this._paddingHorizontal;
      }

      public function set paddingHorizontal(param1:Number) : void {
         this._paddingHorizontal = param1;
         invalidate(InvalidationType.SETTINGS);
      }

      override protected function setupRenderer(param1:Button, param2:uint) : void {
         var _loc3_:SoundButtonEx = null;
         super.setupRenderer(param1,param2);
         param1.autoSize = this.autoSize;
         if(param1  is  SoundButtonEx)
         {
            _loc3_ = param1 as SoundButtonEx;
            _loc3_.paddingHorizontal = this.paddingHorizontal;
         }
      }

      public function get selectedRenderer() : IListItemRenderer {
         if(_selectedIndex >= 0)
         {
            return _renderers[_selectedIndex];
         }
         return null;
      }

      override public function get data() : Object {
         return selectedItem;
      }

      public function disposeRenderers() : void {
         var _loc2_:* = NaN;
         var _loc3_:Button = null;
         var _loc4_:IDisposable = null;
         var _loc5_:DisplayObject = null;
         var _loc1_:Number = _renderers.length;
         _loc2_ = _loc1_-1;
         while(_loc2_ >= 0)
         {
            _loc3_ = getButtonAt(_loc2_);
            if(_loc3_ != null)
            {
               _loc4_ = _loc3_ as IDisposable;
               if(_loc4_)
               {
                  _loc4_.dispose();
               }
               _loc5_ = _loc3_ as DisplayObject;
               if(container)
               {
                  if(container.contains(_loc5_))
                  {
                     container.removeChild(_loc5_);
                  }
               }
            }
            _renderers.splice(_loc2_,1);
            _loc2_--;
         }
         this.removeChild(container);
         if(_dataProvider)
         {
            _dataProvider.cleanUp();
         }
         _dataProvider = null;
      }

      override public function dispose() : void {
         removeEventListener(InputEvent.INPUT,handleInput,false);
         if(_dataProvider)
         {
            _dataProvider.removeEventListener(Event.CHANGE,handleDataChange,false);
         }
         this.disposeRenderers();
         if(_group)
         {
            _group.removeEventListener(ButtonEvent.CLICK,handleButtonGroupChange,false);
            _group.dispose();
            _group = null;
         }
         super.dispose();
      }

      override protected function populateRendererData(param1:Button, param2:uint) : void {
         var _loc3_:Object = _dataProvider.requestItemAt(param2);
         if((param1.hasOwnProperty("tooltip")) && (_loc3_) && (_loc3_.hasOwnProperty("tooltip")))
         {
            param1["tooltip"] = _loc3_.tooltip;
         }
         super.populateRendererData(param1,param2);
      }

      override public function toString() : String {
         return "[WG ButtonBarEx " + name + "]";
      }
   }

}