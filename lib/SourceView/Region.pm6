use v6.c;

use Method::Also;

use SourceView::Raw::Types;
use SourceView::Raw::Region;

use GTK::Text::Iter:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GtkSourceRegionAncestry is export of Mu
  where GtkSourceRegion | GObject;

class SourceView::Region::Iter { ... }

class SourceView::Region {
  also does GLib::Roles::Object;

  has GtkSourceRegion $!sr is implementor;

  submethod BUILD ( :$gtk-source-region ) {
    self.setGtkSourceRegion($gtk-source-region) if $gtk-source-region
  }

  method setGtkSourceRegion (GtkSourceRegionAncestry $_) {
    my $to-parent;

    $!sr = do {
      when GtkSourceRegion {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkSourceRegion, $_);
      }
    }
    self!setObject($to-parent);
  }

  method SourceView::Raw::Definitions::GtkSourceRegion
    is also<GtkSourceRegion>
  { $!sr }

  multi method new (
    $gtk-source-region where * ~~ GtkSourceRegionAncestry,

    :$ref = True
  ) {
    return unless $gtk-source-region;

    my $o = self.bless( :$gtk-source-region );
    $o.ref if $ref;
    $o;
  }
  multi method new (GtkTextBuffer() $buffer, *%a) {
    my $gtk-source-region = gtk_source_region_new($buffer);

    my $o = $gtk-source-region ?? self.bless( :$gtk-source-region ) !! Nil;
    $o.setAttributes(%a) if $o && +%a;
    $o;
  }

  # Type: GtkSourceTextBuffer
  method buffer ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( SourceView::Buffer.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('buffer', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |SourceView::Buffer.getTypePair
        );
      },
      STORE => -> $, GtkSourceBuffer() $val is copy {
        $gv.object = $val;
        self.prop_set('buffer', $gv);
      }
    );
  }

  method add_region (GtkSourceRegion() $region_to_add) is also<add-region> {
    gtk_source_region_add_region($!sr, $region_to_add);
  }

  method add_subregion (GtkTextIter() $start, GtkTextIter() $end)
    is also<add-subregion>
  {
    gtk_source_region_add_subregion($!sr, $start, $end);
  }

  proto method get_bounds (|)
    is also<get-bounds>
  { * }

  multi method get_bounds ( :$raw = False, :$region = True ) {
    my ($s, $e) = GtkTextIter.new xx 2;

    samewith($s, $e);
    return ($s, $e) if $raw;
    ($s, $e).map({
      ( $region ?? SourceView::Region::Iter !! GTK::Text::Iter ).new($_)
    });
  }
  multi method get_bounds (GtkTextIter() $start, GtkTextIter() $end) {
    gtk_source_region_get_bounds($!sr, $start, $end);
  }

  method get_buffer ( :$raw = False ) is also<get-buffer> {
    propReturnObject(
      gtk_source_region_get_buffer($!sr),
      $raw,
      |SourceView::Buffer.getTypePair
    );
  }

  proto method get_start_region_iter (|)
    is also<get-start-region-iter>
  { * }

  multi method get_start_region_iter ( :$raw = False ) {
    my $s = GtkSourceRegionIter.new;
    samewith($s);
    $s = Source::Region::Iter.new($s) unless $raw;
    $s;
  }
  multi method get_start_region_iter (GtkSourceRegionIter() $iter) {
    gtk_source_region_get_start_region_iter($!sr, $iter);
  }

  method intersect_region (GtkSourceRegion() $region2)
    is also<intersect-region>
  {
    so gtk_source_region_intersect_region($!sr, $region2);
  }

  method intersect_subregion (GtkTextIter() $start, GtkTextIter() $end)
    is also<intersect-subregion>
  {
    so gtk_source_region_intersect_subregion($!sr, $start, $end);
  }

  method is_empty is also<is-empty> {
    so gtk_source_region_is_empty($!sr);
  }

  method subtract_region (GtkSourceRegion() $region_to_subtract)
    is also<subtract-region>
  {
    gtk_source_region_subtract_region($!sr, $region_to_subtract);
  }

  method subtract_subregion (GtkTextIter() $start, GtkTextIter() $end)
    is also<subtract-subregion>
  {
    gtk_source_region_subtract_subregion($!sr, $start, $end);
  }

  method to_string is also<to-string> {
    gtk_source_region_to_string($!sr);
  }

}

# BOXED
class SourceView::Region::Iter {
  has GtkSourceRegionIter $!sri is implementor;

  submethod BUILD ( :$gtk-region-iter ) {
    $!sri = $gtk-region-iter if $gtk-region-iter
  }

  method SourceView::Raw::Structs::GtkSourceRegionIter
    is also<GtkSourceRegionIter>
  { $!sri }

  proto method get_subregion (|)
    is also<get-subregion>
  { * }

  multi method get_subregion ( :$raw = False, :$region = True ) {
    my ($s, $e) = GtkTextIter.new xx 2;

    samewith($s, $e);
    return ($s, $e) if $raw;
    ($s, $e).map({
      ( $region ?? ::?CLASS !! GTK::Text::Iter ).new($_)
    });
  }
  multi method get_subregion (GtkTextIter() $start, GtkTextIter() $end) {
    gtk_source_region_iter_get_subregion($!sri, $start, $end);
  }

  method is_end is also<is-end> {
    gtk_source_region_iter_is_end($!sri);
  }

  method next {
    gtk_source_region_iter_next($!sri);
  }

}
