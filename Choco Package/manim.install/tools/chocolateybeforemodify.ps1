$manim = Get-Process manim -ErrorAction SilentlyContinue
if ($manim) {
  # try gracefully first
  $manim.CloseMainWindow()
  # kill after five seconds
  Sleep 5
  if (!$manim.HasExited) {
    $manim | Stop-Process -Force
  }
}
Remove-Variable firefox