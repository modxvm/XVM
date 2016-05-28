/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.tcarousel_filtersPopover_view
{
    import flash.display.MovieClip;

    public dynamic class MainTimeline extends MovieClip
    {
        public var main:UI_FiltersPopoverView;

        public function MainTimeline()
        {
            super();
            this.main = new UI_FiltersPopoverView();
            stage.addChild(main);
        }
    }
}
