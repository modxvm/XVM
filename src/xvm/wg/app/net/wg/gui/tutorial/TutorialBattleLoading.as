package net.wg.gui.tutorial 
{
    import net.wg.gui.components.controls.*;
    import net.wg.gui.events.*;
    import net.wg.gui.tutorial.controls.*;
    import net.wg.infrastructure.base.meta.*;
    import net.wg.infrastructure.base.meta.impl.*;
    
    public class TutorialBattleLoading extends net.wg.infrastructure.base.meta.impl.BattleLoadingMeta implements net.wg.infrastructure.base.meta.IBattleLoadingMeta
    {
        public function TutorialBattleLoading()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            getDataS();
            App.contextMenuMgr.hide();
            this.mapBG.visible = false;
            this.mapBG.addEventListener(net.wg.gui.events.UILoaderEvent.COMPLETE, this.onBackgroundLoaded);
            return;
        }

        protected override function draw():void
        {
            super.draw();
            return;
        }

        internal function onBackgroundLoaded(arg1:net.wg.gui.events.UILoaderEvent):void
        {
            this.updateStage(App.appWidth, App.appHeight);
            this.mapBG.visible = true;
            return;
        }

        public function as_setMapBG(arg1:String):void
        {
            this.mapBG.source = arg1;
            return;
        }

        public function as_setProgress(arg1:Number):void
        {
            this.form.updateProgress(arg1);
            return;
        }

        public function as_setBattleTypeName(arg1:String):void
        {
            this.form.updateBattleType(arg1);
            return;
        }

        public function as_setMapName(arg1:String):void
        {
            this.form.updateMapName(arg1);
            return;
        }

        public function as_setWinText(arg1:String):void
        {
            return;
        }

        public function as_setTeams(arg1:String, arg2:String):void
        {
            return;
        }

        public function as_setTeamValues(arg1:Object):void
        {
            return;
        }

        public function as_setTip(arg1:String):void
        {
            return;
        }

        public function as_setBattleTypeFrameNum(arg1:Number):void
        {
            return;
        }

        public function as_setBattleTypeFrameName(arg1:String):void
        {
            return;
        }

        public override function updateStage(arg1:Number, arg2:Number):void
        {
            var loc1:*=Math.max(arg1 / 1920, arg2 / 1200);
            var loc2:*;
            this.mapBG.scaleY = loc2 = loc1;
            this.mapBG.scaleX = loc2;
            if (this.mapBG.width > 0 && this.mapBG.height > 0) 
            {
                this.mapBG.x = arg1 - this.mapBG.width >> 1;
                this.mapBG.y = arg2 - this.mapBG.height >> 1;
            }
            this.form.x = arg1 >> 1;
            this.form.y = arg2 - FORM_HEIGHT >> 1;
            return;
        }

        protected override function onDispose():void
        {
            super.onDispose();
            this.mapBG.removeEventListener(net.wg.gui.events.UILoaderEvent.COMPLETE, this.onBackgroundLoaded);
            this.mapBG.dispose();
            return;
        }

        internal static const FORM_HEIGHT:Number=752;

        public var mapBG:net.wg.gui.components.controls.UILoaderAlt;

        public var form:net.wg.gui.tutorial.controls.TutorialBattleLoadingForm;
    }
}
