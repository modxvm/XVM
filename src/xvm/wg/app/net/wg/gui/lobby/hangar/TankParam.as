package net.wg.gui.lobby.hangar
{
   import scaleform.clik.controls.ListItemRenderer;
   import flash.text.TextField;
   import scaleform.clik.data.ListData;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import scaleform.clik.events.InputEvent;
   import flash.events.TimerEvent;
   import flash.text.StyleSheet;
   
   public class TankParam extends ListItemRenderer
   {
      
      public function TankParam() {
         super();
         this._styles = new Styles();
      }
      
      private static const INVALIDATE_TEXT:String = "inv_text";
      
      private static const INVALIDATE_VALUE:String = "inv_value";
      
      public var paramField:TextField;
      
      public var tfField:TextField;
      
      private var _text:String = "";
      
      private var _value:String = "";
      
      private var _styles:Styles = null;
      
      override public function setData(param1:Object) : void {
         var _loc2_:ParamsVO = null;
         super.setData(param1);
         if(param1)
         {
            _loc2_ = ParamsVO(param1);
            this.param = _loc2_.param;
            this.text = MENU.tank_params(_loc2_.text);
            this.selected = _loc2_.selected;
            invalidate();
         }
      }
      
      override public function setListData(param1:ListData) : void {
         index = param1.index;
      }
      
      override protected function onDispose() : void {
         removeEventListener(Event.ADDED,addToAutoGroup,false);
         removeEventListener(Event.REMOVED,addToAutoGroup,false);
         removeEventListener(MouseEvent.ROLL_OVER,handleMouseRollOver,false);
         removeEventListener(MouseEvent.ROLL_OUT,handleMouseRollOut,false);
         removeEventListener(MouseEvent.MOUSE_DOWN,handleMousePress,false);
         removeEventListener(MouseEvent.CLICK,handleMouseRelease,false);
         removeEventListener(MouseEvent.DOUBLE_CLICK,handleMouseRelease,false);
         removeEventListener(InputEvent.INPUT,handleInput,false);
         if(_repeatTimer)
         {
            _repeatTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,beginRepeat,false);
            _repeatTimer.removeEventListener(TimerEvent.TIMER,handleRepeat,false);
         }
         this._styles.dispose();
         this._styles = null;
         if(_data)
         {
            ParamsVO(_data).dispose();
            _data = null;
         }
         this._text = null;
         this._value = null;
         this.paramField = null;
         this.tfField = null;
         super.onDispose();
      }
      
      override public function get selected() : Boolean {
         return _selected;
      }
      
      override public function set selected(param1:Boolean) : void {
         if(_selected == param1)
         {
            return;
         }
         _selected = param1;
         validateNow();
      }
      
      override public function set enabled(param1:Boolean) : void {
         var _loc2_:String = null;
         super.enabled = param1;
         mouseChildren = false;
         if(super.enabled)
         {
            _loc2_ = "normal";
         }
         else
         {
            _loc2_ = "disabled";
         }
         setState(_loc2_);
      }
      
      public function get text() : String {
         return this._text;
      }
      
      public function set text(param1:String) : void {
         if(this._text == param1)
         {
            return;
         }
         this._text = param1;
         invalidate(INVALIDATE_TEXT);
      }
      
      public function get param() : String {
         return this._value;
      }
      
      public function set param(param1:String) : void {
         if(this._value == param1)
         {
            return;
         }
         this._value = param1;
         invalidate(INVALIDATE_VALUE);
      }
      
      override protected function configUI() : void {
         super.configUI();
         _stateMap = 
            {
               "normal":["normal"],
               "disabled":["disabled"]
            };
         var _loc1_:StyleSheet = new StyleSheet();
         _loc1_.setStyle("h1",{"color":"#B4A983"});
         _loc1_.setStyle("p",{"color":"#9F9260"});
         var _loc2_:StyleSheet = new StyleSheet();
         _loc2_.setStyle("h1",{"color":"#E1DDCE"});
         _loc2_.setStyle("p",{"color":"#B4A983"});
         var _loc3_:StyleSheet = new StyleSheet();
         _loc3_.setStyle("h1",{"color":"#666666"});
         _loc3_.setStyle("p",{"color":"#666666"});
         this._styles.normal = _loc1_;
         this._styles.selected = _loc2_;
         this._styles.disabled = _loc3_;
         this.tfField.styleSheet = this._styles.normal;
      }
      
      override protected function draw() : void {
         super.draw();
         if(isInvalid(INVALIDATE_TEXT))
         {
            if(this.tfField != null)
            {
               this.tfField.htmlText = this._text;
            }
         }
         if(isInvalid(INVALIDATE_VALUE))
         {
            if(this.paramField != null)
            {
               this.paramField.text = this._value;
            }
         }
         if(this.tfField != null)
         {
            if(!super.enabled)
            {
               this.tfField.styleSheet = this._styles.disabled;
            }
            else if(_selected)
            {
               this.tfField.styleSheet = this._styles.selected;
            }
            else
            {
               this.tfField.styleSheet = this._styles.normal;
            }
            
            this.tfField.htmlText = this._text;
         }
      }
   }
}
import net.wg.infrastructure.interfaces.entity.IDisposable;
import flash.text.StyleSheet;

class Styles extends Object implements IDisposable
{
   
   function Styles() {
      super();
   }
   
   private var _normal:StyleSheet = null;
   
   private var _selected:StyleSheet = null;
   
   private var _disabled:StyleSheet = null;
   
   public function get normal() : StyleSheet {
      return this._normal;
   }
   
   public function set normal(param1:StyleSheet) : void {
      this._normal = param1;
   }
   
   public function get selected() : StyleSheet {
      return this._selected;
   }
   
   public function set selected(param1:StyleSheet) : void {
      this._selected = param1;
   }
   
   public function get disabled() : StyleSheet {
      return this._disabled;
   }
   
   public function set disabled(param1:StyleSheet) : void {
      this._disabled = param1;
   }
   
   public function dispose() : void {
      if(this._normal)
      {
         this._normal.clear();
         this._normal = null;
      }
      if(this._selected)
      {
         this._selected.clear();
         this._selected = null;
      }
      if(this._disabled)
      {
         this._disabled.clear();
         this._disabled = null;
      }
   }
}
