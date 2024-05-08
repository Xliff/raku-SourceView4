use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use SourceView::Raw::Types;
use SourceView::Raw::Source::Completion::Cell;

use GTK::Widget:ver<4>;

use GLib::Roles::Implementor;

our subset GtkSourceCompletionCellAncestry is export of Mu
  where GtkSourceCompletionCell | GtkWidgetAncestry;

class SourceView::Source::Completion::Cell is GTK::Widget:ver<4> {
  has GtkSourceCompletionCell $!scc is implementor;

  submethod BUILD ( :$gtk-comp-cell ) {
    self.setGtkSourceCompletionCell($gtk-comp-cell) if $gtk-comp-cell
  }

  method setGtkSourceCompletionCell (GtkSourceCompletionCellAncestry $_) {
    my $to-parent;

    $!scc = do {
      when GtkSourceCompletionCell {
        $to-parent = cast(GtkWidget, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkSourceCompletionCell, $_);
      }
    }
    self.setGtkWidget($to-parent);
  }

  method SourceView::Raw::Definitions::GtkSourceCompletionCell
    is also<GtkSourceCompletionCell>
  { $!scc }

  multi method new (
    $gtk-comp-cell where * ~~ GtkSourceCompletionCellAncestry,

    :$ref = True
  ) {
    return unless $gtk-comp-cell;

    my $o = self.bless( :$gtk-comp-cell );
    $o.ref if $ref;
    $o;
  }

  # Type: GtkSourceTypeCompletionColumn
  method column ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( SourceView::Completion::Column.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('column', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |SoruceView::Completion::Column.getTypePair
        );
      },
      STORE => -> $, GtkSourceCompletionColumn() $val is copy {
        $gv.object = $val;
        self.prop_set('column', $gv);
      }
    );
  }

  # Type: string
  method markup is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('markup', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('markup', $gv);
      }
    );
  }

  # Type: GdkPaintable
  method paintable ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GDK::Paintable.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('paintable', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GDK::Paintable.getTypePair
        );
      },
      STORE => -> $, GdkPaintable() $val is copy {
        $gv.object = $val;
        self.prop_set('paintable', $gv);
      }
    );
  }

  # Type: string
  method text is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('text', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('text', $gv);
      }
    );
  }

  # Type: GtkWidget
  method widget (
    :$raw           = False,
    :quick(:$fast)  = False,
    :slow(:$proper) = $fast.not
  )
    is rw
    is g-property
  {
    my $gv = GLib::Value.new( GTK::Widget.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('widget', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          $proper
        );
      },
      STORE => -> $, GtkWidget() $val is copy {
        $gv.object = $val;
        self.prop_set('widget', $gv);
      }
    );
  }

  method get_column ( :$raw = False ) is also<get-column> {
    propReturnObject(
      gtk_source_completion_cell_get_column($!scc),
      $raw,
      |SourceView::Completion::Column.getTypePair
    );
  }

  method get_type {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &gtk_source_completion_cell_get_type,
      $n,
      $t
    );
  }

  method get_widget (
    :$raw           = False,
    :quick(:$fast)  = False,
    :slow(:$proper) = $fast.not
  )
    is also<get-widget>
  {
    returnProperWidget(
      gtk_source_completion_cell_get_widget($!scc),
      $raw,
      $proper
    );
  }

  method set_gicon (GIcon() $gicon) is also<set-gicon> {
    gtk_source_completion_cell_set_gicon($!scc, $gicon);
  }

  method set_icon_name (Str() $icon_name) is also<set-icon-name> {
    gtk_source_completion_cell_set_icon_name($!scc, $icon_name);
  }

  method set_markup (Str() $markup) is also<set-markup> {
    gtk_source_completion_cell_set_markup($!scc, $markup);
  }

  method set_paintable (GdkPaintable() $paintable) is also<set-paintable> {
    gtk_source_completion_cell_set_paintable($!scc, $paintable);
  }

  method set_text (Str() $text) is also<set-text> {
    gtk_source_completion_cell_set_text($!scc, $text);
  }

  method set_text_with_attributes (Str() $text, PangoAttrList() $attrs)
    is also<set-text-with-attributes>
  {
    gtk_source_completion_cell_set_text_with_attributes($!scc, $text, $attrs);
  }

  method set_widget (GtkWidget() $child) is also<set-widget> {
    gtk_source_completion_cell_set_widget($!scc, $child);
  }

}
