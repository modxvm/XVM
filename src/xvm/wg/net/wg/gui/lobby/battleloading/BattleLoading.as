package net.wg.gui.lobby.battleloading 
{
    import net.wg.gui.components.controls.*;
    import net.wg.infrastructure.base.meta.*;
    import net.wg.infrastructure.base.meta.impl.*;
    
    public class BattleLoading extends net.wg.infrastructure.base.meta.impl.BattleLoadingMeta implements net.wg.infrastructure.base.meta.IBattleLoadingMeta
    {
        public function BattleLoading()
        {
            super();
            return;
        }

        public function as_setProgress(arg1:Number):void
        {
            if (this.progress == arg1) 
            {
                return;
            }
            this.progress = arg1;
            invalidate(PROGRESS_IS_INVALID);
            return;
        }

        public function as_setMapName(arg1:String):void
        {
            if (this.mapName == arg1) 
            {
                return;
            }
            this.mapName = arg1;
            invalidate(MAP_NAME_IS_INVALID);
            return;
        }

        public function as_setBattleTypeName(arg1:String):void
        {
            if (this.battleTypeName == arg1) 
            {
                return;
            }
            this.battleTypeName = arg1;
            invalidate(BT_NAME_IS_INVALID);
            return;
        }

        public function as_setBattleTypeFrameNum(arg1:Number):void
        {
            if (this.battleTypeFrameNum == arg1) 
            {
                return;
            }
            this.battleTypeFrameNum = arg1;
            invalidate(BT_FRAME_NUM_IS_INVALID);
            return;
        }

        public function as_setBattleTypeFrameName(arg1:String):void
        {
            if (this.battleTypeFrameName == arg1) 
            {
                return;
            }
            this.battleTypeFrameName = arg1;
            invalidate(BT_FRAME_NAME_IS_INVALID);
            return;
        }

        public function as_setWinText(arg1:String):void
        {
            if (this.winText == arg1) 
            {
                return;
            }
            this.winText = arg1;
            invalidate(WIN_TEXT_IS_INVALID);
            return;
        }

        public function as_setTeams(arg1:String, arg2:String):void
        {
            if (this.teamName1 == arg1 || this.teamName2 == arg2) 
            {
                return;
            }
            this.teamName1 = arg1;
            this.teamName2 = arg2;
            invalidate(TEAMS_IS_INVALID);
            return;
        }

        public function as_setTip(arg1:String):void
        {
            if (this.tip == arg1) 
            {
                return;
            }
            this.tip = arg1;
            invalidate(TIP_IS_INVALID);
            return;
        }

        public function as_setTeamValues(arg1:Object):void
        {
            this.teamValues = arg1;
            invalidate(TEAM_VALUES_IS_INVALID);
            return;
        }

        public override function updateStage(arg1:Number, arg2:Number):void
        {
            this.form.x = arg1 >> 1;
            this.form.y = arg2 - 743 >> 1;
            this.mapBG.x = 0;
            this.mapBG.y = 0;
            var loc1:*=1920 / 1200;
            var loc2:*=arg1 / arg2;
            if (loc1 > loc2) 
            {
                this.mapBG.width = arg2 * loc1;
                this.mapBG.height = arg2;
            }
            else 
            {
                this.mapBG.width = arg1;
                this.mapBG.height = arg1 * 1 / loc1;
            }
            this.mapBG.x = arg1 - this.mapBG.width >> 1;
            this.mapBG.y = arg2 - this.mapBG.height >> 1;
            return;
        }

        protected override function onDispose():void
        {
            super.onDispose();
            this.form.onDispose();
            return;
        }

        public override function toString():String
        {
            return "[WG BattleLoading " + name + "]";
        }

        protected override function onPopulate():void
        {
            super.onPopulate();
            getDataS();
            App.contextMenuMgr.hide();
            this.updateStage(App.appWidth, App.appHeight);
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            return;
        }

        protected override function draw():void
        {
            if (isInvalid(MAP_BG_IS_INVALID) && this.mapBG) 
            {
                this.mapBG.source = this.mapBgSource;
            }
            if (isInvalid(PROGRESS_IS_INVALID) && this.form) 
            {
                this.form.updateProgress(this.progress);
            }
            if (isInvalid(MAP_NAME_IS_INVALID) && this.form) 
            {
                this.form.updateMapName(this.mapName);
            }
            if (isInvalid(BT_NAME_IS_INVALID) && this.form && this.battleTypeName) 
            {
                this.form.setBattleTypeName(this.battleTypeName);
            }
            if (isInvalid(BT_FRAME_NUM_IS_INVALID) && this.form && !isNaN(this.battleTypeFrameNum)) 
            {
                this.form.setBattleTypeFrameNum(this.battleTypeFrameNum);
            }
            if (isInvalid(BT_FRAME_NAME_IS_INVALID) && this.form && this.battleTypeFrameName) 
            {
                this.form.setBattleTypeFrameName(this.battleTypeFrameName);
            }
            if (isInvalid(WIN_TEXT_IS_INVALID) && this.form) 
            {
                this.form.updateWinText(this.winText);
            }
            if (isInvalid(TEAMS_IS_INVALID) && this.form) 
            {
                invalidate(TEAMS_IS_INVALID);
                this.form.updateTeamsHeaders(this.teamName1, this.teamName2);
            }
            if (isInvalid(TIP_IS_INVALID) && this.form) 
            {
                this.form.updateTip(this.tip);
            }
            if (isInvalid(TEAM_VALUES_IS_INVALID) && this.form) 
            {
                this.form.updateTeamValues(this.teamValues);
            }
            return;
        }

        public function as_setMapBG(arg1:String):void
        {
            if (this.mapBgSource == arg1) 
            {
                return;
            }
            this.mapBgSource = arg1;
            invalidate(MAP_BG_IS_INVALID);
            return;
        }

        internal static const MAP_BG_IS_INVALID:String="map_bg_is_invalid";

        internal static const PROGRESS_IS_INVALID:String="progress_is_invalid";

        internal static const MAP_NAME_IS_INVALID:String="map_name_is_invalid";

        internal static const BT_NAME_IS_INVALID:String="battle_type_name_is_invalid";

        internal static const BT_FRAME_NUM_IS_INVALID:String="battle_type_frame_num_is_invalid";

        internal static const BT_FRAME_NAME_IS_INVALID:String="battle_type_frame_name_is_invalid";

        internal static const WIN_TEXT_IS_INVALID:String="win_text_is_invalid";

        internal static const TEAMS_IS_INVALID:String="teams_is_invalid";

        internal static const TIP_IS_INVALID:String="tip_is_invalid";

        internal static const TEAM_VALUES_IS_INVALID:String="team_value_is_invalid";

        public var mapBG:net.wg.gui.components.controls.UILoaderAlt;

        public var form:net.wg.gui.lobby.battleloading.BattleLoadingForm;

        internal var mapBgSource:String="";

        internal var progress:Number=0;

        internal var mapName:String="";

        internal var battleTypeName:String;

        internal var battleTypeFrameNum:Number=NaN;

        internal var battleTypeFrameName:String;

        internal var winText:String="";

        internal var teamName1:String="";

        internal var teamName2:String="";

        internal var tip:String="";

        internal var teamValues:Object="";
    }
}
