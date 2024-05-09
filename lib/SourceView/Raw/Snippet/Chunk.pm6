use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use SourceView::Raw::Definitions:ver<4>;

unit package SourceView::Raw::Snippet::Chunk;

### /usr/src/gtksourceview/gtksourceview/gtksourcesnippetchunk.h

sub gtk_source_snippet_chunk_copy (GtkSourceSnippetChunk $chunk)
  returns GtkSourceSnippetChunk
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_snippet_chunk_get_context (GtkSourceSnippetChunk $chunk)
  returns GtkSourceSnippetContext
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_snippet_chunk_get_focus_position (GtkSourceSnippetChunk $chunk)
  returns gint
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_snippet_chunk_get_spec (GtkSourceSnippetChunk $chunk)
  returns Str
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_snippet_chunk_get_text (GtkSourceSnippetChunk $chunk)
  returns Str
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_snippet_chunk_get_text_set (GtkSourceSnippetChunk $chunk)
  returns uint32
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_snippet_chunk_get_tooltip_text (GtkSourceSnippetChunk $chunk)
  returns Str
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_snippet_chunk_new
  returns GtkSourceSnippetChunk
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_snippet_chunk_set_context (
  GtkSourceSnippetChunk   $chunk,
  GtkSourceSnippetContext $context
)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_snippet_chunk_set_focus_position (
  GtkSourceSnippetChunk $chunk,
  gint                  $focus_position
)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_snippet_chunk_set_spec (
  GtkSourceSnippetChunk $chunk,
  Str                   $spec
)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_snippet_chunk_set_text (
  GtkSourceSnippetChunk $chunk,
  Str                   $text
)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_snippet_chunk_set_text_set (
  GtkSourceSnippetChunk $chunk,
  gboolean              $text_set
)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_snippet_chunk_set_tooltip_text (
  GtkSourceSnippetChunk $chunk,
  Str                   $tooltip_text
)
  is      native(sourceview)
  is      export
{ * }
