use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GDK::Raw::Enums:ver<4>;
use GDK::Raw::Structs:ver<4>;
use GTK::Raw::Structs:ver<4>;
use SourceView::Raw::Definitions:ver<4>;
use SourceView::Raw::Enums:ver<4>;

unit package SourceView::Raw::Gutter::Renderer:ver<4>;

### /usr/src/gtksourceview/gtksourceview/gtksourcegutterrenderer.h

sub gtk_source_gutter_renderer_activate (
  GtkSourceGutterRenderer $renderer,
  GtkTextIter             $iter,
  GdkRectangle            $area,
  guint                   $button,
  GdkModifierType         $state,
  gint                    $n_presses
)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_gutter_renderer_align_cell (
  GtkSourceGutterRenderer $renderer,
  guint                   $line,
  gfloat                  $width,
  gfloat                  $height,
  gfloat                  $x       is rw,
  gfloat                  $y       is rw
)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_gutter_renderer_get_alignment_mode (
  GtkSourceGutterRenderer $renderer
)
  returns GtkSourceGutterRendererAlignmentMode
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_gutter_renderer_get_buffer (GtkSourceGutterRenderer $renderer)
  returns GtkSourceBuffer
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_gutter_renderer_get_view (GtkSourceGutterRenderer $renderer)
  returns GtkSourceView
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_gutter_renderer_get_xalign (GtkSourceGutterRenderer $renderer)
  returns gfloat
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_gutter_renderer_get_xpad (GtkSourceGutterRenderer $renderer)
  returns gint
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_gutter_renderer_get_yalign (GtkSourceGutterRenderer $renderer)
  returns gfloat
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_gutter_renderer_get_ypad (GtkSourceGutterRenderer $renderer)
  returns gint
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_gutter_renderer_query_activatable (
  GtkSourceGutterRenderer $renderer,
  GtkTextIter             $iter,
  GdkRectangle            $area
)
  returns uint32
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_gutter_renderer_set_alignment_mode (
  GtkSourceGutterRenderer              $renderer,
  GtkSourceGutterRendererAlignmentMode $mode
)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_gutter_renderer_set_xalign (
  GtkSourceGutterRenderer $renderer,
  gfloat                  $xalign
)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_gutter_renderer_set_xpad (
  GtkSourceGutterRenderer $renderer,
  gint                    $xpad
)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_gutter_renderer_set_yalign (
  GtkSourceGutterRenderer $renderer,
  gfloat                  $yalign
)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_gutter_renderer_set_ypad (
  GtkSourceGutterRenderer $renderer,
  gint                    $ypad
)
  is      native(sourceview)
  is      export
{ * }
