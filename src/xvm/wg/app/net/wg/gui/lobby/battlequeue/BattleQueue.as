package net.wg.gui.lobby.battlequeue
{
   import net.wg.infrastructure.base.meta.impl.BattleQueueMeta;
   import net.wg.infrastructure.base.meta.IBattleQueueMeta;
   import net.wg.gui.components.icons.BattleTypeIcon;
   import flash.text.TextField;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.ScrollingListEx;
   import scaleform.clik.events.ButtonEvent;
   import flash.ui.Keyboard;
   import flash.events.KeyboardEvent;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.InputEvent;


   public class BattleQueue extends BattleQueueMeta implements IBattleQueueMeta
   {
          
      public function BattleQueue() {
         super();
      }

      public var battleIconBig:BattleTypeIcon;

      public var battleIcon:BattleTypeIcon;

      public var titleField:TextField;

      public var descriptionLabel:TextField;

      public var timerLabel:TextField;

      public var playersLabel:TextField;

      public var titleFieldLevel:TextField;

      public var titleFieldType:TextField;

      public var exitButton:SoundButtonEx;

      public var startButton:SoundButtonEx;

      public var listByLevel:ScrollingListEx;

      public var listByType:ScrollingListEx;

      override protected function configUI() : void {
         this.titleFieldLevel.visible = false;
         this.listByLevel.visible = false;
         this.titleFieldType.visible = false;
         this.startButton.addEventListener(ButtonEvent.CLICK,this.onStartClick);
         this.exitButton.addEventListener(ButtonEvent.CLICK,this.onExitButton);
         App.gameInputMgr.setKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.handleEscape,true);
         super.configUI();
      }

      private function onExitButton(param1:ButtonEvent) : void {
         exitClickS();
      }

      private function onStartClick(param1:ButtonEvent) : void {
         startClickS();
      }

      public function as_setTimer(param1:String, param2:String) : void {
         if(param2 != null)
         {
            param1 = param1 + (" <font color=\"#FFFFFF\">" + param2 + "</font>");
         }
         this.timerLabel.htmlText = param1;
      }

      public function as_setType(param1:Number) : void {
         this.battleIcon.typeByNumber = param1 + 1;
         this.battleIconBig.typeByNumber = param1 + 1;
         this.titleField.text = MENU.loading_battletypes(param1.toString());
         this.descriptionLabel.text = MENU.loading_battletypes_desc(param1.toString());
      }

      public function as_setPlayers(param1:String, param2:Number) : void {
         this.playersLabel.htmlText = param1 + " <font color=\"#FFFFFF\">" + param2.toString() + "</font>";
      }

      public function as_setListByLevel(param1:Object) : void {
         var _loc2_:Array = null;
         _loc2_ = new Array();
         var _loc3_:uint = 0;
         while(_loc3_ < param1.data.length)
         {
            _loc2_.push(
               {
                  "type":param1.data.length - _loc3_,
                  "count":param1.data[_loc3_]
               }
            );
            _loc3_++;
         }
         this.titleFieldLevel.text = param1.title;
         this.titleFieldLevel.visible = true;
         this.listByLevel.visible = true;
         this.listByLevel.dataProvider = new DataProvider(_loc2_);
      }

      public function as_setListByType(param1:Object) : void {
         var _loc2_:Array = null;
         _loc2_ = new Array();
         var _loc3_:uint = 0;
         while(_loc3_ < param1.data.length)
         {
            _loc2_.push(
               {
                  "type":param1.data[_loc3_][0],
                  "count":param1.data[_loc3_][1]
               }
            );
            _loc3_++;
         }
         this.titleFieldType.text = param1.title;
         this.titleFieldType.visible = true;
         this.listByType.visible = true;
         this.listByType.dataProvider = new DataProvider(_loc2_);
      }

      public function as_showStart(param1:Boolean) : void {
         this.startButton.visible = param1;
      }

      public function as_showExit(param1:Boolean) : void {
         this.exitButton.visible = param1;
      }

      override public function updateStage(param1:Number, param2:Number) : void {
         this.x = param1 - this.actualWidth >> 1;
         this.y = Math.min(-parent.y + (param2 - this.actualHeight >> 1),80);
      }

      override protected function onDispose() : void {
         App.gameInputMgr.clearKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN);
         this.listByLevel.disposeRenderers();
         this.listByType.disposeRenderers();
         if(this.startButton.hasEventListener(ButtonEvent.CLICK))
         {
            this.startButton.removeEventListener(ButtonEvent.CLICK,this.onStartClick);
         }
         if(this.exitButton.hasEventListener(ButtonEvent.CLICK))
         {
            this.exitButton.removeEventListener(ButtonEvent.CLICK,this.onExitButton);
         }
         super.onDispose();
      }

      override public function toString() : String {
         return "[WG BattleQueue " + name + "]";
      }

      private function handleEscape(param1:InputEvent) : void {
         onEscapeS();
      }
   }

}