use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use SourceView::Raw::Definitions;
use SourceView::Raw::Enums;

unit package SourceView::Raw::File::Saver;

### /usr/src/gtksourceview/gtksourceview/gtksourcefilesaver.h

sub gtk_source_file_saver_error_quark
  returns GQuark
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_file_saver_get_buffer (GtkSourceFileSaver $saver)
  returns GtkSourceBuffer
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_file_saver_get_compression_type (GtkSourceFileSaver $saver)
  returns GtkSourceCompressionType
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_file_saver_get_encoding (GtkSourceFileSaver $saver)
  returns GtkSourceEncoding
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_file_saver_get_file (GtkSourceFileSaver $saver)
  returns GtkSourceFile
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_file_saver_get_flags (GtkSourceFileSaver $saver)
  returns GtkSourceFileSaverFlags
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_file_saver_get_location (GtkSourceFileSaver $saver)
  returns GFile
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_file_saver_get_newline_type (GtkSourceFileSaver $saver)
  returns GtkSourceNewlineType
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_file_saver_new (
  GtkSourceBuffer $buffer,
  GtkSourceFile   $file
)
  returns GtkSourceFileSaver
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_file_saver_new_with_target (
  GtkSourceBuffer $buffer,
  GtkSourceFile   $file,
  GFile           $target_location
)
  returns GtkSourceFileSaver
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_file_saver_save_async (
  GtkSourceFileSaver    $saver,
  gint                  $io_priority,
  GCancellable          $cancellable,
                        &progress_callback (goffset, goffset, gpointer),
  gpointer              $progress_callback_data,
                        &progress_callback_notify (gpointer),
                        &callback (
                          GtkSourceFileSaver,
                          GAsyncResult,
                          gpointer
                        ),
  gpointer              $user_data
)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_file_saver_save_finish (
  GtkSourceFileSaver      $saver,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_file_saver_set_compression_type (
  GtkSourceFileSaver       $saver,
  GtkSourceCompressionType $compression_type
)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_file_saver_set_encoding (
  GtkSourceFileSaver $saver,
  GtkSourceEncoding  $encoding
)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_file_saver_set_flags (
  GtkSourceFileSaver      $saver,
  GtkSourceFileSaverFlags $flags
)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_file_saver_set_newline_type (
  GtkSourceFileSaver   $saver,
  GtkSourceNewlineType $newline_type
)
  is      native(sourceview)
  is      export
{ * }
