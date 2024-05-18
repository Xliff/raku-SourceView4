use v6.c;

use Method::Also;

use SourceView::Raw::Types;
use SourceView::Raw::Search::Settings;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GtkSourceSearchSettingsAncestry is export of Mu
  where GtkSourceSearchSettings | GObject;

class SourceView::Search::Settings:ver<4> {
  also does GLib::Roles::Object;

  has GtkSourceSearchSettings $!gsss is implementor;

  submethod BUILD ( :$gtk-search-settings ) {
    self.setGtkSourceSearchSettings($gtk-search-settings)
      if $gtk-search-settings
  }

  method setGtkSourceSearchSettings (GtkSourceSearchSettingsAncestry $_) {
    my $to-parent;

    $!gsss = do {
      when GtkSourceSearchSettings {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkSourceSearchSettings, $_);
      }
    }
    self!setObject($to-parent);
  }

  method SourceView::Raw::Definitions::GtkSourceSearchSettings
    is also<GtkSourceSearchSettings>
  { $!gsss }

  multi method new (
    $gtk-search-settings where * ~~ GtkSourceSearchSettingsAncestry,

    :$ref = True
  ) {
    return unless $gtk-search-settings;

    my $o = self.bless( :$gtk-search-settings );
    $o.ref if $ref;
    $o;
  }
  multi method new ( *%a ) {
    my $gtk-search-settings = gtk_source_search_settings_new();

    my $o = $gtk-search-settings ?? self.bless(:$gtk-search-settings ) !! Nil;
    $o.setAttributes(%a) if $o && +%a;
    $o;
  }

  # Type: boolean
  method at-word-boundaries is rw  is g-property is also<at_word_boundaries> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('at-word-boundaries', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('at-word-boundaries', $gv);
      }
    );
  }

  # Type: boolean
  method case-sensitive is rw  is g-property is also<case_sensitive> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('case-sensitive', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('case-sensitive', $gv);
      }
    );
  }

  # Type: boolean
  method regex-enabled is rw  is g-property is also<regex_enabled> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('regex-enabled', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('regex-enabled', $gv);
      }
    );
  }

  # Type: string
  method search-text is rw  is g-property is also<search_text> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('search-text', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('search-text', $gv);
      }
    );
  }

  # Type: boolean
  method visible-only is rw  is g-property is also<visible_only> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('visible-only', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('visible-only', $gv);
      }
    );
  }

  # Type: boolean
  method wrap-around is rw  is g-property is also<wrap_around> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('wrap-around', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('wrap-around', $gv);
      }
    );
  }

  method get_at_word_boundaries is also<get-at-word-boundaries> {
   so gtk_source_search_settings_get_at_word_boundaries($!gsss);
  }

  method get_case_sensitive is also<get-case-sensitive> {
   so gtk_source_search_settings_get_case_sensitive($!gsss);
  }

  method get_regex_enabled is also<get-regex-enabled> {
    so gtk_source_search_settings_get_regex_enabled($!gsss);
  }

  method get_search_text is also<get-search-text> {
   so gtk_source_search_settings_get_search_text($!gsss);
  }

  method get_visible_only is also<get-visible-only> {
   so gtk_source_search_settings_get_visible_only($!gsss);
  }

  method get_wrap_around is also<get-wrap-around> {
    so gtk_source_search_settings_get_wrap_around($!gsss);
  }

  method set_at_word_boundaries (Int() $at_word_boundaries)
    is also<set-at-word-boundaries>
  {
    my gboolean $a = $at_word_boundaries.so.Int;

    gtk_source_search_settings_set_at_word_boundaries($!gsss, $a);
  }

  method set_case_sensitive (Int() $case_sensitive)
    is also<set-case-sensitive>
  {
    my gboolean $c = $case_sensitive.so.Int;

    gtk_source_search_settings_set_case_sensitive($!gsss, $c);
  }

  method set_regex_enabled (Int() $regex_enabled)
    is also<set-regex-enabled>
  {
    my gboolean $r = $regex_enabled.so.Int;

    gtk_source_search_settings_set_regex_enabled($!gsss, $r);
  }

  method set_search_text (Str() $search_text) is also<set-search-text> {
    gtk_source_search_settings_set_search_text($!gsss, $search_text);
  }

  method set_visible_only (Int() $visible_only) is also<set-visible-only> {
    my gboolean $v = $visible_only.so.Int;

    gtk_source_search_settings_set_visible_only($!gsss, $v);
  }

  method set_wrap_around (Int() $wrap_around) is also<set-wrap-around> {
    my gboolean $w = $wrap_around.so.Int;

    gtk_source_search_settings_set_wrap_around($!gsss, $w);
  }

}
