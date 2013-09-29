package net.wg.infrastructure.base.meta.impl 
{
    import net.wg.data.constants.*;
    import net.wg.infrastructure.base.*;
    
    public class VehicleCustomizationMeta extends net.wg.infrastructure.base.AbstractView
    {
        public function VehicleCustomizationMeta()
        {
            super();
            return;
        }

        public function dropCurrentItemInSectionS(arg1:String, arg2:Number):void
        {
            App.utils.asserter.assertNotNull(this.dropCurrentItemInSection, "dropCurrentItemInSection" + net.wg.data.constants.Errors.CANT_NULL);
            this.dropCurrentItemInSection(arg1, arg2);
            return;
        }

        public function applyCustomizationS(arg1:Array):void
        {
            App.utils.asserter.assertNotNull(this.applyCustomization, "applyCustomization" + net.wg.data.constants.Errors.CANT_NULL);
            this.applyCustomization(arg1);
            return;
        }

        public function setNewItemIdS(arg1:String, arg2:Number, arg3:Number, arg4:Number):void
        {
            App.utils.asserter.assertNotNull(this.setNewItemId, "setNewItemId" + net.wg.data.constants.Errors.CANT_NULL);
            this.setNewItemId(arg1, arg2, arg3, arg4);
            return;
        }

        public function getCurrentItemS(arg1:String):Object
        {
            App.utils.asserter.assertNotNull(this.getCurrentItem, "getCurrentItem" + net.wg.data.constants.Errors.CANT_NULL);
            return this.getCurrentItem(arg1);
        }

        public function getItemCostS(arg1:String, arg2:Number, arg3:Number):Object
        {
            App.utils.asserter.assertNotNull(this.getItemCost, "getItemCost" + net.wg.data.constants.Errors.CANT_NULL);
            return this.getItemCost(arg1, arg2, arg3);
        }

        public function closeWindowS():void
        {
            App.utils.asserter.assertNotNull(this.closeWindow, "closeWindow" + net.wg.data.constants.Errors.CANT_NULL);
            this.closeWindow();
            return;
        }

        public var dropCurrentItemInSection:Function=null;

        public var applyCustomization:Function=null;

        public var setNewItemId:Function=null;

        public var getCurrentItem:Function=null;

        public var getItemCost:Function=null;

        public var closeWindow:Function=null;
    }
}
