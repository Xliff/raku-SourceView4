use v6.c;

use Method::Also;

use SourceView::Raw::Types;
use SourceView::Raw::Snippet::Context;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GtkSourceSnippetContextAncestry is export of Mu
  where GtkSourceSnippetContext | GObject;

class SourceView::Snippet::Context {
  also does GLib::Roles::Object;
  
  has GtkSourceSnippetContext $!gssc is implementor;

  submethod BUILD ( :$gtk-snippet-context ) {
    self.setGtkSourceSnippetContext($gtk-snippet-context)
      if $gtk-snippet-context
  }

  method setGtkSourceSnippetContext (GtkSourceSnippetContextAncestry $_) {
    my $to-parent;

    $!gssc = do {
      when GtkSourceSnippetContext {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkSourceSnippetContext, $_);
      }
    }
    self!setObject($to-parent);
  }

  method SourceView::Raw::Definitions::GtkSourceSnippetContext
    is also<GtkSourceSnippetContext>
  { $!gssc }

  multi method new (
    $gtk-snippet-context where * ~~ GtkSourceSnippetContextAncestry,

    :$ref = True
  ) {
    return unless $gtk-snippet-context;

    my $o = self.bless( :$gtk-snippet-context );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $gtk-snippet-context = gtk_source_snippet_context_new();

    $gtk-snippet-context ?? self.bless( :$gtk-snippet-context ) !! Nil;
  }

  method Changed {
    self.connect($!gssc, 'changed');
  }

  method clear_variables is also<clear-variables> {
    gtk_source_snippet_context_clear_variables($!gssc);
  }

  method expand (Str() $input) {
    gtk_source_snippet_context_expand($!gssc, $input);
  }

  method get_variable (Str() $key) is also<get-variable> {
    gtk_source_snippet_context_get_variable($!gssc, $key);
  }

  method set_constant (Str() $key, Str() $value) is also<set-constant> {
    gtk_source_snippet_context_set_constant($!gssc, $key, $value);
  }

  method set_line_prefix (Str() $line_prefix) is also<set-line-prefix> {
    gtk_source_snippet_context_set_line_prefix($!gssc, $line_prefix);
  }

  method set_tab_width (Int() $tab_width) is also<set-tab-width> {
    my gint $t = $tab_width;

    gtk_source_snippet_context_set_tab_width($!gssc, $t);
  }

  method set_use_spaces (Int() $use_spaces) is also<set-use-spaces> {
    my gboolean $u = $use_spaces.so.Int;

    gtk_source_snippet_context_set_use_spaces($!gssc, $u);
  }

  method set_variable (Str() $key, Str() $value) is also<set-variable> {
    gtk_source_snippet_context_set_variable($!gssc, $key, $value);
  }

}
