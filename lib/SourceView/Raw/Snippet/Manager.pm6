use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GIO::Raw::Definitions;
use SourceView::Raw::Definitions:ver<4>;

unit package SourceView::Raw::Snippet::Manager:ver<4>;

### /usr/src/gtksourceview/gtksourceview/gtksourcesnippetmanager.h

sub gtk_source_snippet_manager_get_default
  returns GtkSourceSnippetManager
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_snippet_manager_get_search_path (GtkSourceSnippetManager $self)
  returns Str
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_snippet_manager_get_snippet (
  GtkSourceSnippetManager $self,
  Str                     $group,
  Str                     $language_id,
  Str                     $trigger
)
  returns GtkSourceSnippet
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_snippet_manager_list_all (GtkSourceSnippetManager $self)
  returns GListModel
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_snippet_manager_list_groups (GtkSourceSnippetManager $self)
  returns Str
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_snippet_manager_list_matching (
  GtkSourceSnippetManager $self,
  Str                     $group,
  Str                     $language_id,
  Str                     $trigger_prefix
)
  returns GListModel
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_snippet_manager_set_search_path (
  GtkSourceSnippetManager $self,
  CArray[Str]             $dirs
)
  is      native(sourceview)
  is      export
{ * }
