use v6.c;

use SourceView::Raw::Types;

use GTK::Application:ver<4>;
use GTK::Builder:ver<4>;
use GTK::Button::Check:ver<4>;
use GTK::Button::Spin:ver<4>;
use GTK::Frame:ver<4>;
use GTK::Grid:ver<4>;
use GTK::Label:ver<4>;
use GTK::ScrolledWindow:ver<4>;
use SourceView::Main;
use SourceView::View:ver<4>;

my $a = GTK::Application.new(
  id     => 'org.genex.sourceview.completion',
  width  => 1280,
  height => 1024
);

$a.Activate.tap: SUB {
  my $f = '.'.IO;

  $f .= add('t') unless $f.add('test-completion.ui').r;
  $f .= add('test-completion.ui');
  die "Completion interface file expected at { $f.absolute } not found!"
    unless $f.r;

  my $b = GTK::Builder.new-from-file($f);

  $b<grid1>.unparent;
  $a.window.child = $b<grid1>;
  $a.window.present;
}

$a.run
