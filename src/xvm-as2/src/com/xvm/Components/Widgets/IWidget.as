/**
 * Widget Interface
 * @author Maxim Schedriviy <m.schedriviy@gmail.com>
 */
import com.xvm.Components.Widgets.Views.IWidgetView;

interface com.xvm.Components.Widgets.IWidget 
{
    public function get mc():MovieClip;
    public function get view():IWidgetView;
    public function get settings():Object;
    public function get playerName():String;
    public function create(mc:MovieClip, settings:Object, playerName:String);
    public function remove();
}