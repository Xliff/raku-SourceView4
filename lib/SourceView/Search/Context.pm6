use v6.c;

use Method::Also;

use NativeCall;

use GLib::Raw::Traits;
use SourceView::Raw::Types;
use SourceView::Raw::Search::Context;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GtkSourceSearchContextAncestry is export of Mu
  where GtkSourceSearchContext | GObject;

class SourceView::Search::Context {
  also does GLib::Roles::Object;

  has GtkSourceSearchContext $!ssc is implementor;

  submethod BUILD ( :$gtk-search-ctx ) {
    self.setGtkSourceSearchContext($gtk-search-ctx) if $gtk-search-ctx
  }

  method setGtkSourceSearchContext (GtkSourceSearchContextAncestry $_) {
    my $to-parent;

    $!ssc = do {
      when GtkSourceSearchContext {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkSourceSearchContext, $_);
      }
    }
    self!setObject($to-parent);
  }

  method SourceView::Raw::Definitions::GtkSourceSearchContext
  { $!ssc }

  multi method new (
    $gtk-search-ctx where * ~~ GtkSourceSearchContextAncestry,

    :$ref = True
  ) {
    return unless $gtk-search-ctx;

    my $o = self.bless( :$gtk-search-ctx );
    $o.ref if $ref;
    $o;
  }

  multi method new (
    GtkSourceBuffer()         $buffer,
    GtkSourceSearchSettings()  $settings
  ) {
    my $gtk-search-ctx = gtk_source_search_context_new($buffer, $settings);

    $gtk-search-ctx ?? self.bless( :$gtk-search-ctx ) !! Nil;
  }

  # Type: GtkSourceBuffer
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

  # Type: boolean
  method highlight is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('highlight', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('highlight', $gv);
      }
    );
  }

  # Type: GtkSourceStyle
  method match-style ( :$raw = False )
    is rw
    is g-property
    is also<match_style>
  {
    my $gv = GLib::Value.new( SourceView::Style.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('match-style', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |SourceView::Style.getTypePair
        );
      },
      STORE => -> $, GtkSourceStyle() $val is copy {
        $gv.object = $val;
        self.prop_set('match-style', $gv);
      }
    );
  }

  # Type: int
  method occurrences-count is rw  is g-property is also<occurrences_count> {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('occurrences-count', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        warn 'occurrences-count does not allow writing'
      }
    );
  }

  # Type: GError
  method regex-error ( :$raw = False )
    is rw
    is g-property
    is also<regex_error>
  {
    my $gv = GLib::Value.new( GLib::Error.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('regex-error', $gv);
        propReturnObject(
          $gv.pointer,
          $raw,
          |GLib::Type.getTypePair
        );
      },
      STORE => -> $,  $val is copy {
        warn 'regex-error does not allow writing'
      }
    );
  }

  # Type: GtkSourceSearchSettings
  method settings ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( SourceView::Search::Settings.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('settings', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |Source::Search::Settings.getType
        );
      },
      STORE => -> $, GtkSourceSearchSettings() $val is copy {
        $gv.object = $val;
        self.prop_set('settings', $gv);
      }
    );
  }

  multi method backward (
     $iter,
    :s(:start(:$match_start)) = GtkTextIter,
    :e(:end(:$match_end))     = GtkTextIter,
    :$all                     = False
  ) {
    samewith(
       $iter,
       $match_start,
       $match_end,
       $,
      :$all
    );
  }
  multi method backward (
    GtkTextIter()  $iter,
    GtkTextIter()  $match_start,
    GtkTextIter()  $match_end,
                   $has_wrapped_around is rw,
                  :$all                       = False
  ) {
    my gboolean $h = 0;

    my $rv = so gtk_source_search_context_backward(
      $!ssc,
      $iter,
      $match_start,
      $match_end,
      $h
    );
    $has_wrapped_around = $h;
    $all.not ?? $rv !! ($rv, $has_wrapped_around);
  }

  proto method backward_async (|)
    is also<backward-async>
  { * }

  multi method backward_async (
     $iter,
     &callback,
     $user_data    = gpointer,
    :$cancellable  = GCancellable
  ) {
    samewith($iter, $cancellable, &callback, $user_data)
  }
  multi method backward_async (
    GtkTextIter()  $iter,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data    = gpointer
  ) {
    gtk_source_search_context_backward_async(
      $!ssc,
      $iter,
      $cancellable,
      &callback,
      $user_data
    );
  }

  proto method backward_finish (|)
    is also<backward-finish>
  { * }

  multi method backward_finish (
    $result,
    $error                   = gerror,
   :s(:start(:$match_start)) = GtkTextIter,
   :e(:end(:$match_end))     = GtkTextIter
  ) {
    samewith(
      $result,
      $match_start,
      $match_end,
      $,
      $error
    );
  }
  multi method backward_finish (
    GAsyncResult             $result,
    GtkTextIter              $match_start,
    GtkTextIter              $match_end,
                             $has_wrapped_around is rw,
    CArray[Pointer[GError]]  $error                     = gerror,
                            :$all                       = False
  ) {
    my gboolean $h = 0;

    clear_error;
    my $rv = so gtk_source_search_context_backward_finish(
      $!ssc,
      $result,
      $match_start,
      $match_end,
      $has_wrapped_around,
      $error
    );
    set_error($error);
    $has_wrapped_around = $h;
    $all.not ?? $rv !! ($rv, $has_wrapped_around);
  }

  multi method forward (
     $iter,
    :$all                     = False,
    :s(:start(:$match_start)) = GtkTextIter,
    :e(:end(:$match_end))     = GtkTextIter
  ) {
    samewith(
       $iter,
       $match_start,
       $match_end,
       $,
      :$all
    );
  }
  multi method forward (
    GtkTextIter()  $iter,
    GtkTextIter()  $match_start,
    GtkTextIter()  $match_end,
                   $has_wrapped_around is rw,
                  :$all                       = False
  ) {
    my gboolean $h = 0;

    my $rv = gtk_source_search_context_forward(
      $!ssc,
      $iter,
      $match_start,
      $match_end,
      $h
    );
    $has_wrapped_around = $h;
    $all.not ?? $rv !! ($rv, $has_wrapped_around);
  }

  proto method forward_async (|)
    is also<forward-async>
  { * }

  multi method forward_async (
     $iter,
     &callback,
     $user_data   = gpointer,
    :$cancellable = GCancellable
  ) {
    samewith(
      $iter,
      $cancellable,
      &callback,
      $user_data
    );
  }
  multi method forward_async (
    GtkTextIter()  $iter,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data    = gpointer
  ) {
    gtk_source_search_context_forward_async(
      $!ssc,
      $iter,
      $cancellable,
      &callback,
      $user_data
    );
  }

  proto method forward_finish (|)
    is also<forward-finish>
  { * }

  multi method forward_finish (
    $result,
    $error                    = gerror,
    :s(:start(:$match_start)) = GtkTextIter,
    :e(:end(:$match_end))     = GtkTextIter,
    :$all                     = False
  ) {
    samewith(
      $result,
      $match_start,
      $match_end,
      $,
      $error,
      :$all
    );
  }
  multi method forward_finish (
    GAsyncResult()           $result,
    GtkTextIter()            $match_start,
    GtkTextIter()            $match_end,
                             $has_wrapped_around is rw,
    CArray[Pointer[GError]]  $error                     = gerror,
                            :$all                       = False
  ) {
    my gboolean $h = 0;

    clear_error;
    my $rv = so gtk_source_search_context_forward_finish(
      $!ssc,
      $result,
      $match_start,
      $match_end,
      $h,
      $error
    );
    set_error($error);
    $has_wrapped_around = $h;
    $all.not ?? $rv !! ($rv, $h);
  }

  method get_buffer ( :$raw = False ) is also<get-buffer> {
    propReturnObject(
      gtk_source_search_context_get_buffer($!ssc),
      $raw,
      |SourceView::Buffer.getTypePair
    );
  }

  method get_highlight is also<get-highlight> {
    so gtk_source_search_context_get_highlight($!ssc);
  }

  method get_match_style ( :$raw = False ) is also<get-match-style> {
    propReturnObject(
      gtk_source_search_context_get_match_style($!ssc),
      $raw,
      |SourceView::Source::Style.getTypePair
    )
  }

  proto method get_occurrence_position (|)
    is also<get-occurrence-position>
  { * }

  multi method get_occurrence_position ( :$raw = False ) {
    my ($s, $e) = GtkTextIter.new xx 2;

    samewith($s, $e);

    ($s, $e) .= map({ GTK::Text::Iter.new($_) }) unless $raw;
    ($s, $e);
  }
  multi method get_occurrence_position (
    GtkTextIter() $match_start,
    GtkTextIter() $match_end,
  ) {
    gtk_source_search_context_get_occurrence_position(
      $!ssc,
      $match_start,
      $match_end
    );
  }

  method get_occurrences_count is also<get-occurrences-count> {
    gtk_source_search_context_get_occurrences_count($!ssc);
  }

  method get_regex_error ( :$raw = False ) is also<get-regex-error> {
    propReturnObject(
      gtk_source_search_context_get_regex_error($!ssc),
      $raw,
      |GLib::Error.getTypePair
    );
  }

  method get_settings ( :$raw = False ) is also<get-settings> {
    propReturnObject(
      gtk_source_search_context_get_settings($!ssc),
      $raw,
      |SourceView::Search::Settings.getTypePair
    );
  }

  method get_type {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &gtk_source_search_context_get_type,
      $n,
      $t
    );

  method replace (
    GtkTextIter()           $match_start,
    GtkTextIter()           $match_end,
    Str()                   $replace,
    Int()                   $replace_length = -1,
    CArray[Pointer[GError]] $error          = gerror
  ) {
    my gint $r = $replace_length;

    clear_error;
    my $rv = so gtk_source_search_context_replace(
      $!ssc,
      $match_start,
      $match_end,
      $replace,
      $r,
      $error
    );
    set_error($error);
    $rv;
  }

  method replace_all (
    Str()                   $replace,
    Int()                   $replace_length,
    CArray[Pointer[GError]] $error           = gerror
  )
    is also<replace-all>
  {
    my gint $r = $replace_length;

    clear_error;
    my $rv = so gtk_source_search_context_replace_all(
      $!ssc,
      $replace,
      $r,
      $error
    );
    set_error($error);
    $rv;
  }

  method set_highlight (Int() $highlight) is also<set-highlight> {
    my gboolean $h = $highlight.so.Int;

    gtk_source_search_context_set_highlight($!ssc, $h);
  }

  method set_match_style (GtkSourceStyle() $match_style)
    is also<set-match-style>
  {
    gtk_source_search_context_set_match_style($!ssc, $match_style);
  }

}
