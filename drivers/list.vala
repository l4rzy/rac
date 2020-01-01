using GLib;
using Rac;

namespace Rac.Drivers {
    public class List {
        private static bool version = false;
        private static bool color = true;
        private static bool ll = false;
        private static bool rec = false;
        private static bool debug = false;

        public const OptionEntry[] options = {
            { "color", 'C', 0, OptionArg.NONE, ref color, "Enable color support", null },
            { "long", 'l', 0, OptionArg.NONE, ref ll, "List as long format", null },
            { "recursive", 'R', 0, OptionArg.NONE, ref rec, "Recursively list all children", null },
            { "debug", 'd', 0, OptionArg.NONE, ref debug, "Verbose debug info", null },
            { "version", 'v', 0, OptionArg.NONE, ref version, "Display version number", null },
            // list terminator
            { null }
        };

        private static void list_children (File file, string space = "", Cancellable ? cancellable = null) throws Error {
            FileEnumerator enumerator = file.enumerate_children (
                "standard::*",
                FileQueryInfoFlags.NOFOLLOW_SYMLINKS,
                cancellable);
            FileInfo info = null;
            while (cancellable.is_cancelled () == false && ((info = enumerator.next_file (cancellable)) != null)) {
                if (info.get_file_type () == FileType.DIRECTORY) {
                    File subdir = file.resolve_relative_path (info.get_name ());
                    // list the current folder
                    print ("%s%s/\n", space, info.get_name ());
                    if (rec) {
                        list_children (subdir, space + "  ", cancellable);
                    }
                } else {
                    print ("%s%s\n", space, info.get_name ());
                }
            }

            if (cancellable.is_cancelled ()) {
                throw new IOError.CANCELLED ("Operation was cancelled");
            }
        }

        public static int run (string[] args) {
            try {
                var opt_context = new OptionContext (@"$(args[1]) - List trash items");
                opt_context.add_main_entries (options, null);
                opt_context.set_help_enabled (true);
                opt_context.parse (ref args);
            } catch (OptionError e) {
                printerr ("error: %s\n", e.message);
                printerr ("Run '%s %s --help' to see a full list of available command line options.\n", args[0], args[1]);
                return 1;
            }

            if (version) {
                print (@"rac $(args[1]) v$(VER_MAJOR).$(VER_MINOR).$(VER_PATCH)\n");
                return 0;
            }

            File file = File.new_for_uri ("trash:");
            try {
                if (debug) message ("opening trash");
                list_children (file);
            } catch (Error e) {
                print (@"$(e.message)\n");
                return -1;
            }
            return 0;
        }
    }
}
