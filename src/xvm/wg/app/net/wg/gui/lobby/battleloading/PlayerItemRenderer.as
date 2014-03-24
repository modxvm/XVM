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
   import net.wg.gui.lobby.battleloading.vo.VehicleInfoVO;
   import flash.geom.ColorTransform;
   import net.wg.infrastructure.interfaces.IColorScheme;
   import net.wg.infrastructure.managers.IColorSchemeManager;


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
      }

      private function speakHandler(param1:VoiceChatEvent) : void {
         this.onPlayerSpeak(param1.getAccountDBID(),param1.type == VoiceChatEvent.START_SPEAKING);
      }

      public function onPlayerSpeak(param1:Number, param2:Boolean) : void {
         if((data) && (param1 == VehicleInfoVO(data).accountDBID) && (this.voiceWave))
         {
            this.voiceWave.setSpeaking(param2);
         }
      }

      override protected function onDispose() : void {
         App.voiceChatMgr.removeEventListener(VoiceChatEvent.START_SPEAKING,this.speakHandler);
         App.voiceChatMgr.removeEventListener(VoiceChatEvent.STOP_SPEAKING,this.speakHandler);
         super.onDispose();
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
         var _loc1_:VehicleInfoVO = null;
         if((data) && (initialized))
         {
            _loc1_ = VehicleInfoVO(data);
            this.selfBg.visible = _loc1_.isCurrentPlayer;
            App.utils.commons.formatPlayerName(textField,App.utils.commons.getUserProps(_loc1_.playerName,_loc1_.clanAbbrev,_loc1_.region,_loc1_.igrType));
            if(this.vehicleField != null)
            {
               this.vehicleField.text = _loc1_.vehicleName;
            }
            if(this.iconLoader != null)
            {
               this.iconLoader.visible = true;
               if(this.iconLoader.source != _loc1_.vehicleIcon)
               {
                  this.iconLoader.source = _loc1_.vehicleIcon;
               }
            }
            if(this.squad != null)
            {
               if(_loc1_.isSquadMan())
               {
                  this.squad.show(_loc1_.isCurrentSquad,_loc1_.squadIndex);
               }
               else
               {
                  this.squad.hide();
               }
            }
            if(!_loc1_.isNotAvailable())
            {
               enabled = (_loc1_.isAlive()) && (_loc1_.isReady());
            }
            if(this.voiceWave != null)
            {
               if(_loc1_.isSpeaking)
               {
                  this.voiceWave.setSpeaking(true);
               }
               this.voiceWave.setMuted(_loc1_.isMuted);
               if(data.isMuted)
               {
                  this.voiceWave.setSpeaking(false);
                  this.voiceWave.validateNow();
               }
            }
            if(!(this.playerActionMarker == null) && (_loc1_.vehicleAction))
            {
               this.playerActionMarker.action = _loc1_.vehicleAction;
               this.playerActionMarker.team = _loc1_.isPlayerTeam?"myteam":"enemy";
            }
            this.updateState(_loc1_);
            this.visible = true;
         }
         else
         {
            this.selfBg.visible = false;
            textField.htmlText = "";
            this.vehicleField.text = "";
            this.iconLoader.visible = false;
            enabled = false;
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
          
      }

      private function updateState(param1:VehicleInfoVO) : void {
         var _loc7_:* = NaN;
         var _loc8_:ColorTransform = null;
         var _loc2_:IColorScheme = null;
         var _loc3_:IColorScheme = null;
         var _loc4_:IColorSchemeManager = App.colorSchemeMgr;
         var _loc5_:* = true;
         var _loc6_:Boolean = param1.isAlive();
         if(!param1.isNotAvailable())
         {
            _loc5_ = (_loc6_) && (param1.isReady());
         }
         if(param1.isCurrentPlayer)
         {
            _loc2_ = _loc4_.getScheme(_loc5_?"selected":"selected_dead");
            _loc3_ = _loc4_.getScheme(_loc6_?"selected":"selected_dead");
         }
         else
         {
            if(param1.isCurrentSquad)
            {
               _loc2_ = _loc4_.getScheme(_loc5_?"squad":"squad_dead");
               _loc3_ = _loc4_.getScheme(_loc6_?"squad":"squad_dead");
            }
            else
            {
               if(param1.isTeamKiller())
               {
                  _loc2_ = _loc4_.getScheme(_loc5_?"teamkiller":"teamkiller_dead");
                  _loc3_ = _loc4_.getScheme(_loc6_?"teamkiller":"teamkiller_dead");
               }
               else
               {
                  _loc2_ = _loc4_.getScheme(_loc5_?"normal":"normal_dead");
                  _loc3_ = _loc4_.getScheme(_loc6_?"normal":"normal_dead");
               }
            }
         }
         if(_loc2_)
         {
            textField.textColor = _loc2_.rgb;
            this.vehicleField.textColor = _loc2_.rgb;
         }
         else
         {
            DebugUtils.LOG_ERROR("Color of text not found",param1);
            _loc7_ = _loc5_?16777215:5130300;
            textField.textColor = _loc7_;
            this.vehicleField.textColor = _loc7_;
         }
         if(_loc3_)
         {
            this.iconLoader.transform.colorTransform = _loc3_.colorTransform;
         }
         else
         {
            DebugUtils.LOG_ERROR("Color of icon not found",param1);
            _loc8_ = _loc5_?new ColorTransform(1,1,1,1,0,0,0,0):new ColorTransform(0.8,0.8,0.8,0.5,0,0,0,0);
            this.iconLoader.transform.colorTransform = _loc8_;
         }
      }

      override protected function updateAfterStateChange() : void {
         invalidate();
      }

      override public function toString() : String {
         return "[WG PlayerItemRenderer " + name;
      }
   }

}