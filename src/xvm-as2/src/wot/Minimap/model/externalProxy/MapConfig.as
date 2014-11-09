import com.xvm.*;
import flash.geom.*;
import flash.filters.*;
import wot.Minimap.dataTypes.*;

class wot.Minimap.model.externalProxy.MapConfig
{
    private static var _isAltMode:Boolean = false;
    public static function get isAltMode():Boolean              { return _isAltMode; }
    public static function set isAltMode(value:Boolean):Void    { _isAltMode = value; }

    public static function get enabled():Boolean                { return minimap.enabled; }
    public static function get mapBackgroundImageAlpha():Number { return minimap.mapBackgroundImageAlpha; }
    public static function get selfIconAlpha():Number           { return minimap.selfIconAlpha; }
    public static function get hideCameraTriangle():Number      { return minimap.hideCameraTriangle; }
    public static function get cameraAlpha():Number             { return minimap.cameraAlpha; }
    public static function get iconScale():Number               { return minimap.iconScale; }

    /** Zoom */
    public static function get zoomCentered():Boolean   { return minimap.zoom.centered; }
    public static function get zoomPixelsBack():Number  { return minimap.zoom.pixelsBack; }

    /** Labels */
    /** Vehicle class macro */
    public static function get lightSymbol():String     { return vehicleclassmacro.light; }
    public static function get mediumSymbol():String    { return vehicleclassmacro.medium; }
    public static function get heavySymbol():String     { return vehicleclassmacro.heavy; }
    public static function get tdSymbol():String        { return vehicleclassmacro.td; }
    public static function get spgSymbol():String       { return vehicleclassmacro.spg; }
    public static function get superSymbol():String     { return vehicleclassmacro.superh; }
    /** Units */
    public static function get revealedEnabled():Boolean { return labels.units.revealedEnabled; }
    public static function get lostEnemyEnabled():Boolean { return labels.units.lostEnemyEnabled; }
    /** Format */
    public static function unitLabelFormat(entryName:String, status:Number)
    {
        var unitType:String = defineCfgProperty(entryName, status);
        return labels.units.format[unitType];
    }
    /** CSS */
    public static function unitLabelCss(entryName:String, status:Number)
    {
        var unitType:String = defineCfgProperty(entryName, status);
        return labels.units.css[unitType];
    }
    /** Alpha */
    public static function unitLabelAlpha(entryName:String, status:Number)
    {
        var unitType:String = defineCfgProperty(entryName, status);
        return labels.units.alpha[unitType];
    }
    /** Shadow enabled */
    public static function unitShadowEnabled(entryName:String, status:Number):Boolean
    {
        var unitType:String = defineCfgProperty(entryName, status);
        return labels.units.shadow[unitType].enabled;
    }
    /** Shadow filter */
    public static function unitShadow(entryName:String, status:Number):DropShadowFilter
    {
        var unitType:String = defineCfgProperty(entryName, status);
        return Utils.extractShadowFilter(labels.units.shadow[unitType]);
    }
    /** Offset */
    public static function unitLabelOffset(entryName:String, status:Number)
    {
        var unitType:String = defineCfgProperty(entryName, status);
        return new Point(labels.units.offset[unitType].x, labels.units.offset[unitType].y);
    }

    /** Map size label */
    public static function get mapSizeLabelEnabled():Boolean    { return mapSize.enabled; }
    public static function get mapSizeLabelFormat():String      { return mapSize.format; }
    public static function get mapSizeLabelCss():String         { return mapSize.css; }
    public static function get mapSizeLabelAlpha():Number       { return mapSize.alpha; }
    public static function get mapSizeLabelOffset():Point       { return new Point(mapSize.offsetX, mapSize.offsetY); }
    /** Shadow */
    public static function get mapSizeLabelShadowEnabled(vehicleClass):Boolean  { return mapSize.shadow.enabled; }
    public static function get mapSizeLabelShadow():DropShadowFilter            { return Utils.extractShadowFilter(labels.mapSize.shadow); }
    public static function get mapSizeLabelWidth() :Number                      { return mapSize.width; }
    public static function get mapSizeLabelHeight():Number                      { return mapSize.height; }

    /** Circles */
    public static function get circles():Object         { return minimap.circles; }

    /** Square */
    public static function get squareEnabled():Boolean  { return square.enabled; }
    public static function get artiEnabled():Boolean    { return square.artilleryEnabled; }
    public static function get squareConfig():Object    { return square; }

    /** Lines */
    public static function get linesEnabled():Boolean   { return lines.enabled; }
    public static function get linesVehicle():Array     { return lines.vehicle; }
    public static function get linesCamera():Array      { return lines.camera; }
    public static function get linesTraverseAngle():Array { return lines.traverseAngle; }

    // -- Private

    /** Translate internal WG entryName and unit status(dead\tk) to minimap config file entry */
    private static function defineCfgProperty(wgEntryName:String, status:Number):String
    {
        /** Prefix: lost dead or alive */
        var xvmPrefix:String;

        if (Math.abs(status) == Player.PLAYER_LOST)
            xvmPrefix = "lost";
        else if (Math.abs(status) == Player.PLAYER_DEAD)
            xvmPrefix = "dead";
        else
            xvmPrefix = "";

        /** Postfix: ally, enemy, tk or squad */
        var xvmPostfix:String;

        if (wgEntryName == "squadman")
            xvmPostfix = "squad"; /** Translate squad WG entry name to squad XVM entry name */
        else
            xvmPostfix = wgEntryName;

        if (status <= Player.TEAM_KILLER_FLAG && wgEntryName == "ally") /** <- Skip enemy and squad TK */
            xvmPostfix = "teamkiller";

        /** Result */
        var xvmFullEntry:String;

        if (wgEntryName == "")
            xvmFullEntry = "oneself";
        else
            xvmFullEntry = xvmPrefix + xvmPostfix;

        if (xvmFullEntry == "lostenemy")
            xvmFullEntry = "lost"; /** Backwards config compatibility */

        return xvmFullEntry;
    }

    private static function get labels():Object
    {
        return minimap.labels;
    }

    private static function get lines():Object
    {
        return minimap.lines;
    }

    private static function get square():Object
    {
        return minimap.square;
    }

    private static function get mapSize():Object
    {
        return labels.mapSize;
    }

    private static function get vehicleclassmacro():Object
    {
        return labels.vehicleclassmacro;
    }

    private static function get minimap():Object
    {
        return _isAltMode ? Config.config.minimapAlt : Config.config.minimap;
    }
}
