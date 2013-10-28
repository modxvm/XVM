package net.wg.gui.lobby.battleloading
{
   import scaleform.clik.controls.ListItemRenderer;
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.components.icons.SquadIcon;
   import net.wg.gui.components.controls.VoiceWave;
   import net.wg.gui.components.icons.PlayerActionMarker;
   import net.wg.infrastructure.events.VoiceChatEvent;
   import flash.events.MouseEvent;
   import scaleform.clik.events.InputEvent;
   import flash.geom.Transform;
   import flash.geom.ColorTransform;
   import net.wg.infrastructure.interfaces.IColorScheme;
   import flash.events.Event;


   public class PlayerItemRenderer extends ListItemRenderer
   {
          
      public function PlayerItemRenderer() {
         super();
         this.visible = false;
      }

      public var selfBg:Sprite;

      public var vehicleField:TextField;

      public var iconLoader:UILoaderAlt;

      public var squad:SquadIcon;

      public var voiceWave:VoiceWave;

      public var playerActionMarker:PlayerActionMarker;

      private var _enabled:Boolean = false;

      override protected function configUI() : void {
         super.configUI();
         App.voiceChatMgr.addEventListener(VoiceChatEvent.START_SPEAKING,this.speakHandler);
         App.voiceChatMgr.addEventListener(VoiceChatEvent.STOP_SPEAKING,this.speakHandler);
         if(hasEventListener(MouseEvent.ROLL_OVER))
         {
            removeEventListener(MouseEvent.ROLL_OVER,handleMouseRollOver);
         }
         if(hasEventListener(MouseEvent.ROLL_OUT))
         {
            removeEventListener(MouseEvent.ROLL_OUT,handleMouseRollOut);
         }
         if(hasEventListener(MouseEvent.MOUSE_DOWN))
         {
            removeEventListener(MouseEvent.MOUSE_DOWN,handleMousePress);
         }
         if(hasEventListener(MouseEvent.CLICK))
         {
            removeEventListener(MouseEvent.CLICK,handleMouseRelease);
         }
         if(hasEventListener(MouseEvent.DOUBLE_CLICK))
         {
            removeEventListener(MouseEvent.DOUBLE_CLICK,handleMouseRelease);
         }
         if(hasEventListener(InputEvent.INPUT))
         {
            removeEventListener(InputEvent.INPUT,handleInput);
         }
         this.updateState();
      }

      private function speakHandler(param1:VoiceChatEvent) : void {
         this.onPlayerSpeak(param1.getAccountDBID(),param1.type == VoiceChatEvent.START_SPEAKING);
      }

      public function onPlayerSpeak(param1:uint, param2:Boolean) : void {
         if((data) && (param1 == data.id) && (this.voiceWave))
         {
            this.voiceWave.setSpeaking(param2);
         }
      }

      override public function dispose() : void {
         App.voiceChatMgr.removeEventListener(VoiceChatEvent.START_SPEAKING,this.speakHandler);
         App.voiceChatMgr.removeEventListener(VoiceChatEvent.STOP_SPEAKING,this.speakHandler);
         super.dispose();
      }

      override protected function draw() : void {
         this.update();
         super.draw();
      }

      override public function setData(param1:Object) : void {
         this.data = param1;
         invalidate();
      }

      private function update() : void {
         if((data) && (initialized))
         {
            this.selfBg.visible = _selected;
            if(data.label)
            {
               label = App.utils.commons.formatPlayerName(textField,data.label,data.clanAbbrev,null,data.isIGR);
            }
            if(!(this.vehicleField == null) && !(data.vehicle == null))
            {
               this.vehicleField.text = data.vehicle;
            }
            if(this.iconLoader != null)
            {
               this.iconLoader.visible = true;
               if(this.iconLoader.source != data.icon)
               {
                  this.iconLoader.source = data.icon;
               }
            }
            if((!(this.squad == null)) && (this.squad.setSquad) && !(data.squad == null))
            {
               this.squad.setSquad(data.squad);
            }
            if(data.enabled != null)
            {
               this.enabled = data.enabled;
            }
            if(this.voiceWave != null)
            {
               if(data.speak)
               {
                  this.voiceWave.setSpeaking(true);
               }
               if(data.muted != null)
               {
                  this.voiceWave.setMuted(data.muted);
               }
            }
            if(!(this.playerActionMarker == null) && !(data.vehAction == null) && !(data.team == null))
            {
               this.playerActionMarker.action = data.vehAction;
               this.playerActionMarker.team = data.team == "team1"?"myteam":"enemy";
            }
            this.updateState();
            this.visible = true;
         }
         else
         {
            this.selfBg.visible = false;
            textField.htmlText = "";
            this.vehicleField.text = "";
            this.iconLoader.visible = false;
            this.enabled = false;
            if(this.voiceWave != null)
            {
               this.voiceWave.setSpeaking(false,true);
               this.voiceWave.setMuted(false);
            }
            if(this.playerActionMarker != null)
            {
               this.playerActionMarker.action = 0;
            }
         }
      }

      override protected function setState(param1:String) : void {
          
      }

      override protected function updateText() : void {
         if(!(_label == null) && !(textField == null))
         {
            textField.htmlText = _label;
         }
      }

      private function updateState() : void {
         var _loc3_:Transform = null;
         var _loc4_:ColorTransform = null;
         var _loc5_:* = NaN;
         var _loc6_:ColorTransform = null;
         var _loc1_:IColorScheme = null;
         var _loc2_:* = false;
         if((_selected) || !(data == null) && data.squad > 10)
         {
            _loc2_ = true;
            _loc1_ = App.colorSchemeMgr.getScheme(super.enabled?"selected":"selected_dead");
         }
         else
         {
            if(!(data == null) && (data.isTeamKiller))
            {
               _loc1_ = App.colorSchemeMgr.getScheme(super.enabled?"teamkiller":"teamkiller_dead");
            }
            else
            {
               _loc1_ = App.colorSchemeMgr.getScheme(super.enabled?"normal":"normal_dead");
            }
         }
         if(_loc1_)
         {
            if(data)
            {
               label = App.utils.commons.formatPlayerName(textField,data.label,null,null,data.isIGR,_loc1_);
            }
            this.vehicleField.textColor = _loc1_.rgb;
            if(_loc2_)
            {
               _loc4_ = new ColorTransform();
               _loc4_.redOffset = 21;
               _loc4_.greenOffset = 9;
               _loc4_.blueMultiplier = 0.51;
               _loc4_.greenMultiplier = 0.87;
               this.iconLoader.transform.colorTransform = _loc4_;
            }
            else
            {
               _loc3_ = new Transform(this.iconLoader);
               _loc3_.colorTransform = _loc1_.colorTransform;
            }
         }
         else
         {
            _loc5_ = super.enabled?16777215:5130300;
            _loc6_ = super.enabled?new ColorTransform(1,1,1,1,0,0,0,0):new ColorTransform(0.8,0.8,0.8,0.5,0,0,0,0);
            textField.textColor = _loc5_;
            this.vehicleField.textColor = _loc5_;
            _loc3_ = new Transform(this.iconLoader);
            _loc3_.colorTransform = _loc6_;
         }
      }

      override protected function updateAfterStateChange() : void {
         invalidate();
      }

      override public function get enabled() : Boolean {
         return this._enabled;
      }

      override public function set enabled(param1:Boolean) : void {
         if(this._enabled == param1)
         {
            return;
         }
         this._enabled = param1;
         super.enabled = this._enabled;
         this.updateState();
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
         this.updateState();
         dispatchEvent(new Event(Event.SELECT));
      }

      override public function toString() : String {
         return "[WG PlayerItemRenderer " + name;
      }
   }

}