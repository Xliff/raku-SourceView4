use v6.c;

use Method::Also;
use NativeCall;

use SourceView::Raw::Types;
use SourceView::Raw::Source::Completion::Provider;

use GLib::Roles::Object;

role SourceView::Roles::Source::Completion::Provider {
  has GtkSourceCompletionProvider $!scp is implementor;

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
  method page-size is rw  is g-property {
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
  method remember-info-visibility is rw  is g-property {
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
  method select-on-show is rw  is g-property {
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
  method show-icons is rw  is g-property {
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

  # Type: GtkSourceTypeView
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

  method activate (
    GtkSourceCompletionContext()  $context,
    GtkSourceCompletionProposal() $proposal
  ) {
    gtk_source_completion_provider_activate($!scp, $context, $proposal);
  }

  method display (
    GtkSourceCompletionContext()  $context,
    GtkSourceCompletionProposal() $proposal,
    GtkSourceCompletionCell()     $cell
  ) {
    gtk_source_completion_provider_display($!scp, $context, $proposal, $cell);
  }

  method get_priority (GtkSourceCompletionContext() $context)
    is also<get-priority>
  {
    gtk_source_completion_provider_get_priority($!scp, $context);
  }

  method get_title is also<get-title> {
    gtk_source_completion_provider_get_title($!scp);
  }

  method is_trigger (GtkTextIter() $iter, Str() $ch) is also<is-trigger> {
    my gunichar $c = $ch.comb.head.ord;

    gtk_source_completion_provider_is_trigger($!scp, $iter, $ch);
  }

  method key_activates (
    GtkSourceCompletionContext()  $context,
    GtkSourceCompletionProposal() $proposal,
    Int()                         $keyval,
    Int()                         $state
  )
    is also<key-activates>
  {
    my guint           $k = $keyval;
    my GdkModifierType $s = $state;

    gtk_source_completion_provider_key_activates(
      $!scp,
      $context,
      $proposal,
      $k,
      $s
    );
  }

  method list_alternates (
    GtkSourceCompletionContext()  $context,
    GtkSourceCompletionProposal() $proposal
  )
    is also<list-alternates>
  {
    gtk_source_completion_provider_list_alternates($!scp, $context, $proposal);
  }

  proto method populate_async (|)
    is also<populate-async>
  { * }

  multi method populate_async (
     $context,
     &callback,
     $user_data   = gpointer,
    :$cancellable = GCancellable
  ) {
    samewith(
      $context,
      $cancellable,
      &callback,
      $user_data
    );
  }
  multi method populate_async (
    GtkSourceCompletionContext() $context,
    GCancellable()               $cancellable,
                                 &callback,
    gpointer                     $user_data    = gpointer
  ) {
    gtk_source_completion_provider_populate_async(
      $!scp,
      $context,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method populate_finish (
    GAsyncResult()           $result,
    CArray[Pointer[GError]]  $error   = gerror,
                            :$raw     = False
  )
    is also<populate-finish>
  {
    clear_error;
    my $lm = gtk_source_completion_provider_populate_finish(
      $!scp,
      $result,
      $error
    );
    set_error($error);

    propReturnObject($lm, $raw, |GIO::ListModel.getTypePair);
  }

  method refilter (
    GtkSourceCompletionContext()  $context,
    GListModel()                  $model
  ) {
    gtk_source_completion_provider_refilter($!scp, $context, $model);
  }

}

our subset GtkSourceCompletionProviderAncestry is export of Mu
  where GtkSourceCompletionProvider | GObject;

class SourceView::Source::Completion::Provider {
  also does GLib::Roles::Object;
  also does SourceView::Roles::Source::Completion::Provider;

  submethod BUILD ( :$gtk-source-comp ) {
    self.setGtkSourceCompletionProvider($gtk-source-comp) if $gtk-source-comp
  }

  method setGtkSourceCompletion (GtkSourceCompletionProviderAncestry $_) {
    my $to-parent;

    $!scp = do {
      when GtkSourceCompletionProvider {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkSourceCompletionProvider, $_);
      }
    }
    self!setObject($to-parent);
  }

  method SourceView::Raw::Definitions::GtkSourceCompletionProvider
    is also<GtkSourceCompletionProvider>
  { $!scp }

  multi method new (
    $gtk-source-comp where * ~~ GtkSourceCompletionProviderAncestry,

    :$ref = True
  ) {
    return unless $gtk-source-comp;

    my $o = self.bless( :$gtk-source-comp );
    $o.ref if $ref;
    $o;
  }

}
