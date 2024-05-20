use v6.c;

use Method::Also;

use SourceView::Raw::Types;
use SourceView::Raw::Gutter::Renderer;

use GTK::Widget:ver<4>;
use SourceView::Buffer;
use SourceView::View;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GtkSourceGutterRendererAncestry is export of Mu
  where GtkSourceGutterRenderer | GtkWidgetAncestry;

class SourceView::Gutter::Renderer is GTK::Widget:ver<4> {
  has GtkSourceGutterRenderer $!sgr is implementor;

  submethod BUILD ( :$gtk-gutter-renderer ) {
    self.setGtkSourceGutterRenderer($gtk-gutter-renderer)
      if $gtk-gutter-renderer
  }

  method setGtkSourceGutterRenderer (GtkSourceGutterRendererAncestry $_) {
    my $to-parent;

    $!sgr = do {
      when GtkSourceGutterRenderer {
        $to-parent = cast(GtkWidget, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkSourceGutterRenderer, $_);
      }
    }
    self.setGtkWidget($to-parent);
  }

  method SourceView::Raw::Definitions::GtkSourceGutterRenderer
    is also<GtkSourceGutterRenderer>
  { $!sgr }

  multi method new (
    $gtk-gutter-renderer where * ~~ GtkSourceGutterRendererAncestry,

    :$ref = True
  ) {
    return unless $gtk-gutter-renderer;

    my $o = self.bless( :$gtk-gutter-renderer );
    $o.ref if $ref;
    $o;
  }

  # Type: GtkSourceTypeGutterRendererAlignmentMode
  method alignment-mode ( :$enum = True )
    is rw
    is g-property
    is also<alignment_mode>
  {
    my $gv = GLib::Value.new(
      SourceView::Enums::RendererAlignmentMode.get_type
    );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('alignment-mode', $gv);
        my $m = $gv.enum;
        return $m unless $enum;
        GtkSourceGutterRendererAlignmentModeEnum($m);
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(GtkSourceGutterRendererAlignmentMode) = $val;
        self.prop_set('alignment-mode', $gv);
      }
    );
  }

  # Type: GtkSourceTypeGutterLines
  method lines is rw  is g-property {
    my $gv = GLib::Value.new( SourceView::Guttter::Renderer::Lines.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('lines', $gv);
        $gv.GtkSourceTypeGutterLines;
      },
      STORE => -> $,  $val is copy {
        warn 'lines does not allow writing'
      }
    );
  }

  # Type: GtkSourceTextView
  method view is rw  is g-property {
    my $gv = GLib::Value.new( SourceView::View.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('view', $gv);
        $gv.GtkSourceTextView;
      },
      STORE => -> $,  $val is copy {
        warn 'view does not allow writing'
      }
    );
  }

  # Type: float
  method xalign is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_FLOAT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('xalign', $gv);
        $gv.float;
      },
      STORE => -> $, Num() $val is copy {
        $gv.float = $val;
        self.prop_set('xalign', $gv);
      }
    );
  }

  # Type: int
  method xpad is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('xpad', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('xpad', $gv);
      }
    );
  }

  # Type: float
  method yalign is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_FLOAT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('yalign', $gv);
        $gv.float;
      },
      STORE => -> $, Num() $val is copy {
        $gv.float = $val;
        self.prop_set('yalign', $gv);
      }
    );
  }

  # Type: int
  method ypad is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('ypad', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('ypad', $gv);
      }
    );
  }

  # Is originally:
  # GtkSourceGutterRenderer *renderer,  GtkTextIter *iter,  GdkRectangle *area,  guint button,  GdkModifierType state,  gint n_presses --> void
  method Activate {
    self.connect-activate($!sgr);
  }

  # Is originally:
  # GtkSourceGutterRenderer *renderer,  GtkTextIter *iter,  GdkRectangle *area --> gboolean
  method Query-Activatable is also<Query_Activatable> {
    self.connect-query-activatable($!sgr);
  }

  # Is originally:
  # GtkSourceGutterRenderer *renderer,  GtkSourceGutterLines *lines,  guint line --> void
  method Query-Data is also<Query_Data> {
    self.connect-query-data($!sgr);
  }

  method activate (
    GtkTextIter()  $iter,
    GdkRectangle() $area,
    Int()          $button,
    Int()          $state,
    Int()          $n_presses
  ) {
    my guint            $b = $button;
    my gint             $n = $n_presses;
    my GdkModifierType  $s =  $state;

    gtk_source_gutter_renderer_activate($!sgr, $iter, $area, $b, $s, $n);
  }

  proto method align_cell (|)
  { * }

  multi method align_cell ($line, $width, $height) {
    samewith($line, $width, $height, $, $);
  }
  multi method align_cell (
    Int()  $line,
    Num()  $width,
    Num()  $height,
           $x       is rw,
           $y       is rw
  )
    is also<align-cell>
  {
    my guint   $l                = $line;
    my gfloat ($w, $h, $xx, $yy) = ($width, $height, 0e0, 0e0);

    gtk_source_gutter_renderer_align_cell($!sgr, $l, $w, $h, $xx, $yy);
    ($x, $y) = ($xx, $yy);
  }

  method get_alignment_mode ( :$enum = True ) is also<get-alignment-mode> {
    my $m = gtk_source_gutter_renderer_get_alignment_mode($!sgr);
    return $m unless $enum;
    GtkSourceGutterRendererAlignmentModeEnum($m);
  }

  method get_buffer ( :$raw = False ) is also<get-buffer> {
    propReturnObject(
      gtk_source_gutter_renderer_get_buffer($!sgr),
      $raw,
      |SourceView::Buffer.getTypePair
    );
  }

  method get_view ( :$raw = False ) is also<get-view> {
    propReturnObject(
      gtk_source_gutter_renderer_get_view($!sgr),
      $raw,
      |SourceView::View.getTypePair
    );
  }

  method get_xalign is also<get-xalign> {
    gtk_source_gutter_renderer_get_xalign($!sgr);
  }

  method get_xpad is also<get-xpad> {
    gtk_source_gutter_renderer_get_xpad($!sgr);
  }

  method get_yalign is also<get-yalign> {
    gtk_source_gutter_renderer_get_yalign($!sgr);
  }

  method get_ypad is also<get-ypad> {
    gtk_source_gutter_renderer_get_ypad($!sgr);
  }

  method query_activatable (GtkTextIter() $iter, GdkRectangle() $area)
    is also<query-activatable>
  {
    gtk_source_gutter_renderer_query_activatable($!sgr, $iter, $area);
  }

  method set_alignment_mode (GtkSourceGutterRendererAlignmentMode $mode) is also<set-alignment-mode> {
    my GtkSourceGutterRendererAlignmentMode $m = $mode;

    gtk_source_gutter_renderer_set_alignment_mode($!sgr, $m);
  }

  method set_xalign (Num() $xalign) is also<set-xalign> {
    my gfloat $x = $xalign;

    gtk_source_gutter_renderer_set_xalign($!sgr, $x);
  }

  method set_xpad (Int() $xpad) is also<set-xpad> {
    my gint $x = $xpad;

    gtk_source_gutter_renderer_set_xpad($!sgr, $x);
  }

  method set_yalign (Num() $yalign) is also<set-yalign> {
    my gfloat $y = $yalign;

    gtk_source_gutter_renderer_set_yalign($!sgr, $y);
  }

  method set_ypad (Int() $ypad) is also<set-ypad> {
    my gint $y = $ypad;

    gtk_source_gutter_renderer_set_ypad($!sgr, $y);
  }

}
