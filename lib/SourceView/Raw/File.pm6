use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GIO::Raw::Definitions;
use SourceView::Raw::Definitions;
use SourceView::Raw::Enums;

unit package SourceView::Raw::Source::File;

### /usr/src/gtksourceview/gtksourceview/gtksourcefile.h

sub gtk_source_file_check_file_on_disk (GtkSourceFile $file)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_file_get_compression_type (GtkSourceFile $file)
  returns GtkSourceCompressionType
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_file_get_encoding (GtkSourceFile $file)
  returns GtkSourceEncoding
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_file_get_location (GtkSourceFile $file)
  returns GFile
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_file_get_newline_type (GtkSourceFile $file)
  returns GtkSourceNewlineType
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_file_is_deleted (GtkSourceFile $file)
  returns uint32
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_file_is_externally_modified (GtkSourceFile $file)
  returns uint32
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_file_is_local (GtkSourceFile $file)
  returns uint32
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_file_is_readonly (GtkSourceFile $file)
  returns uint32
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_file_new
  returns GtkSourceFile
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_file_set_location (
  GtkSourceFile $file,
  GFile         $location
)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_file_set_mount_operation_factory (
  GtkSourceFile $file,
                &callback (gpointer),
  gpointer      $user_data,
                &notify (gpointer)
)
  is      native(sourceview)
  is      export
{ * }
