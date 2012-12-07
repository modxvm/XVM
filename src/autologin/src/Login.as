/**
 * ...
 * @author sirmax2
 */
import Logger;

class Login extends net.wargaming.login.Login
{
    static var dummy = Logger.dummy;

    static var sent: Boolean = false;

    function draw()
    {
        //Logger.add("draw: sent=" + sent);

        super.draw();

        if (_root.modalBackground == undefined) // detect and skip replays
            return;

        if (sent)
            return;
        sent = true;

        //Logger.addObject(_root, "_root", 2);

        var me = this;
        var intervalId;
        intervalId = setInterval(function() {
            if (me.visible == true)
            {
                clearInterval(intervalId);
                me.form_mc.onSubmit({type:"click"});
            }
        }, 10);
    }
}
