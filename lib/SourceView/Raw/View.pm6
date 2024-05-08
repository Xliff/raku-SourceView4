use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;
use GTK::Raw::Structs:ver<4>;
use SourceView::Raw::Definitions:ver<4>;
use SourceView::Raw::Enums:ver<4>;

unit package SourceView::Raw::View:ver<4>;

### /usr/src/gtksourceview/gtksourceview/gtksourceview.h

sub gtk_source_view_get_auto_indent (GtkSourceView $view)
  returns uint32
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_view_get_background_pattern (GtkSourceView $view)
  returns GtkSourceBackgroundPatternType
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_view_get_completion (GtkSourceView $view)
  returns GtkSourceCompletion
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_view_get_enable_snippets (GtkSourceView $view)
  returns uint32
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_view_get_gutter (
  GtkSourceView     $view,
  GtkTextWindowType $window_type
)
  returns GtkSourceGutter
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_view_get_highlight_current_line (GtkSourceView $view)
  returns uint32
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_view_get_hover (GtkSourceView $view)
  returns GtkSourceHover
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_view_get_indent_on_tab (GtkSourceView $view)
  returns uint32
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_view_get_indent_width (GtkSourceView $view)
  returns gint
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_view_get_indenter (GtkSourceView $view)
  returns GtkSourceIndenter
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_view_get_insert_spaces_instead_of_tabs (GtkSourceView $view)
  returns uint32
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_view_get_mark_attributes (
  GtkSourceView $view,
  Str           $category,
  gint          $priority is rw
)
  returns GtkSourceMarkAttributes
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_view_get_right_margin_position (GtkSourceView $view)
  returns guint
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_view_get_show_line_marks (GtkSourceView $view)
  returns uint32
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_view_get_show_line_numbers (GtkSourceView $view)
  returns uint32
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_view_get_show_right_margin (GtkSourceView $view)
  returns uint32
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_view_get_smart_backspace (GtkSourceView $view)
  returns uint32
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_view_get_smart_home_end (GtkSourceView $view)
  returns GtkSourceSmartHomeEndType
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_view_get_space_drawer (GtkSourceView $view)
  returns GtkSourceSpaceDrawer
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_view_get_tab_width (GtkSourceView $view)
  returns guint
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_view_get_visual_column (
  GtkSourceView $view,
  GtkTextIter   $iter
)
  returns guint
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_view_indent_lines (
  GtkSourceView $view,
  GtkTextIter   $start,
  GtkTextIter   $end
)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_view_new
  returns GtkSourceView
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_view_new_with_buffer (GtkSourceBuffer $buffer)
  returns GtkSourceView
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_view_push_snippet (
  GtkSourceView    $view,
  GtkSourceSnippet $snippet,
  GtkTextIter      $location
)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_view_set_auto_indent (
  GtkSourceView $view,
  gboolean      $enable
)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_view_set_background_pattern (
  GtkSourceView                  $view,
  GtkSourceBackgroundPatternType $background_pattern
)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_view_set_enable_snippets (
  GtkSourceView $view,
  gboolean      $enable_snippets
)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_view_set_highlight_current_line (
  GtkSourceView $view,
  gboolean      $highlight
)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_view_set_indent_on_tab (
  GtkSourceView $view,
  gboolean      $enable
)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_view_set_indent_width (
  GtkSourceView $view,
  gint          $width
)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_view_set_indenter (
  GtkSourceView     $view,
  GtkSourceIndenter $indenter
)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_view_set_insert_spaces_instead_of_tabs (
  GtkSourceView $view,
  gboolean      $enable
)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_view_set_mark_attributes (
  GtkSourceView           $view,
  Str                     $category,
  GtkSourceMarkAttributes $attributes,
  gint                    $priority
)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_view_set_right_margin_position (
  GtkSourceView $view,
  guint         $pos
)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_view_set_show_line_marks (
  GtkSourceView $view,
  gboolean      $show
)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_view_set_show_line_numbers (
  GtkSourceView $view,
  gboolean      $show
)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_view_set_show_right_margin (
  GtkSourceView $view,
  gboolean      $show
)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_view_set_smart_backspace (
  GtkSourceView $view,
  gboolean      $smart_backspace
)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_view_set_smart_home_end (
  GtkSourceView             $view,
  GtkSourceSmartHomeEndType $smart_home_end
)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_view_set_tab_width (
  GtkSourceView $view,
  guint         $width
)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_view_unindent_lines (
  GtkSourceView $view,
  GtkTextIter   $start,
  GtkTextIter   $end
)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_view_get_type ()
  returns GType
  is      native(sourceview)
  is      export
{ * }
