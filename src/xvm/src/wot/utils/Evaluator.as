/**
 * ...
 * @author Maxim Schedriviy
 */
import wot.utils.IEvaluatorProvider;
import wot.utils.Logger;

class wot.utils.Evaluator
{
    private var provider:IEvaluatorProvider;

    private function trace(str:String):Void
    {
        Logger.add("[Evaluator]> " + str);
    }

    public function Evaluator(provider:IEvaluatorProvider)
    {
        this.provider = provider;
    }

    public function evaluate(script:String):Object
    {
        var commands:Array = script.split(";");

        for (var i = 0; i < commands.length; ++i)
        {
            trace("cmd:" + commands[i]);
        }

        return null;
    }
}
