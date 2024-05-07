use v6.c;

use Method::Also;

use SourceView::Raw::Types;

use GLib::Roles::Object;
use SourceView::Roles::Source::Completion::Provider;

our subset GtkSourceCompletionWordsAncestry is export of Mu
  where GtkSourceCompletionWords | GObject;

class SourceView::Source::Completion::Provider::Words {
  also does GLib::Roles::Object;
  also does SourceView::Roles::Source::Completion::Provider;

  has GtkSourceCompletionWords $!scw is implementor;

  submethod BUILD ( :$gtk-comp-words ) {
    self.setGtkSourceCompletionWords($gtk-comp-words) if $gtk-comp-words
  }

  method setGtkSourceCompletionWords (GtkSourceCompletionWordsAncestry $_) {
    my $to-parent;

    $!scw = do {
      when GtkSourceCompletionWords {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkSourceCompletionWords, $_);
      }
    }
    self!setObject($to-parent);
  }

  method SourceView::Raw::Definitions::GtkSourceCompletionWords
    is also<GtkSourceCompletionWords>
  { $!scw }

  multi method new (
    $gtk-comp-words where * ~~ GtkSourceCompletionWordsAncestry,

    :$ref = True
  ) {
    return unless $gtk-comp-words;

    my $o = self.bless( :$gtk-comp-words );
    $o.ref if $ref;
    $o;
  }

  multi method new (Str() $title) {
    my $gtk-comp-words = gtk_source_completion_words_new($title);

    $gtk-comp-words ?? self.bless( :$gtk-comp-words ) !! Nil;
  }

  # Type: uint
  method minimum-word-size is rw  is g-property is also<minimum_word_size> {
    my $gv = GLib::Value.new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('minimum-word-size', $gv);
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('minimum-word-size', $gv);
      }
    );
  }

  # Type: int
  method priority is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('priority', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('priority', $gv);
      }
    );
  }

  # Type: uint
  method proposals-batch-size
    is rw
    is g-property
    is also<proposals_batch_size>
  {
    my $gv = GLib::Value.new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('proposals-batch-size', $gv);
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('proposals-batch-size', $gv);
      }
    );
  }

  # Type: uint
  method scan-batch-size is rw  is g-property is also<scan_batch_size> {
    my $gv = GLib::Value.new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('scan-batch-size', $gv);
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('scan-batch-size', $gv);
      }
    );
  }

  # Type: string
  method title is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('title', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('title', $gv);
      }
    );
  }

  method register (GtkTextBuffer() $buffer) {
    gtk_source_completion_words_register($!scw, $buffer);
  }

  method unregister (GtkTextBuffer() $buffer) {
    gtk_source_completion_words_unregister($!scw, $buffer);
  }
}

### /usr/src/gtksourceview/gtksourceview/completion-providers/words/gtksourcecompletionwords.h

sub gtk_source_completion_words_new (Str $title)
  returns GtkSourceCompletionWords
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_completion_words_register (
  GtkSourceCompletionWords $words,
  GtkTextBuffer            $buffer
)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_completion_words_unregister (
  GtkSourceCompletionWords $words,
  GtkTextBuffer            $buffer
)
  is      native(sourceview)
  is      export
{ * }
