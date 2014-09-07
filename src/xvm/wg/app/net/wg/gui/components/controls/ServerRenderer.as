package net.wg.gui.components.controls
{
    import scaleform.clik.utils.Constraints;
    import net.wg.gui.components.common.serverStats.ServerVO;
    import scaleform.clik.constants.InvalidationType;
    
    public class ServerRenderer extends SoundListItemRenderer
    {
        
        public function ServerRenderer()
        {
            super();
        }
        
        public var serverIndicator:ServerIndicator;
        
        override protected function configUI() : void
        {
            super.configUI();
            constraints.addElement(this.serverIndicator.name,this.serverIndicator,Constraints.RIGHT);
        }
        
        override protected function onDispose() : void
        {
            this.serverIndicator.dispose();
            super.onDispose();
        }
        
        override public function setData(param1:Object) : void
        {
            this.data = param1;
            invalidateData();
        }
        
        override protected function draw() : void
        {
            var _loc1_:ServerVO = null;
            if(isInvalid(InvalidationType.DATA))
            {
                if(data)
                {
                    _loc1_ = data as ServerVO;
                    this.serverIndicator.setState(_loc1_.csisStatus);
                    this.serverIndicator.validateNow();
                    enabled = !(_loc1_.csisStatus == ServerIndicator.NOT_AVAILABLE);
                    this.visible = true;
                }
                else
                {
                    this.visible = false;
                }
            }
            super.draw();
        }
    }
}
