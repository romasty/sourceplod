package ru.plod.util.proxy {

    import flash.utils.Proxy;
    import flash.utils.flash_proxy;


    dynamic public class PropertyResolver extends Proxy {

        private var _$$$_source : *;
        private var _$$$_tasks : Array = new Array();

        public function PropertyResolver(source : *)
        {
            super();
            _$$$_source = source;
        }


        public function resolveTasks() : void
        {
            var task : ResolverTask;
            for each(task in _$$$_tasks) {
                task.resolveTask();
            }
        }



        flash_proxy override function setProperty(name : *, value : *) : void
        {
            //trace("ParamResolver:", "setProperty", _$$$_source, name, value);

            if(value is ResolverTask) {

                var task : ResolverTask = ResolverTask(value);
                task.target = _$$$_source;
                task.targetProperty = name;
                _$$$_tasks.push(task);

            } else {

                _$$$_source[name] = value;

            }
        }

        flash_proxy override function getProperty(name : *) : *
        {
            //trace("ParamResolver:", "getProperty", _$$$_source, name);

            var task : ResolverTask = new ResolverTask();
            task.source = _$$$_source;
            task.sourceProperty = name;

            return task;
        }

        flash_proxy override function callProperty(name : *, ...args : Array) : *
        {
            //trace("ParamResolver:", "callProperty", _$$$_source, name, args);

            var task : ResolverTask = new ResolverTask();
            task.source = _$$$_source;
            task.sourceFunc = name;
            task.args = args;

            return task;

        }
    }
}
