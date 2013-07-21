import com.xvm.Logger;
import flash.geom.Point;
import wot.Minimap.dataTypes.Player;
import wot.Minimap.model.externalProxy.MapConfig;
import wot.Minimap.staticUtils.MinimapMacro;
import wot.Minimap.view.LabelsContainer;

class wot.Minimap.view.LabelViewBuilder
{
    public static var TEXT_FIELD_NAME:String = "textField";
    
    private static var TF_DEPTH:Number = 100;
    
    public static function createTextField(label:MovieClip):Void
    {
        var status:Number = label[LabelsContainer.STATUS_FIELD_NAME];
        var playerInfo:Player = label[LabelsContainer.PLAYER_INFO_FIELD_NAME];
        var entryName:String = label[LabelsContainer.ENTRY_NAME_FIELD_NAME];
        var vehicleClass:String = label[LabelsContainer.VEHICLE_CLASS_FIELD_NAME];
        
        var offset:Point = MapConfig.unitLabelOffset(entryName, status);

        var textField:TextField = label.createTextField(TEXT_FIELD_NAME, TF_DEPTH, offset.x, offset.y, 100, 40);
        textField.antiAliasType = "advanced";
        textField.html = true;
        textField.multiline = true;
        textField.selectable = false;

        var style:TextField.StyleSheet = new TextField.StyleSheet();
        style.parseCSS(MapConfig.unitLabelCss(entryName, status));
        textField.styleSheet = style;

        var format:String = MapConfig.unitLabelFormat(entryName, status);
        var text:String = MinimapMacro.process(format, playerInfo, vehicleClass);
        if (text == "undefined" || !text)
        {
            /**
             * Skip creation of textFields with "undefined" string.
             * Happens for oneSelf icon at replay rewind.
             */
            text = "";
        }
        textField.htmlText = text;

        if (MapConfig.unitShadowEnabled(entryName, status))
        {
            textField.filters = [MapConfig.unitShadow(entryName, status)];
        }

        textField._alpha = MapConfig.unitLabelAlpha(entryName, status);
        
        if (!MapConfig.lostEnemyEnabled && status == Player.PLAYER_LOST)
        {
            /**
             * In case user does not want to see labels for lost
             * just make it fully transparent.
             * 
             * Removing text field or label is not suitable
             * for current label management algorithm.
             */
            textField._alpha = 0;
        }
    }
}
