use v6.c;

use SourceView::Raw::Types:ver<4>;

use GTK::Application:ver<4>;
use GTK::Box:ver<4>;
use GTK::ScrolledWindow:ver<4>;
use SourceView::View:ver<4>;
use SourceView::Style::Scheme::Manager:ver<4>;
use SourceView::Style::Scheme::Preview:ver<4>;

sub MAIN {
  my $a = GTK::Application.new(
    id     => 'org.genex.sourceview.style.scheme.preview',
    width  => 1200,
    height => 768
  );

  $a.Activate.tap: SUB {
    my $sw = GTK::ScrolledWindow.new(
      propagate-natural-width => True,
  	  hscrollbar-policy       => GTK_POLICY_NEVER,
  	  min-content-height      => 250
    );
    my $b  = GTK::Box.new-vbox( margins => 12, spacing => 12 );

    my $m = SourceView::Style::Scheme::Manager.default;
    for $m[] {
      my $p = SourceView::Style::Scheme::Preview.new( $_ );
      $p.Activate.tap: SUB {
        say "Selected: { $p.scheme.name }";
        .selected = False for $b.children(
          base => SourceView::Style::Scheme::Preview
        )[];
        $p.selected = True;
      }
      $b.append($p);
    }

    ($sw.child, $a.window.child) = ($b, $sw);
    $a.window.present;
  }

  $a.run;
}
