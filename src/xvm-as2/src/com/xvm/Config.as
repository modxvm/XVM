/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
import com.xvm.*;

class com.xvm.Config
{
    // Public vars
    public static var config:Object = null;
    public static var battleLevel:Number = NaN;
    public static var battleType:Number = NaN;
    public static var eventType:String = null;
    public static var myVehId:Number = null;
    public static var networkServicesSettings:Object = null;
    public static var minimapCirclesData:Object = null;
    public static var IS_DEVELOPMENT:Boolean = false;

    // INTERNAL

    // instance
    private static var _instance:Config = null;
    public static function get instance():Config
    {
        if (_instance == null)
            _instance = new Config();
        return _instance;
    }

    public function GetConfigCallback(config_data:String, lang_str:String, battleLevel:Number, battleType:Number, eventType:String, myVehId:Number, vehInfoData:String, networkServicesSettings:String, minimapCirclesData:String, IS_DEVELOPMENT:Boolean)
    {
        //Logger.add("Config::GetConfigCallback()");
        try
        {
            Config.config = JSONx.parse(config_data);
            //Logger.addObject(Config.config);
            Config.battleLevel = battleLevel;
            Config.battleType = battleType;
            Config.eventType = eventType;
            Config.myVehId = myVehId;
            Config.networkServicesSettings = JSONx.parse(networkServicesSettings);
            Config.minimapCirclesData = JSONx.parse(minimapCirclesData);
            Config.IS_DEVELOPMENT = IS_DEVELOPMENT;
            Locale.setupLanguage(lang_str);
            VehicleInfo.onVehicleInfoData(vehInfoData);
            Macros.RegisterGlobalMacrosData();
            ApplyGlobalMacros();

            Logger.add("Config: Loaded");
            GlobalEventDispatcher.dispatchEvent( { type: Defines.E_CONFIG_LOADED } );
        }
        catch (ex)
        {
            Logger.add("CONFIG LOAD ERROR: " + Utils.parseError(ex));
        }
    }

    private function ApplyGlobalMacros()
    {
        // playersPanel
        var cfg = Config.config.playersPanel;
        cfg.startMode = Macros.FormatGlobalStringValue(cfg.startMode);
        cfg.altMode = Macros.FormatGlobalStringValue(cfg.altMode);
        cfg.short.enabled = Macros.FormatGlobalBooleanValue(cfg.short.enabled);
        cfg.medium.enabled = Macros.FormatGlobalBooleanValue(cfg.medium.enabled);
        cfg.medium2.enabled = Macros.FormatGlobalBooleanValue(cfg.medium2.enabled);
        cfg.large.enabled = Macros.FormatGlobalBooleanValue(cfg.large.enabled);
        cfg.none.enabled = Macros.FormatGlobalBooleanValue(cfg.none.enabled);
        cfg.none.leftPanel.x = Macros.FormatGlobalNumberValue(cfg.none.leftPanel.x);
        cfg.none.leftPanel.y = Macros.FormatGlobalNumberValue(cfg.none.leftPanel.y);
        cfg.none.leftPanel.width = Macros.FormatGlobalNumberValue(cfg.none.leftPanel.width);
        cfg.none.leftPanel.height = Macros.FormatGlobalNumberValue(cfg.none.leftPanel.height);
        cfg.none.rightPanel.x = Macros.FormatGlobalNumberValue(cfg.none.rightPanel.x);
        cfg.none.rightPanel.y = Macros.FormatGlobalNumberValue(cfg.none.rightPanel.y);
        cfg.none.rightPanel.width = Macros.FormatGlobalNumberValue(cfg.none.rightPanel.width);
        cfg.none.rightPanel.height = Macros.FormatGlobalNumberValue(cfg.none.rightPanel.height);

        cfg = Config.config.minimap.circles;
        cfg.enabled = Macros.FormatGlobalBooleanValue(cfg.enabled);
        ApplyGlobalMacrosMinimapCircles(cfg.view);
        ApplyGlobalMacrosMinimapCircle(cfg.artillery);
        ApplyGlobalMacrosMinimapCircle(cfg.shell);
        ApplyGlobalMacrosMinimapCircles(cfg.special);

        cfg = Config.config.minimapAlt.circles;
        cfg.enabled = Macros.FormatGlobalBooleanValue(cfg.enabled);
        ApplyGlobalMacrosMinimapCircles(cfg.view);
        ApplyGlobalMacrosMinimapCircle(cfg.artillery);
        ApplyGlobalMacrosMinimapCircle(cfg.shell);
        ApplyGlobalMacrosMinimapCircles(cfg.special);

        cfg = Config.config.minimap.lines;
        cfg.enabled = Macros.FormatGlobalBooleanValue(cfg.enabled);
        ApplyGlobalMacrosMinimapLines(Config.config.minimap.lines.vehicle);
        ApplyGlobalMacrosMinimapLines(Config.config.minimap.lines.camera);
        ApplyGlobalMacrosMinimapLines(Config.config.minimap.lines.traverseAngle);

        cfg = Config.config.minimapAlt.lines;
        cfg.enabled = Macros.FormatGlobalBooleanValue(cfg.enabled);
        ApplyGlobalMacrosMinimapLines(Config.config.minimap.lines.vehicle);
        ApplyGlobalMacrosMinimapLines(Config.config.minimap.lines.camera);
        ApplyGlobalMacrosMinimapLines(Config.config.minimap.lines.traverseAngle);
    }

    private function ApplyGlobalMacrosMinimapCircles(cfg)
    {
        for (var i:Number = 0; i < cfg.length; ++i)
        {
            ApplyGlobalMacrosMinimapCircle(cfg[i]);
        }
    }

    private function ApplyGlobalMacrosMinimapCircle(cfg)
    {
        if (cfg.enabled != null)
            cfg.enabled = Macros.FormatGlobalBooleanValue(cfg.enabled);
        if (cfg.distance != null)
            cfg.distance = Macros.FormatGlobalStringValue(cfg.distance);
        if (cfg.scale != null)
            cfg.scale = Macros.FormatGlobalNumberValue(cfg.scale);
        if (cfg.thickness != null)
            cfg.thickness = Macros.FormatGlobalNumberValue(cfg.thickness);
        if (cfg.alpha != null)
            cfg.alpha = Macros.FormatGlobalNumberValue(cfg.alpha);
        if (cfg.color != null)
            cfg.color = Macros.FormatGlobalStringValue(cfg.color);
    }

    private function ApplyGlobalMacrosMinimapLines(cfg)
    {
        for (var i:Number = 0; i < cfg.length; ++i)
        {
            ApplyGlobalMacrosMinimapLine(cfg[i]);
        }
    }

    private function ApplyGlobalMacrosMinimapLine(cfg)
    {
        if (cfg.enabled != null)
            cfg.enabled = Macros.FormatGlobalBooleanValue(cfg.enabled);
        if (cfg.inmeters != null)
            cfg.inmeters = Macros.FormatGlobalBooleanValue(cfg.inmeters);
        if (cfg.color != null)
            cfg.color = Macros.FormatGlobalStringValue(cfg.color);
        if (cfg.from != null)
            cfg.from = Macros.FormatGlobalNumberValue(cfg.from);
        if (cfg.to != null)
            cfg.to = Macros.FormatGlobalNumberValue(cfg.to);
        if (cfg.thickness != null)
            cfg.thickness = Macros.FormatGlobalNumberValue(cfg.thickness);
        if (cfg.alpha != null)
            cfg.alpha = Macros.FormatGlobalNumberValue(cfg.alpha);
    }
}
