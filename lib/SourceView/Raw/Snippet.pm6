use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use SourceView::Raw::Definitions:ver<4>;

unit package SourceView::Raw::Snippet;

### /usr/src/gtksourceview/gtksourceview/gtksourcesnippet.h

sub gtk_source_snippet_add_chunk (
  GtkSourceSnippet      $snippet,
  GtkSourceSnippetChunk $chunk
)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_snippet_copy (GtkSourceSnippet $snippet)
  returns GtkSourceSnippet
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_snippet_get_context (GtkSourceSnippet $snippet)
  returns GtkSourceSnippetContext
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_snippet_get_description (GtkSourceSnippet $snippet)
  returns Str
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_snippet_get_focus_position (GtkSourceSnippet $snippet)
  returns gint
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_snippet_get_language_id (GtkSourceSnippet $snippet)
  returns Str
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_snippet_get_n_chunks (GtkSourceSnippet $snippet)
  returns guint
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_snippet_get_name (GtkSourceSnippet $snippet)
  returns Str
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_snippet_get_nth_chunk (
  GtkSourceSnippet $snippet,
  guint            $nth
)
  returns GtkSourceSnippetChunk
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_snippet_get_trigger (GtkSourceSnippet $snippet)
  returns Str
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_snippet_new (
  Str $trigger,
  Str $language_id
)
  returns GtkSourceSnippet
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_snippet_new_parsed (
  Str                     $text,
  CArray[Pointer[GError]] $error
)
  returns GtkSourceSnippet
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_snippet_set_description (
  GtkSourceSnippet $snippet,
  Str              $description
)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_snippet_set_language_id (
  GtkSourceSnippet $snippet,
  Str              $language_id
)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_snippet_set_name (
  GtkSourceSnippet $snippet,
  Str              $name
)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_snippet_set_trigger (
  GtkSourceSnippet $snippet,
  Str              $trigger
)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_snippet_get_type ()
  returns GType
  is      native(sourceview)
  is      export
{ * }
