use v6.c;

use NativeCall;

use SourceView::Raw::Definitions;

use GLib::Roles::StaticClass;

class SourceView::Main {
  also does GLib::Roles::StaticClass;

  method init {
    gtk_source_init;
  }
}

### /usr/src/gtksourceview/gtksourceview/gtksourceview.init

sub gtk_source_init ()
  is export
  is native(sourceview)
{ * }

INIT { SourceView::Main.init }
