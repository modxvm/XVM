package net.wg.infrastructure.base.meta.impl
{
    import net.wg.data.constants.Errors;
    
    public class TechTreeMeta extends ResearchViewMeta
    {
        
        public function TechTreeMeta()
        {
            super();
        }
        
        public var requestNationTreeData:Function = null;
        
        public var getNationTreeData:Function = null;
        
        public var goToNextVehicle:Function = null;
        
        public var onCloseTechTree:Function = null;
        
        public function requestNationTreeDataS() : void
        {
            App.utils.asserter.assertNotNull(this.requestNationTreeData,"requestNationTreeData" + Errors.CANT_NULL);
            this.requestNationTreeData();
        }
        
        public function getNationTreeDataS(param1:String) : Object
        {
            App.utils.asserter.assertNotNull(this.getNationTreeData,"getNationTreeData" + Errors.CANT_NULL);
            return this.getNationTreeData(param1);
        }
        
        public function goToNextVehicleS(param1:Number) : void
        {
            App.utils.asserter.assertNotNull(this.goToNextVehicle,"goToNextVehicle" + Errors.CANT_NULL);
            this.goToNextVehicle(param1);
        }
        
        public function onCloseTechTreeS() : void
        {
            App.utils.asserter.assertNotNull(this.onCloseTechTree,"onCloseTechTree" + Errors.CANT_NULL);
            this.onCloseTechTree();
        }
    }
}
