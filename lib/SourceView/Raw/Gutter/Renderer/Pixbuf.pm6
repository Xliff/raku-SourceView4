use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GIO::Raw::Definitions;
use GDK::Pixbuf::Raw::Definitions;
use GDK::Raw::Definitions:ver<4>;
use GDK::Raw::Structs:ver<4>;
use SourceView::Raw::Definitions;

unit package SourceView::Raw::Gutter::Renderer::Pixbuf:ver<4>;

### /usr/src/gtksourceview/gtksourceview/gtksourcegutterrendererpixbuf.h

sub gtk_source_gutter_renderer_pixbuf_get_gicon (GtkSourceGutterRendererPixbuf $renderer)
  returns GIcon
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_gutter_renderer_pixbuf_get_icon_name (GtkSourceGutterRendererPixbuf $renderer)
  returns Str
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_gutter_renderer_pixbuf_get_paintable (GtkSourceGutterRendererPixbuf $renderer)
  returns GdkPaintable
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_gutter_renderer_pixbuf_get_pixbuf (GtkSourceGutterRendererPixbuf $renderer)
  returns GdkPixbuf
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_gutter_renderer_pixbuf_new
  returns GtkSourceGutterRenderer
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_gutter_renderer_pixbuf_overlay_paintable (
  GtkSourceGutterRendererPixbuf $renderer,
  GdkPaintable                  $paintable
)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_gutter_renderer_pixbuf_set_gicon (
  GtkSourceGutterRendererPixbuf $renderer,
  GIcon                         $icon
)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_gutter_renderer_pixbuf_set_icon_name (
  GtkSourceGutterRendererPixbuf $renderer,
  Str                           $icon_name
)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_gutter_renderer_pixbuf_set_paintable (
  GtkSourceGutterRendererPixbuf $renderer,
  GdkPaintable                  $paintable
)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_gutter_renderer_pixbuf_set_pixbuf (
  GtkSourceGutterRendererPixbuf $renderer,
  GdkPixbuf                     $pixbuf
)
  is      native(sourceview)
  is      export
{ * }
