package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;


   public class ResearchMeta extends ResearchViewMeta
   {
          
      public function ResearchMeta() {
         super();
      }

      public var requestNationData:Function = null;

      public var getResearchItemsData:Function = null;

      public var onResearchItemsDrawn:Function = null;

      public var request4Install:Function = null;

      public var requestModuleInfo:Function = null;

      public var goToTechTree:Function = null;

      public var exitFromResearch:Function = null;

      public function requestNationDataS() : Boolean {
         App.utils.asserter.assertNotNull(this.requestNationData,"requestNationData" + Errors.CANT_NULL);
         return this.requestNationData();
      }

      public function getResearchItemsDataS(param1:Number, param2:Boolean) : Object {
         App.utils.asserter.assertNotNull(this.getResearchItemsData,"getResearchItemsData" + Errors.CANT_NULL);
         return this.getResearchItemsData(param1,param2);
      }

      public function onResearchItemsDrawnS() : void {
         App.utils.asserter.assertNotNull(this.onResearchItemsDrawn,"onResearchItemsDrawn" + Errors.CANT_NULL);
         this.onResearchItemsDrawn();
      }

      public function request4InstallS(param1:Number) : void {
         App.utils.asserter.assertNotNull(this.request4Install,"request4Install" + Errors.CANT_NULL);
         this.request4Install(param1);
      }

      public function requestModuleInfoS(param1:String) : void {
         App.utils.asserter.assertNotNull(this.requestModuleInfo,"requestModuleInfo" + Errors.CANT_NULL);
         this.requestModuleInfo(param1);
      }

      public function goToTechTreeS(param1:String) : void {
         App.utils.asserter.assertNotNull(this.goToTechTree,"goToTechTree" + Errors.CANT_NULL);
         this.goToTechTree(param1);
      }

      public function exitFromResearchS() : void {
         App.utils.asserter.assertNotNull(this.exitFromResearch,"exitFromResearch" + Errors.CANT_NULL);
         this.exitFromResearch();
      }
   }

}