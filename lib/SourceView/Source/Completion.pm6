use v6.c;

use Method::Also;

use SourceView::Raw::Types;
use SourceView::Raw::Source::Completion;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GtkSourceCompletionAncestry is export of Mu
  where GtkSourceCompletion | GObject;

class SourceView::Source::Completion {
  also does GLib::Roles::Object;

  has GtkSourceCompletion $!sc is implementor;

  submethod BUILD ( :$gtk-source-comp ) {
    self.setGtkSourceCompletion($gtk-source-comp) if $gtk-source-comp
  }

  method setGtkSourceCompletion (GtkSourceCompletionAncestry $_) {
    my $to-parent;

    $!sc = do {
      when GtkSourceCompletion {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkSourceCompletion, $_);
      }
    }
    self!setObject($to-parent);
  }

  method SourceView::Raw::Definitions::GtkSourceCompletion
    is also<GtkSourceCompletion>
  { $!sc }

  method new (
    $gtk-source-comp where * ~~ GtkSourceCompletionAncestry,

    :$ref = True
  ) {
    return unless $gtk-source-comp;

    my $o = self.bless( :$gtk-source-comp );
    $o.ref if $ref;
    $o;
  }

  # Type: GtkSourceTextView
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
      STORE => -> $,  $val is copy {
        warn 'buffer does not allow writing'
      }
    );
  }

  # Type: uint
  method page-size is rw  is g-property is also<page_size> {
    my $gv = GLib::Value.new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('page-size', $gv);
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('page-size', $gv);
      }
    );
  }

  # Type: boolean
  method remember-info-visibility
    is rw
    is g-property
    is also<remember_info_visibility>
  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('remember-info-visibility', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('remember-info-visibility', $gv);
      }
    );
  }

  # Type: boolean
  method select-on-show is rw  is g-property is also<select_on_show> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('select-on-show', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('select-on-show', $gv);
      }
    );
  }

  # Type: boolean
  method show-icons is rw  is g-property is also<show_icons> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('show-icons', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('show-icons', $gv);
      }
    );
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
      STORE => -> $, GtkSourceView() $val is copy {
        $gv.object = $val;
        self.prop_set('view', $gv);
      }
    );
  }

  method Hide {
    self.commect($!sc, 'hide');
  }

  method Show {
    self.connect($!sc, 'show');
  }

  method Provider-Added ( :$raw = False ) {
    self.connect-provider($!sc, 'provider-added', :$raw);
  }

  method Provider-Removed ( :$raw = False ) {
    self.connect-provider($!sc, 'provider-removed', :$raw);
  }

  method add_provider (GtkSourceCompletionProvider() $provider)
    is also<add-provider>
  {
    gtk_source_completion_add_provider($!sc, $provider);
  }

  method block_interactive is also<block-interactive> {
    gtk_source_completion_block_interactive($!sc);
  }

  method fuzzy_highlight (
    Str()  $haystack,
    Str()  $casefold_query,
          :$raw             = False
  )
    is static
    is also<fuzzy-highlight>
  {
    propReturnObject(
      gtk_source_completion_fuzzy_highlight($haystack, $casefold_query),
      $raw,
      |Pango::AttrList.getTypePair
    );
  }

  proto method fuzzy_match (|)
    is also<fuzzy-match>
    is static
  { * }

  multi method fuzzy_match (
    Str()  $haystack,
    Str()  $casefold_needle,
          :$all              = False
  ) {
    my $p;

    my $rv = samewith($haystack, $casefold_needle, $p);
    $all.not ?? $rv !! ($rv, $p);
  }
  multi method fuzzy_match (
    Str() $haystack,
    Str() $casefold_needle,
          $priority is rw
  ) {
    my guint $p = 0;

    gtk_source_completion_fuzzy_match($haystack, $casefold_needle, $p);
    $priority = $p;
  }

  method get_buffer ( :$raw = False ) is also<get-buffer> {
    propReturnObject(
      gtk_source_completion_get_buffer($!sc),
      $raw,
      |SourceView::Buffer.getTypePair
    );
  }

  method get_page_size is also<get-page-size> {
    gtk_source_completion_get_page_size($!sc);
  }

  method get_view ( :$raw = False ) is also<get-view> {
    propReturnObject(
      gtk_source_completion_get_view($!sc),
      $raw,
      |SouceView::View.getTypePair
    );
  }

  method hide {
    gtk_source_completion_hide($!sc);
  }

  method remove_provider (GtkSourceCompletionProvider() $provider)
    is also<remove-provider>
  {
    gtk_source_completion_remove_provider($!sc, $provider);
  }

  method set_page_size (Int() $page_size) is also<set-page-size> {
    my guint $p = $page_size;

    gtk_source_completion_set_page_size($!sc, $p);
  }

  method show {
    gtk_source_completion_show($!sc);
  }

  method unblock_interactive is also<unblock-interactive> {
    gtk_source_completion_unblock_interactive($!sc);
  }

}
