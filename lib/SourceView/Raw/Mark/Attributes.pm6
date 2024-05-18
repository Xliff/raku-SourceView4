use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GIO::Raw::Definitions;
use GDK::Pixbuf::Raw::Definitions;
use GDK::Raw::Definitions:ver<4>;
use GDK::Raw::Structs:ver<4>;
use GTK::Raw::Structs:ver<4>;
use SourceView::Raw::Definitions:ver<4>;

unit package Sourceview::Raw::Mark::Attributes;

### /usr/src/gtksourceview/gtksourceview/gtksourcemarkattributes.h

sub gtk_source_mark_attributes_get_background (
  GtkSourceMarkAttributes $attributes,
  GdkRGBA                 $background
)
  returns uint32
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_mark_attributes_get_gicon (GtkSourceMarkAttributes $attributes)
  returns GIcon
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_mark_attributes_get_icon_name (
  GtkSourceMarkAttributes $attributes
)
  returns Str
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_mark_attributes_get_pixbuf (GtkSourceMarkAttributes $attributes)
  returns GdkPixbuf
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_mark_attributes_get_tooltip_markup (
  GtkSourceMarkAttributes $attributes,
  GtkSourceMark           $mark
)
  returns Str
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_mark_attributes_get_tooltip_text (
  GtkSourceMarkAttributes $attributes,
  GtkSourceMark           $mark
)
  returns Str
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_mark_attributes_new
  returns GtkSourceMarkAttributes
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_mark_attributes_render_icon (
  GtkSourceMarkAttributes $attributes,
  GtkWidget               $widget,
  gint                    $size
)
  returns GdkPaintable
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_mark_attributes_set_background (
  GtkSourceMarkAttributes $attributes,
  GdkRGBA                 $background
)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_mark_attributes_set_gicon (
  GtkSourceMarkAttributes $attributes,
  GIcon                   $gicon
)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_mark_attributes_set_icon_name (
  GtkSourceMarkAttributes $attributes,
  Str                     $icon_name
)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_mark_attributes_set_pixbuf (
  GtkSourceMarkAttributes $attributes,
  GdkPixbuf               $pixbuf
)
  is      native(sourceview)
  is      export
{ * }
