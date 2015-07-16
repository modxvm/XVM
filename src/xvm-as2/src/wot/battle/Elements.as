/**
 * ...
 * @author sirmax2
 */
import com.xvm.Config;
import com.xvm.Defines;
import com.xvm.Logger;
import com.xvm.MathEvaluator;
import com.xvm.Strings;

class wot.battle.Elements
{
    public static var width, height, scale;

    public static var CMD_LOG:String = "$log";
    public static var CMD_DELAY:String = "$delay";
    public static var CMD_INTERVAL:String = "$interval";
    public static var CMD_TEXT_FORMAT:String = "$textFormat";

    public static function SetupElements()
    {
        if (!Config.config || !width || !height)
            return;
        for (var i = 0; i < Config.config.battle.elements.length; ++i)
            apply(_root, Config.config.battle.elements[i], "_root");
    }

    private static function apply(obj, opt, name)
    {
        //Logger.addObject(opt, 1, name);
        if (opt[CMD_LOG] != null)
        {
            Logger.addObject(obj, opt[CMD_LOG], name);
            delete opt[CMD_LOG];
        }

        if (opt[CMD_DELAY] != null)
        {
            _global.setTimeout(function() { Elements.apply(obj, opt, name); }, opt[CMD_DELAY]);
            delete opt[CMD_DELAY];
            return;
        }

        if (opt[CMD_INTERVAL] != null)
        {
            _global.setInterval(function() { Elements.apply(obj, opt, name); }, opt[CMD_INTERVAL]);
            delete opt[CMD_INTERVAL];
            return;
        }

        for (var key in opt)
        {
            var value = opt[key];
            if (value == CMD_LOG)
                Logger.addObject(obj[key], 1, name + "." + key);
            else if (key == CMD_TEXT_FORMAT && obj instanceof TextField)
                applyTextFormat(obj, value, name);
            else if (typeof value == "object" && !value instanceof Array && obj[key] != null)
                apply(obj[key], value, name + "." + key);
            else
            {
                // percent value
                if (typeof obj[key] == "number" && Strings.endsWith("%", value))
                {
                    value = value.substring(0, value.length - 1);
                    value = parseFloat(value) * width / 100;
                }
                // eval
                if (typeof obj[key] == "number" && typeof value == "string")
                {
                    var evaluator:MathEvaluator = new MathEvaluator([
                        // contexts
                        { WIDTH:width, HEIGHT:height }, // globals
                        obj,                            // current object
                        _root,                          // _root
                        Config.config,                  // config
                        Defines                         // global defines
                    ]);
                    //Logger.add(value + " => " + evaluator.eval(value));
                    value = evaluator.eval(value);
                }
                obj[key] = value;
            }
        }
        //Logger.add("<< " + name);
    }

    private static function applyTextFormat(obj:TextField, opt, name)
    {
        var tf:TextFormat = obj.getNewTextFormat();
        apply(tf, opt, name + CMD_TEXT_FORMAT);
        obj.setNewTextFormat(tf);
    }
}
