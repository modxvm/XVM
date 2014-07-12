package net.wg.gui.lobby.fortifications.cmp.build.impl
{
    import flash.display.MovieClip;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.text.TextField;
    import net.wg.gui.components.controls.UILoaderAlt;
    
    public class OrderInfoIconCmp extends MovieClip implements IDisposable
    {
        
        public function OrderInfoIconCmp() {
            super();
            this.bgOrderCount.visible = this.orderItemCount.visible = false;
            this.level.visible = false;
        }
        
        public var bgOrderCount:MovieClip;
        
        public var orderItemCount:TextField;
        
        public var level:MovieClip;
        
        public var icon:UILoaderAlt;
        
        public function dispose() : void {
            this.icon.dispose();
            this.icon = null;
            this.bgOrderCount = null;
            this.orderItemCount = null;
            this.level = null;
        }
        
        public function setLevels(param1:int) : void {
            if(param1 > 0)
            {
                this.level.gotoAndStop(param1);
                this.level.visible = true;
            }
        }
        
        public function setSource(param1:String) : void {
            if(param1)
            {
                this.icon.source = param1;
            }
        }
        
        public function setResourceCount(param1:int) : void {
            this.bgOrderCount.visible = this.orderItemCount.visible = !(param1 == -1);
            if(this.orderItemCount.visible)
            {
                this.orderItemCount.text = param1.toString();
            }
        }
    }
}
