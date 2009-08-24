<form action="<?= $c->uri_for('/.admin') ?>" method="post">
  <p>
    <?= raw_string form->input('keyword') ?>
    <input type="submit" value="Search" />
  </p>
</form>

? if (my $keyword = form->valid_param('keyword')) {
<p><strong>"<?= $keyword ?>"</strong> に該当するキーワード： <?= $s->{keywords}->count ?>件
? }

<ul>
? while (my $keyword = $s->{keywords}->next) {

<li>
  <a href="<?= $c->uri_for('/.admin/keyword/' . $keyword->id ) ?>">
    <?= $keyword->keyword ?> (<?= $keyword->count ?>)
  </a>
</li>

? }
</ul>

? my $pager = $s->{keywords}->pager;
? if (my $prev = $pager->previous_page) {
<a href="<?= $c->req->uri_with({ page => $prev }) ?>">prev</a>
? }
? if (my $next = $pager->next_page) {
<a href="<?= $c->req->uri_with({ page => $next }) ?>">next</a>
? }


