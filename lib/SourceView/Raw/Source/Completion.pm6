use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use Pango::Raw::Definitions;
use GTK::Raw::Definitions:ver<4>;
use SourceView::Raw::Definitions:ver<4>;

unit package SourceView::Raw::Source::Completion:ver<4>;

### /usr/src/gtksourceview/gtksourceview/gtksourcecompletion.h

sub gtk_source_completion_add_provider (
  GtkSourceCompletion         $self,
  GtkSourceCompletionProvider $provider
)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_completion_block_interactive (GtkSourceCompletion $self)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_completion_fuzzy_highlight (
  Str $haystack,
  Str $casefold_query
)
  returns PangoAttrList
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_completion_fuzzy_match (
  Str   $haystack,
  Str   $casefold_needle,
  guint $priority         is rw
)
  returns uint32
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_completion_get_buffer (GtkSourceCompletion $self)
  returns GtkSourceBuffer
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_completion_get_page_size (GtkSourceCompletion $self)
  returns guint
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_completion_get_view (GtkSourceCompletion $self)
  returns GtkSourceView
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_completion_hide (GtkSourceCompletion $self)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_completion_remove_provider (
  GtkSourceCompletion         $self,
  GtkSourceCompletionProvider $provider
)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_completion_set_page_size (
  GtkSourceCompletion $self,
  guint               $page_size
)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_completion_show (GtkSourceCompletion $self)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_completion_unblock_interactive (GtkSourceCompletion $self)
  is      native(sourceview)
  is      export
{ * }
