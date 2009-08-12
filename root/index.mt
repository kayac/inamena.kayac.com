? extends 'common/base'

? block content => sub {

<div id="main">
<div id="formBox">
<h2>否めないコメントをつけたいキーワードを入力してください。</h2>
<p>例：窪塚洋介、草なぎ剛、ドッペルゲンガー</p>

<form id="form" method="post" action="<?= $c->uri_for('/') ?>">
  <?= raw_string form->input('q') ?>
  <input type="image" src="<?= $c->uri_for('/img/btn_search.png') ?>" alt="検索" width="135" height="70" class="btn" />
? if (my $error = form->error_message('q')) {
  <?= raw_string $error ?>
? }
</form>
<!--/#formBox--></div>

<div class="subCont" id="list">
<h2><img src="/img/tit2.png" alt="いなめなリスト" width="950" height="40" /></h2>

<div class="ad" id="ad2">
?= $self->render('common/adsense')
<!--/adsence--></div>

<p>総キーワード：<strong><?= $c->stash->{counter}{keyword} ?></strong>件 / 総コメント：<strong><?= $c->stash->{counter}{comment} ?></strong>件</p>


<div id="listBox">
<ul>
? for my $item (@{ $c->stash->{top_keywords_cloud} || [] }) {
<li class="lvl<?= $item->{weight} ?>">
  <a href="<?= $c->uri_for('/', $item->{keyword}) ?>">
    <?= $item->{keyword} ?> (<?= $item->{count} ?>)
  </a>
</li>
? }
</ul>

<!--/#list--></div>

</div>


<div class="ad" id="ad3">
?= $self->render('common/adsense')
<!--/adsence--></div>

<p class="goPageTop"><a href="#top">ページトップへ</a></p>
<!--/#main--></div>
<hr />

? } # endblock content

