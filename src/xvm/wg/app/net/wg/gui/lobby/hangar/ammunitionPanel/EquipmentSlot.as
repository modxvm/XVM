package net.wg.gui.lobby.hangar.ammunitionPanel 
{
    import net.wg.data.constants.*;
    import net.wg.gui.components.controls.*;
    
    public class EquipmentSlot extends net.wg.gui.lobby.hangar.ammunitionPanel.DeviceSlot
    {
        public function EquipmentSlot()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            if (this.icon) 
            {
                var loc1:*;
                this.icon.mouseChildren = loc1 = false;
                this.icon.mouseEnabled = loc1;
            }
            return;
        }

        public override function dispose():void
        {
            this.icon.dispose();
            super.dispose();
            return;
        }

        public function setIcon(arg1:String, arg2:Boolean):void
        {
            this.icon.source = arg1;
            locked.visible = !arg2;
            return;
        }

        protected override function applyIconData(arg1:*):void
        {
            if (arg1) 
            {
                this.setIcon(arg1.icon, arg1.removable);
            }
            else 
            {
                this.setIcon(net.wg.data.constants.FittingTypes.EMPTY_ARTIFACT_ICON, true);
            }
            return;
        }

        public var icon:net.wg.gui.components.controls.UILoaderAlt;
    }
}
