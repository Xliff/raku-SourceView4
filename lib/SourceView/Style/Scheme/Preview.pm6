use v6.c;

use Method::Also;

use NativeCall;

use GLib::Raw::Traits;
use SourceView::Raw::Types;

use GTK::Widget:ver<4>;
use SourceView::Style;

use GLib::Roles::Implementor;

our subset GtkSourceStyleSchemePreviewAncestry is export of Mu
  where GtkSourceStyleSchemePreview | GtkWidgetAncestry;

class SourceView::Style::Scheme::Preview:ver<4> is GTK::Widget:ver<4> {
  has GtkSourceStyleSchemePreview $!sssp is implementor;

  submethod BUILD ( :$gtk-scheme-preview ) {
    self.setGtkSourceStyleSchemePreview($gtk-scheme-preview)
      if $gtk-scheme-preview
  }

  method setGtkSourceStyleSchemePreview (
    GtkSourceStyleSchemePreviewAncestry $_
  ) {
    my $to-parent;

    $!sssp = do {
      when GtkSourceStyleSchemePreview {
        $to-parent = cast(GtkWidget, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkSourceStyleSchemePreview, $_);
      }
    }
    self.setGtkWidget($to-parent);
  }

  method SourceView::Raw::Definitions::GtkSourceStyleSchemePreview
    is also<GtkSourceStyleSchemePreview>
  { $!sssp }

  multi method new (
    $gtk-scheme-preview where * ~~ GtkSourceStyleSchemePreviewAncestry,

    :$ref = True
  ) {
    return unless $gtk-scheme-preview;

    my $o = self.bless( :$gtk-scheme-preview );
    $o.ref if $ref;
    $o;
  }

  multi method new ( GtkSourceStyleScheme() $scheme, *%a ) {
    my $gtk-scheme-preview = gtk_source_style_scheme_preview_new($scheme);

    my $o = $gtk-scheme-preview ?? self.bless( :$gtk-scheme-preview ) !! Nil;
    $o.setAttributes(%a) if $o && +%a;
    $o;
  }

  method scheme ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( SourceView::Style::Scheme.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('scheme', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |SourceView::Style::Scheme.getTypePair
        );
      },
      STORE => -> $, GtkSourceStyleScheme() $val is copy {
        $gv.object = $val;
        self.prop_set('scheme', $gv);
      }
    );
  }

  # Type: boolean
  method selected is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('selected', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('selected', $gv);
      }
    );
  }

  method Activate {
    self.connect($!sssp, 'activate');
  }

  method get_scheme ( :$raw = False ) is also<get-scheme> {
    propReturnObject(
      gtk_source_style_scheme_preview_get_scheme($!sssp),
      $raw,
      |SourceView::Style::Scheme.getTypePair
    );
  }

  method get_selected is also<get-selected> {
    gtk_source_style_scheme_preview_get_selected($!sssp);
  }

  method set_selected (Int() $selected) is also<set-selected> {
    my gboolean $s = $selected;

    gtk_source_style_scheme_preview_set_selected($!sssp, $selected);
  }
}

### /usr/src/gtksourceview/gtksourceview/gtksourcestyleschemepreview.h

sub gtk_source_style_scheme_preview_get_scheme (
  GtkSourceStyleSchemePreview $self
)
  returns GtkSourceStyleScheme
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_style_scheme_preview_get_selected (
  GtkSourceStyleSchemePreview $self
)
  returns uint32
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_style_scheme_preview_new (GtkSourceStyleScheme $scheme)
  returns GtkWidget
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_style_scheme_preview_set_selected (
  GtkSourceStyleSchemePreview $self,
  gboolean                    $selected
)
  is      native(sourceview)
  is      export
{ * }
