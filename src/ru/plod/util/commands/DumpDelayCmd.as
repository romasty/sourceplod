package ru.plod.util.commands {
    import flash.utils.setTimeout;

	import ru.plod.core.commands.Command;


	public class DumpDelayCmd extends Command {

        private var _delay : uint;

        public function DumpDelayCmd(delay : uint)
        {
            _delay = delay;
        }

        override protected function run():void
        {
            setTimeout(complete, _delay);
        }
    }
}