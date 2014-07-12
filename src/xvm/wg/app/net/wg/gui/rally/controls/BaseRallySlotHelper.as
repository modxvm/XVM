package net.wg.gui.rally.controls
{
    import net.wg.infrastructure.interfaces.IResettable;
    import net.wg.gui.rally.interfaces.IRallySlotVO;
    import flash.display.InteractiveObject;
    
    public class BaseRallySlotHelper extends Object implements ISlotRendererHelper
    {
        
        public function BaseRallySlotHelper() {
            super();
        }
        
        public static var IS_READY:int = 2;
        
        public function initControlsState(param1:RallySimpleSlotRenderer) : void {
            param1.slotLabel.text = "";
            param1.takePlaceBtn.visible = false;
            param1.takePlaceFirstTimeBtn.visible = false;
            param1.vehicleBtn.visible = true;
            IResettable(param1.vehicleBtn).reset();
        }
        
        public function updateComponents(param1:RallySimpleSlotRenderer, param2:IRallySlotVO) : void {
            var _loc3_:* = false;
            if(param1.takePlaceFirstTimeBtn)
            {
                param1.takePlaceFirstTimeBtn.visible = _loc3_;
            }
            if(param1.takePlaceBtn)
            {
                param1.takePlaceBtn.visible = _loc3_;
            }
            if(param2)
            {
                if(param1.contextMenuArea)
                {
                    param1.contextMenuArea.visible = (param2) && (param2.playerObj) && !param2.playerObj.himself;
                }
            }
        }
        
        public function onControlRollOver(param1:InteractiveObject, param2:RallySimpleSlotRenderer, param3:IRallySlotVO, param4:* = null) : void {
            if((param1 == param2.contextMenuArea) && (param3) && (param3.playerObj))
            {
                App.toolTipMgr.show(param3.playerObj.getToolTip());
            }
        }
    }
}
