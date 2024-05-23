use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use GIO::Raw::Structs;
use SourceView::Raw::Definitions;
use SourceView::Raw::Enums;

unit package SourceView::Raw::File::Loader;

### /usr/src/gtksourceview/gtksourceview/gtksourcefileloader.h

sub gtk_source_file_loader_error_quark
  returns GQuark
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_file_loader_get_buffer (GtkSourceFileLoader $loader)
  returns GtkSourceBuffer
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_file_loader_get_compression_type (GtkSourceFileLoader $loader)
  returns GtkSourceCompressionType
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_file_loader_get_encoding (GtkSourceFileLoader $loader)
  returns GtkSourceEncoding
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_file_loader_get_file (GtkSourceFileLoader $loader)
  returns GtkSourceFile
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_file_loader_get_input_stream (GtkSourceFileLoader $loader)
  returns GInputStream
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_file_loader_get_location (GtkSourceFileLoader $loader)
  returns GFile
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_file_loader_get_newline_type (GtkSourceFileLoader $loader)
  returns GtkSourceNewlineType
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_file_loader_load_async (
  GtkSourceFileLoader   $loader,
  gint                  $io_priority,
  GCancellable          $cancellable,
                        &progress_callback (gpointer),
  gpointer              $progress_callback_data,
                        &progress_callback_notify (gpointer),
                        &callback (
                          GtkSourceFileLoader,
                          GAsyncResult,
                          gpointer
                        ),
  gpointer              $user_data
)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_file_loader_load_finish (
  GtkSourceFileLoader     $loader,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_file_loader_new (
  GtkSourceBuffer $buffer,
  GtkSourceFile   $file
)
  returns GtkSourceFileLoader
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_file_loader_new_from_stream (
  GtkSourceBuffer $buffer,
  GtkSourceFile   $file,
  GInputStream    $stream
)
  returns GtkSourceFileLoader
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_file_loader_set_candidate_encodings (
  GtkSourceFileLoader $loader,
  GSList              $candidate_encodings
)
  is      native(sourceview)
  is      export
{ * }
