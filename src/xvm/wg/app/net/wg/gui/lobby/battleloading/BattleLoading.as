package net.wg.gui.lobby.battleloading
{
   import net.wg.infrastructure.base.meta.impl.BattleLoadingMeta;
   import net.wg.infrastructure.base.meta.IBattleLoadingMeta;
   import net.wg.gui.components.controls.UILoaderAlt;


   public class BattleLoading extends BattleLoadingMeta implements IBattleLoadingMeta
   {
          
      public function BattleLoading() {
         super();
      }

      private static const MAP_BG_IS_INVALID:String = "map_bg_is_invalid";

      private static const PROGRESS_IS_INVALID:String = "progress_is_invalid";

      private static const MAP_NAME_IS_INVALID:String = "map_name_is_invalid";

      private static const BT_NAME_IS_INVALID:String = "battle_type_name_is_invalid";

      private static const BT_FRAME_NUM_IS_INVALID:String = "battle_type_frame_num_is_invalid";

      private static const BT_FRAME_NAME_IS_INVALID:String = "battle_type_frame_name_is_invalid";

      private static const WIN_TEXT_IS_INVALID:String = "win_text_is_invalid";

      private static const TEAMS_IS_INVALID:String = "teams_is_invalid";

      private static const TIP_IS_INVALID:String = "tip_is_invalid";

      private static const TEAM_VALUES_IS_INVALID:String = "team_value_is_invalid";

      public var mapBG:UILoaderAlt;

      public var form:BattleLoadingForm;

      private var mapBgSource:String = "";

      private var progress:Number = 0;

      private var mapName:String = "";

      private var battleTypeName:String;

      private var battleTypeFrameNum:Number = NaN;

      private var battleTypeFrameName:String;

      private var winText:String = "";

      private var teamName1:String = "";

      private var teamName2:String = "";

      private var tip:String = "";

      private var teamValues:Object = null;

      override protected function configUI() : void {
         super.configUI();
      }

      override protected function draw() : void {
         if((isInvalid(MAP_BG_IS_INVALID)) && (this.mapBG))
         {
            this.mapBG.source = this.mapBgSource;
         }
         if((isInvalid(PROGRESS_IS_INVALID)) && (this.form))
         {
            this.form.updateProgress(this.progress);
         }
         if((isInvalid(MAP_NAME_IS_INVALID)) && (this.form))
         {
            this.form.updateMapName(this.mapName);
         }
         if((isInvalid(BT_NAME_IS_INVALID)) && (this.form) && (this.battleTypeName))
         {
            this.form.setBattleTypeName(this.battleTypeName);
         }
         if((isInvalid(BT_FRAME_NUM_IS_INVALID)) && (this.form) && !isNaN(this.battleTypeFrameNum))
         {
            this.form.setBattleTypeFrameNum(this.battleTypeFrameNum);
         }
         if((isInvalid(BT_FRAME_NAME_IS_INVALID)) && (this.form) && (this.battleTypeFrameName))
         {
            this.form.setBattleTypeFrameName(this.battleTypeFrameName);
         }
         if((isInvalid(WIN_TEXT_IS_INVALID)) && (this.form))
         {
            this.form.updateWinText(this.winText);
         }
         if((isInvalid(TEAMS_IS_INVALID)) && (this.form))
         {
            invalidate(TEAMS_IS_INVALID);
            this.form.updateTeamsHeaders(this.teamName1,this.teamName2);
         }
         if((isInvalid(TIP_IS_INVALID)) && (this.form))
         {
            this.form.updateTip(this.tip);
         }
         if((isInvalid(TEAM_VALUES_IS_INVALID)) && (this.form) && (this.teamValues))
         {
            this.form.updateTeamValues(this.teamValues);
         }
      }

      public function as_setMapBG(param1:String) : void {
         if(this.mapBgSource == param1)
         {
            return;
         }
         this.mapBgSource = param1;
         if(this.mapBG)
         {
            this.mapBG.source = this.mapBgSource;
         }
         invalidate(MAP_BG_IS_INVALID);
      }

      public function as_setProgress(param1:Number) : void {
         if(this.progress == param1)
         {
            return;
         }
         this.progress = param1;
         invalidate(PROGRESS_IS_INVALID);
      }

      public function as_setMapName(param1:String) : void {
         if(this.mapName == param1)
         {
            return;
         }
         this.mapName = param1;
         invalidate(MAP_NAME_IS_INVALID);
      }

      public function as_setBattleTypeName(param1:String) : void {
         if(this.battleTypeName == param1)
         {
            return;
         }
         this.battleTypeName = param1;
         invalidate(BT_NAME_IS_INVALID);
      }

      public function as_setBattleTypeFrameNum(param1:Number) : void {
         if(this.battleTypeFrameNum == param1)
         {
            return;
         }
         this.battleTypeFrameNum = param1;
         invalidate(BT_FRAME_NUM_IS_INVALID);
      }

      public function as_setBattleTypeFrameName(param1:String) : void {
         if(this.battleTypeFrameName == param1)
         {
            return;
         }
         this.battleTypeFrameName = param1;
         invalidate(BT_FRAME_NAME_IS_INVALID);
      }

      public function as_setWinText(param1:String) : void {
         if(this.winText == param1)
         {
            return;
         }
         this.winText = param1;
         invalidate(WIN_TEXT_IS_INVALID);
      }

      public function as_setTeams(param1:String, param2:String) : void {
         if(this.teamName1 == param1 || this.teamName2 == param2)
         {
            return;
         }
         this.teamName1 = param1;
         this.teamName2 = param2;
         invalidate(TEAMS_IS_INVALID);
      }

      public function as_setTip(param1:String) : void {
         if(this.tip == param1)
         {
            return;
         }
         this.tip = param1;
         invalidate(TIP_IS_INVALID);
      }

      public function as_setTeamValues(param1:Object) : void {
         this.teamValues = param1;
         invalidate(TEAM_VALUES_IS_INVALID);
      }

      override public function updateStage(param1:Number, param2:Number) : void {
         this.form.x = param1 >> 1;
         this.form.y = param2 - 743 >> 1;
         this.mapBG.x = 0;
         this.mapBG.y = 0;
         var _loc3_:Number = 1920 / 1200;
         var _loc4_:Number = param1 / param2;
         if(_loc3_ > _loc4_)
         {
            this.mapBG.width = param2 * _loc3_;
            this.mapBG.height = param2;
         }
         else
         {
            this.mapBG.width = param1;
            this.mapBG.height = param1 * 1 / _loc3_;
         }
         this.mapBG.x = param1 - this.mapBG.width >> 1;
         this.mapBG.y = param2 - this.mapBG.height >> 1;
      }

      override protected function onDispose() : void {
         super.onDispose();
         this.form.dispose();
      }

      override public function toString() : String {
         return "[WG BattleLoading " + name + "]";
      }

      override protected function onPopulate() : void {
         super.onPopulate();
         getDataS();
         App.contextMenuMgr.hide();
         this.updateStage(App.appWidth,App.appHeight);
      }
   }

}