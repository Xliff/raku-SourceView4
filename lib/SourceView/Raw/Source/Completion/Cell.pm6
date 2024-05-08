use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GIO::Raw::Definitions;
use Pango::Raw::Definitions;
use GDK::Raw::Definitions:ver<4>;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Structs:ver<4>;
use SourceView::Raw::Definitions:ver<4>;
use SourceView::Raw::Enums:ver<4>;

unit package SourceView::Raw::Completion::Cell:ver<4>;

### /usr/src/gtksourceview/gtksourceview/gtksourcecompletioncell.h

sub gtk_source_completion_cell_get_column (GtkSourceCompletionCell $self)
  returns GtkSourceCompletionColumn
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_completion_cell_get_widget (GtkSourceCompletionCell $self)
  returns GtkWidget
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_completion_cell_set_gicon (
  GtkSourceCompletionCell $self,
  GIcon                   $gicon
)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_completion_cell_set_icon_name (
  GtkSourceCompletionCell $self,
  Str                     $icon_name
)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_completion_cell_set_markup (
  GtkSourceCompletionCell $self,
  Str                     $markup
)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_completion_cell_set_paintable (
  GtkSourceCompletionCell $self,
  GdkPaintable            $paintable
)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_completion_cell_set_text (
  GtkSourceCompletionCell $self,
  Str                     $text
)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_completion_cell_set_text_with_attributes (
  GtkSourceCompletionCell $self,
  Str                     $text,
  PangoAttrList           $attrs
)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_completion_cell_set_widget (
  GtkSourceCompletionCell $self,
  GtkWidget               $child
)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_completion_cell_get_type (
  GtkSourceCompletionCell $self,
  GtkWidget               $child
)
  returns GType
  is      native(sourceview)
  is      export
{ * }
