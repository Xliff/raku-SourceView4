use v6.c;

use Method::Also;

use SourceView::Raw::Types;

use GTK::Text::Tag:ver<4>;

our subset GtkSourceTagAncestry is export of Mu
  where GtkSourceTag | GtkTextTagAncestry;

class SourceView::Tag:ver<4> is GTK::Text::Tag:ver<4> {
  has GtkSourceTag $!gst is implementor;

  submethod BUILD ( :$gtk-source-tag ) {
    self.setGtkSourceTag($gtk-source-tag)
      if $gtk-source-tag
  }

  method setGtkSourceTag (GtkSourceTagAncestry $_) {
    my $to-parent;

    $!gst = do {
      when GtkSourceTag {
        $to-parent = cast(GtkTextTag, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkSourceTag, $_);
      }
    }
    self.setGtkTextTag($to-parent);
  }

  method SourceView::Raw::Definitions::GtkSourceTag
    is also<GtkSourceTag>
  { $!gst }

  multi method new (
    $gtk-source-tag where * ~~ GtkSourceTagAncestry,

    :$ref = True
  ) {
    return unless $gtk-source-tag;

    my $o = self.bless( :$gtk-source-tag );
    $o.ref if $ref;
    $o;
  }
  multi method new ( Str() $name is copy, *%a ) {
    $name //= %a<name>:delete;
    
    my $gtk-source-tag = gtk_source_tag_new($name);

    my $o = $gtk-source-tag ?? self.bless( :$gtk-source-tag ) !! Nil;
    $o.setAttributes(%a) if $o && +%a;
    $o;
  }

}


### /usr/src/gtksourceview/gtksourceview/gtksourcetag.h

sub gtk_source_tag_new (Str $name)
  returns GtkTextTag
  is      native(sourceview)
  is      export
{ * }
