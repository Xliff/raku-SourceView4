use v6.c;

use Method::Also;

use SourceView::Raw::Types;
use SourceView::Raw::SpaceDrawer;

use JSON::Fast;
use GLib::Variant;
use JSON::GLib::Variant;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GtkSourceSpaceDrawerAncestry is export of Mu
  where GtkSourceSpaceDrawer | GObject;

class SourceView::SpaceDrawer {
  also does GLib::Roles::Object;

  has GtkSourceSpaceDrawer $!sd is implementor;

  submethod BUILD ( :$gtk-space-drawer ) {
    self.setGtkSourceSpaceDrawer($gtk-space-drawer) if $gtk-space-drawer
  }

  method setGtkSourceSpaceDrawer (GtkSourceSpaceDrawerAncestry $_) {
    my $to-parent;

    $!sd = do {
      when GtkSourceSpaceDrawer {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkSourceSpaceDrawer, $_);
      }
    }
    self!setObject($to-parent);
  }

  method SourceView::Raw::Definitions::GtkSourceSpaceDrawer
    is also<GtkSourceSpaceDrawer>
  { $!sd }

  multi method new (
    $gtk-space-drawer where * ~~ GtkSourceSpaceDrawerAncestry,

    :$ref = True
  ) {
    return unless $gtk-space-drawer;

    my $o = self.bless( :$gtk-space-drawer );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $gtk-source-drawer = gtk_source_space_drawer_new();

    $gtk-source-drawer ?? self.bless( :$gtk-source-drawer ) !! Nil;
  }

  # Type: boolean
  method enable-matrix is rw  is g-property is also<enable_matrix> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('enable-matrix', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('enable-matrix', $gv);
      }
    );
  }

  # Type: GVariant
  method matrix ( :$raw = False, :$variant = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GLib::Variant.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('matrix', $gv);
        my $v = propReturnObject(
          $gv.pointer,
          $raw,
          |GLib::Variant.getTypePair
        );
        return $v if $variant;
        JSON::GLib::Variant.serialize-data($v).&from-json
      },
      STORE => -> $, GVariant() $val is copy {
        $gv.pointer = $val;
        self.prop_set('matrix', $gv);
      }
    );
  }

  method bind_matrix_setting (
    GSettings() $settings,
    Str()       $key,
    Int()       $flags
  )
    is also<bind-matrix-setting>
  {
    my GSettingsBindFlags $f = $flags;

    gtk_source_space_drawer_bind_matrix_setting($!sd, $settings, $key, $f);
  }

  method get_enable_matrix is also<get-enable-matrix> {
    so gtk_source_space_drawer_get_enable_matrix($!sd);
  }

  method get_matrix ( :$raw = False, :$variant = False ) is also<get-matrix> {
    my $v = gtk_source_space_drawer_get_matrix($!sd);
    return $v if $variant;
    JSON::GLib::Variant.serialize-data($v).&from-json
  }

  method get_types_for_locations (Int() $locations)
    is also<get-types-for-locations>
  {
    my GtkSourceSpaceLocationFlags $l = $locations;

    gtk_source_space_drawer_get_types_for_locations($!sd, $l);
  }

  method set_enable_matrix (Int() $enable_matrix) is also<set-enable-matrix> {
    my gboolean $e = $enable_matrix.so.Int;

    gtk_source_space_drawer_set_enable_matrix($!sd, $e);
  }

  proto method set_matrix (|)
    is also<set-matrix>
  { * }

  multi method set_matrix (@matrix)  {
    # cw: GVariant of "au"
    samewith( JSON::GLib::Variant.deserialize( @matrix.&to-json, 'au' ) );
  }
  multi method set_matrix (GVariant() $matrix) {
    gtk_source_space_drawer_set_matrix($!sd, $matrix);
  }

  method set_types_for_locations (Int() $locations, Int() $types)
    is also<set-types-for-locations>
  {
    my GtkSourceSpaceLocationFlags $l = $locations;
    my GtkSourceSpaceTypeFlags     $t = $types;

    gtk_source_space_drawer_set_types_for_locations($!sd, $l, $t);
  }

}
