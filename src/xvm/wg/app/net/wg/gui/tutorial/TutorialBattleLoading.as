package net.wg.gui.tutorial
{
   import net.wg.infrastructure.base.meta.impl.BattleLoadingMeta;
   import net.wg.infrastructure.base.meta.IBattleLoadingMeta;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.tutorial.controls.TutorialBattleLoadingForm;
   import net.wg.gui.events.UILoaderEvent;
   
   public class TutorialBattleLoading extends BattleLoadingMeta implements IBattleLoadingMeta
   {
      
      public function TutorialBattleLoading() {
         super();
      }
      
      private static const FORM_HEIGHT:Number = 752;
      
      public var mapBG:UILoaderAlt;
      
      public var form:TutorialBattleLoadingForm;
      
      override protected function configUI() : void {
         super.configUI();
         App.contextMenuMgr.hide();
         this.mapBG.visible = false;
         this.mapBG.addEventListener(UILoaderEvent.COMPLETE,this.onBackgroundLoaded);
      }
      
      override protected function draw() : void {
         super.draw();
      }
      
      private function onBackgroundLoaded(param1:UILoaderEvent) : void {
         this.updateStage(App.appWidth,App.appHeight);
         this.mapBG.visible = true;
      }
      
      public function as_setMapBG(param1:String) : void {
         this.mapBG.source = param1;
      }
      
      public function as_setProgress(param1:Number) : void {
         this.form.updateProgress(param1);
      }
      
      public function as_setBattleTypeName(param1:String) : void {
         this.form.updateBattleType(param1);
      }
      
      public function as_setMapName(param1:String) : void {
         this.form.updateMapName(param1);
      }
      
      public function as_setWinText(param1:String) : void {
      }
      
      public function as_setTeams(param1:String, param2:String) : void {
      }
      
      public function as_setTip(param1:String) : void {
      }
      
      public function as_setBattleTypeFrameNum(param1:Number) : void {
      }
      
      public function as_setBattleTypeFrameName(param1:String) : void {
      }
      
      public function as_setPlayerData(param1:Number, param2:Number) : void {
      }
      
      public function as_setVehiclesData(param1:Boolean, param2:Array) : void {
      }
      
      public function as_addVehicleInfo(param1:Boolean, param2:Object, param3:Array) : void {
      }
      
      public function as_updateVehicleInfo(param1:Boolean, param2:Object, param3:Array) : void {
      }
      
      public function as_setVehicleStatus(param1:Boolean, param2:Number, param3:uint, param4:Array) : void {
      }
      
      public function as_setPlayerStatus(param1:Boolean, param2:Number, param3:uint) : void {
      }
      
      public function as_setTipTitle(param1:String) : void {
      }
      
      override public function updateStage(param1:Number, param2:Number) : void {
         var _loc3_:Number = Math.max(param1 / 1920,param2 / 1200);
         this.mapBG.scaleX = this.mapBG.scaleY = _loc3_;
         if(this.mapBG.width > 0 && this.mapBG.height > 0)
         {
            this.mapBG.x = param1 - this.mapBG.width >> 1;
            this.mapBG.y = param2 - this.mapBG.height >> 1;
         }
         this.form.x = param1 >> 1;
         this.form.y = param2 - FORM_HEIGHT >> 1;
      }
      
      override protected function onDispose() : void {
         super.onDispose();
         this.mapBG.removeEventListener(UILoaderEvent.COMPLETE,this.onBackgroundLoaded);
         this.mapBG.dispose();
      }
   }
}
