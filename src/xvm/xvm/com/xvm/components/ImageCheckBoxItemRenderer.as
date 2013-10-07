/**
* ...
* @author STL1te
*/
package com.xvm.components
{
    import com.xvm.*;
    import com.xvm.utils.*;
    import flash.display.*;
    import flash.geom.*;
    import net.wg.gui.components.controls.CheckBox;
    import net.wg.gui.events.*;

    public class ImageCheckBoxItemRenderer extends ListItemRedererImageText // from controls.swf
    {
        public var checkBox:CheckBox;

        public function ImageCheckBoxItemRenderer()
        {
            super();
            this.icon.autoSize = false;
        }

        override protected function configUI():void
        {
            super.configUI();

            this.checkBox = this.addChildAt(App.utils.classFactory.getComponent("CheckBox", CheckBox), 5) as CheckBox;
            this.checkBox.label = "";
            this.checkBox.x = 45;
            this.checkBox.setActualSize(40, 20);
            this.width = 148;
            this.parent.scrollRect = new Rectangle(0, 0, 93, 220);
        }

        override protected function draw():void
        {
            super.draw();
            this.checkBox.selected = this.selected = this.data.selected;
            return;
        }

        override protected function completeLoadA(event:UILoaderEvent):void
        {
            super.completeLoadA(event);
            var loader:* = this.icon.getChildAt(1);
            var iconWidth:Number = loader.content.width >> 1;
            this.icon.x = int(this.ico_border.x + (this.ico_border.width >> 1) - iconWidth);
        }
    }

}
