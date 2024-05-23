use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use SourceView::Raw::Types;
use SourceView::Raw::View;

use GTK::Text::View:ver<4>;
use SourceView::Buffer:ver<4>;
use SourceView::SpaceDrawer:ver<4>;

use GLib::Roles::Implementor;

our subset GtkSourceViewAncestry is export of Mu
  where GtkSourceView | GtkTextViewAncestry;

class SourceView::View is GTK::Text::View:ver<4> {
  has GtkSourceView $!sv is implementor;

  submethod BUILD ( :$gtk-source-view ) {
    self.setGtkSourceView($gtk-source-view) if $gtk-source-view
  }

  method setGtkSourceView (GtkSourceViewAncestry $_) {
    my $to-parent;

    $!sv = do {
      when GtkSourceView {
        $to-parent = cast(GtkTextView, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkSourceView, $_);
      }
    }
    self.setGtkTextView($to-parent);
  }

  method SourceView::Raw::Definitions::GtkSourceView
    is also<GtkSourceView>
  { $!sv }

  proto method new (|)
  { * }

  multi method new (
    $gtk-source-view where * ~~ GtkSourceViewAncestry,

    :$ref = True
  ) {
    return unless $gtk-source-view;

    my $o = self.bless( :$gtk-source-view );
    $o.ref if $ref;
    $o;
  }

  multi method new ( *%a ) {
    my $gtk-source-view = gtk_source_view_new();

    my $o = $gtk-source-view ?? self.bless( :$gtk-source-view ) !! Nil;
    $o.setAttributes(%a) if $o && +%a;
    $o;
  }

  method new_with_buffer (GtkTextBuffer() $buffer, *%a)
    is also<new-with-buffer>
  {
    my $gtk-source-view = gtk_source_view_new_with_buffer($buffer);
    # cw: Not allowed since it is a parameter.
    %a<buffer>:delete;

    my $o = $gtk-source-view ?? self.bless( :$gtk-source-view ) !! Nil;
    $o.setAttributes(%a) if $o && +%a;
    $o;
  }

  # Type: GtkSourceBuffer (override)
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
      STORE => -> $, GtkTextBuffer() $val is copy {
        $gv.object = $val;
        self.prop_set('buffer', $gv);
      }
    );
  }

  # Type: boolean
  method auto-indent is rw  is g-property is also<auto_indent> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('auto-indent', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('auto-indent', $gv);
      }
    );
  }

  # Type: GtkSourceTypeBackgroundPatternType
  method background-pattern ( :$enum = True )
    is rw
    is g-property
    is also<background_pattern>
  {
    my $gv = GLib::Value.new(
      SourceView::Enums::Type::BackgroundPattern.get_type
    );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('background-pattern', $gv);
        my $t = $gv.enum;
        return $t unless $enum;
        GtkSourceBackgroundPatternTypeEnum($t);
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(GtkSourceBackgroundPatternType) = $val;
        self.prop_set('background-pattern', $gv);
      }
    );
  }

  # Type: GtkSourceTypeCompletion
  method completion ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( SourceView::TypeCompletion.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('completion', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |SourceView::TypeCompletion.getTypePair
        );
      },
      STORE => -> $,  $val is copy {
        warn 'completion does not allow writing'
      }
    );
  }

  # Type: boolean
  method enable-snippets is rw  is g-property is also<enable_snippets> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('enable-snippets', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('enable-snippets', $gv);
      }
    );
  }

  # Type: boolean
  method highlight-current-line
    is rw
    is g-property
    is also<highlight_current_line>
  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('highlight-current-line', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('highlight-current-line', $gv);
      }
    );
  }

  # Type: boolean
  method indent-on-tab is rw  is g-property is also<indent_on_tab> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('indent-on-tab', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('indent-on-tab', $gv);
      }
    );
  }

  # Type: int
  method indent-width is rw  is g-property is also<indent_width> {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('indent-width', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('indent-width', $gv);
      }
    );
  }

  # Type: GtkSourceIndenter
  method indenter ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( SourceView::Indenter.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('indenter', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |SourceView::Indenter.getTypePair
        );
      },
      STORE => -> $, GtkSourceIndenter() $val is copy {
        $gv.object = $val;
        self.prop_set('indenter', $gv);
      }
    );
  }

  # Type: boolean
  method insert-spaces-instead-of-tabs
    is rw
    is g-property
    is also<insert_spaces_instead_of_tabs>
  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('insert-spaces-instead-of-tabs', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('insert-spaces-instead-of-tabs', $gv);
      }
    );
  }

  # Type: uint
  method right-margin-position
    is rw
    is g-property
    is also<right_margin_position>
  {
    my $gv = GLib::Value.new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('right-margin-position', $gv);
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('right-margin-position', $gv);
      }
    );
  }

  # Type: boolean
  method show-line-marks is rw  is g-property
    is also<
      show_line_marks
      line-marks
      line_marks
    >
  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('show-line-marks', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('show-line-marks', $gv);
      }
    );
  }

  # Type: boolean
  method show-line-numbers is rw
    is g-property
    is also<
      show_line_numbers
      line_numbers
      line-numbers
    >
  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('show-line-numbers', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('show-line-numbers', $gv);
      }
    );
  }

  # Type: boolean
  method show-right-margin
    is rw
    is g-property
    is also<show_right_margin>
  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('show-right-margin', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('show-right-margin', $gv);
      }
    );
  }

  # Type: boolean
  method smart-backspace
    is rw
    is g-property
    is also<smart_backspace>
  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('smart-backspace', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('smart-backspace', $gv);
      }
    );
  }

  # Type: GtkSourceTypeSmartHomeEndType
  method smart-home-end ( :$enum = True )
    is rw
    is g-property
    is also<smart_home_end>
  {
    my $gv = GLib::Value.new( SourceView::Enums::SmartHomeEnd.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('smart-home-end', $gv);
        my $t = $gv.enum;
        return $t unless $enum;
        GtkSourceSmartHomeEndTypeEnum($t);
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(GtkSourceSmartHomeEndType) = $val;
        self.prop_set('smart-home-end', $gv);
      }
    );
  }

  # Type: GtkSourceTypeSpaceDrawer
  method space-drawer ( :$raw = False )
    is rw
    is g-property
    is also<space_drawer>
  {
    my $gv = GLib::Value.new( SourceView::SpaceDrawer.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('space-drawer', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |SourceView::SpaceDrawer.getTypePair
        );
      },
      STORE => -> $,  $val is copy {
        warn 'space-drawer does not allow writing'
      }
    );
  }

  # Type: uint
  method tab-width is rw  is g-property is also<tab_width> {
    my $gv = GLib::Value.new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('tab-width', $gv);
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('tab-width', $gv);
      }
    );
  }

  # Is originally:
  # GtkSourceView *view,  gboolean down --> void
  method Move-Lines is also<Move_Lines> {
    self.connect-bool($!sv, 'move-lines');
  }

  # Is originally:
  # GtkSourceView *view,  GtkSourceSnippet *snippet,  GtkTextIter *location --> void
  method Push-Snippet ( :$raw = False ) is also<Push_Snippet> {
    self.connect-push-snippet($!sv, :$raw);
  }

  # Is originally:
  # GtkSourceView *view --> void
  method Show-Completion is also<Show_Completion> {
    self.connect($!sv, 'show-completion');
  }

  # Is originally:
  # GtkSourceView *view,  gint step --> void
  method Move-Words is also<Move_Words> {
    self.connect-int($!sv, 'move-words');
  }

  # Is originally:
  # GtkSourceView *view,  GtkTextIter *iter,  guint button,  GdkModifierType state,  gint n_presses --> void
  method Line-Mark-Activated ( :$raw = False ) is also<Line_Mark_Activated> {
    self.connect-line-mark-activated($!sv, :$raw = False);
  }

  method get_auto_indent is also<get-auto-indent> {
    so gtk_source_view_get_auto_indent($!sv);
  }

  method get_background_pattern ( :$enum = True ) is also<get-background-pattern> {
    my $p = gtk_source_view_get_background_pattern($!sv);
    return $p unless $enum;
    GtkSourceBackgroundPatternTypeEnum($p);
  }

  method get_completion ( :$raw = False ) is also<get-completion> {
    propReturnObject(
      gtk_source_view_get_completion($!sv),
      $raw,
      |SourceView::Completion.getTypePair
    );
  }

  method get_enable_snippets is also<get-enable-snippets> {
    so gtk_source_view_get_enable_snippets($!sv);
  }

  proto method get_gutter (|)
    is also<get-gutter>
  { * }

  method left-gutter is also<left_gutter> {
    self.get_gutter( :l );
  }

  method right-gutter is also<right_gutter> {
    self.get_gutter( :r );
  }

  multi method get_gutter ( :l(:$left) is required where *.so ) {
    samewith( GTK_TEXT_WINDOW_LEFT )
  }
  multi method get_gutter ( :r(:$right) is required where *.so) {
    samewith( GTK_TEXT_WINDOW_RIGHT )
  }
  multi method get_gutter (Int() $window_type, :$raw = False)  {
    my GtkTextWindowType $w = $window_type;

    propReturnObject(
      gtk_source_view_get_gutter($!sv, $w),
      $raw,
      |::('SourceView::Gutter').getTypePair
    );
  }

  method get_highlight_current_line is also<get-highlight-current-line> {
    gtk_source_view_get_highlight_current_line($!sv);
  }

  method get_hover ( :$raw = False ) is also<get-hover> {
    propReturnObject(
      gtk_source_view_get_hover($!sv),
      $raw,
      |SourceView::Hover.getTypePair
    );
  }

  method get_indent_on_tab is also<get-indent-on-tab> {
    so gtk_source_view_get_indent_on_tab($!sv);
  }

  method get_indent_width is also<get-indent-width> {
    gtk_source_view_get_indent_width($!sv);
  }

  method get_indenter ( :$raw = False ) is also<get-indenter> {
    propReturnObject(
      gtk_source_view_get_indenter($!sv),
      $raw,
      |SourceView::Indenter.getTypePair
    );
  }

  method get_insert_spaces_instead_of_tabs
    is also<get-insert-spaces-instead-of-tabs>
  {
    so gtk_source_view_get_insert_spaces_instead_of_tabs($!sv);
  }

  method get_mark_attributes (
    Str()  $category,
           $priority is rw,
          :$all              = False,
          :$raw              = False
  )
    is also<get-mark-attributes>
  {
    my gint $p = 0;

    my $ma = gtk_source_view_get_mark_attributes($!sv, $category, $p);
    $priority = $p;
    $ma = propReturnObject($ma, False, |Source::Mark::Attributes.getTypePair);
    $all.not ?? $ma !! ($ma, $priority);
  }

  method get_right_margin_position is also<get-right-margin-position> {
    gtk_source_view_get_right_margin_position($!sv);
  }

  method get_show_line_marks is also<get-show-line-marks> {
    so gtk_source_view_get_show_line_marks($!sv);
  }

  method get_show_line_numbers is also<get-show-line-numbers> {
    so gtk_source_view_get_show_line_numbers($!sv);
  }

  method get_show_right_margin is also<get-show-right-margin> {
    so gtk_source_view_get_show_right_margin($!sv);
  }

  method get_smart_backspace is also<get-smart-backspace> {
    so gtk_source_view_get_smart_backspace($!sv);
  }

  method get_smart_home_end is also<get-smart-home-end> {
    so gtk_source_view_get_smart_home_end($!sv);
  }

  method get_space_drawer ( :$raw = False ) is also<get-space-drawer> {
    propReturnObject(
      gtk_source_view_get_space_drawer($!sv),
      $raw,
      |SourceView::SpaceDrawer.getTypePair
    );
  }

  method get_tab_width is also<get-tab-width> {
    gtk_source_view_get_tab_width($!sv);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_source_view_get_type, $n, $t );
  }

  method get_visual_column (GtkTextIter() $iter) is also<get-visual-column> {
    gtk_source_view_get_visual_column($!sv, $iter);
  }

  method indent_lines (GtkTextIter() $start, GtkTextIter() $end)
    is also<indent-lines>
  {
    gtk_source_view_indent_lines($!sv, $start, $end);
  }

  method push_snippet (GtkSourceSnippet() $snippet, GtkTextIter() $location)
    is also<push-snippet>
  {
    gtk_source_view_push_snippet($!sv, $snippet, $location);
  }

  method set_auto_indent (Int() $enable) is also<set-auto-indent> {
    my gboolean $e = $enable.so.Int;

    gtk_source_view_set_auto_indent($!sv, $enable);
  }

  method set_background_pattern (Int() $background_pattern)
    is also<set-background-pattern>
  {
    my GtkSourceBackgroundPatternType $b = $background_pattern;

    gtk_source_view_set_background_pattern($!sv, $b);
  }

  method set_enable_snippets (Int() $enable_snippets)
    is also<set-enable-snippets>
  {
    my gboolean $e = $enable_snippets.so.Int;

    gtk_source_view_set_enable_snippets($!sv, $enable_snippets);
  }

  method set_highlight_current_line (Int() $highlight)
    is also<set-highlight-current-line>
  {
    my gboolean $h = $highlight.so.Int;

    gtk_source_view_set_highlight_current_line($!sv, $highlight);
  }

  method set_indent_on_tab (Int() $enable) is also<set-indent-on-tab> {
    my gboolean $e = $enable.so.Int;

    gtk_source_view_set_indent_on_tab($!sv, $enable);
  }

  method set_indent_width (Int() $width) is also<set-indent-width> {
    my gint $w = $width;

    gtk_source_view_set_indent_width($!sv, $w);
  }

  method set_indenter (GtkSourceIndenter() $indenter) is also<set-indenter> {
    gtk_source_view_set_indenter($!sv, $indenter);
  }

  method set_insert_spaces_instead_of_tabs (Int() $enable)
    is also<set-insert-spaces-instead-of-tabs>
  {
    my gboolean $e = $enable;

    gtk_source_view_set_insert_spaces_instead_of_tabs($!sv, $e);
  }

  method set_mark_attributes (
    Str()                     $category,
    GtkSourceMarkAttributes() $attributes,
    Int()                     $priority
  )
    is also<set-mark-attributes>
  {
    my gint $p = $priority;

    gtk_source_view_set_mark_attributes($!sv, $category, $attributes, $p);
  }

  method set_right_margin_position (Int() $pos)
    is also<set-right-margin-position>
  {
    my guint $p = $pos;

    gtk_source_view_set_right_margin_position($!sv, $p);
  }

  method set_show_line_marks (Int() $show) is also<set-show-line-marks> {
    my gboolean $s = $show;

    gtk_source_view_set_show_line_marks($!sv, $show);
  }

  method set_show_line_numbers (Int() $show) is also<set-show-line-numbers> {
    my gboolean $s = $show;

    gtk_source_view_set_show_line_numbers($!sv, $show);
  }

  method set_show_right_margin (Int() $show) is also<set-show-right-margin> {
    my gboolean $s = $show;

    gtk_source_view_set_show_right_margin($!sv, $show);
  }

  method set_smart_backspace (Int() $smart_backspace)
    is also<set-smart-backspace>
  {
    my gboolean $s = $smart_backspace;

    gtk_source_view_set_smart_backspace($!sv, $smart_backspace);
  }

  method set_smart_home_end (Int() $smart_home_end)
    is also<set-smart-home-end>
  {
    my GtkSourceSmartHomeEndType $s = $smart_home_end;

    gtk_source_view_set_smart_home_end($!sv, $s);
  }

  method set_tab_width (Int() $width) is also<set-tab-width> {
    my guint $w = $width;

    gtk_source_view_set_tab_width($!sv, $w);
  }

  method unindent_lines (GtkTextIter() $start, GtkTextIter() $end)
    is also<unindent-lines>
  {
    gtk_source_view_unindent_lines($!sv, $start, $end);
  }

}
