use v6.c;

use Method::Also;

use GLib::Roles::StaticClass;

class SourceView::Utils {
  also does GLib::Roles::StaticClass;

  method escape_search_text (Str() $text) is also<escape-search-text> {
    gtk_source_utils_escape_search_text($text);
  }

  method unescape_search_text (Str() $text) is also<unescape-search-text> {
    gtk_source_utils_unescape_search_text($text);
  }

}


### /usr/src/gtksourceview/gtksourceview/gtksourceutils.h

sub gtk_source_utils_escape_search_text (Str $text)
  returns Str
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_utils_unescape_search_text (Str $text)
  returns Str
  is      native(sourceview)
  is      export
{ * }
