use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use SourceView::Raw::Definitions;

unit package SourceView::Raw::Language::Manager;

### /usr/src/gtksourceview/gtksourceview/gtksourcelanguagemanager.h

sub gtk_source_language_manager_append_search_path (
  GtkSourceLanguageManager $lm,
  Str                      $path
)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_language_manager_get_default
  returns GtkSourceLanguageManager
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_language_manager_get_language (
  GtkSourceLanguageManager $lm,
  Str                      $id
)
  returns GtkSourceLanguage
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_language_manager_get_language_ids (GtkSourceLanguageManager $lm)
  returns CArray[Str]
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_language_manager_get_search_path (GtkSourceLanguageManager $lm)
  returns CArray[Str]
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_language_manager_guess_language (
  GtkSourceLanguageManager $lm,
  Str                      $filename,
  Str                      $content_type
)
  returns GtkSourceLanguage
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_language_manager_new
  returns GtkSourceLanguageManager
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_language_manager_prepend_search_path (
  GtkSourceLanguageManager $lm,
  Str                      $path
)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_language_manager_set_search_path (
  GtkSourceLanguageManager $lm,
  CArray[Str]              $dirs
)
  is      native(sourceview)
  is      export
{ * }
