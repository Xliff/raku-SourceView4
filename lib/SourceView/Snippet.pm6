use v6.c;

use Method::Also;

use NativeCall;

use GLib::Raw::Traits;
use SourceView::Raw::Types;
use SourceView::Raw::Snippet;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GtkSourceSnippetAncestry is export of Mu
  where GtkSourceSnippet | GObject;

class SourceView::Snippet {
  also does Positional;
  also does GLib::Roles::Object;

  has GtkSourceSnippet $!gss is implementor;

  submethod BUILD ( :$gtk-source-snippet ) {
    self.setGtkSourceSnippet($gtk-source-snippet) if $gtk-source-snippet
  }

  method setGtkSourceSnippet (GtkSourceSnippetAncestry $_) {
    my $to-parent;

    $!gss = do {
      when GtkSourceSnippet {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkSourceSnippet, $_);
      }
    }
    self!setObject($to-parent);
  }

  method SourceView::Raw::Definitions::GtkSourceSnippet
    is also<GtkSourceSnippet>
  { $!gss }

  multi method new (
    $gtk-source-snippet where * ~~ GtkSourceSnippetAncestry,

    :$ref = True
  ) {
    return unless $gtk-source-snippet;

    my $o = self.bless( :$gtk-source-snippet );
    $o.ref if $ref;
    $o;
  }
  multi method new (Str() $trigger, Str() $language_id) {
    my $gtk-source-snippet = gtk_source_snippet_new($!gss, $language_id);

    $gtk-source-snippet ?? self.bless( :$gtk-source-snippet ) !! Nil
  }

  method new_parsed (Str() $text, CArray[Pointer[GError]] $error = gerror) is also<new-parsed> {
    clear_error;
    my $gtk-source-snippet = gtk_source_snippet_new_parsed($text, $error);
    set_error($error);

    $gtk-source-snippet ?? self.bless( :$gtk-source-snippet ) !! Nil
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
      STORE => -> $,  $val is copy {
        warn 'buffer does not allow writing'
      }
    );
  }

  # Type: string
  method description is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('description', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('description', $gv);
      }
    );
  }

  # Type: int
  method focus-position is rw  is g-property is also<focus_position> {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('focus-position', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        warn 'focus-position does not allow writing'
      }
    );
  }

  # Type: string
  method language-id is rw  is g-property is also<language_id> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('language-id', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('language-id', $gv);
      }
    );
  }

  # Type: string
  method name is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('name', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('name', $gv);
      }
    );
  }

  # Type: string
  method trigger is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('trigger', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('trigger', $gv);
      }
    );
  }

  method add_chunk (GtkSourceSnippetChunk() $chunk) is also<add-chunk> {
    gtk_source_snippet_add_chunk($!gss, $chunk);
  }

  method copy ( :$raw = False ) {
    propReturnObject(
      gtk_source_snippet_copy($!gss),
      $raw,
      |self.getTypePair
    );
  }

  method get_context ( :$raw = False ) is also<get-context> {
    propReturnObject(
      gtk_source_snippet_get_context($!gss),
      $raw,
      |SourceView::Snippet::Context.getTypePair
    )
  }

  method get_description is also<get-description> {
    gtk_source_snippet_get_description($!gss);
  }

  method get_focus_position is also<get-focus-position> {
    gtk_source_snippet_get_focus_position($!gss);
  }

  method get_language_id is also<get-language-id> {
    gtk_source_snippet_get_language_id($!gss);
  }

  method get_n_chunks is also<get-n-chunks> {
    gtk_source_snippet_get_n_chunks($!gss);
  }

  method get_name is also<get-name> {
    gtk_source_snippet_get_name($!gss);
  }

  method AT-POS (\k) is also<AT_POS> {
    self.get_nth_chunk(k);
  }
  method get_nth_chunk (Int() $nth, :$raw = False) is also<get-nth-chunk> {
    my guint $n = $nth;

    propReturnObject(
      gtk_source_snippet_get_nth_chunk($!gss, $n),
      $raw,
      |SourceView::Snippet::Chunk.getTypePair
    );
  }

  method get_trigger is also<get-trigger> {
    gtk_source_snippet_get_trigger($!gss),
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_source_snippet_get_type, $n, $t );
  }

  method set_description (Str() $description) is also<set-description> {
    gtk_source_snippet_set_description($!gss, $description);
  }

  method set_language_id (Str() $language_id) is also<set-language-id> {
    gtk_source_snippet_set_language_id($!gss, $language_id);
  }

  method set_name (Str() $name) is also<set-name> {
    gtk_source_snippet_set_name($!gss, $name);
  }

  method set_trigger (Str() $trigger) is also<set-trigger> {
    gtk_source_snippet_set_trigger($!gss, $trigger);
  }

}
