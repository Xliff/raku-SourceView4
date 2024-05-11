use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use SourceView::Raw::Definitions;

unit package SourceView::Raw::Scheme;

### /usr/src/gtksourceview/gtksourceview/gtksourcestylescheme.h

sub gtk_source_style_scheme_get_authors (GtkSourceStyleScheme $scheme)
  returns Str
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_style_scheme_get_description (GtkSourceStyleScheme $scheme)
  returns Str
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_style_scheme_get_filename (GtkSourceStyleScheme $scheme)
  returns Str
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_style_scheme_get_id (GtkSourceStyleScheme $scheme)
  returns Str
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_style_scheme_get_metadata (
  GtkSourceStyleScheme $scheme,
  Str                  $name
)
  returns Str
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_style_scheme_get_name (GtkSourceStyleScheme $scheme)
  returns Str
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_style_scheme_get_style (
  GtkSourceStyleScheme $scheme,
  Str                  $style_id
)
  returns GtkSourceStyle
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_style_scheme_get_type
  returns GType
  is      native(sourceview)
  is      export
{ * }
