package preview
{
    public class Resources
    {
        [Embed(source="../assets/markers.swf", mimeType="application/octet-stream")]
        public static const markersSWF: Class;

        [Embed(source="images/markers/clan1.png")]
        public static const IMG_clan1: Class;
        [Embed(source="images/markers/clan2.png")]
        public static const IMG_clan2: Class;
        [Embed(source="images/markers/ussr-IS-3.png")]
        public static const IMG_contour1: Class;
        [Embed(source="images/markers/germany-Ferdinand.png")]
        public static const IMG_contour2: Class;
        [Embed(source="images/markers/germany-Hummel.png")]
        public static const IMG_contour3: Class;
    }
}
