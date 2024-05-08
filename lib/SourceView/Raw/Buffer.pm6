use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Structs:ver<4>;
use SourceView::Raw::Definitions:ver<4>;
use SourceView::Raw::Enums:ver<4>;

unit package SourceView::Raw::Buffer:ver<4>;

### /usr/src/gtksourceview/gtksourceview/gtksourcebuffer.h

sub gtk_source_buffer_backward_iter_to_source_mark (
  GtkSourceBuffer $buffer,
  GtkTextIter     $iter,
  Str             $category
)
  returns uint32
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_buffer_change_case (
  GtkSourceBuffer         $buffer,
  GtkSourceChangeCaseType $case_type,
  GtkTextIter             $start,
  GtkTextIter             $end
)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_buffer_create_source_mark (
  GtkSourceBuffer $buffer,
  Str             $name,
  Str             $category,
  GtkTextIter     $where
)
  returns GtkSourceMark
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_buffer_create_source_tag (
  GtkSourceBuffer $buffer,
  Str             $tag_name,
  Str             $first_property_name
)
  returns GtkTextTag
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_buffer_ensure_highlight (
  GtkSourceBuffer $buffer,
  GtkTextIter     $start,
  GtkTextIter     $end
)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_buffer_forward_iter_to_source_mark (
  GtkSourceBuffer $buffer,
  GtkTextIter     $iter,
  Str             $category
)
  returns uint32
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_buffer_get_context_classes_at_iter (
  GtkSourceBuffer $buffer,
  GtkTextIter     $iter
)
  returns Str
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_buffer_get_highlight_matching_brackets (GtkSourceBuffer $buffer)
  returns uint32
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_buffer_get_highlight_syntax (GtkSourceBuffer $buffer)
  returns uint32
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_buffer_get_implicit_trailing_newline (GtkSourceBuffer $buffer)
  returns uint32
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_buffer_get_language (GtkSourceBuffer $buffer)
  returns GtkSourceLanguage
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_buffer_get_loading (GtkSourceBuffer $buffer)
  returns uint32
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_buffer_get_source_marks_at_iter (
  GtkSourceBuffer $buffer,
  GtkTextIter     $iter,
  Str             $category
)
  returns GSList
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_buffer_get_source_marks_at_line (
  GtkSourceBuffer $buffer,
  gint            $line,
  Str             $category
)
  returns GSList
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_buffer_get_style_scheme (GtkSourceBuffer $buffer)
  returns GtkSourceStyleScheme
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_buffer_iter_backward_to_context_class_toggle (
  GtkSourceBuffer $buffer,
  GtkTextIter     $iter,
  Str             $context_class
)
  returns uint32
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_buffer_iter_forward_to_context_class_toggle (
  GtkSourceBuffer $buffer,
  GtkTextIter     $iter,
  Str             $context_class
)
  returns uint32
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_buffer_iter_has_context_class (
  GtkSourceBuffer $buffer,
  GtkTextIter     $iter,
  Str             $context_class
)
  returns uint32
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_buffer_join_lines (
  GtkSourceBuffer $buffer,
  GtkTextIter     $start,
  GtkTextIter     $end
)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_buffer_new (GtkTextTagTable $table)
  returns GtkSourceBuffer
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_buffer_new_with_language (GtkSourceLanguage $language)
  returns GtkSourceBuffer
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_buffer_remove_source_marks (
  GtkSourceBuffer $buffer,
  GtkTextIter     $start,
  GtkTextIter     $end,
  Str             $category
)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_buffer_set_highlight_matching_brackets (
  GtkSourceBuffer $buffer,
  gboolean        $highlight
)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_buffer_set_highlight_syntax (
  GtkSourceBuffer $buffer,
  gboolean        $highlight
)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_buffer_set_implicit_trailing_newline (
  GtkSourceBuffer $buffer,
  gboolean        $implicit_trailing_newline
)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_buffer_set_language (
  GtkSourceBuffer   $buffer,
  GtkSourceLanguage $language
)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_buffer_set_style_scheme (
  GtkSourceBuffer      $buffer,
  GtkSourceStyleScheme $scheme
)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_buffer_sort_lines (
  GtkSourceBuffer    $buffer,
  GtkTextIter        $start,
  GtkTextIter        $end,
  GtkSourceSortFlags $flags,
  gint               $column
)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_buffer_get_type ()
  returns GType
  is      native(sourceview)
  is      export
{ * }
