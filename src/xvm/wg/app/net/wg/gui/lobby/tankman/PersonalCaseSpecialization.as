package net.wg.gui.lobby.tankman
{
    import scaleform.clik.core.UIComponent;
    import net.wg.gui.components.controls.UILoaderAlt;
    import flash.text.TextField;
    import scaleform.clik.constants.InvalidationType;
    
    public class PersonalCaseSpecialization extends UIComponent
    {
        
        public function PersonalCaseSpecialization()
        {
            super();
        }
        
        public var contourIcon:UILoaderAlt;
        
        public var vehicleType:TextField;
        
        private var _vType:String = "";
        
        private var _vIco:String = "";
        
        override protected function configUI() : void
        {
            super.configUI();
        }
        
        override protected function onDispose() : void
        {
            super.onDispose();
            this.contourIcon.dispose();
        }
        
        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.DATA))
            {
                this.vehicleType.text = this._vType;
                this.contourIcon.source = this._vIco;
            }
        }
        
        public function setData(param1:String, param2:String) : void
        {
            this._vType = param1;
            this._vIco = param2;
            this.contourIcon.visible = !(this._vIco == null);
            invalidateData();
        }
    }
}
