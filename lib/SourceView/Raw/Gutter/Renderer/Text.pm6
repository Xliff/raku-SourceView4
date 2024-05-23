use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use SourceView::Raw::Definitions;

unit package SourceView::Gutter::Renderer::Text;

### /usr/src/gtksourceview/gtksourceview/gtksourcegutterrenderertext.h

sub gtk_source_gutter_renderer_text_measure (
  GtkSourceGutterRendererText $renderer,
  Str                         $text,
  gint                        $width     is rw,
  gint                        $height    is rw
)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_gutter_renderer_text_measure_markup (
  GtkSourceGutterRendererText $renderer,
  Str                         $markup,
  gint                        $width     is rw,
  gint                        $height    is rw
)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_gutter_renderer_text_new
  returns GtkSourceGutterRendererText
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_gutter_renderer_text_set_markup (
  GtkSourceGutterRendererText $renderer,
  Str                         $markup,
  gint                        $length
)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_gutter_renderer_text_set_text (
  GtkSourceGutterRendererText $renderer,
  Str                         $text,
  gint                        $length
)
  is      native(sourceview)
  is      export
{ * }
