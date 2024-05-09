use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use SourceView::Raw::Types;
use SourceView::Raw::Snippet::Chunk;

use GLib::Roles::Implementor;

use SourceView::Snippet::Context;

our subset GtkSourceSnippetChunkAncestry is export of Mu
  where GtkSourceSnippetChunk | GObject;

class SourceView::Snippet::Chunk {
  also does GLib::Roles::Object;

  has GtkSourceSnippetChunk $!gssc is implementor;

  submethod BUILD ( :$gtk-snippet-chunk ) {
    self.setGtkSourceSnippetChunk($gtk-snippet-chunk) if $gtk-snippet-chunk
  }

  method setGtkSourceSnippetChunk (GtkSourceSnippetChunkAncestry $_) {
    my $to-parent;

    $!gssc = do {
      when GtkSourceSnippetChunk {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkSourceSnippetChunk, $_);
      }
    }
    self!setObject($to-parent);
  }

  method SourceView::Raw::Definitions::GtkSourceSnippetChunk
    is also<GtkSourceSnippetChunk>
  { $!gssc }

  multi method new (
    $gtk-snippet-chunk where * ~~ GtkSourceSnippetChunkAncestry,

    :$ref = True
  ) {
    return unless $gtk-snippet-chunk;

    my $o = self.bless( :$gtk-snippet-chunk );
    $o.ref if $ref;
    $o;
  }
  multi method new ( *%a ) {
    my $gtk-source-chunk = gtk_source_snippet_chunk_new();

    my $o = $gtk-source-chunk ?? self.bless( :$gtk-source-chunk ) !! Nil;
    $o.setAttributes(%a);
    $o;
  }

  # Type: GtkSourceSnippetContext
  method context ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( SourceView::Snippet::Context.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('context', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |SourceView::Snippet::Context.getTypePair
        );
      },
      STORE => -> $, GtkSourceSnippetContext() $val is copy {
        $gv.object = $val;
        self.prop_set('context', $gv);
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
        $gv.int = $val;
        self.prop_set('focus-position', $gv);
      }
    );
  }

  # Type: string
  method spec is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('spec', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('spec', $gv);
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

  # Type: boolean
  method text-set is rw  is g-property is also<text_set> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('text-set', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('text-set', $gv);
      }
    );
  }

  # Type: string
  method tooltip-text is rw  is g-property is also<tooltip_text> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('tooltip-text', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('tooltip-text', $gv);
      }
    );
  }

  method copy ( :$raw = False ) {
    propReturnObject(
      gtk_source_snippet_chunk_copy($!gssc),
      $raw,
      |self.getTypePair
    )
  }

  method get_context ( :$raw = False ) is also<get-context> {
    propReturnObject(
      gtk_source_snippet_chunk_get_context($!gssc),
      $raw,
      |SourceView::Snippet::Context.getTypePair
    );
  }

  method get_focus_position is also<get-focus-position> {
    gtk_source_snippet_chunk_get_focus_position($!gssc);
  }

  method get_spec is also<get-spec> {
    gtk_source_snippet_chunk_get_spec($!gssc);
  }

  method get_text is also<get-text> {
    gtk_source_snippet_chunk_get_text($!gssc);
  }

  method get_text_set is also<get-text-set> {
    so gtk_source_snippet_chunk_get_text_set($!gssc);
  }

  method get_tooltip_text is also<get-tooltip-text> {
    gtk_source_snippet_chunk_get_tooltip_text($!gssc);
  }

  method set_context (GtkSourceSnippetContext() $context)
    is also<set-context>
  {
    gtk_source_snippet_chunk_set_context($!gssc, $context);
  }

  method set_focus_position (Int() $focus_position)
    is also<set-focus-position>
  {
    my gint $f = $focus_position;

    gtk_source_snippet_chunk_set_focus_position($!gssc, $focus_position);
  }

  method set_spec (Str() $spec) is also<set-spec> {
    gtk_source_snippet_chunk_set_spec($!gssc, $spec);
  }

  method set_text (Str() $text) is also<set-text> {
    gtk_source_snippet_chunk_set_text($!gssc, $text);
  }

  method set_text_set (Int() $text_set) is also<set-text-set> {
    my gboolean $t = $text_set.so.Int;

    gtk_source_snippet_chunk_set_text_set($!gssc, $t);
  }

  method set_tooltip_text (Str() $tooltip_text) is also<set-tooltip-text> {
    gtk_source_snippet_chunk_set_tooltip_text($!gssc, $tooltip_text);
  }

}
