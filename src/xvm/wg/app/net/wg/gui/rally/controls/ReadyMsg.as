package net.wg.gui.rally.controls
{
    import flash.display.MovieClip;
    import flash.text.TextField;
    
    public class ReadyMsg extends MovieClip
    {
        
        public function ReadyMsg() {
            super();
        }
        
        public var tf:TextField;
        
        public function setMessage(param1:String, param2:String) : void {
            gotoAndStop(param2);
            this.tf.text = param1;
        }
    }
}
