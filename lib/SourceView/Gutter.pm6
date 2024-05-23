use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use SourceView::Raw::Types;

use GTK::Enums:ver<4>;
use GTK::Widget:ver<4>;
use SourceView::View:ver<4>;

use GLib::Roles::Implementor;

our subset GtkSourceGutterAncestry is export of Mu
  where GtkSourceGutter | GtkWidgetAncestry;

class SourceView::Gutter:ver<4> is GTK::Widget:ver<4> {
  has GtkSourceGutter $!sg is implementor;

  submethod BUILD ( :$gtk-source-gutter ) {
    self.setGtkSourceGutter($gtk-source-gutter) if $gtk-source-gutter
  }

  method setGtkSourceGutter (GtkSourceGutterAncestry $_) {
    my $to-parent;

    $!sg = do {
      when GtkSourceGutter {
        $to-parent = cast(GtkWidget, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkSourceGutter, $_);
      }
    }
    self.setGtkWidget($to-parent);
  }

  method SourceView::Raw::Definitions::GtkSourceGutter
    is also<GtkSourceGutter>
  { $!sg }

  multi method new (
    $gtk-source-gutter where * ~~ GtkSourceGutterAncestry,

    :$ref = True
  ) {
    return unless $gtk-source-gutter;

    my $o = self.bless( :$gtk-source-gutter );
    $o.ref if $ref;
    $o;
  }

  # Type: GtkSourceView
  method view ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( SourceView::View.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('view', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |SourceView::View.getTypePair
        );
      },
      STORE => -> $,  $val is copy {
        $gv.GtkSourceTypeView = $val;
        self.prop_set('view', $gv);
      }
    );
  }

  # Type: GtkTextWindowType
  method window_type ( :$enum = True ) is rw  is g-property {
    my $gv = GLib::Value.new( GTK::Enums::TextWindowType.get_type; );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('window_type', $gv);
        my $t = $gv.enum;
        return $t unless $enum;
        GtkTextWindowTypeEnum($t);
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(GtkTextWindowType) = $val;
        self.prop_set('window_type', $gv);
      }
    );
  }

  method get_view ( :$raw = False ) is also<get-view> {
    propReturnObject(
      gtk_source_gutter_get_view($!sg),
      $raw,
      |SourceView::View.getTypePair
    );
  }

  method insert (
    GtkSourceGutterRenderer() $renderer,
    Int()                     $position  = 0
  ) {
    my gint $p = $position;

    gtk_source_gutter_insert($!sg, $renderer, $position);
  }

  method remove (GtkSourceGutterRenderer() $renderer) {
    gtk_source_gutter_remove($!sg, $renderer);
  }

  method reorder (
    GtkSourceGutterRenderer() $renderer,
    Int()                     $position
  ) {
    my gint $p = $position;

    gtk_source_gutter_reorder($!sg, $renderer, $position);
  }

}

### /usr/src/gtksourceview/gtksourceview/gtksourcegutter.h

sub gtk_source_gutter_get_view (GtkSourceGutter $gutter)
  returns GtkSourceView
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_gutter_insert (
  GtkSourceGutter         $gutter,
  GtkSourceGutterRenderer $renderer,
  gint                    $position
)
  returns uint32
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_gutter_remove (
  GtkSourceGutter         $gutter,
  GtkSourceGutterRenderer $renderer
)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_gutter_reorder (
  GtkSourceGutter         $gutter,
  GtkSourceGutterRenderer $renderer,
  gint                    $position
)
  is      native(sourceview)
  is      export
{ * }
