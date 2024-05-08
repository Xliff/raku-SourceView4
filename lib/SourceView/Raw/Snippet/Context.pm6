use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use SourceView::Raw::Definitions:ver<4>;

unit package SourceView::Raw::Snippet::Context;

### /usr/src/gtksourceview/gtksourceview/gtksourcesnippetcontext.h

sub gtk_source_snippet_context_clear_variables (GtkSourceSnippetContext $self)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_snippet_context_expand (
  GtkSourceSnippetContext $self,
  Str                     $input
)
  returns Str
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_snippet_context_get_variable (
  GtkSourceSnippetContext $self,
  Str                     $key
)
  returns Str
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_snippet_context_new
  returns GtkSourceSnippetContext
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_snippet_context_set_constant (
  GtkSourceSnippetContext $self,
  Str                     $key,
  Str                     $value
)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_snippet_context_set_line_prefix (
  GtkSourceSnippetContext $self,
  Str                     $line_prefix
)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_snippet_context_set_tab_width (
  GtkSourceSnippetContext $self,
  gint                    $tab_width
)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_snippet_context_set_use_spaces (
  GtkSourceSnippetContext $self,
  gboolean                $use_spaces
)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_snippet_context_set_variable (
  GtkSourceSnippetContext $self,
  Str                     $key,
  Str                     $value
)
  is      native(sourceview)
  is      export
{ * }
