use v6.c;

use Method::Also;
use NativeCall;

use SourceView::Raw::Types;
use SourceView::Raw::Style::Scheme::Manager;

use GLib::Roles::Implementor;
use GLib::Roles::Object;


our subset GtkSourceStyleSchemeManagerAncestry is export of Mu
  where GtkSourceStyleSchemeManager | GObject;

class SourceView::Style::Scheme::Manager {
  also does Iterable;
  also does Positional;
  also does GLib::Roles::Object;

  has GtkSourceStyleSchemeManager $!sssm is implementor;

  submethod BUILD ( :$gtk-scheme-manager ) {
    self.setGtkSourceStyleSchemeManager($gtk-scheme-manager)
      if $gtk-scheme-manager
  }

  method setGtkSourceStyleSchemeManager (
    GtkSourceStyleSchemeManagerAncestry $_
  ) {
    my $to-parent;

    $!sssm = do {
      when GtkSourceStyleSchemeManager {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkSourceStyleSchemeManager, $_);
      }
    }
    self!setObject($to-parent);
  }

  method SourceView::Raw::Definitions::GtkSourceStyleSchemeManager
    is also<GtkStyleSchemeManager>
  { $!sssm }

  multi method new (
    $gtk-scheme-manager where * ~~ GtkSourceStyleSchemeManagerAncestry,

    :$ref = True
  ) {
    return unless $gtk-scheme-manager;

    my $o = self.bless( :$gtk-scheme-manager );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $gtk-scheme-manager = gtk_source_style_scheme_manager_new();

    $gtk-scheme-manager ?? self.bless( :$gtk-scheme-manager ) !! Nil;
  }

  # Type: GtkSourceStrv
  method scheme-ids ( :$raw = False )
    is rw
    is g-property
    is also<scheme_ids>
  {
    my $gv = GLib::Value.new( G_TYPE_POINTER );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('scheme-ids', $gv);
        my $ca = cast(CArray[Str], $gv.pointer);
        return $ca if $raw;
        CStringArrayToArray($ca);
      },
      STORE => -> $,  $val is copy {
        warn 'scheme-ids does not allow writing'
      }
    );
  }

  # Type: GtkSourceStrv
  method search-path ( :$raw = False )
    is rw
    is g-property
    is also<search_path>
  {
    my $gv = GLib::Value.new( G_TYPE_POINTER );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('search-path', $gv);
        my $ca = cast(CArray[Str], $gv.pointer);
        return $ca if $raw;
        CStringArrayToArray($ca);
      },
      STORE => -> $, $val is copy {
        if $val !~~ CArray[Str] {
          $val = do given $val {
            when Array {
              $_ = newCArray(Str, $_);
            }

            when Pointer {
              $_ = cast(CArray[Str], $_);
            }

            default {
              X::GLib::InvalidType.new(
                message => "Value must be compatible to a CArray[Str]!"
              ).throw;
            }
          }
        }
        $gv.pointer = $val;
        self.prop_set('search-path', $gv);
      }
    );
  }

  method append_search_path (Str() $path) is also<append-search-path> {
    gtk_source_style_scheme_manager_append_search_path($!sssm, $path);
  }

  method force_rescan is also<force-rescan> {
    gtk_source_style_scheme_manager_force_rescan($!sssm);
  }

  method get_default ( :$raw = False ) is also<get-default> {
    my $gtk-scheme-manager = gtk_source_style_scheme_manager_get_default();

    return Nil                 unless $gtk-scheme-manager;
    return $gtk-scheme-manager if     $raw;

    self.bless( :$gtk-scheme-manager )
  }

  method get_scheme (Str() $scheme_id, :$raw = False) is also<get-scheme> {
    propReturnObject(
      gtk_source_style_scheme_manager_get_scheme($!sssm, $scheme_id),
      $raw,
      |SourceView::Style::Scheme.getTypePair
    );
  }

  method get_scheme_ids ( :$raw = False ) is also<get-scheme-ids> {
    my $ca = gtk_source_style_scheme_manager_get_scheme_ids($!sssm);
    return $ca if $raw;
    CStringArrayToArray($ca);
  }

  method get_search_path is also<get-search-path> {
    gtk_source_style_scheme_manager_get_search_path($!sssm);
  }

  method prepend_search_path (Str() $path) is also<prepend-search-path> {
    gtk_source_style_scheme_manager_prepend_search_path($!sssm, $path);
  }

  proto method set_search_path (|)
    is also<set-search-path>
  { * }

  multi method set_search_path ($path) {
    samewith( resolveBuffer($path) );
  }
  multi method set_search_path (CArray[Str] $path) {
    gtk_source_style_scheme_manager_set_search_path($!sssm, $path);
  }

  method AT-POS (\k) {
    my $names = self.get_scheme_ids;
    return Nil unless k < $names.elems;
    $names[k];
  }

  method EXITS-POS (\k) {
    self.AT-POS(k).defined;
  }

  method iterator {
    my $self  = self;
    my $names = self.get_scheme_ids;

    (
      class :: does Iterator {
        has $.index is rw = 0;

        method pull-one is also<pull_one> {
          $!index++ while $names.elems > $!index;
          $names.elems > $!index
            ?? $self.get-scheme( $names[$!index] ) !! IterationEnd;
        }
      }
    ).new;
  }
}
