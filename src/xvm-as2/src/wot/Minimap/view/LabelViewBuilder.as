import com.xvm.*;
import flash.geom.*;
import flash.filters.*;
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

        var offset:Point = unitLabelOffset(entryName, status);

        var textField:TextField = label.createTextField(TEXT_FIELD_NAME, TF_DEPTH, offset.x, offset.y, 100, 40);
        label[TEXT_FIELD_NAME] = textField;
        textField.antiAliasType = Config.config.minimap.labels.units.antiAliasType;
        textField.html = true;
        textField.multiline = true;
        textField.selectable = false;

        var style:TextField.StyleSheet = new TextField.StyleSheet();
        style.parseCSS(unitLabelCss(entryName, status));
        textField.styleSheet = style;

        if (unitShadowEnabled(entryName, status))
        {
            textField.filters = [unitShadow(entryName, status)];
        }

        textField._alpha = unitLabelAlpha(entryName, status);

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

        var format:String = unitLabelFormat(entryName, status);

        var obj = { };
        var playerState = BattleState.getUserData(playerInfo.userName);
        for (var i in playerInfo)
            obj[i] = playerInfo[i];
        for (var i in playerState)
            obj[i] = playerState[i];
        var text:String = Macros.Format(playerInfo.userName, format, obj);
        //Logger.add(playerInfo.userName + ": " + text);
        textField.htmlText = text;
    }

    public static function removeTextField(label:MovieClip):Void
    {
        var textField:TextField = label[TEXT_FIELD_NAME];
        if (textField == null)
            return;
        textField.removeTextField();
        label[TEXT_FIELD_NAME] = null;
    }

    // PRIVATE

    // TODO: REFACTOR AND REMOVE


    /** Translate internal WG entryName and unit status(dead\tk) to minimap config file entry */
    private static function defineCfgProperty(wgEntryName:String, status:Number):String
    {
        /** Prefix: lost dead or alive */
        var xvmPrefix:String;

        if ((status & Player.STATUS_MASK) == Player.PLAYER_LOST)
            xvmPrefix = "lost";
        else if ((status & Player.STATUS_MASK) == Player.PLAYER_DEAD)
            xvmPrefix = "dead";
        else
            xvmPrefix = "";

        /** Postfix: ally, enemy, tk or squad */
        var xvmPostfix:String;

        if (wgEntryName == "squadman")
            xvmPostfix = "squad"; /** Translate squad WG entry name to squad XVM entry name */
        else
            xvmPostfix = wgEntryName;

        if ((status & Player.TEAM_KILLER_FLAG) && wgEntryName == "ally") /** <- Skip enemy and squad TK */
            xvmPostfix = "teamkiller";

        /** Result */
        var xvmFullEntry:String;

        if (wgEntryName == "player")
            xvmFullEntry = "oneself";
        else
            xvmFullEntry = xvmPrefix + xvmPostfix;

        if (xvmFullEntry == "lostenemy")
            xvmFullEntry = "lost"; // Backwards config compatibility

        return xvmFullEntry;
    }

    private static function unitLabelOffset(entryName:String, status:Number)
    {
        var unitType:String = defineCfgProperty(entryName, status);
        return new Point(Config.config.minimap.labels.units.offset[unitType].x, Config.config.minimap.labels.units.offset[unitType].y);
    }

    public static function unitLabelCss(entryName:String, status:Number)
    {
        var unitType:String = defineCfgProperty(entryName, status);
        return Config.config.minimap.labels.units.css[unitType];
    }

    public static function unitShadowEnabled(entryName:String, status:Number):Boolean
    {
        var unitType:String = defineCfgProperty(entryName, status);
        return Config.config.minimap.labels.units.shadow[unitType].enabled;
    }

    public static function unitShadow(entryName:String, status:Number):DropShadowFilter
    {
        var unitType:String = defineCfgProperty(entryName, status);
        return Utils.extractShadowFilter(Config.config.minimap.labels.units.shadow[unitType]);
    }

    public static function unitLabelAlpha(entryName:String, status:Number)
    {
        var unitType:String = defineCfgProperty(entryName, status);
        return Config.config.minimap.labels.units.alpha[unitType];
    }

    public static function unitLabelFormat(entryName:String, status:Number)
    {
        var unitType:String = defineCfgProperty(entryName, status);
        return Config.config.minimap.labels.units.format[unitType];
    }
}
