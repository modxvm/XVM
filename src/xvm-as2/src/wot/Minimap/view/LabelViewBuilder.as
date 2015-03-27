import com.xvm.*;
import flash.geom.*;
import wot.Minimap.*;
import wot.Minimap.dataTypes.*;
import wot.Minimap.model.externalProxy.*;
import wot.Minimap.view.*;

class wot.Minimap.view.LabelViewBuilder
{
    public static var TEXT_FIELD_NAME:String = "textField";

    private static var TF_DEPTH:Number = 100;

    public static function createTextField(label:MovieClip):Void
    {
        removeTextField(label);

        var status:Number = label[LabelsContainer.STATUS_FIELD_NAME];
        var playerInfo:Player = label[LabelsContainer.PLAYER_INFO_FIELD_NAME];
        var entryName:String = label[LabelsContainer.ENTRY_NAME_FIELD_NAME];
        var vehicleClass:String = label[LabelsContainer.VEHICLE_CLASS_FIELD_NAME];

        var offset:Point = MapConfig.unitLabelOffset(entryName, status);

        var textField:TextField = label.createTextField(TEXT_FIELD_NAME, TF_DEPTH, offset.x, offset.y, 100, 40);
        label[TEXT_FIELD_NAME] = textField;
        textField.antiAliasType = Config.config.minimap.labels.units.antiAliasType;
        textField.html = true;
        textField.multiline = true;
        textField.selectable = false;

        var style:TextField.StyleSheet = new TextField.StyleSheet();
        style.parseCSS(MapConfig.unitLabelCss(entryName, status));
        textField.styleSheet = style;

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

        updateTextField(label);
    }

    public static function updateTextField(label:MovieClip):Void
    {
        var textField:TextField = label[TEXT_FIELD_NAME];
        if (textField == null)
            return;

        var status:Number = label[LabelsContainer.STATUS_FIELD_NAME];
        var playerInfo:Player = label[LabelsContainer.PLAYER_INFO_FIELD_NAME];
        var entryName:String = label[LabelsContainer.ENTRY_NAME_FIELD_NAME];

        var format:String = MapConfig.unitLabelFormat(entryName, status);

        var obj = { };
        var playerState = BattleState.getUserData(playerInfo.userName);
        for (var i in playerState)
            obj[i] = playerState[i];
        for (var i in playerInfo)
            obj[i] = playerInfo[i];
        var text:String = Macros.Format(playerInfo.userName, format, obj);
        //Logger.add(text);
        textField.htmlText = text;

        /*var scale:Number = IconsProxy.selfEntry.wrapper._xscale;
        if (textField._xscale != scale)
        {
            //Logger.add("rescale: " + textField._xscale + " => " + scale);
            textField._xscale = textField._yscale = scale;
        }*/
    }

    public static function removeTextField(label:MovieClip):Void
    {
        var textField:TextField = label[TEXT_FIELD_NAME];
        if (textField == null)
            return;
        textField.removeTextField();
        label[TEXT_FIELD_NAME] = null;
    }
}
