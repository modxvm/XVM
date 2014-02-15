package controls
{
    import flash.display.*;
    
    import mx.controls.Alert;
    import mx.controls.listClasses.ListItemRenderer;
    import mx.core.*;

    public class ComboBoxItemRenderer extends ListItemRenderer
    {
        [Embed("images/separator.png")]
        private const iconClass:Class;

        override protected function commitProperties():void
        {
            super.commitProperties();

            var type:String = super.data.type;
            if (type)
            {
                if (type.toLowerCase() == "separator")
                {
                    label.text = "";
                    label.visible = false;
                    icon = new iconClass();
                    addChild(DisplayObject(icon));
                    //height = 3; // bug when 2 separators in a list
                    return;
                }
            }
            else
            {
                label.visible = true;
                if (data.bitmap != null && icon == null)
                {
                    icon = new BitmapAsset(data.bitmap);
                    addChild(DisplayObject(icon));
                }
            }
        }

        override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
        {
            super.updateDisplayList(unscaledWidth, unscaledHeight);

            if(super.listData)
            {
                //size the separator in the List
                if (super.data.type == "separator")
                {
                    if (icon)
                    {
                        icon.x = 2;
                        icon.y = (unscaledHeight - icon.measuredHeight) / 2;
                        icon.setActualSize(unscaledWidth - 4, icon.measuredHeight);
                    }
                    return;
                }
            }
       }
    }
}
