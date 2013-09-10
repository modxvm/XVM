package net.wg.infrastructure.base.meta.impl 
{
    import net.wg.data.constants.*;
    
    public class TechTreeMeta extends net.wg.infrastructure.base.meta.impl.ResearchViewMeta
    {
        public function TechTreeMeta()
        {
            super();
            return;
        }

        public function requestNationTreeDataS():void
        {
            App.utils.asserter.assertNotNull(this.requestNationTreeData, "requestNationTreeData" + net.wg.data.constants.Errors.CANT_NULL);
            this.requestNationTreeData();
            return;
        }

        public function getNationTreeDataS(arg1:String):Object
        {
            App.utils.asserter.assertNotNull(this.getNationTreeData, "getNationTreeData" + net.wg.data.constants.Errors.CANT_NULL);
            return this.getNationTreeData(arg1);
        }

        public function goToNextVehicleS(arg1:Number):void
        {
            App.utils.asserter.assertNotNull(this.goToNextVehicle, "goToNextVehicle" + net.wg.data.constants.Errors.CANT_NULL);
            this.goToNextVehicle(arg1);
            return;
        }

        public function onCloseTechTreeS():void
        {
            App.utils.asserter.assertNotNull(this.onCloseTechTree, "onCloseTechTree" + net.wg.data.constants.Errors.CANT_NULL);
            this.onCloseTechTree();
            return;
        }

        public var requestNationTreeData:Function=null;

        public var getNationTreeData:Function=null;

        public var goToNextVehicle:Function=null;

        public var onCloseTechTree:Function=null;
    }
}
