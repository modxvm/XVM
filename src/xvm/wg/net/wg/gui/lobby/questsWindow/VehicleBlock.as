package net.wg.gui.lobby.questsWindow 
{
    import flash.display.*;
    import flash.text.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.lobby.questsWindow.data.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.core.*;
    
    public class VehicleBlock extends scaleform.clik.core.UIComponent
    {
        public function VehicleBlock()
        {
            super();
            return;
        }

        public function setData(arg1:Object):void
        {
            this.tankData = new net.wg.gui.lobby.questsWindow.data.VehicleBlockVO(arg1);
            invalidateData();
            return;
        }

        protected override function draw():void
        {
            if (isInvalid(scaleform.clik.constants.InvalidationType.DATA)) 
            {
                this.nationIcon.source = this.tankData.nationIconPath;
                this.typeIcon.source = this.tankData.typeIconPath;
                this.levelMC.gotoAndStop(this.tankData.vLevel);
                this.tankSmallIcon.source = this.tankData.vIconSmall;
                this.vehicleTF.text = this.tankData.vName;
            }
            return;
        }

        public override function dispose():void
        {
            if (this.nationIcon) 
            {
                this.nationIcon.dispose();
                this.nationIcon = null;
            }
            if (this.typeIcon) 
            {
                this.typeIcon.dispose();
                this.typeIcon = null;
            }
            this.levelMC = null;
            if (this.tankSmallIcon) 
            {
                this.tankSmallIcon.dispose();
                this.tankSmallIcon = null;
            }
            if (this.tankData) 
            {
                this.tankData.dispose();
                this.tankData = null;
            }
            this.vehicleTF = null;
            super.dispose();
            return;
        }

        public var nationIcon:net.wg.gui.components.controls.UILoaderAlt;

        public var typeIcon:net.wg.gui.components.controls.UILoaderAlt;

        public var levelMC:flash.display.MovieClip;

        public var tankSmallIcon:net.wg.gui.components.controls.UILoaderAlt;

        public var vehicleTF:flash.text.TextField;

        internal var tankData:net.wg.gui.lobby.questsWindow.data.VehicleBlockVO=null;
    }
}
