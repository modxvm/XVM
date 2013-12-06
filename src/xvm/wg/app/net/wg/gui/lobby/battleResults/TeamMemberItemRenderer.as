package net.wg.gui.lobby.battleResults
{
   import net.wg.gui.components.controls.SoundListItemRenderer;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.gui.components.controls.UILoaderAlt;
   import flash.events.MouseEvent;
   import net.wg.data.components.BattleResultsCIGenerator;
   import flash.filters.ColorMatrixFilter;
   import net.wg.infrastructure.interfaces.IColorScheme;


   public class TeamMemberItemRenderer extends SoundListItemRenderer
   {
          
      public function TeamMemberItemRenderer() {
         super();
      }

      public var selfBg:MovieClip;

      public var teamKillBg:MovieClip;

      public var deadBg:MovieClip;

      public var selectionBg:MovieClip;

      public var playerName:TextField;

      public var vehicleName:TextField;

      public var damageLbl:TextField;

      public var fragsLbl:TextField;

      public var xpLbl:TextField;

      public var medalIcon:EfficiencyIconRenderer;

      public var fakeFocusIndicator:MovieClip;

      public var sqadIcon:MovieClip;

      public var vehicleIcon:UILoaderAlt;

      private var _dataDirty:Boolean = false;

      override public function setData(param1:Object) : void {
         this.data = param1;
         this._dataDirty = true;
         invalidate();
      }

      override protected function configUI() : void {
         super.configUI();
         this.mouseChildren = true;
         this.medalIcon.addEventListener(MouseEvent.ROLL_OVER,this.onMedalRollOver);
         this.medalIcon.addEventListener(MouseEvent.ROLL_OUT,this.onMedalRollOut);
         this.medalIcon.addEventListener(MouseEvent.CLICK,this.onMedalClick);
      }

      override public function dispose() : void {
         super.dispose();
         this.medalIcon.removeEventListener(MouseEvent.ROLL_OVER,this.onMedalRollOver);
         this.medalIcon.removeEventListener(MouseEvent.ROLL_OUT,this.onMedalRollOut);
         this.medalIcon.removeEventListener(MouseEvent.CLICK,this.onMedalClick);
         this.medalIcon.dispose();
         this.vehicleIcon.dispose();
      }

      private function onMedalRollOver(param1:MouseEvent) : void {
         var _loc2_:Array = null;
         var _loc3_:uint = 0;
         if(data.achievements.length > 0)
         {
            _loc2_ = [];
            _loc3_ = 0;
            while(_loc3_ < data.achievements.length)
            {
               _loc2_.push(App.utils.locale.makeString(ACHIEVEMENTS.all(data.achievements[_loc3_].type)));
               _loc3_++;
            }
            App.toolTipMgr.show(_loc2_.join("\n"));
         }
      }

      override protected function handleMouseRollOver(param1:MouseEvent) : void {
         super.handleMouseRollOver(param1);
         this.fakeFocusIndicator.gotoAndPlay("over");
      }

      override protected function handleMouseRollOut(param1:MouseEvent) : void {
         super.handleMouseRollOut(param1);
         this.fakeFocusIndicator.gotoAndPlay("out");
      }

      private function onMedalRollOut(param1:MouseEvent) : void {
         App.toolTipMgr.hide();
      }

      private function onMedalClick(param1:MouseEvent) : void {
         this.handleMouseRelease(param1);
      }

      override protected function handleMouseRelease(param1:MouseEvent) : void {
         var _loc2_:Object = null;
         if((App.utils.commons.isRightButton(param1)) && (this.data))
         {
            _loc2_ =
               {
                  "uid":data.playerId,
                  "userName":data.userName,
                  "himself":data.isSelf
               }
            ;
            App.contextMenuMgr.showUserContextMenu(this,_loc2_,new BattleResultsCIGenerator(data.isOwnSquad));
         }
         super.handleMouseRelease(param1);
      }

      private function getDimmFilter() : ColorMatrixFilter {
         var _loc1_:ColorMatrixFilter = new ColorMatrixFilter();
         var _loc2_:Array = [0.4,0,0,0,0];
         var _loc3_:Array = [0,0.4,0,0,0];
         var _loc4_:Array = [0,0,0.4,0,0];
         var _loc5_:Array = [0,0,0,1,0];
         var _loc6_:Array = new Array();
         _loc6_ = _loc6_.concat(_loc2_);
         _loc6_ = _loc6_.concat(_loc3_);
         _loc6_ = _loc6_.concat(_loc4_);
         _loc6_ = _loc6_.concat(_loc5_);
         _loc1_.matrix = _loc6_;
         return _loc1_;
      }

      override protected function draw() : void {
         var _loc1_:IColorScheme = null;
         var _loc2_:* = NaN;
         super.draw();
         if(this._dataDirty)
         {
            if(data)
            {
               this.visible = true;
               this.selfBg.visible = data.isSelf;
               this.sqadIcon.visible = false;
               _loc1_ = null;
               if(data.isTeamKiller)
               {
                  _loc1_ = App.colorSchemeMgr.getScheme(data.killerID > 0?"teamkiller_dead":"teamkiller");
               }
               else
               {
                  if(data.isOwnSquad)
                  {
                     _loc1_ = App.colorSchemeMgr.getScheme(data.killerID > 0?"selected_dead":"selected");
                  }
                  else
                  {
                     _loc1_ = App.colorSchemeMgr.getScheme(data.killerID > 0?"normal_dead":"normal");
                  }
               }
               App.utils.commons.formatPlayerName(this.playerName,data.playerName,null,null,data.isIGR,"","",_loc1_.rgb,-5);
               this.vehicleIcon.source = data.tankIcon?data.tankIcon:this.vehicleIcon.sourceAlt;
               this.vehicleName.text = data.vehicleName;
               this.xpLbl.text = App.utils.locale.integer(data.xp - data.achievementXP);
               this.damageLbl.text = "0";
               this.fragsLbl.text = " ";
               this.vehicleName.textColor = _loc1_.rgb;
               this.fragsLbl.textColor = this.damageLbl.textColor = 13413751;
               this.deadBg.visible = false;
               this.medalIcon.visible = false;
               if(data.killerID > 0)
               {
                  this.damageLbl.textColor = 6381391;
                  this.deadBg.visible = true;
                  this.vehicleIcon.filters = [this.getDimmFilter()];
               }
               else
               {
                  this.vehicleIcon.filters = [];
               }
               if(data.damageDealt > 0)
               {
                  this.damageLbl.text = App.utils.locale.integer(data.damageDealt);
               }
               if(data.squadID > 0)
               {
                  this.sqadIcon.visible = true;
                  this.sqadIcon.gotoAndStop(data.isOwnSquad?"own":"other");
                  this.sqadIcon.squadLbl.text = data.squadID;
               }
               if(data.kills)
               {
                  this.fragsLbl.htmlText = data.kills;
                  if(this.fragsLbl.text == "0")
                  {
                     this.fragsLbl.text = " ";
                  }
               }
               if(data.tkills > 0)
               {
                  _loc2_ = this.getColorForAlias("teamkiller",65535);
                  this.fragsLbl.htmlText = this.fragsLbl.htmlText + ("(<FONT color=\"#" + _loc2_.toString(16) + "\">" + data.tkills + "</FONT>)");
               }
               if(data.medalsCount > 0)
               {
                  this.medalIcon.value = data.medalsCount;
                  this.medalIcon.validateNow();
                  this.medalIcon.visible = true;
               }
            }
            else
            {
               this.visible = false;
               this.selectable = false;
            }
            this._dataDirty = false;
         }
         this.mouseChildren = true;
      }

      private function getColorForAlias(param1:String, param2:Number) : Number {
         var alias:String = param1;
         var defaultColor:Number = param2;
         var result:Number = undefined;
         try
         {
            result = App.colorSchemeMgr.getRGB(alias);
         }
         catch(e:Error)
         {
            result = defaultColor;
         }
      }
   }

}