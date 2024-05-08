use v6.c;

use Method::Also;

use SourceView::Raw::Types;
use SourceView::Raw::Buffer;

use GTK::Buffer:ver<4>;

use GLib::Roles::Implementor;
use SourceView::Roles::Signals::Buffer;

our subset GtkSourceBufferAncestry is export of Mu
  where GtkSourceBuffer | GtkTextBufferAncestry;

class SourceView::Buffer:ver<4> is GTK::Text::Buffer:ver<4> {
  also does SourceView::Roles::Signals::Buffer;

  has GtkSourceBuffer $!sb is implementor;

  submethod BUILD ( :$gtk-source-buffer ) {
    self.setGtkSourceBuffer($gtk-source-buffer) if $gtk-source-buffer
  }

  method setGtkSourceBuffer (GtkSourceBufferAncestry $_) {
    my $to-parent;

    $!sb = do {
      when GtkSourceBuffer {
        $to-parent = cast(GtkTextBuffer, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkSourceBuffer, $_);
      }
    }
    self.setGtkTextBuffer($to-parent);
  }

  method SourceView::Raw::Definitions::GtkSourceBuffer
    is also<GtkSourceBuffer>
  { $!sb }

  multi method new (
    $gtk-source-buffer where * ~~ GtkSourceBufferAncestry,

    :$ref = True
  ) {
    return unless $gtk-source-buffer;

    my $o = self.bless( :$gtk-source-buffer );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $gtk-source-buffer = gtk_source_buffer_new();

    $gtk-source-buffer ?? self.bless( :$gtk-source-buffer ) !! Nil
  }

  method new_with_language (GtkSourceLanguage() $language)
    is also<new-with-language>
  {
    my $gtk-source-buffer =  gtk_source_buffer_new_with_language($language);
  }

  # Type: boolean
  method highlight-matching-brackets
    is rw
    is g-property
    is also<highlight_matching_brackets>
  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('highlight-matching-brackets', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('highlight-matching-brackets', $gv);
      }
    );
  }

  # Type: boolean
  method highlight-syntax is rw  is g-property is also<highlight_syntax> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('highlight-syntax', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('highlight-syntax', $gv);
      }
    );
  }

  # Type: boolean
  method implicit-trailing-newline
    is rw
    is g-property
    is also<implicit_trailing_newline>
  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('implicit-trailing-newline', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('implicit-trailing-newline', $gv);
      }
    );
  }

  # Type: GtkSourceTypeLanguage
  method language ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( SourceView::Language.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('language', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |SourceView::Language.getTypePair
        );
      },
      STORE => -> $, GtkSourceTypeLanguage() $val is copy {
        $gv.object = $val;
        self.prop_set('language', $gv);
      }
    );
  }

  # Type: boolean
  method loading is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('loading', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        warn 'loading does not allow writing'
      }
    );
  }

  # Type: GtkSourceTypeStyleScheme
  method style-scheme ( :$raw = False )
    is rw
    is g-property
    is also<style_scheme>
  {
    my $gv = GLib::Value.new( SourceView::StyleScheme.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('style-scheme', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |SourceView::StyleScheme.getTypePair
        )
      },
      STORE => -> $, GtkSourceStyleScheme() $val is copy {
        $gv.object = $val;
        self.prop_set('style-scheme', $gv);
      }
    );
  }

  method Cursor-Moved is also<Cursor_Moved> {
    self.connect($!sb, 'cursor-moved');
  }

  # Is originally:
  # GtkSourceBuffer *buffer,  GtkTextIter *iter,  GtkSourceBracketMatchType state --> void
  method Bracket-Matched ( :$raw = False ) is also<Bracket_Matched> {
    self.connect-bracket-matched($!sb, :$raw);
  }

  method Highlight-Updated ( :$raw = False ) is also<Highlight_Updated> {
    self.connect-highlight-updated($!sb, :$raw);
  }

  method Source-Mark-Updated ( :$raw = False ) is also<Source_Mark_Updated> {
    self.connect-source-mark-updated($!sb, :$raw = False);
  }

  method backward_iter_to_source_mark (
    GtkTextIter()     $iter,
    Str()             $category
  )
    is also<backward-iter-to-source-mark>
  {
    gtk_source_buffer_backward_iter_to_source_mark($!sb, $iter, $category);
  }

  method change_case (
    GtkSourceChangeCaseType() $case_type,
    GtkTextIter()             $start,
    GtkTextIter()             $end
  )
    is also<change-case>
  {
    my GtkSourceChangeCaseType $c = $case_type;

    gtk_source_buffer_change_case($!sb, $c, $start, $end);
  }

  method create_source_mark (
    Str()             $name,
    Str()             $category,
    GtkTextIter()     $where
  )
    is also<create-source-mark>
  {
    gtk_source_buffer_create_source_mark($!sb, $name, $category, $where);
  }

  method create_source_tag (
    Str             $tag_name,
    Str             $first_property_name
  )
    is also<create-source-tag>
  {
    gtk_source_buffer_create_source_tag($!sb, $tag_name, $first_property_name);
  }

  method ensure_highlight (
    GtkTextIter()     $start,
    GtkTextIter()     $end
  )
    is also<ensure-highlight>
  {
    gtk_source_buffer_ensure_highlight($!sb, $start, $end);
  }

  method forward_iter_to_source_mark (
    GtkTextIter     $iter,
    Str             $category
  )
    is also<forward-iter-to-source-mark>
  {
    gtk_source_buffer_forward_iter_to_source_mark($!sb, $iter, $category);
  }

  method get_context_classes_at_iter (GtkTextIter() $iter, :$raw = False)
    is also<get-context-classes-at-iter>
  {
    my $ca = gtk_source_buffer_get_context_classes_at_iter($!sb, $iter);
    return $ca if $raw;
    CStringArrayToArray($ca);
  }

  method get_highlight_matching_brackets
    is also<get-highlight-matching-brackets>
  {
    so gtk_source_buffer_get_highlight_matching_brackets($!sb);
  }

  method get_highlight_syntax is also<get-highlight-syntax> {
    so gtk_source_buffer_get_highlight_syntax($!sb);
  }

  method get_implicit_trailing_newline
    is also<get-implicit-trailing-newline>
  S{
    so gtk_source_buffer_get_implicit_trailing_newline($!sb);
  }

  method get_language ( :$raw = False ) is also<get-language> {
    propReturnObject(
      gtk_source_buffer_get_language($!sb),
      $raw,
      |SourceView::Language.getTypePair
    );
  }

  method get_loading is also<get-loading> {
    so gtk_source_buffer_get_loading($!sb);
  }

  method get_source_marks_at_iter (
    GtkTextIter()  $iter,
    Str()          $category       = Str,
                  :$raw            = False,
                  :glist(:$gslist) = False
  )
    is also<get-source-marks-at-iter>
  {
    returnGSList(
      gtk_source_buffer_get_source_marks_at_iter($!sb, $iter, $category),
      $raw,
      $gslist,
      |SourceView::Mark.getTypePair
    );
  }

  method get_source_marks_at_line (
    Int()  $line,
    Str()  $category       = Str,
          :$raw            = False,
          :glist(:$gslist) = False
  )
    is also<get-source-marks-at-line>
  {
    my gint $l = $line;

    returnGSList(
      gtk_source_buffer_get_source_marks_at_line($!sb, $l, $category),
      $raw,
      $gslist,
      |SourceView::Mark.getTypePair
    );
  }

  method get_style_scheme ( :$raw = False ) is also<get-style-scheme> {
    propReturnObject(
      gtk_source_buffer_get_style_scheme($!sb),
      $raw,
      |SourceView::StyleScheme.getTypePair
    );
  }

  method iter_backward_to_context_class_toggle (
    GtkTextIter()-     $iter,
    Str()-             $context_class
  )
    is also<iter-backward-to-context-class-toggle>
  {
    gtk_source_buffer_iter_backward_to_context_class_toggle(
      $!sb,
      $iter,
      $context_class
    );
  }

  method iter_forward_to_context_class_toggle (
    GtkTextIter()     $iter,
    Str()             $context_class
  )
    is also<iter-forward-to-context-class-toggle>
  {
    gtk_source_buffer_iter_forward_to_context_class_toggle(
      $!sb,
      $iter,
      $context_class
    );
  }

  method iter_has_context_class (GtkTextIter() $iter, Str() $context_class)
    is also<iter-has-context-class>
  {
    gtk_source_buffer_iter_has_context_class($!sb, $iter, $context_class);
  }

  method join_lines (GtkTextIter() $start, GtkTextIter() $end)
    is also<join-lines>
  {
    gtk_source_buffer_join_lines($!sb, $start, $end);
  }

  method remove_source_marks (
    GtkTextIter() $start,
    GtkTextIter() $end,
    Str()         $category
  )
    is also<remove-source-marks>
  {
    gtk_source_buffer_remove_source_marks($!sb, $start, $end, $category);
  }

  method set_highlight_matching_brackets (Int() $highlight)
    is also<set-highlight-matching-brackets>
  {
    my gboolean $h = $highlight;

    gtk_source_buffer_set_highlight_matching_brackets($!sb, $h);
  }

  method set_highlight_syntax (Int() $highlight)
    is also<set-highlight-syntax>
  {
    my gboolean $h = $highlight;

    gtk_source_buffer_set_highlight_syntax($!sb, $h);
  }

  method set_implicit_trailing_newline (Int() $implicit_trailing_newline)
    is also<set-implicit-trailing-newline>
  {
    my gboolean $i = $implicit_trailing_newline;

    gtk_source_buffer_set_implicit_trailing_newline($!sb, $i);
  }

  method set_language (GtkSourceLanguage() $language)
    is also<set-language>
  {
    gtk_source_buffer_set_language($!sb, $language);
  }

  method set_style_scheme (GtkSourceStyleScheme() $scheme)
    is also<set-style-scheme>
  {
    gtk_source_buffer_set_style_scheme($!sb, $scheme);
  }

  method sort_lines (
    GtkTextIter() $start,
    GtkTextIter() $end,
    Int()         $flags,
    Int()         $column
  )
    is also<sort-lines>
  {
    my GtkSourceSortFlags $f = $flags;
    my gint               $c = $column;

    gtk_source_buffer_sort_lines($!sb, $start, $end, $f, $c);
  }

}
