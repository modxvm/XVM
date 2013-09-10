package net.wg.infrastructure.base.meta.impl 
{
    import net.wg.data.constants.*;
    
    public class ResearchMeta extends net.wg.infrastructure.base.meta.impl.ResearchViewMeta
    {
        public function ResearchMeta()
        {
            super();
            return;
        }

        public function requestNationDataS():Boolean
        {
            App.utils.asserter.assertNotNull(this.requestNationData, "requestNationData" + net.wg.data.constants.Errors.CANT_NULL);
            return this.requestNationData();
        }

        public function getResearchItemsDataS(arg1:Number, arg2:Boolean):Object
        {
            App.utils.asserter.assertNotNull(this.getResearchItemsData, "getResearchItemsData" + net.wg.data.constants.Errors.CANT_NULL);
            return this.getResearchItemsData(arg1, arg2);
        }

        public function onResearchItemsDrawnS():void
        {
            App.utils.asserter.assertNotNull(this.onResearchItemsDrawn, "onResearchItemsDrawn" + net.wg.data.constants.Errors.CANT_NULL);
            this.onResearchItemsDrawn();
            return;
        }

        public function request4InstallS(arg1:Number):void
        {
            App.utils.asserter.assertNotNull(this.request4Install, "request4Install" + net.wg.data.constants.Errors.CANT_NULL);
            this.request4Install(arg1);
            return;
        }

        public function requestModuleInfoS(arg1:String):void
        {
            App.utils.asserter.assertNotNull(this.requestModuleInfo, "requestModuleInfo" + net.wg.data.constants.Errors.CANT_NULL);
            this.requestModuleInfo(arg1);
            return;
        }

        public function goToTechTreeS(arg1:String):void
        {
            App.utils.asserter.assertNotNull(this.goToTechTree, "goToTechTree" + net.wg.data.constants.Errors.CANT_NULL);
            this.goToTechTree(arg1);
            return;
        }

        public function exitFromResearchS():void
        {
            App.utils.asserter.assertNotNull(this.exitFromResearch, "exitFromResearch" + net.wg.data.constants.Errors.CANT_NULL);
            this.exitFromResearch();
            return;
        }

        public var requestNationData:Function=null;

        public var getResearchItemsData:Function=null;

        public var onResearchItemsDrawn:Function=null;

        public var request4Install:Function=null;

        public var requestModuleInfo:Function=null;

        public var goToTechTree:Function=null;

        public var exitFromResearch:Function=null;
    }
}
