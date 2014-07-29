package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.AbstractView;
    import net.wg.data.constants.Errors;
    
    public class VehicleCustomizationMeta extends AbstractView
    {
        
        public function VehicleCustomizationMeta()
        {
            super();
        }
        
        public var dropCurrentItemInSection:Function = null;
        
        public var applyCustomization:Function = null;
        
        public var setNewItemId:Function = null;
        
        public var getCurrentItem:Function = null;
        
        public var getItemCost:Function = null;
        
        public var closeWindow:Function = null;
        
        public function dropCurrentItemInSectionS(param1:String, param2:Number) : void
        {
            App.utils.asserter.assertNotNull(this.dropCurrentItemInSection,"dropCurrentItemInSection" + Errors.CANT_NULL);
            this.dropCurrentItemInSection(param1,param2);
        }
        
        public function applyCustomizationS(param1:Array) : void
        {
            App.utils.asserter.assertNotNull(this.applyCustomization,"applyCustomization" + Errors.CANT_NULL);
            this.applyCustomization(param1);
        }
        
        public function setNewItemIdS(param1:String, param2:Number, param3:Number, param4:Number) : void
        {
            App.utils.asserter.assertNotNull(this.setNewItemId,"setNewItemId" + Errors.CANT_NULL);
            this.setNewItemId(param1,param2,param3,param4);
        }
        
        public function getCurrentItemS(param1:String) : Object
        {
            App.utils.asserter.assertNotNull(this.getCurrentItem,"getCurrentItem" + Errors.CANT_NULL);
            return this.getCurrentItem(param1);
        }
        
        public function getItemCostS(param1:String, param2:Number, param3:Number) : Object
        {
            App.utils.asserter.assertNotNull(this.getItemCost,"getItemCost" + Errors.CANT_NULL);
            return this.getItemCost(param1,param2,param3);
        }
        
        public function closeWindowS() : void
        {
            App.utils.asserter.assertNotNull(this.closeWindow,"closeWindow" + Errors.CANT_NULL);
            this.closeWindow();
        }
    }
}
