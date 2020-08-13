$manim = Get-Process manim -ErrorAction SilentlyContinue
if ($manim) {
  $manim.CloseMainWindow()
  Sleep 5
  if (!$manim.HasExited) {
    $manim | Stop-Process -Force
  }
}
Remove-Variable manim
