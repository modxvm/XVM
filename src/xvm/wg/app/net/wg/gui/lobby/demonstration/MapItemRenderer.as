package net.wg.gui.lobby.demonstration 
{
    import net.wg.data.constants.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.lobby.demonstration.data.*;
    import scaleform.clik.constants.*;
    
    public class MapItemRenderer extends net.wg.gui.components.controls.SoundListItemRenderer
    {
        public function MapItemRenderer()
        {
            super();
            soundType = net.wg.data.constants.SoundTypes.RNDR_NORMAL;
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(scaleform.clik.constants.InvalidationType.DATA) && data) 
            {
                textField.text = net.wg.gui.lobby.demonstration.data.MapItemVO(data).name;
            }
            return;
        }

        public override function setData(arg1:Object):void
        {
            super.setData(arg1);
            invalidate(scaleform.clik.constants.InvalidationType.DATA);
            return;
        }
    }
}
