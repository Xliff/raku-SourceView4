use v6.c;

use SourceView::Raw::Types;

use GTK::Application:Ver<4>;
use GTK::Grid:ver<4>;
use GTK::Button::Check:ver<4>;
use GTK::ScrolledWindow:ver<4>;
use SourceView::View:ver<4>;

sub fill-buffer ($b, $t) {
  $b.text = '';

  my $i = $b.start-iter;
  $b.insert( $i, qq:to/BUF/ ~ "\n" );
    ---
    \tText without draw-spaces tag.
    \tNon-breaking whitespace .
    \tTrailing spaces.\t
    ---
    BUF

  $b.insert-with-tags( $i, qq:to/BUF/.chomp, $t );
    \tText with draw-spaces tag.
    \tNon-breaking whitespace: .
    \tTrailing spaces.\t
    ---
    BUF

}

sub MAIN {

  my $a = GTK::Application.new(
    title  => 'org.genex.sourceview.spacedrawer',
    width  => 1200,
    height => 600
  );

  $a.Activate.tap: SUB {
    my $hgrid  = GTK::Grid.new( orientation => GTK_ORIENTATION_HORIZONTAL );
    my $view   = SourceView::View.new( expand => True, monospace => True );
    my $buffer = $view.buffer;

    my $tag    = $buffer.create-source-tag(draw-spaces => False);
    fill-buffer($buffer, $tag);

    my $space-drawer = $view.space-drawer;

    $space-drawer.set-types-for-locations(
      GTK_SOURCE_SPACE_LOCATION_ALL,
      GTK_SOURCE_SPACE_TYPE_NBSP
    );

    $space-drawer.set-types-for-locations(
      GTK_SOURCE_SPACE_LOCATION_TRAILING,
			GTK_SOURCE_SPACE_TYPE_ALL
    );

    my $panel-grid = GTK::Grid.new(
      orientation => GTK_ORIENTATION_VERTICAL,
      margins     => 6
    );
    $hgrid.attach($panel-grid);

    my ($r, $c) = (0, 0);
    my $matrix-check = GTK::Button::Check.new-with-label(
      'GtkSourceSpaceDrawer enable-matrix',
      active => True
    );
    $panel-grid.attach($matrix-check, $r, $c++);
    $matrix-check.bind('active', $space-drawer, 'enable-matrix', :bi);

    my $tag-set-check = GTK::Button::Check.new-with-label(
      'GtkSourceTag draw-spaces-set',
      active => True
    );
    $panel-grid.attach($tag-set-check, $r, $c++);
    $tag-set-check.bind('active', $tag, 'draw-spaces-set', :bi);

    my $tag-check = GTK::Button::Check.new-with-label(
      'GtkSourceTag draw-spaces',
      active => False
    );
    $panel-grid.attach($tag-check, $r, $c++);
    $tag-check.bind('active', $tag, 'draw-spaces', :bi);

    my $iret-check = GTK::Button::Check.new-with-label(
      'Implicit trailing newline',
      margin-top => 12
    );
    $panel-grid.attach($iret-check, $r, $c++);
    $buffer.bind('implicit-trailing-newline', $iret-check, 'active', :bi);

    my $sw = GTK::ScrolledWindow.new( child => $view );
    $hgrid.attach($sw, 1, 0);
    .set-size-request(400,500) for $hgrid, $sw;

    $a.window.child = $hgrid;
    $a.window.present;
  }

  $a.run;
}
