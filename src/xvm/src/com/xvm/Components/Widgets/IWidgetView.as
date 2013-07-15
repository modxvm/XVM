/**
 * Widget View Interface
 * @author Maxim Schedriviy <m.schedriviy@gmail.com>
 */

interface com.xvm.Components.Widgets.IWidgetView
{
    public function get panel();
    public function update(data:Object);
    public function updateIdle(pos:Number)
}
