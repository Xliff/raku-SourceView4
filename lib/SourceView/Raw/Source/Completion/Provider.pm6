use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use GDK::Raw::Enums;
use GTK::Raw::Structs:ver<4>;
use SourceView::Raw::Definitions:ver<4>;

unit package SourceView::Raw::Source::Comletion::Provider:ver<4>;

### /usr/src/gtksourceview/gtksourceview/gtksourcecompletionprovider.h

sub gtk_source_completion_provider_activate (
  GtkSourceCompletionProvider $self,
  GtkSourceCompletionContext  $context,
  GtkSourceCompletionProposal $proposal
)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_completion_provider_display (
  GtkSourceCompletionProvider $self,
  GtkSourceCompletionContext  $context,
  GtkSourceCompletionProposal $proposal,
  GtkSourceCompletionCell     $cell
)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_completion_provider_get_priority (
  GtkSourceCompletionProvider $self,
  GtkSourceCompletionContext  $context
)
  returns gint
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_completion_provider_get_title (
  GtkSourceCompletionProvider $self
)
  returns Str
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_completion_provider_is_trigger (
  GtkSourceCompletionProvider $self,
  GtkTextIter                 $iter,
  gunichar                    $ch
)
  returns uint32
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_completion_provider_key_activates (
  GtkSourceCompletionProvider $self,
  GtkSourceCompletionContext  $context,
  GtkSourceCompletionProposal $proposal,
  guint                       $keyval,
  GdkModifierType             $state
)
  returns uint32
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_completion_provider_list_alternates (
  GtkSourceCompletionProvider $self,
  GtkSourceCompletionContext  $context,
  GtkSourceCompletionProposal $proposal
)
  returns GPtrArray
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_completion_provider_populate_async (
  GtkSourceCompletionProvider $self,
  GtkSourceCompletionContext  $context,
  GCancellable                $cancellable,
                              &callback (
                                GtkSourceCompletionProvider,
                                GAsyncResult,
                                gpointer
                              ),
  gpointer                    $user_data
)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_completion_provider_populate_finish (
  GtkSourceCompletionProvider $self,
  GAsyncResult                $result,
  CArray[Pointer[GError]]     $error
)
  returns GListModel
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_completion_provider_refilter (
  GtkSourceCompletionProvider $self,
  GtkSourceCompletionContext  $context,
  GListModel                  $model
)
  is      native(sourceview)
  is      export
{ * }
