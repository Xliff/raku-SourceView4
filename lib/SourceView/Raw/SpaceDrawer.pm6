use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use GIO::Raw::Enums;
use SourceView::Raw::Definitions:ver<4>;
use SourceView::Raw::Enums:ver<4>;

unit package SourceView::Raw::SpaceDrawer:ver<4>;

### /usr/src/gtksourceview/gtksourceview/gtksourcespacedrawer.h

sub gtk_source_space_drawer_bind_matrix_setting (
  GtkSourceSpaceDrawer $drawer,
  GSettings            $settings,
  Str                  $key,
  GSettingsBindFlags   $flags
)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_space_drawer_get_enable_matrix (GtkSourceSpaceDrawer $drawer)
  returns uint32
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_space_drawer_get_matrix (GtkSourceSpaceDrawer $drawer)
  returns GVariant
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_space_drawer_get_types_for_locations (
  GtkSourceSpaceDrawer        $drawer,
  GtkSourceSpaceLocationFlags $locations
)
  returns GtkSourceSpaceTypeFlags
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_space_drawer_new
  returns GtkSourceSpaceDrawer
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_space_drawer_set_enable_matrix (
  GtkSourceSpaceDrawer $drawer,
  gboolean             $enable_matrix
)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_space_drawer_set_matrix (
  GtkSourceSpaceDrawer $drawer,
  GVariant             $matrix
)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_space_drawer_set_types_for_locations (
  GtkSourceSpaceDrawer        $drawer,
  GtkSourceSpaceLocationFlags $locations,
  GtkSourceSpaceTypeFlags     $types
)
  is      native(sourceview)
  is      export
{ * }
