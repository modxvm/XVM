package net.wg.gui.cyberSport.controls
{
    import flash.display.MovieClip;
    import flash.text.TextField;
    import flash.display.Sprite;
    
    public class SelectedVehiclesMsg extends MovieClip
    {
        
        public function SelectedVehiclesMsg()
        {
            super();
        }
        
        private static var TF_POS_NORMAL:Number = -140;
        
        private static var TF_POS_WARN:Number = -160;
        
        public var textField:TextField;
        
        public var warningIcon:Sprite;
        
        public function update(param1:String, param2:Boolean = false) : void
        {
            this.textField.htmlText = param1;
            this.warningIcon.visible = param2;
            this.textField.x = param2?TF_POS_WARN:TF_POS_NORMAL;
        }
    }
}
