<p><strong><?= $s->{keyword}->keyword ?></strong>の否めない一覧</p>

? for my $comment ($s->{keyword}->comments) {
<form method="post">
<p>
  <?= $comment->body ?>
  <input type="hidden" name="id" value="<?= $comment->id ?>" />
  <input type="submit" value="delete" />
</p>
</form>
? }
