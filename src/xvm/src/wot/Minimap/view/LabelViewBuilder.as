import com.xvm.Logger;
import wot.Minimap.view.LabelsContainer;
import flash.geom.Point;
import wot.Minimap.dataTypes.Player;
import wot.Minimap.model.externalProxy.MapConfig;
import wot.Minimap.staticUtils.MinimapMacro;
import wot.PlayersPanel.PlayersPanelProxy;

class wot.Minimap.view.LabelViewBuilder
{
    public static var TEXT_FIELD_NAME:String = "textField";
    
    public static function createTextField(label:MovieClip):Void
    {
        var status:String = label[LabelsContainer.STATUS_FIELD_NAME];
        var playerInfo:Player = label[LabelsContainer.PLAYER_INFO_FIELD_NAME];
        var entryName:String = label[LabelsContainer.ENTRY_NAME_FIELD_NAME];
        var vehicleClass:String = label[LabelsContainer.VEHICLE_CLASS_FIELD_NAME];
        Logger.add("status " + status);
        Logger.addObject(playerInfo, "playerInfo", 2);
        Logger.add("entryName " + entryName);
        Logger.add("vehicleClass " + vehicleClass);
        Logger.add("");
        Logger.add("");
        
        var offset:Point = MapConfig.unitLabelOffset(entryName);

        var textField:TextField = label.createTextField(TEXT_FIELD_NAME, label.getNextHighestDepth(), offset.x, offset.y, 100, 40);
        textField.antiAliasType = "advanced";
        textField.html = true;
        textField.multiline = true;
        textField.selectable = false;

        var style:TextField.StyleSheet = new TextField.StyleSheet();
        style.parseCSS(MapConfig.unitLabelCss(entryName));
        textField.styleSheet = style;

        var text:String = getText(entryName, playerInfo, vehicleClass);
        if (text == "undefined" || !text)
        {
            /**
             * Skip creation of textFields with "undefined" string.
             * Happens for oneSelf icon at replay rewind.
             */
            text = "";
        }
        textField.htmlText = text;

        if (MapConfig.unitShadowEnabled(entryName))
        {
            textField.filters = [MapConfig.unitShadow(entryName)];
        }

        textField._alpha = MapConfig.unitLabelAlpha(entryName);
    }

    // -- Private

    private static function getText(entryName:String, player:Player, vehicleClass:String):String
    {
        var format:String = MapConfig.unitLabelFormat(entryName);

        return MinimapMacro.process(format, player, vehicleClass);
    }
}