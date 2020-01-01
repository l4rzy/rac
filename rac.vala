using GLib;
using Rac;

public class Text {
    private static bool version = false;

    public const OptionEntry[] options = {
        { "version", 'v', 0, OptionArg.NONE, ref version, "Display version number", null },
        // list terminator
        { null }
    };

    public static int main (string[] args) {
        switch (args[1]) {
            case "list", "ls":
                return Drivers.List.run (args);
            case "empty", "restore", "rm":
                message ("not implemented yet");
                break;
            default:
                try {
                    var opt_context = new OptionContext ("- Do things with your trash");
                    opt_context.add_main_entries (options, null);
                    opt_context.set_help_enabled (true);

                    var list_group = new OptionGroup ("list", "Subcommand `list` or `ls`:", "Show help of subcommand ls");
                    list_group.add_entries (Drivers.List.options);
                    opt_context.add_group (list_group);
                    opt_context.parse (ref args);

                    if (version) {
                        print (@"rac v$(VER_MAJOR).$(VER_MINOR).$(VER_PATCH)\n");
                        return 0;
                    } else {
                        print (@"Run $(args[0]) --help to show help\n");
                    }
                } catch (Error e) {
                    print (@"Error: $(e.message)\nRun $(args[0]) --help to show help\n");
                }
                break;
        }
        return -1;
    }
}
