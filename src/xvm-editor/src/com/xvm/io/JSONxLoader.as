/**
 * Loader for JSONx format (JSON with references)
 * @author Maxim Schedriviy <m.schedriviy@gmail.com>
 */
package com.xvm.io
{
    import com.xvm.io.JSONx;
    import flash.display.Loader;
    import flash.events.Event;
    import flash.net.URLLoader;
    import flash.net.URLRequest;
    import flash.events.IOErrorEvent;

    public class JSONxLoader
    {
        private var rootPath:Object;
        private var rootFileName:Object;
        private var target:Object;
        private var callback:Function;

        private var file_cache:Object = { };
        private var obj_cache:Object = { };
        private var pendingFiles:Array = [ ];

        private var rootObj:Object;

        public static function LoadAndParse(filename:String, target:Object, callback:Function):void
        {
            //Logger.add("LoadAndParse: " + filename);
            var jxl:JSONxLoader = new JSONxLoader(filename, target, callback);
            // WARNING: inline call does not work
            jxl.LoadFiles();
        }

        // PRIVATE

        function JSONxLoader(rootFileName:String, target:Object, callback:Function)
        {
            var a:Array = rootFileName.split("\\").join("/").split("/");
            this.rootFileName = a.pop();
            this.rootPath = a.length > 0 ? a.join("/") + "/" : "";
            this.target = target;
            this.callback = callback;
            this.pendingFiles = [ this.rootFileName ];
            this.rootObj = {$ref: { file: this.rootFileName, path: "." }};
        }

        private var loadingCount:Number;
        private function LoadFiles():void
        {
            loadingCount = pendingFiles.length;
            for (var i:Number = 0; i < loadingCount; ++i)
                LoadFile(pendingFiles[i]);
            pendingFiles = [ ];
        }

        private function LoadFile(filename:String):void
        {
            var me:JSONxLoader = this;
            var loader:URLLoader = new URLLoader();
            var $this:JSONxLoader = this;
            loader.addEventListener(Event.COMPLETE, function(e:Event):void { $this.onLoadFileComplete(e, filename) });
            loader.addEventListener(IOErrorEvent.IO_ERROR, function(e:Event):void { $this.onLoadFileComplete(e, filename) });
            try
            {
                loader.load(new URLRequest(rootPath + filename));
            }
            catch (error:Error)
            {
                //Logger.add(error.getStackTrace());
            }
        }

        private function onLoadFileComplete(e:Event, filename:String):void
        {
            var loader:URLLoader = e.target as URLLoader;
            file_cache[filename] = loader.data;
            if (!--loadingCount)
                LoadFileCallback();
        }

        private function LoadFileCallback():void
        {
            try
            {
                rootObj = Deref(rootObj);
                if (pendingFiles.length > 0)
                {
                    LoadFiles();
                    return;
                }
            }
            catch (ex:*)
            {
                callback.call(target, ex);
                return;
            }

            callback.call(target, { data:rootObj, filename:rootFileName } );
        }

        private function Deref(data:Object, level:int = 0, file:String = null, obj_path:String = null):Object
        {
            // limit of recursion
            if (level > 32)
                return data;

            if (data == null)
                return null;

            // scalar
            if (typeof data.toString == 'undefined')
                return data;

            if (!obj_path)
                obj_path = "";

            // array
            if (data is Array) // array
            {
                var len:int = data.length;
                for (var i:int = 0; i < len; ++i)
                    data[i] = Deref(data[i], level + 1, file, obj_path + "[" + i + "]");
                return data;
            }

            // object
            if (!data.hasOwnProperty('$ref'))
            {
                for (var n:String in data)
                {
                    data[n] = Deref(data[n], level + 1, file, (obj_path == "" ? "" : obj_path + ".") + n);
                }
                return data;
            }

            // reference
            //   "$ref": { "file": "...", "line": "..." }

            if (data.$ref.$ref != null)
                throw { type: "BAD_REF", message: "endless reference recursion in " + file + ", " + obj_path};

            var fn:String = data.$ref.abs_path;
            if (!fn)
            {
                var d:Object = splitDir(file || "");
                fn = (d.d + (data.$ref.file || d.f));
            }

            if (!file_cache.hasOwnProperty(fn))
            {
                data.$ref.abs_path = fn;
                var found:Boolean = false;
                var len2:int = pendingFiles.length;
                for (var j:int = 0; j < len2; ++j)
                {
                    if (pendingFiles[j] == fn)
                    {
                        found = true;
                        break;
                    }
                }
                if (!found)
                    pendingFiles.push(fn);
            }
            else
            {
                try
                {
                    if (!obj_cache.hasOwnProperty(fn))
                        obj_cache[fn] = JSONx.parse(file_cache[fn]);
                    if (obj_cache[fn] == null)
                        throw { type: fn == rootFileName ? "NO_FILE" : "NO_REF_FILE", message: "file is missing: " + fn };
                    var value:* = getValue(obj_cache[fn], data.$ref.path);
                    if (value === undefined)
                        throw { type: "BAD_REF", message: "bad reference:\n    ${\"" + data.$ref.file + "\":\"" + data.$ref.path + "\"}" };

                    // override referenced values
                    //   "damageText": {
                    //     "$ref": { "path":"def.damageText" },
                    //     "damageMessage": "all {{dmg}}"
                    //    }

                    for (var n2:String in data)
                    {
                        if (n2 != "$ref")
                            value[n2] = data[n2];
                    }

                    // deref result
                    data = Deref(value, level + 1, fn, obj_path);
                }
                catch (ex:*)
                {
                    throw ex.error ? ex : { error: ex, filename: fn };
                }
            }

            return data;
        }

        private function getValue(obj:*, path: String):*
        {
            if (obj === undefined)
                return undefined;

            if (path == "." || path == "")
                return obj;

            var p: Array = path.split("."); // "path.to.value"
            var o:* = obj;
            var p_len:Number = p.length;
            for (var i:Number = 0; i < p_len; ++i)
            {
                if (!o.hasOwnProperty(p[i]))
                    return undefined;
                o = o[p[i]];
            }
            return o == null ? null : clone(o);
        }

        private function clone(obj:Object):Object
        {
            return JSONx.parse(JSONx.stringify(obj, "", true));
        }

        private function splitDir(path:String):Object
        {
            var fileArray:Vector.<String> = Vector.<String> (path.split("\\").join("/").split("/"));
            return {
                f: fileArray.pop(),
                d: fileArray.length > 0 ? fileArray.join("/") + "/" : ""
            };
        }
    }
}
